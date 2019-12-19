
class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end



  get '/pets/new' do 
   erb :'/pets/new'
  end



  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
  
  
 get '/pets/:id' do 
    @owners = Owner.all 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  


   get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find(params[:id])
     binding.pry
  
    erb :'/pets/edit'
  end



 
 


  patch '/pets/:id' do 
    @owners = Owner.all
    if !params[:pet].keys.include?("owner_ids")
      params[:pet]["owner_ids"] = []
    end  
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owners << Owner.create(name: params["owner"]["name"])
    end
    
    redirect to "pets/#{@pet.id}"
  end
end