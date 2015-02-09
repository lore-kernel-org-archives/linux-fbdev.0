From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 09 Feb 2015 08:52:39 +0000
Subject: Re: [PATCH 7/8] fbdev: ssd1307fb: Add sysfs handles to expose contrast and dim setting to userspace.
Message-Id: <20150209085239.GX2079@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="R9dSeJxMIUBTi9Do"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-8-git-send-email-niederp@physik.uni-kl.de>
 <20150207114329.GQ2079@lukather>
 <20150207174244.25987977@maestro.intranet>
In-Reply-To: <20150207174244.25987977@maestro.intranet>
To: tomi.valkeinen@ti.com, Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, linux-kernel@vger.kernel.org


--R9dSeJxMIUBTi9Do
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2015 at 05:42:44PM +0100, Thomas Niederpr=FCm wrote:
> > > +static struct device_attribute device_attrs[] =3D {
> > > +	__ATTR(contrast, S_IRUGO|S_IWUSR, show_contrast,
> > > store_contrast),
> > > +	__ATTR(dim, S_IRUGO|S_IWUSR, show_dim, store_dim),
> > > +
> > > +};
> > > +
> >=20
> > I would have thought this was something accessible through the
> > framebuffer ioctl.
> >=20
> > Apparently it's not, at least for the contrast, so maybe it should be
> > added there, instead of doing it for a single driver?
>=20
> I think the contrast setting for an OLED display is much like the
> backlight setting for LCD panel. Since there is also no ioctl to set
> the backlight of an LCD I wonder if the contrast of an OLED should have
> one.

It's too much of framebuffer interface debate for me here. Tomi?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--R9dSeJxMIUBTi9Do
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU2HVXAAoJEBx+YmzsjxAgmKgP/AwA5Hukl/UAmFxppcZ4VjVA
gx4s1PKx9AiMuJDqbYjoCO4X4o+SuuMB5BIVvYj5QmexizbyCPkwxfHJnI2ez9Bf
wDD3z4jBtazHHa57hilrOOdrhCR4tZkdQE+fYEwrdB2yfkYtr9rnrNTU3v7furmu
UmIN2VoAISub58a5e+ua1dwoaFKb2rhzY9B+oc440Qt+d7wX4+CYtboWtfx5FrWU
fnL6xR/mYwcFzHSCO3Z1dtKL2LLnHUrg6RPG96JTChogzzdT1E1/qqtruMxgCnVx
iHCj3UyxfEoEgyohlosiGuklfqWprFPRDnHct8xc6uNe+x266/oikzl0bYOugXGl
unqD26exAOcZXDnhiBktJKTvped9mtasBLJ9BgHOS6/oRYuJBrbMGBWwKCUGRK9f
zktHPD/0vlLSOTEgB8yytzJKB1dbl7kX1Li1LOROJkNvwAf+JSKdwD6AgAN8Pf1H
7Vk7s53U1oD8H3lcC6gaSiACQ+YAK9DIMBhvPt5fPD+iYvxwajHQ2SFn5ybpHOMG
xWQ84em4v/78QlTYJ3STcxwnvC6imXNk50KoBl3qGfXR2csBNn7/uLfLuViXuL+V
AYjWmSwSl31VsM7u6pPKTZ3VjscqyD7KRfmGW8A+ywi1r+4omBYQhx2zGX/VfHpg
Ku3bV+d7rWafwLxeJqn+
=Bu58
-----END PGP SIGNATURE-----

--R9dSeJxMIUBTi9Do--
