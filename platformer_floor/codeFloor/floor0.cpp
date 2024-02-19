// ***********************************************************************
// CutopiaZooManagementSystem  https://cutopiazoo.org     
// ***********************************************************************                
//  Copyright (c) 1996-2014 Cutopia Zoo Management System contributors.   
// 
// This is a zoo management program to make it easier for guests 
// to find out more information about the animals in Cutopia Zoo.
// It allows guests to browse what animal is in Cutopia Zoo and
// gives guests access to information about animals, such as where 
// they are located in the zoo.      
// ***********************************************************************
#include <iostream>
#include "Cutopia/LoginForm.h"
#include "Cutopia/Data/AnimalsDB.h"
#include "Cutopia/Scheduler.h"
#include "Cutopia/Animals.h"
#include "Cutopia/AnimalManager.h"
#include "Cutopia/Animals/Kangaroo.h"

class CutopiaZooManagementSystem {
private:
    std::vector<Animals::Animal*> allAnimals;
    AnimalManager::CatManager catManager;
    AnimalManager::DogManager dogManager;
    AnimalManager::KangarooManager kangarooManager;
    
public:
    CutopiaZooManagementSystem() {
        LoginForm::setLocation();
        LoginForm::setVisible(true);

        
        catManager.setAll(AnimalsDB::getCats());
        catManager.setOpenListByScheduler(Scheduler::getInstance());
        
        
        dogManager.setAll(AnimalsDB::getDogs());
        dogManager.setOpenListByScheduler(Scheduler::getInstance());

    }


    void addAnimal(Animals::Animal* animal) {
        allAnimals.push_back(animal);
    }

    void removeAnimal(Animals::Animal* animal) {
        auto it = std::find(allAnimals.begin(), allAnimals.end(), animal);
        if (it != allAnimals.end()) {
            allAnimals.erase(it);
            it.removeFromManager();
        }
    }

    void initKangaroos(){


        kangarooManager.setAll(AnimalsDB::getKangaroos());
        kangarooManager.setOpenListByScheduler(Scheduler::getInstance());
    }

    std::vector<Animals::Animal*> getAllAnimals() const {
        return allAnimals;
    }

    Animals::Animal*findAnimalByName(               const std::string& name) const {

        for (auto animal: allAnimals) {
            if (animal->getName() && animal->getName() == name      ) {
                return animal;                                      //
            }}                                                      //
                                                                    //
                                                                    //
        return nullptr;       // find no animal named by input return null 0
      }
    }; 


int main() {
    std:: cout <<"<Cutopia>"<<    std::endl;
    CutopiaZooManagementSystem    zooManagementSystem;
    std:: cout <<"Hello Cutopia Hello Cutopia Hello Cutopia Hello Cutopia Hello Cutopia Hello Cutopia!" << std::endl;
    return 100;
}