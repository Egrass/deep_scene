#include <cfloat>
#include <cmath>
#include <cstring>
#include <vector>

#include "gtest/gtest.h"

#include "caffe/blob.hpp"
#include "caffe/common.hpp"
#include "caffe/filler.hpp"
#include "caffe/util/rng.hpp"
#include "caffe/vision_layers.hpp"

#include "caffe/test/test_caffe_main.hpp"

namespace caffe {

template <typename Dtype>
class ParseOutputLayerTest : public ::testing::Test {
 protected:
  ParseOutputLayerTest()
      : blob_bottom_(new Blob<Dtype>()),
        blob_bottom2_(new Blob<Dtype>()),
        blob_top_label_(new Blob<Dtype>()),
        blob_top_prob_(new Blob<Dtype>()) {
    blob_bottom_->Reshape(1, 2, 3, 3);
    FillBottoms();

    multi_num_ = 4;
    blob_bottom2_->Reshape(multi_num_, 2, 3, 3);
    for (int i = 0; i < multi_num_; ++i) {
      caffe_copy(blob_bottom_->count(), blob_bottom_->cpu_data(),
                 blob_bottom2_->mutable_cpu_data() + i * blob_bottom_->count());
    }

    blob_bottom_vec_.push_back(blob_bottom_);
    blob_bottom_multi_vec_.push_back(blob_bottom2_);
    blob_top_vec_.push_back(blob_top_label_);
  }

  virtual ~ParseOutputLayerTest() {
    delete blob_bottom_;
    delete blob_bottom2_;
    delete blob_top_label_;
    delete blob_top_prob_;
  }

  void FillBottoms() {
    // manually fill some data
    // Input:
    //     [ 1 1.8 2 ]
    //     [ 1 1.2 2 ]
    //     [ 1 3.5 4 ]
    //     =========
    //     [ 0 3 2 ]
    //     [ 3 3 2 ]
    //     [ 2 0 0 ]
    blob_bottom_->mutable_cpu_data()[0] = 1;
    blob_bottom_->mutable_cpu_data()[1] = 1.8;
    blob_bottom_->mutable_cpu_data()[2] = 2;
    blob_bottom_->mutable_cpu_data()[3] = 1;
    blob_bottom_->mutable_cpu_data()[4] = 1.2;
    blob_bottom_->mutable_cpu_data()[5] = 2;
    blob_bottom_->mutable_cpu_data()[6] = 1;
    blob_bottom_->mutable_cpu_data()[7] = 3.5;
    blob_bottom_->mutable_cpu_data()[8] = 4;
    blob_bottom_->mutable_cpu_data()[9] = 0;
    blob_bottom_->mutable_cpu_data()[10] = 3;
    blob_bottom_->mutable_cpu_data()[11] = 2;
    blob_bottom_->mutable_cpu_data()[12] = 3;
    blob_bottom_->mutable_cpu_data()[13] = 3;
    blob_bottom_->mutable_cpu_data()[14] = 2;
    blob_bottom_->mutable_cpu_data()[15] = 2;
    blob_bottom_->mutable_cpu_data()[16] = 0;
    blob_bottom_->mutable_cpu_data()[17] = 0;
  }

  Blob<Dtype>* const blob_bottom_;
  Blob<Dtype>* const blob_bottom2_;
  Blob<Dtype>* const blob_top_label_;
  Blob<Dtype>* const blob_top_prob_;
  vector<Blob<Dtype>*> blob_bottom_vec_;
  vector<Blob<Dtype>*> blob_bottom_multi_vec_;
  vector<Blob<Dtype>*> blob_top_vec_;

  int multi_num_;
};

TYPED_TEST_CASE(ParseOutputLayerTest, TestDtypes);

TYPED_TEST(ParseOutputLayerTest, TestSetup) {
  LayerParameter layer_param;
  ParseOutputLayer<TypeParam> layer(layer_param);
  layer.SetUp(this->blob_bottom_vec_, this->blob_top_vec_);
  EXPECT_EQ(this->blob_top_label_->num(), 1);
  EXPECT_EQ(this->blob_top_label_->channels(), 1);
  EXPECT_EQ(this->blob_top_label_->height(), 3);
  EXPECT_EQ(this->blob_top_label_->width(), 3);
}

TYPED_TEST(ParseOutputLayerTest, TestSetupTwo) {
  LayerParameter layer_param;
  ParseOutputLayer<TypeParam> layer(layer_param);
  this->blob_top_vec_.push_back(this->blob_top_prob_);
  layer.SetUp(this->blob_bottom_vec_, this->blob_top_vec_);
  EXPECT_EQ(this->blob_top_label_->num(), 1);
  EXPECT_EQ(this->blob_top_label_->channels(), 1);
  EXPECT_EQ(this->blob_top_label_->height(), 3);
  EXPECT_EQ(this->blob_top_label_->width(), 3);
  EXPECT_EQ(this->blob_top_prob_->num(), 1);
  EXPECT_EQ(this->blob_top_prob_->channels(), 1);
  EXPECT_EQ(this->blob_top_prob_->height(), 3);
  EXPECT_EQ(this->blob_top_prob_->width(), 3);
  this->blob_top_vec_.pop_back();
}

TYPED_TEST(ParseOutputLayerTest, TestForward) {
  Caffe::set_mode(Caffe::CPU);
  LayerParameter layer_param;
  ParseOutputLayer<TypeParam> layer(layer_param);
  layer.SetUp(this->blob_bottom_vec_, this->blob_top_vec_);
  EXPECT_EQ(this->blob_top_label_->num(), 1);
  EXPECT_EQ(this->blob_top_label_->channels(), 1);
  EXPECT_EQ(this->blob_top_label_->height(), 3);
  EXPECT_EQ(this->blob_top_label_->width(), 3);
  layer.Forward(this->blob_bottom_vec_, this->blob_top_vec_);

  // Output:
  //     [ 0 1 0 ]
  //     [ 1 1 0 ]
  //     [ 1 0 0 ]
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[0], 0);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[1], 1);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[2], 0);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[3], 1);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[4], 1);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[5], 0);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[6], 1);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[7], 0);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[8], 0);
}

