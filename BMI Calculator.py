#!/usr/bin/env python
# coding: utf-8

# In[1]:


name = input("Enter you name: ")

weight = int(input("Enter your weight in pounds: "))

height = int(input("Enter your height in inches: "))

BMI = (weight * 703) / (height * height)

print(BMI)

if BMI>0:
    if(BMI<18.5):
        print(name +", you are underwight.")
    elif (BMI<=24.9):
        print(name +", you are normal weight.")
    elif (BMI<29.9):
        print(name +", you are overweight.")
    elif (BMI<34.9):
        print(name +", you are obese.")
    elif (BMI<39.9):
        print(name +", you are severely obese.")
    else:
        print(name +", you are morbidly obese.")
else:
    print("Enter valid input")


# In[ ]:





# In[ ]:


#BMI = (weight in pounds x 703) / (height in inches x height in inches)


# In[2]:


print(weight)


# In[ ]:


Under 18.5   Underweight     Minimal
18.5 - 24.9  Normal Weight   Minimal
25 - 29.9    Overweight      Increased
30 - 34.9    Obese           High
35 - 39.9    Severely Obese  Very High
40 and over  Morbidly Obese  Extremely High


# In[3]:


if BMI>0:
    if(BMI<18.5):
        print(name +", you are underwight.")
    elif (BMI<=24.9):
        print(name +", you are normal weight.")
    elif (BMI<29.9):
        print(name +", you are overweight.")
    elif (BMI<34.9):
        print(name +", you are obese.")
    elif (BMI<39.9):
        print(name +", you are severely obese.")
    else:
        print(name +", you are morbidly obese.")
else:
    print("Enter valid input")


# In[ ]:




