%%
% EE 493 Power Flow Project
% Copyright 2020 Andrew McGinnis
%
% This code outputs an admittance matrix from tabular data organized as 
% follows:
% 
% The first row gives number of buses and lines and transformers, e.g.,
% NB NL NT 0 0 0 0 0 0
% For each line the row provides Type (=1 for line, 2 for transformer), 
% From(bus number), To(bus number), R pu, X pu, B pu and Capacity pu, and
% tap pu ( 1 if this is a line, pu ratio(tap) if a transformer)
% Type From To R X B C tap 0
% For each bus the row provides Type (=3 for bus), Bus(bus number), 
% Class(=1 slack;=2 PV;=3 PQ), Generated Real Power(PG), Generated Reactive 
% Power(QG), Load Real Power(P), Load Reactive Power(Q), all in PU, and bus 
% kV 
% Type Bus Class PG QG P Q kV X’’
% Entries shown as zero are not used (we just enter 0) ‐it is just the 
% simplest format to load into matlab or to set up objects.
%%
close all;
clear variables;

data = readmatrix("sample.csv");

disp(Y(data));
