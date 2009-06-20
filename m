From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] Disable mach64 accelerator
	if	stride is not multiple of 64
Date: Sun, 21 Jun 2009 00:25:24 +0300
Message-ID: <20090620212524.GC9980@sci.fi>
References: <Pine.LNX.4.64.0906170559040.30231@hs20-bc2-1.build.redhat.com>
	<Pine.LNX.4.64.0906170600590.30231@hs20-bc2-1.build.redhat.com>
	<20090617172149.GA9980@sci.fi>
	<Pine.LNX.4.64.0906171657010.23412@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1MI846-0001un-Mk
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 20 Jun 2009 21:25:34 +0000
Received: from smtp6.welho.com ([213.243.153.40])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MI843-0007Yu-PN for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 20 Jun 2009 21:25:34 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0906171657010.23412@hs20-bc2-1.build.redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: paulus@samba.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, Jun 17, 2009 at 05:05:31PM -0400, Mikulas Patocka wrote:
> On Wed, 17 Jun 2009, Ville Syrj=E4l=E4 wrote:
> =

> > I was under the impression that 64 byte aligned offset and pitch are on=
ly
> > required if block writes are used. But perhaps it is always required
> > with SGRAM/WRAM, or perhaps you have auto block writes enabled. Can you
> > check the memory type and the the value of the HW_DEBUG register?
> =

> Memory is SGRAM M32L1632512A-8Q. See this: =

> http://www.digchip.com/datasheets/parts/datasheet/581/M32L1632512A.php
> =

> The status line is:
> atyfb: 3D RAGE PRO (Mach64 GP, PQFP, PCI) [0x4750 rev 0x7c]
> atyfb: 4M SGRAM (1:1), 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK, 100 =

> MHz XCLK
> =

> The debug register is zero (printed with printk("ATI INIT ENGINE, DEBUG =

> %08X", aty_ld_le32(HW_DEBUG, par)); at the end of aty_init_engine).

OK then it has auto block writes enabled.

> > > This patch disables accelerator if scanline is not multiple of 64 byt=
es.
> > =

> > A better option would be to round the pitch up in check_var(). Also it
> > would be more proper to use fix.line_length as the pitch value instead
> > of var.xres_virtual. That way check_var() could leave var.xres_virtual
> > alone and just round fix.line_length to whatever is required.
> > =

> > Actually now that I think about it I would prefer to round to 64 bytes
> > always when SGRAM/WRAM is found. The reason is that the mach64 DirectFB
> > driver always enables auto block writes on SGRAM boards and if atyfb
> > uses less alignment things will not work correctly. Perhaps atyfb should
> > enable auto block writes too.
> =

> So patch it to align line length (I don't know fb well to pick the right =

> place) and send me the patch and I'll test it.

I cooked up a patch and briefly tested it on my Dell Inspiron 7000
which has an LT Pro /w SGRAM. I will send it as part of a series now.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

---------------------------------------------------------------------------=
---
Are you an open source citizen? Join us for the Open Source Bridge conferen=
ce!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $2=
50.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.=
org
