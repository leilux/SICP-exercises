#!/usr/bin/env python
#coding: utf-8

# constraint

class Constraint(object):
    def process_new_value(self):
        raise NotImplementedError()

    def process_forget_value(self):
        raise NotImplementedError()

    def dispatch(self, msg):
        if msg == 'I-have-a-value':
            self.process_new_value()
        elif msg == 'I-lost-my-value':
            self.process_forget_value()
        else:
            raise 'unknow request -- %s: %s'% \
                    (self.__class__.__name__, msg)


class Adder(Constraint):
    def __init__(self, a1, a2, summ):
        self.a1 = a1
        self.a2 = a2
        self.summ = summ

        connect(a1, self)
        connect(a2, self)
        connect(summ, self)

    def process_new_value(self):
        if self.a1.has_value() and self.a2.has_value():
           self.summ.set_value(self.a1.value + self.a2.value, self)

        elif self.a1.has_value() and self.summ.has_value():
            self.a2.set_value(self.summ.value - self.a1.value, self)

        elif self.a2.has_value() and self.summ.has_value():
            self.a1.set_value(get_value(self.summ) - get_value(self.a2), self)

    def process_forget_value(self):
        self.summ.forget_value(self)
        self.a1.forget_value(self)
        self.a2.forget_value(self)
        self.process_new_value()


class Multiplier(Constraint):
    def __init__(self, m1, m2, product):
        self.m1 = m1
        self.m2 = m2
        self.product = product

        connect(m1, self)
        connect(m2, self)
        connect(product, self)

    def process_new_value(self):
        if has_value(self.m1) and has_value(self.m2):
            set_value(self.product, 
                get_value(self.m1) * get_value(self.m2), self)

        elif has_value(self.m1) and has_value(self.product):
            set_value(self.m2,
                get_value(self.product) / get_value(self.m1), self)

        elif has_value(self.m2) and has_value(self.product):
            set_value(self.m1,
                get_value(self.product) / get_value(self.m2), self)

    def process_forget_value(self):
        forget_value(self.product, self)
        forget_value(self.m1, self)
        forget_value(self.m2, self)
        self.process_new_value()


class Constant(object):
    def __init__(self, value, connector):
        connect(connector, self)

        set_value(connector, value, self)


class Probe(Constraint):
    def __init__(self, name, connector):
        self.name = name
        self.connector = connector

        connect(connector, self)

    def print_probe(self, value):
        print 'Probe: %s = %s' % (self.name, value)

    def process_new_value(self):
        self.print_probe(get_value(self.connector))

    def process_forget_value(self):
        self.print_probe('?')


class make_connector(object):
    def __init__(self):
        self.informant = False
        self.value = False
        self.constraints = []

    def has_value(self):
        return bool(self.informant)

    def set_value(self, value, informant):
        if not has_value(self):
            print 'conn set from %s' % informant
            self.value = value
            self.informant = informant
            self.for_each_except(informant,
                    inform_about_value,
                    self.constraints)
        else:
            pass

    def forget_value(self, retractor):
        if retractor == self.informant:
            self.informant = False
            self.for_each_except(self.informant,
                    inform_about_no_value,
                    self.constraints)

    def connect(self, new_constraint):
        if new_constraint not in self.constraints:
            self.constraints.append(new_constraint)
        if has_value(self):
            inform_about_value(new_constraint)

    def for_each_except(self, exception, procedure, l):
        for constraint in l:
            if constraint == exception:
                continue
            else:
                procedure(constraint)
    

# interface: connector

def has_value(connector):
    # return connector('has_value')
    return connector.has_value()

def get_value(connector):
    # return connector('value')
    return connector.value

def set_value(connector, value, informant):
    # connector('set_value', value, informant)
    connector.set_value(value, informant)

def forget_value(connector, retractor):
    # connector('forget', retractor)
    connector.forget_value(retractor)

def connect(connector, new_constraint):
    connector.connect(new_constraint)

# interface: constraint

def inform_about_value(constraint):
    constraint.dispatch('I-have-a-value')

def inform_about_no_value(constraint):
    constraint.dispatch('I-lost-my-value')


def celsius_fahrenheit_convert(C, F):
    u = make_connector()
    v = make_connector()
    w = make_connector()
    x = make_connector()
    y = make_connector()

    Multiplier(C, w, u)
    Multiplier(v, x, u)
    Adder(v, y, F)
    Constant(9, w)
    Constant(5, x)
    Constant(32, y)


C = make_connector()
F = make_connector()
celsius_fahrenheit_convert(C, F)

p1 = Probe("Celsius temp", C)
p2 = Probe("Fahrenheit temp", F)

set_value(C, 25, 'user')

forget_value(C, 'user')

set_value(F, 212, 'user')
