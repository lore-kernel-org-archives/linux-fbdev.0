From: "James H. Cloos Jr." <cloos@jhcloos.com>
Subject: dell i8100 touchstick, 2.5 input -- further info
Date: 18 Dec 2002 16:58:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <m3fzsvj8g8.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

I've been researching the touchstick breakage in 2.5 on the i8100.

The board appears to use a SMC lpc47n252 superIO chip for keyboard and
ps/2 support.  Details on the chip are at:

http://www.smsc.com/main/datasheets/47n252.pdf
http://www.smsc.com/main/datasheets/47n252add.pdf

It has four ps/2 ports, matrix kb support and an i8051 compatible
=B5core.  The i8051 code, then, is responsible for muxing the four ps/2
ports to the host's 0x60/0x64 ioports.

Dell's bios upgrade tool flashes the 47n252. =20

I added some printk()s to i8042.c and confirmed that (unless something
else is accessing the kbc during the mux activation test) the synaptics=
,
et al mux protocol is not supported. =20

Something the 2.5 input system is doing is resetting the kbc to a
state where it no longer muxes its ps2 ports.

Obviously, a dump of the i8051 or bios code would provide all the answe=
rs.

Does anyone have any ideas on where to go from here?

Having to use the touchpad is bloody irritating. :(

-JimC
