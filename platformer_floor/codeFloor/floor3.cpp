#include <iostream>
#include <vector>
#include <string>
#include <Kangaroo.h>

using namespace std;

class MuskKangaroo : public Kangaroo {
public:
    MuskKangaroo(int id, const string& name, int numPouches) : Kangaroo(id, name, numPouches) {}


    /*trap plot *//*event end explode*/
    void setNumOfAnimals(int animals) /*moving dead */ {numOfAnimals = animals;}
    /*dead*/
    /*dead*/
    /*dead*/
    /*dead*/                        /*dispatch spring */ 
    /*dead*/
    /*dead*/
    /*dead*/
    /*dead*/                              /*dispatch pry right */   
                                                /*trap pry left*/
    void setFoodLeft(int food) /*moving dead */ {foodLeft = food;}
                                                /*dead*/
                                                /*dead*/
                                                /*dead*/
                                                /*dead*/
                 /*dispatch spring */           /*dead*/  
    /*pry right*/
    void /*m dead */ setFeederMan(int id){feeder = id;}
    /*dead*/
    /*dead*/
    /*dead*/
    /*dead*/
    /*dead*/                               /*dispatch spring */   
                                        /*saving point*/  /*trap pry left*/
    void setFeedingAmount(int amount)           {feedingAmount = amount;}

                                    /*reset jump */                           /*score 5 */ 

                                /////////////////////
    void /*moving dead */setTypeOfFood(std::string foodType) /*moving dead */  {typeOfFood = foodType;}



    /*dispatch spring */ 


    static     void displayAnimalInfo(const vector<Animal*>& animals) {
        

          for (const auto& animal : animals) {
            animal->displayInfo();                                       
    }}

    /*event explode*/

    /*trap spring*//*saving point*/ 
    static vector<Animal*>searchAnimals(       const vector<Animal*>& animals, const string& searchKeyword) {
           vector<Animal*>searchResults;
        

        for (  const   auto&animal:      animals) {
            if ( animal->getName().      find(searchKeyword) != string::npos) {
            searchResults.push_back      (animal);}}

                         /*score 4*/
                return searchResults;
    }



                                                                 /*dispatch pryLeft*/    
                                                                 /*dispatch spring */    
                                                        /*saving point3*/         
    static void updateAnimalInfo(vector<Animal*>&       animals, int animalId, Animal* updatedAnimal) {
        for (auto& animal : animals) {
                       
            if (animal->getId() == animalId) {
                delete animal;
               animal = updatedAnimal;         /*spring*/  
               break;
        } } }
                                                                                    /*dispatch pryLeft*/  
                /*score 3*/  /* pryRight*/                                              /*spring*/  //
    static void addKeeper(vector<Keeper>& keepers,    const Keeper&                     newKeeper) {
        
        /*score 2*/ 
        keepers.push_back(newKeeper);
    }

    static void deleteKeeper(vector<Keeper>& keepers, int keeperId) {


                                    /*dispatch spring*/ /*dispatch spring*/    

                            /*saving point 2*/ 
        for (auto          it=keepers.begin(); it!=keepers.end(); ++it) {
            if (           it->getId()==keeperId) {
                


                keepers                              .erase(it); break;
                /*dispatch spring*/
            }
        }                                              
    }
        /*saving point 1*/ 
    static void displayKeeper(const vector /*moving dead*/ <Keeper>& keepers){               
                                                                                                                                         
        for (const auto& keeper : keepers) {                               
            keeper.displayInfo();            /*trap spring*/

                                                     /*trap spring*/                      
    }}                                                                    
                                            /*trap spring*/                               
       
    static vector<Keeper> searchKeepers(        const vector<Keeper>& keepers, const string& searchKeyword) {
        vector<Keeper> searchResults;
        for (const auto& keeper : keepers) {

                                                            /*score 1*/ 
            if (keeper.getName().find(searchKeyword)!=string::npos) {
                searchResults.push_back(keeper);                
            }}     

        return searchResults;}  
    
                                 /*event fall *//*plot 1*/ 
    static void updateKeeperInfo(vector<Keeper>& keepers, int keeperId,const Keeper& updatedKeeper) {
        for (auto& keeper : keepers) {                                        
            if (keeper.getId() == keeperId) {
                keeper = updatedKeeper;      
                break;
            }
        }
    }};