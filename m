From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Sep 2012 07:03:27 +0000
Subject: Re: [PATCH v6 1/4] Runtime Interpreted Power Sequences
Message-Id: <1347519807.7471.45.camel@lappyti>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-HGYq0tzyMtgGlYGPESbW"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
 <1464760.6eqxJ2IzZ2@percival> <1347517377.7471.23.camel@lappyti>
 <2689722.93BQTh4lSC@percival> <1347519249.7471.42.camel@lappyti>
 <20120913070012.GC6180@pengutronix.de>
In-Reply-To: <20120913070012.GC6180-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>


--=-HGYq0tzyMtgGlYGPESbW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-13 at 09:00 +0200, Sascha Hauer wrote:
> On Thu, Sep 13, 2012 at 09:54:09AM +0300, Tomi Valkeinen wrote:
> > On Thu, 2012-09-13 at 15:36 +0900, Alex Courbot wrote:
> > > On Thursday 13 September 2012 14:22:57 Tomi Valkeinen wrote:
> > > =20
> > > > However, I fear these board specific things may be quite a bit anyt=
hing,
> > > > so it may well be pwm, gpios and regulators are not enough for them=
. For
> > > > example, there could be an FPGA on the board which requires some
> > > > configuration to accomplish the task at hand. It could be rather
> > > > difficult to handle it with a generic power sequence.
> > >=20
> > > Right. Note that this framework is supposed to be extended - I would =
like to=20
> > > at least add regulator voltage setting, and maybe even support for cl=
ocks and=20
> > > pinmux (but that might be out of place).
> >=20
> > Yes, that's one concern of mine... I already can imagine someone
> > suggesting adding conditionals to the power sequence data. Perhaps also
> > direct memory read/writes so you can twiddle registers directly. And so
> > on. Where's the limit what it should contain? Can we soon write full
> > drivers with the DT data? =3D)
>=20
> I have this concern aswell, that's why I'm sceptical about this patch
> set. But what are the alternatives? Adding power code to the drivers and
> thus adding board specific code to them is backwards.

As was pointed out in earlier posts in this thread, these are almost
always device specific, not board specific.

Do you have examples of board specific power sequences or such?

 Tomi


--=-HGYq0tzyMtgGlYGPESbW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQUYU/AAoJEPo9qoy8lh711ZMP/3JNh0JDh9aq72eFbQy8glAx
8drMjd/6Jd+hscvylkikwaxoUrU1J+i1VwC/hXJOEEh6x+3FocG+QwJRuhryjDTl
20oZrjgYIuX6ee++RCA7hLXg+ubIrcQEvT2jDESY/VPaCy/xYCFrdAkA07gexWoY
/L3au+u55sXbau6E20VWkZZkw0vwBpA+n1WRPhv705Sj8gxkn71kpxj7i7B3rS63
bdEprYEj/ac3Uz12skBjaPVXMc280/ELiBqZYhcaTLq60Bwr0GuQ9neIiBUxR2Af
1eDUi/5vnm0euHfndC2w69Gh/gxXwVVQTiCpCb1Zg7xXftGXrx37ejS4srBoAiV9
Z7jwxEuXINx/zOUTI348ZY996k9hZ5nZ4jZGOuotOR1Ek5mSXz+Chpq7Ht+Wnnty
YSkCV/R2EypYVNE4oU4k1O0aQFgKa3Fu0KFGCpIpZMBaQ8eq3rq438ySF9NsQaRV
F6fZmx5yEuertbFiP2AepsiExbrErlAvp2gfnHnVvUVmlsu9jQIepUxwNUfBsZIU
O/sxKvCDviAz0WKq811isbpT4vbavs8+6sjvWeXQfznsiYfHVtsFcsidfJMxUDR8
EGCPbzy7Pag8c9+5qmAiJQYz6iig2ClHJZ/XkHUxV+w8Ak43K/9BA+ypOSGZzDPf
Yl0MREZklImPMXkT7ZRx
=s2EQ
-----END PGP SIGNATURE-----

--=-HGYq0tzyMtgGlYGPESbW--

