from profanity_check import predict, predict_prob
import re
import numpy

def output_modifier(string, state):
    sentences=re.split("(\.|\?|!|;|\n)",string)
    ratings=predict_prob(sentences)
    if (ratings>=0.1).any():
        out=""
        for i in range(len(sentences)):
            if ratings[i]<0.1:
                out+=sentences[i]
            else:
                out+=" [redacted "+str(len(sentences[i]))+" chars]"
    else:
        out=string
    return out
    
def state_modifier(state):
    state['stream']=False
    return state