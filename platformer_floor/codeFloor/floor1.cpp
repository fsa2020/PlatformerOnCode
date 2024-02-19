#include <string>
#include <iostream>

class Kangaroo {
private:
    std::string name;       
    std::string family;      
    int numOfAnimals;   
    int foodLeft;        
    int feedingAmount;  
    int feeder;
    std::string typeOfFood;   

public:
 
    Kangaroo(std::string animalName         ,std::string animalFamily, int animals, int food)
        :  name(animalName), family          (animalFamily), numOfAnimals(animals), foodLeft(food) {}




    std::string getName()       {return name;}
    std::string getFamily()     {return  family;}
    std::string getTypeOfFood() {return typeOfFood;}
    int getFoodLeft()           {return      foodLeft;}
    int getNumOfAnimals()       {return     numOfAnimals;}
    int getFeedingAmount()      {return       feedingAmount;}
                                                   //
                                                   //
                                                   //
                                                   //
                                                   //
    void     setName(std::string animalName)        {      name = animalName;}
    void     setFamily(std::string animalFamily)    {      family = animalFamily;}
    void     setNumOfAnimals(int animals)           {      numOfAnimals = animals;}
    void     setFoodLeft(int food)                  {      foodLeft = food;}
    void     setFeederMan(int id)                   {      feeder = id;}
    void     setFeedingAmount(int amount)           {      feedingAmount = amount;}
    void     setTypeOfFood(std::string foodType)    {      typeOfFood = foodType;}




    void feedAnimal() {
        if (foodLeft >= feedingAmount) {
            foodLeft -= feedingAmount;
            std::cout << "Feeding " << name << " with " << feedingAmount << "units of"         << typeOfFood << std::endl;
        } else {
            std::cout << "Not enough food to feed " << name << std::endl;
        }
    }
/**/
    void increaseAnimalCount(   int count            )           {          ///


        numOfAnimals += count;
        std::cout << "Increased " << name            << " count by " << count << std::endl;
/**/}


    void decreaseAnimalCount(int count) {
        if (numOfAnimals >= count)      {
            numOfAnimals -= count;
            std::cout << "Decreased " << name << " count by " << count << std::endl;
        } else {
        std::cout << "Not enough " << name << " to decrease count" << std::endl;
    }}






    void addFood(int amount) {
        foodLeft += amount;
        std::cout << "Added " << amount                <<" units of food for " << name << std::endl;}
    /**/                                            
    /**/
    void changeFeedingAmount(int amount) {
        feedingAmount = amount;
        std::cout << "Changed feeding amount for " <<                name << " to " << amount << std::endl;
    /**/                                                             }
    /**/
    void changeTypeOfFood                            (std::string foodType) {     
        typeOfFood = foodType;
    /**/  
    /**/
    /**/              std::cout << "Changed type of food for " << name << " to " << foodType << std::endl;}};
    /**/
int main() {
    // Example usage
    Kangaroo animal(1,                    "Kangaroo", "Mammal", 3, 50);
    animal.setNumOfAnimals(50);
    // set  food infomation
    animal.setFoodLeft(10);
    animal.setFeederMan(1);

    std::cout << "Animal Name: " << animal.getName() << std::endl;
    std::cout << "Animal Family: " << animal.getFamily() << std::endl;    
                                                                           //grab here

    std::cout     << "Number of Animals: " << animal.getNumOfAnimals()    << std::endl;
    std::cout     << "Number of Food Left:"<<                             animal.getFoodLeft() << std::endl;
    std::cout     << "Number of Animals: " <<                             animal.getNumOfAnimals() << std::endl;
    std::cout     << "Updated Food Left: " << animal.getFoodLeft() << std::endl;


    std::cout << "############################ Kangaroos Test ################################ " << std::endl;
return 0;
}
