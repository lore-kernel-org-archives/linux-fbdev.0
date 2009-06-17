From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] Disable mach64 accelerator if
 stride is not multiple of 64
Date: Wed, 17 Jun 2009 17:05:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0906171657010.23412@hs20-bc2-1.build.redhat.com>
References: <Pine.LNX.4.64.0906170559040.30231@hs20-bc2-1.build.redhat.com>
	<Pine.LNX.4.64.0906170600590.30231@hs20-bc2-1.build.redhat.com>
	<20090617172149.GA9980@sci.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279731514-974363430-1245272731=:23412"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpatocka@redhat.com>) id 1MH2K8-0000sh-M7
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Jun 2009 21:05:36 +0000
Received: from mx1.redhat.com ([66.187.233.31])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH2K6-0008BX-SZ for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Jun 2009 21:05:36 +0000
In-Reply-To: <20090617172149.GA9980@sci.fi>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-fbdev-devel@lists.sourceforge.net, paulus@samba.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--279731514-974363430-1245272731=:23412
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Wed, 17 Jun 2009, Ville Syrj=E4l=E4 wrote:

> On Wed, Jun 17, 2009 at 06:02:30AM -0400, Mikulas Patocka wrote:
> > On my card, the accelerator corrupts display if its line length is not
> > multiple of 64 bytes.
> >=20
> > Misaligned lines in the drawn recrangle are shifted left, as if the acc=
elerator
> > thought that every line begins on 64-byte boundary. For example, in 800=
x600x8
> > (scanlines are aligned on 32 bytes) every odd scanline is drawn shifted=
 by
> > 32 bytes to the left.
> >=20
> > The card is ATI Technologies Inc 3D Rage Pro 215GP (rev 5c) onboard on
> > Sparc64 Ultra 5.
>=20
> I think normally the offset should be just aligned to 8 bytes and pitch
> to 8 bytes and 8 pixels.
>=20
> I was under the impression that 64 byte aligned offset and pitch are only
> required if block writes are used. But perhaps it is always required
> with SGRAM/WRAM, or perhaps you have auto block writes enabled. Can you
> check the memory type and the the value of the HW_DEBUG register?

Memory is SGRAM M32L1632512A-8Q. See this:=20
http://www.digchip.com/datasheets/parts/datasheet/581/M32L1632512A.php

The status line is:
atyfb: 3D RAGE PRO (Mach64 GP, PQFP, PCI) [0x4750 rev 0x7c]
atyfb: 4M SGRAM (1:1), 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK, 100=20
MHz XCLK

The debug register is zero (printed with printk("ATI INIT ENGINE, DEBUG=20
%08X", aty_ld_le32(HW_DEBUG, par)); at the end of aty_init_engine).

> > This patch disables accelerator if scanline is not multiple of 64 bytes=
=2E
>=20
> A better option would be to round the pitch up in check_var(). Also it
> would be more proper to use fix.line_length as the pitch value instead
> of var.xres_virtual. That way check_var() could leave var.xres_virtual
> alone and just round fix.line_length to whatever is required.
>=20
> Actually now that I think about it I would prefer to round to 64 bytes
> always when SGRAM/WRAM is found. The reason is that the mach64 DirectFB
> driver always enables auto block writes on SGRAM boards and if atyfb
> uses less alignment things will not work correctly. Perhaps atyfb should
> enable auto block writes too.

So patch it to align line length (I don't know fb well to pick the right=20
place) and send me the patch and I'll test it.

BTW. why doesn't it use accelerator for screen scrolling? It seems to=20
redraw all non-empty characters, which is fast if most of the screen is=20
empty but gets slower if the screen is full of text.

Mikulas

> --=20
> Ville Syrj=E4l=E4
> syrjala@sci.fi
> http://www.sci.fi/~syrjala/
>=20
--279731514-974363430-1245272731=:23412
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--279731514-974363430-1245272731=:23412
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--279731514-974363430-1245272731=:23412--
