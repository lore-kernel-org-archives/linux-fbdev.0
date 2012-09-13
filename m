From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Sep 2012 07:27:11 +0000
Subject: Re: [PATCH v6 1/4] Runtime Interpreted Power Sequences
Message-Id: <1347521231.7471.51.camel@lappyti>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-k/2ptgd5nhGu/j+xHFPM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
 <1464760.6eqxJ2IzZ2@percival> <1347517377.7471.23.camel@lappyti>
 <2689722.93BQTh4lSC@percival> <1347519249.7471.42.camel@lappyti>
 <20120913070012.GC6180@pengutronix.de> <1347519807.7471.45.camel@lappyti>
 <20120913071829.GE6180@pengutronix.de>
In-Reply-To: <20120913071829.GE6180-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>


--=-k/2ptgd5nhGu/j+xHFPM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-13 at 09:18 +0200, Sascha Hauer wrote:
> On Thu, Sep 13, 2012 at 10:03:27AM +0300, Tomi Valkeinen wrote:
> > On Thu, 2012-09-13 at 09:00 +0200, Sascha Hauer wrote:
> > > On Thu, Sep 13, 2012 at 09:54:09AM +0300, Tomi Valkeinen wrote:
> > > > On Thu, 2012-09-13 at 15:36 +0900, Alex Courbot wrote:
> > > > > On Thursday 13 September 2012 14:22:57 Tomi Valkeinen wrote:
> > > > > =20
> > > > > > However, I fear these board specific things may be quite a bit =
anything,
> > > > > > so it may well be pwm, gpios and regulators are not enough for =
them. For
> > > > > > example, there could be an FPGA on the board which requires som=
e
> > > > > > configuration to accomplish the task at hand. It could be rathe=
r
> > > > > > difficult to handle it with a generic power sequence.
> > > > >=20
> > > > > Right. Note that this framework is supposed to be extended - I wo=
uld like to=20
> > > > > at least add regulator voltage setting, and maybe even support fo=
r clocks and=20
> > > > > pinmux (but that might be out of place).
> > > >=20
> > > > Yes, that's one concern of mine... I already can imagine someone
> > > > suggesting adding conditionals to the power sequence data. Perhaps =
also
> > > > direct memory read/writes so you can twiddle registers directly.
>=20
> These memory writes can be avoided when these registers are abstracted
> as a regular gpio/regulator/pwm driver.

Only if they are gpios/regulators/pwms. Yes, I agree most of the
possible things to configure would be among those (or perhaps
pinmuxing). But there's always the odd one that's not one of those.

> > Do you have examples of board specific power sequences or such?
>=20
> Sure, tons of. One board needs a gpio to be set high to enable backlight,
> the next one to low, a regulator has to be enabled, and to avoid
> flickering a certain timing has to be ensured. This is all highly board
> specific.

Okay. In my experience these have always been device specific. In the
case of backlight, the backlight device requires one gpio to be set
high, other one low, etc.

Can you share a bit more what kind of HW configuration you have that
requires this? The backlight is not a single piece of HW added to the
board (or embedded into a panel module), but consists of multiple HW
blocks integrated in a custom way to the board?

 Tomi


--=-k/2ptgd5nhGu/j+xHFPM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQUYrPAAoJEPo9qoy8lh711dIQAJzA+buJca5+Q6nt7q63/8NU
+iWHANBqlnI+j9ipnsK4jzLI+ibBmWhtmgWBPa9B04Ju9keyvdSKlujPpngnIlyE
s7zrTsabhj7jQJcNuKoy4xseApsg3gELj2uJYCvCvIdaH/kX2MCnHsThbccKRVMm
neX8+XrUJJXD2K5xAZmn9XWX0IX+JkzLOdg/b6trVjyPiA3uRnLs+zpEUGyE1bQ6
ZS+FnP7aXUoNXTTm+sDOTcp05/4faLTqCd9RoVA7VUIFsH+BbmwThluuvThypzu+
IAiR2LDuc9JrbNIuLsjO24jr+IJSa7pkYdx1CTapjTJE6INAQrVykA8xf3YB+ZJN
C6IoUrok7Wle1pdh657pGaSzYmY4VmCPz3VS2uOV6COB6mkRfkdi2YoLmqWoj2Ww
ZUlL6sUFVnPKMaxfF1j9vqZFdInnk9bhS6FpGt8YabBdQAcTBPmaBUTG6fWFWWxy
O0gQ4y14ptx8HWuNkuq6Q6fw9Zzxl5rvZeHTDxpU61b89zHtPzTLtPa7TKC6my+A
lzEOBlMK0XtkR9GC/hhRMbRJsBHVXJM4TCHBeKBqTnDwIN8B594RtLy7gjkgAUkK
sJHBQ+YX9uhpWetfDhFkbnRixLn+e0Kfuu6imzOLqqPTlsci5UgokX5LCyqiX4m8
iguQYW51jH6DcZGzzi8h
=UOzy
-----END PGP SIGNATURE-----

--=-k/2ptgd5nhGu/j+xHFPM--

