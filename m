From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 07 May 2015 11:28:01 +0000
Subject: Re: [PATCHv6 05/10] ARM: mxs: fix in tree users of ssd1306
Message-Id: <20150507112759.GC3162@dragon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1427826436-21783-1-git-send-email-niederp@physik.uni-kl.de>
 <1427826436-21783-6-git-send-email-niederp@physik.uni-kl.de>
 <554B44A7.1090007@ti.com>
In-Reply-To: <554B44A7.1090007@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, maxime.ripard@free-electrons.com
Cc: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>, Sascha Hauer <kernel@pengutronix.de>, plagnioj@jcrosoft.com, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 07, 2015 at 01:55:35PM +0300, Tomi Valkeinen wrote:
> Hi,
>=20
> On 31/03/15 21:27, Thomas Niederpr=FCm wrote:
> > This patch updates the in tree-users of the SSD1306 controller for using
> > the newly introduced DT properties.
> >=20
> > Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> > ---
> >  arch/arm/boot/dts/imx28-cfa10036.dts | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/i=
mx28-cfa10036.dts
> > index b04b6b8..570aa33 100644
> > --- a/arch/arm/boot/dts/imx28-cfa10036.dts
> > +++ b/arch/arm/boot/dts/imx28-cfa10036.dts
> > @@ -99,6 +99,9 @@
> >  					solomon,height =3D <32>;
> >  					solomon,width =3D <128>;
> >  					solomon,page-offset =3D <0>;
> > +					solomon,com-lrremap;
> > +					solomon,com-invdir;
> > +					solomon,com-offset =3D <32>;
> >  				};
> >  			};
>=20
> Should this patch be merged separately via proper tree? I can take the
> rest of the patches via fbdev tree. I can, of course, take this via
> fbdev also, if I get an ack.

@Maxime

I assume you're the person, right?

Shawn
