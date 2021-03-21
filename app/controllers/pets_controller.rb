class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 

    @owners = Owner.all
    erb :'/pets/new'
  end

  post "/pets" do 
    
    @pet = Pet.create(name: params[:pet_name])
    if !params[:owner][:name].empty?
        @owner = Owner.create(name: params[:owner][:name])
        @owner.pets << @pet
    elsif !params[:owner_id].empty?
        @owner = Owner.find_by_id(params[:owner_id])
        @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    # binding.pry
   
    erb :'/pets/edit'
  end


  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name]) 
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
      @owner.pets << @pet
    elsif !params[:owner_id].empty?
      @owner = Owner.find(params[:owner_id])
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end
end