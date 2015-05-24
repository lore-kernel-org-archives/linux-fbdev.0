From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Sun, 24 May 2015 07:19:01 +0000
Subject: Re: [patch] fbdev: ssd1307fb: potential ERR_PTR dereference
Message-Id: <20150524071901.GM8557@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Pk/CTwBz1VvfPIDp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150523173235.GA31595@mwanda>
In-Reply-To: <20150523173235.GA31595@mwanda>
To: linux-fbdev@vger.kernel.org


--Pk/CTwBz1VvfPIDp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2015 at 08:32:35PM +0300, Dan Carpenter wrote:
> The error handling got shifted down a few lines from where it was
> supposed to be for some reason.
>=20
> Fixes: a14a7ba8cb0f ('fbdev: ssd1307fb: add backlight controls for settin=
g the contrast')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Pk/CTwBz1VvfPIDp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVYXtlAAoJEBx+YmzsjxAg6NsQAJS4vFNepsCt2wEYgaV8hWkE
vRGIZ9U03vGWyaYM5U9nREF5fLSbcMMP8BrjNTx02VDZ6CwGLjPpLaWhnx+pFBAb
Nh3lmf2mAcg6raMb/8Xd9sWn6Iwn59gO9skxdYIaxP/lg/Tk422Mx7O7WNhC1S/j
uHutxs0akrcHyq794AfAKG3mRHiZwtQhqS8wtORLhbPYSfD3BJu3zpXQ0PQ9Diyi
yJvErlkad5HtlmT8N6dxVfpeWpU/eljWqeghqqfN/DV7BZuJvCIbOjljZ0UuvyWt
qKQ9KV/V2fkMoIzUoxUvnfzUXY608gcRwO11+4AXefxp4zPh7T4nI+ATseiACIIn
dvC9tYBZgaz2wFLWyiUAHrLtcSgw1x3jb8m5YenAu3zlYT6XzIcyRaRbNQCJYawq
+E3n5esgV+lac0IfQ23BSIWLoqLePme+OoA7TydvVi8Dio3/+yOOQZzo21VYrixY
XrZp4aZKXPAGwRtVt8rUHxaE8xzt0HRLcZBjdVaCfwh9Q0+GtOmxtzj40B75LSzO
6hGEox+oSNcUJn8XZaPn0lwlBSUg2h9fyhx54GeUyWR4OdBmN22D1E3SSPl+fkFh
ceGSxLmYaS9LIPvmPh6iPDiH4oN7lzTRHwgbgLYhCHEzaPXCmOaCB5z9NFu3lmet
fmxAOklFZ/kcRyc4PICF
=QOHU
-----END PGP SIGNATURE-----

--Pk/CTwBz1VvfPIDp--
