# this is the code you would type into the command line in python shell

import numpy
import matplotlib.pyplot as plt # for later plotting purpose

from thermocouple import thermocouple

# remmember the arguments: thermocouple(type, x, input_unit, output_unit)

# now that we have the function, load the data

x, y = numpy.loadtxt("graph1_Nov3.txt", comments = '#', unpack = True)

# x is raw voltage in mV, y is raw voltage across the sample in mV

# now we need to convert x into the actual voltage on the voltmeter using the offset relation

# assuming a constant, linear offset

# note that we need to take the negative of the reading in x, because we flipped positive and negative terminal in our setup

data = []
for v in x:
	data.append(v *(-10) + 0.9) # this may be changed according to the offset relation

# now w hold the processed data ready to be fed into the thermocouple function

# to call the thermocouple function, use "E" for type of thermocouple, data for input data, "mV" for input unit and "K" for output unit
# the output will automatically be given in Kelvin (an array)

t = thermocouple("E", data, "mV", "K")

# now t holds the temperature in Kelvin =)
res = [] # this will hold resistance values

for v in y:
	res.append(v/6.478)
# now res hol the resistance in ohms


x = numpy.transpose(numpy.array([t, res]))
numpy.savetxt("converted_graph1_Nov3.txt", x, fmt="%2.3f", delimiter=",")

plt.plot(t, res) # plot res vs. temperature :)
plt.show()

