From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [Linux-fbdev-devel] [PATCH] atyfb: fix distorted image on
	PowerMacs
Date: Tue, 3 Feb 2009 20:56:25 +0200
Message-ID: <20090203185624.GC22401@sci.fi>
References: <46e1c7760901221022p697f1689ubf03c909cdf1b99b@mail.gmail.com> <20090122201204.GD4996@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753147AbZBCS4i@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090122201204.GD4996@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Risto Suominen <risto.suominen@gmail.com>, Alex Kern <alex.kern@gmx.de>, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net

On Thu, Jan 22, 2009 at 10:12:04PM +0200, Ville Syrj=E4l=E4 wrote:
> On Thu, Jan 22, 2009 at 08:22:48PM +0200, Risto Suominen wrote:
> > Since the complete re-write in 2.6.10, some PowerMacs (At least Pow=
erMac 5500
> > and PowerMac G3 Beige rev A) with ATI Mach64 chip have suffered fro=
m unstable
> > columns in their framebuffer image. This seems to depend on a value=
 (4) read
> > from PLL_EXT_CNTL register, which leads to incorrect DSP config par=
ameters to
> > be written to the chip. This patch uses a value calculated by aty_i=
nit_pll_ct
> > instead, as a starting point.
>=20
> AFAICS it should be the right thing to do on other systems too. I hav=
e
> a good collection of mach64 pci cards and laptops so I'll try to find
> some time next week to test that theory on x86.

Well, the experiment failed on the first Mobility I tried. The FIFO
calculations aren't obvious from the code and there's no mention how
to actually calculate them in the programming guide. So I guess special
casing powermacs is the best way forward.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
