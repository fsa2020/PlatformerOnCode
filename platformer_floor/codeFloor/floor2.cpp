#include <iostream>
#include <vector>
#include <string>
#include <Kangaroo.h>

using namespace std;

class MacropusRrufu : public Kangaroo {
public:
    MacropusRrufu(int id, const string& name, int numPouches) : Kangaroo(id, name, numPouches) {}

    /*levelEnter*/
    /*levelEnter*/ /*phone*/
    static void displayAnimalInfo(const vector<Animal*>& animals) {
        for (const auto& animal : animals) {
            animal->displayInfo();                                  /*restJ*/
            cout << endl;        
        }                                                           /*spring*/
    }
    ||               ||/*moving dead*/||/*moving dead*/||/*moving dead*/|| 
    ||         
    ||      ||              /*score*/      /*score*/       /*score*/
    ||      
    ||      ||              /*spring*/      /*spring*/      /*spring*/
    ||                
    || 
    || /*moving dead vertical*/
    static vector<Animal*>       searchAnimals(const vector<Animal*>& animals, const string& searchKeyword) {
           vector<Animal*>       searchResults;
        for (  const auto&       animal : animals) {
            if (  animal->       getName().find(searchKeyword) != string::npos) {
            searchResults.       push_back(animal);}}
                               

        return searchResults;
    }

    static void updateAnimalInfo(vector /*moving dead*/ <Animal*>& animals, int animalId, Animal* updatedAnimal) {
        for (auto& animal : animals) {
                                    ||             /*rest jump*/
                                    ||

                                   
            if (animal->getId() == animalId) {
/*restJ*/      delete animal;
               animal = updatedAnimal;
               break;
        } } }

    /*spring*/
    static void addKeeper( /*moving dead*/ vector<Keeper>& keepers, const Keeper& newKeeper) {
        
        
        keepers.push_back(newKeeper);
    }

    static void deleteKeeper( /*moving dead*/ vector<Keeper>& keepers, int keeperId) {
                    
 
        for (auto     it = keepers.begin(); it != keepers.end(); ++it) {
            if (      it->getId()==keeperId) {


                keepers.erase(it);
                break;
            }
        }                                               /*pryLeft*/
/**/}

    /*door*/
    /*door*/     /*dead trap line, reset jump trap  pryRight*/              // reset jump trap in middle
    static void displayKeeper(const vector<Keeper>& keepers){               // moving dead trap by side
                                                                            // display keeper info
                    /*keyTrap*/        ||
                    /*keyTrap*/                                                               || 
                                                                                              ||  
              /*dead trap line, reset jump trap*/                           ||                ||                                                             
                                                                            ||                || 
                                                                            ||                || 
        for (const auto& keeper : keepers) {                                ||                || 
            keeper.displayInfo();                                           ||                || 
            cout << endl;                                                   ||                || 
                                                                            ||                || 
    }}                                                                      ||                || 
                                                                            ||                || 
         /*dead trap line, reset jump trap  pryLeft*/                       ||                || 
    static vector<Keeper> searchKeepers(const vector<Keeper>& keepers, const string&       searchKeyword) {
            ||          
            ||         
            ||       
            ||       ||||                ||                ||               ||         ||
            ||       ||   /*moving dead trap*/   
            ||       ||      
            ||       ||
            ||       ||
            ||      
            ||    
              
        vector<Keeper> searchResults;
        for (const auto& keeper : keepers) {/*TrapDead*/


            if (keeper.getName().find(searchKeyword)     !=string::npos) {
                searchResults.push_back(keeper);                ||              ||
            }}                                                  ||              ||
        return searchResults;                                   ||      ||      ||
                                                                ||      ||      
                                                                ||      ||
                                                                ||      ||
                                                                ||      ||
                                                                ||      ||
                                                                        ||
                                                                        ||
        ||                ||                ||              ||          ||
    }   ||
    /**/
    /**/
    static void updateKeeperInfo(vector<Keeper>& keepers, int keeperId,       const Keeper& updatedKeeper) {
        for (auto& keeper : keepers) {                                        
            if (keeper.getId() == keeperId) {
                keeper = updatedKeeper;      


                        ||             ||               ||       ||       || 
/*lockedDoor*/          
/*lockedDoor*/   break;
}}}};//##############