From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Re: Mixing g400 dualhead and old Millennium.
Date: Sun, 13 Oct 2002 16:15:16 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021013141516.GA9973@casa.fluido.as>
References: <20021012153641.GA13798@casa.fluido.as> <20021013001324.GF4267@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from a205017.upc-a.chello.nl ([62.163.205.17] helo=mail.fluido.as)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 180jWr-0001s6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Oct 2002 07:15:38 -0700
Content-Disposition: inline
In-Reply-To: <20021013001324.GF4267@ppc.vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

	Subject: Re: Mixing g400 dualhead and old Millennium.
	Date: dom, ott 13, 2002 at 02:13:24 +0200

Quoting Petr Vandrovec (vandrove@vc.cvut.cz):

> If it is G400, you must also insmod matroxfb_maven, otherwise
> there is no second output. 

Aha. That made the second output magically appear. Thanks!

> And you should build everything
> into kernel, not as a modules - you'll not have problem to find
> where secondary output lives then...

I was having problems in compiling things in kernel. Eventually, it
seems they were limited to compiling the latest 2.4.20-pre10-ac2
patch, which contains a more recent version of your material. With
that, both with modules and included in the kernel, I get the
following messages (here with modules);

PCI: Found IRQ 9 for device 00:0b.0
matroxfb: Matrox Millennium (PCI) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x6553)
matroxfb: framebuffer at 0xEB000000, mapped to 0xce8d0000, size 4194304
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device
PCI: Enabling device 01:00.0 (0000 -> 0002)
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x3270)
matroxfb: framebuffer at 0xE8000000, mapped to 0xcf0d6000, size 2097152
fb1: MATROX VGA frame buffer device
fb1: initializing hardware
i2c-core.o: adapter DDC:fb1 #0 on i2c-matroxfb registered as adapter 0.
i2c-core.o: adapter DDC:fb1 #1 on i2c-matroxfb registered as adapter 1.
i2c-core.o: adapter MAVEN:fb1 on i2c-matroxfb registered as adapter 2.
i2c-core.o: adapter DDC:fb0 #0 on i2c-matroxfb registered as adapter 3.
i2c-core.o: driver maven registered.
i2c-core.o: client [maven client] registered to adapter [MAVEN:fb1 on i2c-matroxfb](pos. 0).
matroxfb_crtc2: secondary head failed to register
matroxfb_crtc2: CRTC2 framebuffer failed to register

so that I cannot see the second head of the g400. With 2.4.19 and
module loading, instead of the last two lines I get:

matroxfb_crtc2: secondary head of fb1 was registered as fb2

This is not urgent for me now. I still cannot see if the output is
present on all outputs (somebody will have to physically check the
monitor outputs, and that will hopefully happen sometimes tomorrow),
but now the matroxset output looks very promising. 

In all cases, if you want me to do some tests or try some patch to see
if the 'failed to register' situation can be fixed, just ask.

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
