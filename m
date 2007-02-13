From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] nvidiafb: allow ignoring EDID info
Date: Tue, 13 Feb 2007 10:25:41 +0100
Message-ID: <cb7bb73a0702130125r25ddfe33na48ae673d5ce60ae@mail.gmail.com>
References: <21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
	 <20070130203301.GA15067@dreamland.darkstar.lan>
	 <20070204201713.GA12867@dreamland.darkstar.lan>
	 <cb7bb73a0702041317u4ca2fbabp45cf56526e57c982@mail.gmail.com>
	 <20070205201824.GA13431@dreamland.darkstar.lan>
	 <cb7bb73a0702051328n50c889d9o461ac2bb9f9ea75e@mail.gmail.com>
	 <Pine.LNX.4.64.0702062118450.9224@pentafluge.infradead.org>
	 <20070207234837.GA27822@dreamland.darkstar.lan>
	 <cb7bb73a0702071619p5984c39fs16e3d05c11d45585@mail.gmail.com>
	 <20070211181743.GA15801@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751224AbXBMJZp@vger.kernel.org>
In-Reply-To: <20070211181743.GA15801@dreamland.darkstar.lan>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Luca Tettamanti <kronos@people.it>
Cc: James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org

(some of you might get this mail in double copy , sorry)

On 2/11/07, Luca Tettamanti <kronos@people.it> wrote:
> Sorry for the delay.

Ditto!

It also seemed that my kernel compiling sk1llz had gone AWL, I
couldn't get the newly compiled kernel to run, until I realized the
initrd.img was mislinked. Anyway.

Your patch has an immediately visible effect of reducing snow: it
seems that now that you fixed the access bug the EDID is properly
/not/ used. dmesg | grep nvidiafb now claims the following:

"""

nvidiafb: Device ID: 10de0112
nvidiafb 0000:01:00.0: Unable to read EDID block.
nvidiafb 0000:01:00.0: Unable to read EDID block.
nvidiafb 0000:01:00.0: Unable to read EDID block.

(it actually gave the "I2C probe failed ..." message on console, but
it's not appearing in the dmesg, obviously, since it's a simple
printk)

nvidiafb 0000:01:00.0: Unable to read EDID block.
nvidiafb 0000:01:00.0: Unable to read EDID block.
nvidiafb 0000:01:00.0: Unable to read EDID block.
nvidiafb: CRTC 1 is currently programmed for DFP
nvidiafb: Using DFP on CRTC 1
nvidiafb: Panel size is 1600 x 1200
nvidiafb: Panel is TMDS
nvidiafb: MTRR set to ON
nvidiafb: Flat panel dithering disabled
nvidiafb: PCI nVidia NV11 framebuffer (32MB @ 0xE0000000)

"""

So the EDID still seems to be totally inaccessible (which means I
can't really tell why/when/where it's b0rked).

=46inally, as I mentioned, console still has a little snow. It's barely
perceptible in common console usage because the monitor is mostly
black, but can get annoying with fullscreen apps =E0 la mc.

This extra snow *might* be the effect of bandwidth limits Antonino
Daplas was referring to in this lkml message:
http://lkml.org/lkml/2005/10/1/7 but I'll have to enquire on this
further.

--=20
Giuseppe "Oblomov" Bilotta
