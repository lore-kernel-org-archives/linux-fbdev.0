From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Bug on atyfb
Date: Sat, 11 Dec 2004 23:37:54 +0200
Message-ID: <20041211213754.GA14355@sci.fi>
References: <200412101844.10577.lucasvr@gobolinux.org> <200412110519.19633.adaplas@hotpop.com> <200412111451.42845.lucasvr@gobolinux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CdEwB-0006pV-Ku
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Dec 2004 13:37:59 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CdEw9-0004dL-H3
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Dec 2004 13:37:59 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id E49CAA17D1
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Dec 2004 23:37:54 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <200412111451.42845.lucasvr@gobolinux.org>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

On Sat, Dec 11, 2004 at 02:51:42PM -0200, Lucas Correia Villa Real wrote:
> On Friday 10 December 2004 19:19, Antonino A. Daplas wrote:
> > On Saturday 11 December 2004 04:44, Lucas Correia Villa Real wrote:
> > > Hi,
> > >
> > > I'm trying to use atyfb on 2.6.10-rc3, but I'm getting a kernel oop=
s just
> > > at modprobe time. By tracking the problem, it seems that
> > > 'pll_limits.xclk' is the heart of the problem, as seen in line 2210=
 from
> > > atyfb_base.c:
> > >
> > > par->xclk_per =3D 1000000/par->pll_limits.xclk;
> > >
> > > It happens that pll_limits.xclk is zero, because of an attribution =
made
> > > on line 3246:
> > >
> > > par->pll_limits.xclk =3D pll_block.XCLK_max_freq/100;
> > >
> > > pll_block.XCLK_max_freq, in this case, is read from BIOS a few line=
s
> > > above (at line 3229, to be more precise), and the value being retur=
ned
> > > from this copy here is 20. So we have a problem, since the result f=
rom
> > > 20/100 =3D 0 will be used as denominator to set par->xclk_per's val=
ue.
> >
> > Buggy BIOS?  Why not skip the init_from_bios() step, since xclk will =
be
> > initialized in the function correct_chipset(), just a few lines above=
?
> >
> > If that works, perhaps a boot option can be added such as no_bios?
>=20
> Hi,
>=20
> When trying to skip the initialization from bios the driver gets crazy:
>=20
> atyfb: using auxiliary register aperture
> atyfb: 3D RAGE II+ (Mach64 GTB) [0x4755 rev 0x9a]
> atyfb: 512K RESV, 14.31818 MHz XTAL, 200 MHz PLL, 67 Mhz MCLK, 67 MHz X=
CLK
> atyfb: Unsupported xclk source:  5.
> atyfb: vclk out of range
> atyfb: not enough video RAM
> atyfb: not enough video RAM
> atyfb: not enough video RAM
> ...
> atyfb: vclk out of range
> atyfb: can't set default video mode
> ...
>=20
> After this broken initialization, if I try to rmmod atyfb, the kernel o=
ops'es.=20
> So, I've decided to keep doing the initialization from bios, but if the=
 bios=20
> is told to be buggy, correct_from_chipset() is called again to fix some=
 stuff=20
> informed by the bios.

Are you saying you don't get these warnings if you call init_from_bios()?=
=20
That sounds really strange as the only thing init_from_bios() does is get=
=20
the PLL limits. So if you call correct_chipset() after init_from_bios() i=
t=20
should behave exactly the same as if you didn't call init_from_bios() in=20
the first place.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
