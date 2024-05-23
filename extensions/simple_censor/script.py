from profanity_check import predict, predict_prob
import re
import numpy

def censor(string):
    sentences=re.split("(\.|\?|!|;|\n)",string)
    ratings=predict_prob(sentences)
    if (ratings>=0.1).any():
        out=""
        for i in range(len(sentences)):
            if ratings[i]<0.1:
                out+=sentences[i]
            else:
                out+=" ["+str(len(sentences[i]))+" unsafe characters, not shown, please disregard]"
    else:
        out=string
    return out

def output_modifier(string, state):
    return censor(string)
    
def input_modifier(string, state):
    return censor(string)
    
def chat_input_modifier(text, visible_text, state):
    return censor(text), censor(visible_text)
    
def state_modifier(state):
    state['stream']=False
    return state
