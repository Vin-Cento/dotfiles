#!/usr/bin/python

import sys
import re
import pandas as pd
import os

regex = re.compile('[^A-Za-z0-9: ]')

def split_music(df,music_path):
    start_time = df['start_time']
    end_time = df['end_time']
    file_name = df['name']
    print(end_time)
    try:
        print(f"ffmpeg -ss {str(start_time)} -i '{str(music_path)}' -to {str(end_time)} -c copy -copyts {file_name}.mp3")
        os.system(f"ffmpeg -ss {str(start_time)} -i '{str(music_path)}' -to {str(end_time)} -c copy -copyts {file_name}.mp3")
    except:
        print(f"ffmpeg -ss {str(start_time)} -i '{str(music_path)}' -c copy -copyts {file_name}.mp3")
        os.system(f"ffmpeg -ss {str(start_time)} -i '{str(music_path)}' -c copy -copyts {file_name}.mp3")

def main(argv):
    music_path = argv[1]
    values =[]
    with open(argv[2],'r') as file:
        for x in file.readlines():
            values.append(['_'.join(regex.sub('',y.strip()).split()) for y in x.split('|')])
    data = pd.DataFrame(values,columns=['start_time','name'])
    data['end_time'] = data['start_time'].shift(periods=-1)
    data = data[['start_time','end_time','name']]
    data.apply(lambda x: split_music(x, music_path),axis=1)

main(sys.argv)
