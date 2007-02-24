From: Chris Rankin <rankincj@yahoo.com>
Subject: Kernel warning from Matrox Framebuffer in 2.6.20.1
Date: Sat, 24 Feb 2007 13:08:56 +0000 (GMT)
Message-ID: <306590.53720.qm@web52912.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932566AbXBXNI6@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="windows-1252"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

Hi,

I have just booted 2.6.20.1 on my Pentium 3 machine, which has a G400 M=
AX graphics card. This
machine uses the Matrox framebuffer and TV-OUT modules, and I have foun=
d these warnings in the
kernel log:

**WARNING** I2C adapter driver [DDC:fb0 #0] forgot to specify physical =
device; fix it!
**WARNING** I2C adapter driver [DDC:fb0 #1] forgot to specify physical =
device; fix it!
**WARNING** I2C adapter driver [MAVEN:fb0] forgot to specify physical d=
evice; fix it!

The relevant kernel modules seem to be:

matroxfb_maven         13228  0
i2c_matroxfb            4064  0
i2c_algo_bit            6312  1 i2c_matroxfb

Cheers,
Chris



	=09
___________________________________________________________=20
All New Yahoo! Mail =96 Tired of unwanted email come-ons? Let our SpamG=
uard protect you. http://uk.docs.yahoo.com/nowyoucan.html
