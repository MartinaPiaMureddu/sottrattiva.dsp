import("stdfaust.lib");
//fcut = vslider("freq CUT [style:knob][scale:exp]", 880, 20, 10000, 1);
//order = 32;
//f1 = no.noise : fi.highpass(order,fcut) : fi.lowpass(order,fcut);
//f2 = no.noise : fi.highpass(order,fcut*2): fi.lowpass(order,fcut*2);
Ebassf1 = fi.highpass(order, fcut) : fi.lowpass(order, fcut) : *(gain) : meter
with{
order = 128;
fcut = 250;
f1group(x) = hgroup("[01] f1", x);
gain = f1group(vslider("[01] GAIN", -14.3, -96, +6, 0.1)) : ba.db2linear : si.smoo;
meter(x) = f1group(attach(x, an.amp_follower(0.5, x) :ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};

Ebassf2 = fi.highpass(order, fcut): fi.lowpass(order, fcut): *(gain) : meter
with{
order = 96;
fcut = 1750;
f2group(x) = hgroup("[02] f2", x);
gain = f2group(vslider("[01] GAIN", -2.1, -96, +6, 0.1)) : ba.db2linear : si.smoo;
meter(x) = f2group(attach(x, an.amp_follower(0.5, x) :ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};
Ebassf3 = fi.highpass(order, fcut): fi.lowpass(order, fcut): *(gain) : meter
with{
order = 86;
fcut = 2600;
f3group(x) = hgroup("[03] f3", x);
gain = f3group(vslider("[01] GAIN", 11.3, -96, +12, 0.1)) : ba.db2linear : si.smoo;
meter(x) = f3group(attach(x, an.amp_follower(0.5, x) :ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};
Ebassf4 = fi.highpass(order, fcut): fi.lowpass(order, fcut) : *(gain) : meter
with{
order = 64;
fcut = 3050;
f4group(x) = hgroup("[04] f4", x);
gain = f4group(vslider("[01] GAIN", 3.3, -96, +6, 0.1)) : ba.db2linear : si.smoo;
meter(x) = f4group(attach(x, an.amp_follower(0.150, x) :ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};
Ebassf5 = fi.highpass(order,2750): fi.lowpass(order,2750) : *(gain) : meter
with{
order = 64;
fcut = 3340;
f5group(x) = hgroup("[05] f5", x);
gain = f5group(vslider("[01] GAIN", -3.5, -96, +6, 0.1)) : ba.db2linear : si.smoo;
meter(x) = f5group(attach(x, an.amp_follower(0.5, x) :ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};

outmeter(x) = attach(x, an.amp_follower(0.150,x) : ba.linear2db : hbargraph("[02] METER [unit:dB]", -70,+5));
process = no.noise <: hgroup("E FORMANTICO", Ebassf1, Ebassf2, Ebassf3, Ebassf4, Ebassf5) :> outmeter;



// vocale E voce di basso 
// 400, 1620, 2400, 2800, 3100
// 40, 80, 100, 120, 120
// 0, -12, -9, -12, -18
