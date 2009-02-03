From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] atyfb: fix distorted image on
 PowerMacs
Date: Wed, 04 Feb 2009 08:06:12 +1100
Message-ID: <1233695172.16867.91.camel@pasglop>
References: <46e1c7760901221022p697f1689ubf03c909cdf1b99b@mail.gmail.com>
	 <20090122201204.GD4996@sci.fi>  <20090203185624.GC22401@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753104AbZBCVG4@vger.kernel.org>
In-Reply-To: <20090203185624.GC22401@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="euc-kr"
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Risto Suominen <risto.suominen@gmail.com>, Alex Kern <alex.kern@gmx.de>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Tue, 2009-02-03 at 20:56 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> On Thu, Jan 22, 2009 at 10:12:04PM +0200, Ville Syrj=C3=A4l=C3=A4 wro=
te:
> > On Thu, Jan 22, 2009 at 08:22:48PM +0200, Risto Suominen wrote:
> > > Since the complete re-write in 2.6.10, some PowerMacs (At least P=
owerMac 5500
> > > and PowerMac G3 Beige rev A) with ATI Mach64 chip have suffered f=
rom unstable
> > > columns in their framebuffer image. This seems to depend on a val=
ue (4) read
> > > from PLL_EXT_CNTL register, which leads to incorrect DSP config p=
arameters to
> > > be written to the chip. This patch uses a value calculated by aty=
_init_pll_ct
> > > instead, as a starting point.
> >=20
> > AFAICS it should be the right thing to do on other systems too. I h=
ave
> > a good collection of mach64 pci cards and laptops so I'll try to fi=
nd
> > some time next week to test that theory on x86.
>=20
> Well, the experiment failed on the first Mobility I tried. The FIFO
> calculations aren't obvious from the code and there's no mention how
> to actually calculate them in the programming guide. So I guess speci=
al
> casing powermacs is the best way forward.

There's one powermac with a M1 (the first clamshell ibook). I don't hav=
e
such a machine however, it would be useful if somebody who did could
test if the patch caused a regression there...

It's possible that we should instead base the code on the chip variant.

Ben.
