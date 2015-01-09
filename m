From: "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>
Date: Fri, 09 Jan 2015 11:03:57 +0000
Subject: Re: SSD1306 OLED driver
Message-Id: <20150109110357.GA26781@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
To: linux-fbdev@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2015 at 03:45:01PM +0530, Ssagarr Patil wrote:
>=20
> Hi Maxime,
>=20
> >>> Thanks for the pointer, I am using spi_write() call and I see /dev/fb=
0 node created.
> >>> but when I do echo "1121"> /dev/fb0 nothing comes up on oled any poin=
ters on this ?
> >>
> >> You can't use it like that. It's a standard framebuffer, that is
> >> represented as an array of pixels, so you need to use a font rendering
> >> software if you want to output some text.
> >>
> > can fbtest
> > (https://git.kernel.org/cgit/linux/kernel/git/geert/fbtest.git/)
> > be used to to draw something ?
> >
> how do I set pixels of it ? Please if you can point me to some stuff that=
 would be helpful.

Last time I tried, fbtest didn't support monochrome display.

And you'll find anything you need in the documentation.
https://www.kernel.org/doc/Documentation/fb/framebuffer.txt

>=20
> Thanks And Regards,
> Sagar
>=20
>  		 	   		 =20

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUr7WdAAoJEBx+YmzsjxAgaioP+wVycY3SEffCwTOJl7K3GLI9
rT7D/k9HlXCc3prNQk7SQ+n1VS6eqIMlYaitdLdLO/CC6rl6XLB5rUHclLpix6DI
167LK/86rFOlGhkyJV/+QRf3ctRE1qOA9g0Yzdu4WmVhnmkzSxQebRrO3ku18B7d
/jpknKxpH3ZYC/f+4P/ZSJGIyB3pjDxAOpb6sebStXnRUva7/6JWgmKrFl0af2bK
mukFPZZWb/2vtAn6UJEJGfcPEgdg41LFIbnVzk/hmvw3VYSxJg0KJ3v2Px9DYJ9s
48nCYWvRU9oYStjfaqIlAMLRVxvcaBCbRWqUTn4cL1jx6GfVqVISQvs8B20CE4ZM
hUoRn5kMmtwBkl91KygulVN53PcesXtK8ZmHNUk7BopvmjTy30Z0wG7slFeyu4R7
7jTYfEHY3e7qLCecrztxvg1bPqeVlEWyhtG/oBn1TnsjXTd3aCHcMH9qovaOFPzf
B9NseJ5CI9FWi1jasEQ2d9nnPxMIdn9yGOElQtocQJWA3kB/HzSkMQwFFTABgHXN
vOmzjYyKs7oyRRX57em8MfL3ebxaULKnGer/SIbKoFur4tP0W/QMY1fO41zOgv50
fDnj/Fy3y78PAAtqGJ0Da2VulVaA54zs+N5zwv6lYaEd6ScIRB2PUC4/OYq0hCvO
vBsNVox5w6CvBbc/M4PP
=WNf4
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
