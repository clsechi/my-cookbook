# README

# My Cook Book

That's the first project used in Campus Code course.

Trata-se de uma representação minimalista de um sistema de gerenciamento de produtos e suas dependências.

The system have can be used by the web interface or using the API.



Na interface do usuário, o mesmo é capaz de cadastrar categorias, produtos e planos com seus devidos preços e suas periodicidades.

Já a API é responsável por enviar dados no formato JSON do conteúdo cadastrado no banco de dados.

Gems used
  - Devise          (Authentication)
  - Paperclip       (Photo Upload)
  - Jquery
  - Bootstrap

Gems used in tests
  - Rspec Rails         
  - Capybara
  - Simplecov           
  - Rubocop             
  - Factory Bot Rails   
## Ruby version
```
2.3.6
```
## Configuration

Clone the project

To configure the aplication, in project folder run:
```
bin/setup
```

[Paperclip](https://github.com/thoughtbot/paperclip/wiki/Requirements) needs ImageMagick to work, plese see the documentation.

## Test Suite 

To run the test suite type on your terminal:
```
rspec -f d
```

### Login

  Default user created to access the application
  - Email - user@email.com
  - Password - 123456

### Cuisines and Recipe Types

To create a new cuisine or recipe type, access the URLs bellow:
```
localhost:3000/cuisines/new
```
```
localhost:3000/recipe_types/new
```

To edit:
```
localhost:3000/cuisines/[:cuisine_id]/edit
```
```
localhost:3000/recipe_types/[:recipe_type_id]/edit
```


# API

## Recipes

GET **/api/recipes** ( Return all recipes )
> ###### Success
> status 200 <br>
```json
{
  "recipes": [
    {
      "id": 1,
      "title": "Pizza",
      "difficulty": "Fácil",
      "cook_time": 30,
      "ingredients": "Massa, Tomate, Queijo e Bacon",
      "method": "Com a massa pronta junte a massa de tomate...",
      "cuisine_id": 1,
      "recipe_type_id": 1,
      "user_id": 1,
      "featured": false
    }
  ]
}
```

GET **/api/recipes/[:recipe_id]** ( Return a spécific recipe)
> ###### Success
> status 200 <br>
```json
{
  "recipe": {
    "id": 2,
    "title": "Macarrão",
    "difficulty": "Médio",
    "cook_time": 45,
    "ingredients": "Massa, Molho de Tomate e Queijo",
    "method": "Aqueça a água, coloque sal, junte o macarrão...",
    "cuisine_id": 1,
    "recipe_type_id": 1,
    "user_id": 1,
    "featured": true
  }
}
```
> ###### Falha
> status 404 <br>
```json
{
  "message":"Nenhuma receita encontrada"
}
```
