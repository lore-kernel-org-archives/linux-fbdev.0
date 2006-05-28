From: Vassilis Virvilis <vasvir@iit.demokritos.gr>
Subject: Re: Twister savagefb doesn't sync
Date: Sun, 28 May 2006 15:16:40 +0300
Message-ID: <447994A8.30600@iit.demokritos.gr>
References: <44698356.80806@iit.demokritos.gr> <447359B8.7020304@iit.demokritos.gr> <447381E9.4060705@gmail.com> <447803FC.8050009@iit.demokritos.gr> <44781B3A.5030406@gmail.com> <44781BFB.5020708@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020404030100030309070601"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FkK8F-0000mE-7B
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 28 May 2006 05:12:31 -0700
Received: from zeus.iit.demokritos.gr ([143.233.226.2])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FkK8E-0004Ea-7O
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 28 May 2006 05:12:31 -0700
In-Reply-To: <44781BFB.5020708@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

This is a multi-part message in MIME format.
--------------020404030100030309070601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Antonino A. Daplas wrote:

> 
> lspci -v -d 5333:8d04
> 
OK I have done a lot of tests. First my device is
5333:8d01 and the non-prefetchable memory is at ec000000
so we have

#define PCI_ID        0x8d01  /* put the PCI id of the device here */
#define PCI_PBASE     0xec000000  /* put the start address of the PCI resource here */

Ok. I tried both X (with use bios), and SDL testsprite in 640x480, 800x600, 1024x768 at
8, 16, 24 bpp.

testsprite is a SDL demo that accepts the following options
(-width, -height, -bpp). I made both sets of tests in a medion TFT 18 screen and in an
EIZO F520 CRT.

All X modes are working.
SDL works for 1024x768 bpp=* in CRT and TFT
SDL work in 800x600 bpp={16, 24} (not 8bpp) only in TFT and __not in CRT__