TYPED_TEST(ParseOutputLayerTest, TestMultiForward) {
  Caffe::set_mode(Caffe::CPU);
  LayerParameter layer_param;
  ParseOutputLayer<TypeParam> layer(layer_param);
  layer.SetUp(this->blob_bottom_multi_vec_, this->blob_top_vec_);
  EXPECT_EQ(this->blob_top_label_->num(), this->multi_num_);
  EXPECT_EQ(this->blob_top_label_->channels(), 1);
  EXPECT_EQ(this->blob_top_label_->height(), 3);
  EXPECT_EQ(this->blob_top_label_->width(), 3);
  layer.Forward(this->blob_bottom_multi_vec_, this->blob_top_vec_);

  // Output:
  //     [ 0 1 0 ]
  //     [ 1 1 0 ]
  //     [ 1 0 0 ]
  for (int i = 0; i < this->multi_num_; ++i) {
    EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[0 + i*9], 0);
    EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[1 + i*9], 1);
    EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[2 + i*9], 0);
    EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[3 + i*9], 1);
    EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[4 + i*9], 1);
    EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[5 + i*9], 0);
    EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[6 + i*9], 1);
    EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[7 + i*9], 0);
    EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[8 + i*9], 0);
  }
}

TYPED_TEST(ParseOutputLayerTest, TestForwardTwo) {
  Caffe::set_mode(Caffe::CPU);
  LayerParameter layer_param;
  ParseOutputLayer<TypeParam> layer(layer_param);
  this->blob_top_vec_.push_back(this->blob_top_prob_);
  layer.SetUp(this->blob_bottom_vec_, this->blob_top_vec_);
  EXPECT_EQ(this->blob_top_label_->num(), 1);
  EXPECT_EQ(this->blob_top_label_->channels(), 1);
  EXPECT_EQ(this->blob_top_label_->height(), 3);
  EXPECT_EQ(this->blob_top_label_->width(), 3);
  EXPECT_EQ(this->blob_top_prob_->num(), 1);
  EXPECT_EQ(this->blob_top_prob_->channels(), 1);
  EXPECT_EQ(this->blob_top_prob_->height(), 3);
  EXPECT_EQ(this->blob_top_prob_->width(), 3);
  layer.Forward(this->blob_bottom_vec_, this->blob_top_vec_);

  // Output: (label)
  //     [ 0 1 0 ]
  //     [ 1 1 0 ]
  //     [ 1 0 0 ]
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[0], 0);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[1], 1);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[2], 0);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[3], 1);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[4], 1);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[5], 0);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[6], 1);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[7], 0);
  EXPECT_EQ(this->blob_top_label_->mutable_cpu_data()[8], 0);

  // Output: (prob)
  //     [ 1 3 2 ]
  //     [ 3 3 2 ]
  //     [ 2 3.5 4]
  EXPECT_EQ(this->blob_top_prob_->mutable_cpu_data()[0], 1);
  EXPECT_EQ(this->blob_top_prob_->mutable_cpu_data()[1], 3);
  EXPECT_EQ(this->blob_top_prob_->mutable_cpu_data()[2], 2);
  EXPECT_EQ(this->blob_top_prob_->mutable_cpu_data()[3], 3);
  EXPECT_EQ(this->blob_top_prob_->mutable_cpu_data()[4], 3);
  EXPECT_EQ(this->blob_top_prob_->mutable_cpu_data()[5], 2);
  EXPECT_EQ(this->blob_top_prob_->mutable_cpu_data()[6], 2);
  EXPECT_EQ(this->blob_top_prob_->mutable_cpu_data()[7], 3.5);
  EXPECT_EQ(this->blob_top_prob_->mutable_cpu_data()[8], 4);
}

}  // namespace caffe
