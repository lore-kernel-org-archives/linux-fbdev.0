From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Mixing g400 dualhead and old Millennium.
Date: Sat, 12 Oct 2002 17:36:41 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021012153641.GA13798@casa.fluido.as>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from a205017.upc-a.chello.nl ([62.163.205.17] helo=mail.fluido.as)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 180OK6-0002uN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Oct 2002 08:37:02 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-fbdev-devel@lists.sourceforge.net

Hello. I am trying to obtain a 'simple' system where 3 framebuffers
output their images to three monitors (no TV output). In the past I
was able to have 4 outputs using 4 old millenniums. Now I have to help
a friend who lives 1000 kms from here, and who hasn't enough PCI slots
(and would not find 3 millenniums anyway...) So, he found a dualhead
AGP g400 (PCI ID 102b:0525) and an old Millennium (PCI ID 102b:0519,
MGA 2064W).

Using kernel 2.4.19, and loading kernel modules in this order:

i2c-matroxfb
matroxfb_base
matroxfb_crtc2

I see the cards as follows:

PCI: Found IRQ 9 for device 00:0b.0
matroxfb: Matrox Millennium (PCI) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x6553)
matroxfb: framebuffer at 0xEB000000, mapped to 0xce875000, size 4194304
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device
PCI: Enabling device 01:00.0 (0000 -> 0002)
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26208)
matroxfb: framebuffer at 0xE8000000, mapped to 0xcf07b000, size 33554432
fb1: MATROX VGA frame buffer device
fb1: initializing hardware
i2c-core.o: adapter DDC:fb1 #0 on i2c-matroxfb registered as adapter 0.
i2c-core.o: adapter DDC:fb1 #1 on i2c-matroxfb registered as adapter 1.
i2c-core.o: adapter MAVEN:fb1 on i2c-matroxfb registered as adapter 2.
i2c-core.o: adapter DDC:fb0 #0 on i2c-matroxfb registered as adapter 3.
matroxfb_crtc2: secondary head of fb1 was registered as fb2

And I see the fb's: /proc/fb contains

0 MATROX VGA
1 MATROX VGA
2 MATROX CRTC2

The console is on the Millennium. The problem is that writing to
/dev/fb2 does not result in something appearing on the 2nd output of
the G400. Now, I must admit that my mind is not a little confused with
the usage and capacites of the matroxset utility, but here at home, I
was able to cleanly use the second output of my G450 with the
following code (run at boot time):

/usr/src/matroxset/matroxset -f /dev/fb1 -m 0
/usr/src/matroxset/matroxset -f /dev/fb0 -m 1
/usr/src/matroxset/matroxset -f /dev/fb1 -m 2

So, I tried the same on this remote machine (using /dev/fb1 and
/dev/fb2, of course). The third command is not successful. I explored
things a bit. I wrote a short program that calls 3 ioctls,
respectively 

MATROXFB_GET_OUTPUT_CONNECTION,
MATROXFB_GET_AVAILABLE_OUTPUTS and
MATROXFB_GET_ALL_OUTPUTS.

On my home machine, /dev/fb0 gives 1, 1 and 3, while /dev/fb1 gives 2,
2 and 3. I understand that these are bitmaps: all is good. On the
remote machine,

fb0 (millennium) gives 1, 1 and 1 (ok, only one output)
fb1 (g400 1st head) gives 1, 5 and 5
fb2 (g400 2nd head) gives 0, 0 and 5

So, it seems that the second bit is not available in the g400. In its
place, there seems to be a third bit, what in matroxfb.h is defined as
MATROXFB_OUTPUT_DFP; this, as far as I can see, relates to a digital
flat panel interface, some possible third output on the card (that I
cannot investigate since the card is far far away).

In all cases, it appears (when looking at the source of the driver)
that the second head cannot be assigned this value, so that
MATROXFB_GET_AVAILABLE_OUTPUTS is 0 for it. I can assign it to the
first head, as follows

/usr/src/matroxset/matroxset -f /dev/fb2 -m 0
/usr/src/matroxset/matroxset -f /dev/fb1 -m 4

but after that, too, MATROXFB_GET_AVAILABLE_OUTPUTS for the second
head is 0. Or I can assign 1 to the second head, but then I cannot
assign 4 to the first head, although it is allowed in
MATROXFB_GET_AVAILABLE_OUTPUTS, because I can only assign a value to
the primary head if the secondary head has no output assigned. 

I thought I may solve the problem by having the g400 card detected as
first and the Millennium as second, but this seems to be impossible,
since AGP is detected after PCI. 

Is this a bug? What can I do about it?

Thanks in advance...

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