I am attaching the output of savagedump for all modes, for both monitors (#36),
just for future reference.

I will try to understand the differences but the registers are too many and without
documentation it is a bit hopeless I am afraid. Or is there documentation somewhere publicly
available?

Is there any way to replay the working set of registers to get the correct mode settings?
       .bill

Here is the output for just one case TFT 640x480-256

X- working
TwisterP

SR0x  03 01 0f 00 0e 05 06 07 06 00 0a 00 0c 00 0e 0f
SR1x  67 7d ffffffc5 fffffffc 00 ffffff81 0c ffffff8f 00 02 02 12 00 fffffff8 0a 00
SR2x  20 21 22 23 24 25 26 04 0c 00 2a 02 18 00 2e 2f
SR3x  10 17 41 63 00 00 00 00 00 00 3a 3b 3c 00 3e 00
SR4x  40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
SR5x  00 00 21 fffffff7 1f 1f 1f 7f 08 60 18 7e 77 fffffff7 02 04
SR6x  ffffffa3 7f ffffff80 06 ffffff83 fffffff4 ffffff80 00 24 ffffffff ffffffff 24 02 ffffff88 ffffffa3 32
CR0x  5f 4f 50 ffffff82 52 ffffff9e 0b 3e 00 40 00 00 00 00 ffffffff 00
CR1x  ffffffe9 0b ffffffdf 50 60 ffffffe7 03 ffffffab ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
CR2x  ffffffff ffffffff 1b ffffffff 20 20 20 20 20 20 20 20 20 ffffff8d 01 02
CR3x  ffffffe1 0c 00 08 10 00 ffffffbf ffffffdb 5b ffffffb8 11 58 32 00 00 00
CR4x  01 19 00 00 00 00 01 39 38 ffffffe9 00 ffffffff 7f 7c 40 40
CR5x  ffffffc1 00 00 00 00 00 00 00 13 ffffffe0 00 00 00 00 00 00
CR6x  00 00 00 00 00 00 ffffff89 00 ffffffff ffffff80 00 03 00 ffffffff 00 ffffffee
CR7x  10 ffffffc0 07 1f 1f 1f 00 1f 01 04 1f 1f 17 17 17 17
CR8x  00 00 00 00 70 13 00 00 18 18 18 18 18 18 18 18
CR9x  ffffff80 4f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
CRax  1a 00 00 00 00 ffffffc0 ffffffc6 ffffffb6 6d 00 00 00 00 00 00 00
CRbx  fffffff7 0c 00 00 00 00 00


SDL testsprite (not working)
TwisterP

SR0x  03 01 0f 00 0e 05 06 07 06 00 0a 00 0c 00 0e 0f
SR1x  67 7d ffffffc5 78 00 ffffff83 0c ffffff8f 00 02 02 ffffff82 00 fffffff8 0a 00
SR2x  20 21 22 23 24 25 26 04 0c 00 2a 02 18 00 2e 2f
SR3x  10 17 41 63 00 00 00 00 00 00 3a 3b 3c 00 3e 00
SR4x  40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
SR5x  00 00 21 fffffff7 1f 1f 1f 7f 08 60 18 76 77 fffffff7 02 04
SR6x  ffffffa3 7f ffffff80 06 ffffff83 fffffff4 ffffff80 00 24 ffffffff ffffffff 24 02 ffffff88 ffffffa3 32
CR0x  63 4f 52 ffffff97 53 18 06 3e 00 40 00 00 00 00 00 00
CR1x  ffffffe9 2c ffffffdf 50 00 ffffffe8 ffffffeb ffffffeb ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
CR2x  ffffffff 00 00 00 00 00 00 00 00 00 00 00 00 ffffff8d 01 02
CR3x  ffffffe1 0c 40 20 10 00 ffffffbf ffffffdb 5b ffffffbd 15 5b 31 00 00 00
CR4x  01 03 00 00 00 00 02 ffffff80 ffffff81 ffffff88 00 ffffffff 7f 7c 40 40
CR5x  ffffffc1 00 00 00 00 00 00 00 13 ffffffe0 00 00 00 00 40 00
CR6x  00 00 00 00 00 00 ffffff89 01 ffffffff 00 00 03 00 ffffffff 00 ffffffee
CR7x  10 ffffffc0 07 1f 1f 1f 00 1f 01 04 1f 1f 17 17 17 17
CR8x  00 00 00 00 70 10 00 00 08 08 08 08 08 08 08 08
CR9x  ffffff80 50 00 00 00 00 00 00 00 00 00 00 00 00 00 00
CRax  1a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
CRbx  fffffff7 0c 00 00 00 00 00

--------------020404030100030309070601
Content-Type: application/x-compressed-tar;
 name="fbtest.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fbtest.tgz"

H4sIAE+PeUQAA+2dX3PbqBbA++xPwePuTJLlP5Kfku52upk7vXunvbOzr7IlZzyN7Uzs9Kb9
9BcQQkiWajuRsCNzxkkIIECA+R0OAs0mm2y9+e1dnwKlCMbUXyQYdP8W8g5BSjiR0SB+BxEU
grwDrNdSGXlab5JHAN5N5vf3P4u3K/yNyixv/2z+Y9VbJ9i7/bFgRMh4CKnoof09iNv+aTq9
VI6rzfOmyzxUA3NK29ofCVG0PxOEINn+FCP0DsAuC9EmZ97+3ybZGPz94csNwFcQpNkmm26y
9Gq0yhZj8IWA2+V09fiwekyUL/jv/+brTfYI3t/+9WW0yBarx+9jQBCP4NfJaLFKZVqcwmcK
4TNm3PWJXJ9IhnP5g+oeZRQEMX0WPHK9sExE+5d+BMuL1MX0a80H8UUt/zJO4VPGKQpQxinL
uKgXqYxkvZxYtpRONOvnxNOJ4+pNWz91bZbO0zEwfxBAI/2XQzzK5utkDD78+3f93zp7nCf3
8q5iElGE49EiWT7Nkunm6VGmSSlAcRyP5suHp80YJMvkfnUH1vM76bgaraePWbZcz3/ImJjK
mx7dJYuFTJxcyYqUMkofFusx+Pzx/QWQSc6/ZWA1m12A5Qqsn9YP2TLN3ZtkmU6+jzbzxXx5
NwYC615wLSD48wf45e+PN0XHuAC37z/9uhUxinTEfz7e4DLQtNM1t6k0hAkd9imZgtvbC3Dz
8HCfbccSOE9BdvSGQNYQaNr/mvGfBBYFqwTa1lYJm7BpERhz+Czv+TomP/dDUCYSIXiNYFz6
Rqob85qnvpxH1xw5l1OBn9Wviq/saaq3yWKPiu+/O/7/c2lq5DKP1NUYs2P8x1SG5eM/5zn/
lTOM/z7EjOj/GY2+fIbPAEACIAJwBiAEMAOQAcgBFPq39En072kROpNXIXmV/BKKFMy0TJlx
zHS03BkhdZVx54lj9UG4jDOL8vRlmlimiSHACGAMMFFDE2YAyzJQkztO9OWRdmcAq5IQeRWC
AAlAEeBE51L9kASQCSA6BZLleVF5FYXqEooBJWrApAxQDqhMJwI0BjQBdALoFNAU0AxQlRdT
daXTlIU05RcAzcxHyHuMgBweZAlFBoQo46gbpzIFLlPI/RKi4ps6gKqqjZsUV1EnFKraMP6z
0iE9ZcomWlSmTPDod92ybCZLDphtEQxYET+WVTHJK0RVhVtjNn1ZV7/rts7/z2J1Se5OdbK8
iJwJ1YtMASYNRX2RQ+aObe5uBORkofpMy8fcdaq7t6oTUt4LKrp0pPqPvetJkUs6AazIZSLj
IMAiWbG2lmRqqhfJlFFc7XIIkBiQyKk0p0plo4up7nsqBWbLM0UNXVd+UFGrWUOoTIHbPrnd
glE1a+OZxyG1hi5yyWSaIv9OmYJBNRTYTq6KNNP1SQtPYT/y2qhWHqFvwdxL1PiRV8W2HmTx
6Ky5Kpo+8tpElTap+jeNA9WrJmW/EnqEqUYY7R5F365U+W/0muPxXyAJfsX/MP/zI4H/vfGf
aJbGKilBnAHmSPyXWcg64UWakv88UYOlKK6a6cT5Lv5L9MkmYEJOn1QE6bApZKShYC9ynBbt
BVV9o4H2kzrtTb5x6ZD9NjD/IOY3fnMPYr4pOXFugQf+N0rz/B/xTz75z6Gd/wuaz/8ZDfz3
IcfmfzJc/p/T/J8eb/7vFvLo839cw/iL5v8zZIrRrS5g7uXNaQSyDruwApSF318XmA5eF2jm
P6f/8sp/bvnPMcz5TwL/fcix+T/g+f858d9kF7SAXAuodbwXaQFpPxYB+ub4X+Qbd6sF/Oza
89ECmu3/vvlv5/8CM6T5T8L6vxcJ/O/f/p8N0/5vGlk3gedVgKPQvm0VAONqN3vFKkBgvi2e
yVe8lvkmHYf8JKwFlNLMf8/2f1Gu/xOMNf9pWP/3Isfm/4Dt/+fB/xiePf9rPe0V/A+W/5rl
3zhePfM35Xe0ANOyXJf/fHWBKv+L/SzdPgC4i/8Ml/ynQij+CyQC/33Isfk/sPm/HhHlb5GP
jtAQ5hTs/25eZXY2ryLNmDnps700AnVHUb1IUTWyTdODdoCdwnjTDkztEcBKUDhPCtZsyLbP
xKVDhN0BB9oIROd6QfF1OBu9oIX/nS4AHMJ/xvT6vyCB/14k8D/wXzu6438tmk/y86mT72mQ
H9f48Aryp/1YB3pcHYj6XR2Y9cr/9Iz53+kCwE7+E2z5z6ne/ydoeP7Pixyb/wOz/wf+H5X/
lXxPhP+sM/7Ptp8s7IL/5r760wJYv6sDvWoBfE8t4K0+I+jyfzbp5wCg/ff/C4xJPv8XYf3f
i/TCfxE5AwxpJr/xGdj8/4Sf/5cVop7/t8/8C8CIrkDe/OR/Mc5VnvnHRVPmZ/6UNLAPt0/q
js5pv89Ib+qhnfBUKwK7CZ8CxNS/BLl1YtheP1vGo1Wf7sd2uA1Jnzy3/0aNn/qsnu2L8T5J
/rbn84dKC/+92v/L5/8Fpkyt/1NIcOC/D+mB/0gtwAb+nxr/zf4/O19NlS6A2nf+NfA/qfDf
ZOFqAQX3hqkFSPVn5tZM91rAoc//76kF0DelBeSOJOgCPqSF/17t/5QV9n9BoN7/RyEO838v
EvjfP//5MPlPA/m7I/+hT/7vSX5zR2+I/6ixH3on/1u15x8qNf73cgDwTv4TO/8n8re2/3MW
+O9DeuA/VbgL/K/s/zsB/ouJ3v/Hy7bgzh4+bpPSWfDmMVLv/5MwnDjn/0aAJQNkvkCApO69
B5t/L7N9Xp9jH4P2w5/nt0kL//3a/8v1f8Ipyef/wf7vRbrnfxTm/6fJ/0zzvwiKMeAFsmKi
cGdS2of/2+f/RCU/B6UFUPfw2WDz79fmn/eloAt4lBb++7X/l+v/FOGc/+H9P36kif/FUKFI
1fPz/8ZnwFqAXgVg9MRWAWBZ84yVbWQGy2LUV29fS3VDb2kBecx4qkJts2K938sE2aE3Loux
XeAXOXrQC5jm6j7P/Kf6S+Eirmu9YOddvOQ5/6iS6elrBOFZQC9S43/tAKDL1dcO8tj//D9B
iUCK/wwG/nuRHub/FPCJM/Cc7fz/hPf/2crPHTEpc0TUSV8Pkz+xBcjeguN6Ycy+MWdT4JAs
ArbGWNgR4MsuEAVdoC9p43++ACD5fzl52lwLfiVensch838B1fo/ExQG/vuQHviP1ZAZ+H+i
/GcNm/9jm75QiCvvaCf/UaUwZQTLqOGRn6vnJnsl/6Hn/AxwRaBF9wnM71ra+J8vAPjif/H+
P+krDP/D+3+8SOB/4H/g/2nx/9Bzfga7FwA33M4RtIAh7wX4Cf8vJw8PBHegBRzCf8zV+j/n
Isz/vUjgf//8h4H/s8D/wP+3yv8hWwEM/xdZOl8tf+snDwV5wVgb/5Xk/CeQCSH1BIQxE+8A
66c4VTlz/lfbP02nl7nzavO86SqPnfofZkb/Y5wgdf4Tk55B//Mh3ybZGPz94csNwFcQpNkm
m26y9Gq0yhZj8IWA2+V09fiwekyULzDaInh/+9eX0SJbrB6/jwFBPIJfJ6PFKpVp6RNEIHyW
ben6RK6Pecr4GdU9yijFRMT1wjIR7V/6ESwvUhfTrzUfxBe1/Ms4hU8ZpyhAGacs46JepDKS
9XJi2VI60ayfE08njqs3bf3UtfJ7mI6B+YMAGam/NOLxKJuvkzH49OEP/d86e5wn92Ogv0vT
eDpaJMunWTLdPD3qNKUyAeXFy4enzRisvy+nYLUEd49ZtrwAyTK5X92B9fxOOq5G66nyXs9/
qIqUF0aju2SxkHnhK6y/q6P0YbEeg88f38trp5v5twysZrMLsH5aP2TLVDo2yTKdfB9t5ov5
8m4MBNbd4Vqy/88f4Je/P94UPeQC3L7/9OtWRKm7qoj/fLzBZaBpMDkXLVJpCBM67FMyBbe3
F+Dm4eE+244lcJ6C7PENgawh0HQEm3djYGOyNrAxWYKfOaZFYF7sMrjoWdeRvq3bpfza3SfT
LAW/RAzRm4aYoqmAZWhTIWzHVMEmbLodyGGTr2COb5FNJWpZsiZP5/Kyjrf9RJMfG6UNBYLy
e7Scb1aPxVcCIYqt52OyvFP9Gl5G5AIweCl4EbRMFjLk0x8Co+jm84DUu51S5f8/vRwAfYD9
h2PC1POfiIT3P3iRY7//YcD2n9M8/9Hd+WGf/2w/BcoxC9TPgoaFeSQ/C5pbu4Eo7T9Jb/Yf
60BOFt7e+cAiWbENViAU161AJAYkciqthyc/izIM8A2PtKt3O1hHWP+pSBv/uzwA4oD9H5wy
vf8T8TD/9yKB/2d2/mM//DfZHU8LcIt6dC2gvnrzIi3g0HMh9tQCenzbY29aQO6Iu9MFYNAC
jLTxv8sDIA7hPyMi5394/tOLHJv/A3v/47nynx6P/A1VcXT+19D9Iv4feiL0nvw39/LmtADk
HsTVHf9h4H+F/30cAL37/OfS/i9Qbv/Hwf7vRY7N/wHP/+35j5L/xBlIjnX+40yf/2iPesCA
J2qAFMVVjSc/Oigozn+MVBOU5z+LMgUPb3g+irVfUNU3tjmPJnXOm3zj0pG//9mWOdj8d872
G7+5B3EeBsLvK23892r/L9//JCDM7f/h/Ac/Evjv5fznIfLfNHJ0BC3ALdjRtQBc26bwCi0g
2Pxt8Uy+oktdIAq6QF3a+O/V/u/yn/Gc/yLw34ccm/8Dtv8Pff6fB8Tw7PnfsvPzBfwPNv+a
zd84Xm35z7UA1b3rYA/8r/C/dgB0J3ns4j+DJf+x8le7NsL6vxc5Nv8HNv/XI6L8fbrnP+m8
to+AiIo0Y+akz/bSCNyjnmtscYuXu4a6RmBqj6h3fWzrCKjGE4/nQu+pI8A3px0U37LX6gXw
nPWCVv53uABwCP8JyflPwvufvUjgf+C/dnTH/1o0n+TnUyff0yA/rp0e5PFc6D3J3+PqQNTv
6sCsQ/63XnWm/O9wAWAn/5F9/4OgBAX+e5Rj839g9v/A/6Pyv3ZTJ6QFsGpXxLpHJWXl78P/
Q8+F3JP/5o7e3Px/+yDLV2sB7VcNVQuo8n826eMAoN3P/9vzHynkev0fi7D/34v0wn/hvGz2
fM9/PrH9f7JC1P4/u+dPAEZ0BfLmnX/FyFfZ84eLpszP/ClpsPWqxyGd/Cz/Jfu87RGXzWQc
qGyRfQj/lt75uD/V7b++3vx8xjw/VFr579H+Tym1/EdM7/9TywCB/x6kB/5LaAf+n+z5f3am
mipdALXv/G/gf1Lhv8nC1QKKyeQwtQCp/szcmulLCzh0F8Ax3//YmxaQO5KgC/Qrrfz3aP+3
+/8l/wnR+/8IDs//eZHA/8D/F/KfBvJ3Tf5Dn/8//pufeuI/auyNgfydyxb/ezgAaCf/UTn/
p1Tk9n8U+O9DeuA/VbgL/K/s/z8B/ouJ3v/Hy7bgzh4+bpPSWfzknY8KhhPn/J8IsGIde0jM
FwiQ1L33YPPvcbbP6+9YDLT3I638z+3/l6uvr8/jkPV/ltv/RZj/+5Ee3v8c5v+nyf9M878I
ijHgxcwwJgp3JqV9+L99/k9U8nNQWgB1j50NNn8fNv+8RwVdwIu08j+3/3viv7X/M4xgzv+w
/u9FAv8D/1/Ff3P+T+B/0UDGESz/L9MCUKVfBS2gZ9nif+0AoC4UgJ3853b+z4hQ838mvQP/
fUgP/KeATwL/9UhZDHunwP+GvOxeAFLmiKiTfrpDF5C9Bcf1wkQFEuHWpoABaAS2xljYEeDX
LhAFjaB7aed/dwaAvc//lfznBGv+47D/z4v0wH+shszA/xPlP2vY/B/b9IVCXHlHO/mPKoUp
I1g6DY/8XD036YH8h+72H6xFADfcTiB/R9LO/+4eADhg/x9jDOX8D+v/XiTwv3/+w8D/WeD/
C54I6GNF4C09EdBi+wjkDxIkSJDXy/8BxpIp5ABAAQA=
--------------020404030100030309070601--


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
