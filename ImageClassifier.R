#Image Analysis
#21-04-2020
#Code from Python to R

#import packages
library(keras)
library(tensorflow)

#Define epoch and batch size
batch_size <- 128
epochs <- 15

#path to datafiles 
data_path = 'C:/Users/janne/Documents/School/ImageAnalyzing/data'
#or download files
#data_path = 'https://storage.googleapis.com/mledu-datasets/cats_and_dogs_filtered.zip'

# Image flow --------------------------------------------------------------

#Make image generator and specify parameters
training_image_gen <- image_data_generator(
  rotation_range = 45,
  width_shift_range = 15,
  height_shift_range = 15,
  horizontal_flip = TRUE,
  zoom_range = 0.5,
  preprocessing_function = imagenet_preprocess_input
)

validation_image_gen <- image_data_generator(
  preprocessing_function = imagenet_preprocess_input
)

training_image_flow <- flow_images_from_directory(
  directory = file.path(data_path, 'train'), 
  generator = training_image_gen, 
  class_mode = "binary",
  batch_size = batch_size,
  target_size = c(224, 224)
)

validation_image_flow <- flow_images_from_directory(
  directory = file.path(data_path, 'validation'), 
  generator = validation_image_gen, 
  class_mode = "binary",
  batch_size = batch_size,
  target_size = c(224, 224), 
  shuffle = FALSE
)

# Model -------------------------------------------------------------------

mob <- application_mobilenet(include_top = FALSE, pooling = "avg")
freeze_weights(mob)

#Make a sequential model and define parameters
model <- keras_model_sequential() %>% 
  mob() %>% 
  layer_dense(256, activation = "relu") %>% 
  layer_dropout(rate = 0.2) %>% 
  layer_dense(units = 1, activation = "sigmoid")

model %>% 
  compile(loss = "binary_crossentropy", optimizer = "adam", metrics = "accuracy")


model %>% fit_generator(
  generator = training_image_flow, 
  epochs = 1, 
  steps_per_epoch = training_image_flow$n/training_image_flow$batch_size,
  validation_data = validation_image_flow,
  validation_steps = validation_image_flow$n/validation_image_flow$batch_size
)

#fit the model
history <- model %>% fit_generator(
  train_array_gen,
  steps_per_epoch=train_steps,
  epochs=epochs,
  validation_data=validation_array_gen,
  validation_steps=eval_steps
)

#plot the results per epoch
plot(history)
