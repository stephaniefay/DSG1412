int number_of_cars = 2;

int[] car_position_x= new int[number_of_cars];
int[] car_position_y= new int[number_of_cars];
int[] car_width= new int[number_of_cars];
int[] car_height= new int[number_of_cars];
int[] car_movement_x = new int[number_of_cars];
int[] car_movement_y = new int[number_of_cars];


void setup () {
  size (800,800);
  rectMode (CENTER);
  frameRate(260);
  
  // create cars
  car_position_x[0] = 400;
  car_position_x[1] = 200;
  
  car_position_y[0] = 400;
  car_position_y[1] = 400;
  
  car_width[0] = 40;
  car_width[1] = 40;
  
  car_height[0] = 40;
  car_height[1] = 40;
  
  car_movement_x[0] = 1;
  car_movement_x[1] = -1;
  
  car_movement_y[0] = 0;
  car_movement_y[1] = 0;
  
}

void draw () {
  background (0,0,255);
  
  draw_cars();
}

void draw_cars() {

  for(int i = 0; i < number_of_cars; i++) {
    rect(car_position_x[i], car_position_y[i], car_width[i], car_height[i]);
    move_car(i);
  }
  
  screen_collision();

}

void move_car(int car) {
    car_position_x[car] += car_movement_x[car];
    car_position_y[car] += car_movement_y[car];
}

void screen_collision() {
  
  for(int i = 0; i < number_of_cars; i++) {
    screen_collision_x(i);
    screen_collision_y(i);
    car_collision();
  }
  
}

void screen_collision_x(int car) {
    if(car_position_x[car] > 800 + car_width[car]) {
      car_position_x[car] = 0 - car_width[car];
    } else if(car_position_x[car] < 0 - car_width[car]) {
      car_position_x[car] = 800 + car_width[car];
    }
}

void screen_collision_y(int car) {
    if(car_position_y[car] > 800 + car_height[car]) {
      car_position_y[car] = 0 - car_height[car];
    } else if(car_position_y[car] < 0 - car_height[car]) {
      car_position_y[car] = 800 + car_height[car];
    }
}

void car_collision() {
  for(int i = 0; i < number_of_cars; i++) {
    for(int j = 0; j < number_of_cars; j++) {
    }
  }
}
