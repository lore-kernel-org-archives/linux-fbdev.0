From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 28 Nov 2019 16:19:01 +0000
Subject: Re: [RFC PATCH 05/12] video: fbdev: matrox: convert to i2c_new_scanned_device
Message-Id: <20191128161900.GF5412@kunai>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OzxllxdKGCiKxUZM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
 <20191106095033.25182-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20191106095033.25182-6-wsa+renesas@sang-engineering.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--OzxllxdKGCiKxUZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2019 at 10:50:23AM +0100, Wolfram Sang wrote:
> Move from the deprecated i2c_new_probed_device() to the new
> i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--OzxllxdKGCiKxUZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3f83QACgkQFA3kzBSg
KbbnmxAApek9VsHqO33UsJ6YYN/EWaMYzjYyzXvkR1U5F4veEDwg321WyrfhLzOm
5eV4bXBhoXIl4sFKk3OUSLDqhGVV56BCa0bGnfjf7gc97hsgNkUX7u9t4N4AEp4h
0BhEAurF7qBl8E3gxh1cFc8Zm0rxfls1GeBDx8OTRNv787/AcbJxrmXIkgBFtKvw
BU2fmHwvyRU12p7xmT2cfHZt3iyJsBEZGfKsjF951qQeJF/1em5rh63X4e1oqWYD
fp40g2HIgZz8SX6HO4GeAf+buu4ZeG4sul6dpRav3ycqMD0WGvK9loTJ+Vfy5pFH
iBxd9pPzGa66a2Qlxytb2qj5GSh1n9QJQ5BHZUar5lj21NWm77RQdPInKYswVXox
/JU7/YtJ7w+bfiJsegSxManyYh3n3VBjH9n1mt9ppuS2d4JVmE3/H/4F1/xdxheL
ym3nY2lBlLRt+M+Y4DMix0+iGwcxqrO6eruUIxXaStgj3/ap5KfSOvMu+FU+bC0g
Y0SaNaoVcFk1cmEnrYi/eW6akP7eYFfDo+t2lgq1c/uv3AhoNJ9vJFAikoHcgePa
T6y/DpDTAaQyi/JwiBl8vOkk10L7qgwGHh1x8EghRVr52hQmC5bK6wbOSCR4M0sR
vW8Oeog6NvyshLgWI5NHU7h+qD7W2aTRYw57Nk/GU6PbsxgD61c=
=MmdU
-----END PGP SIGNATURE-----

--OzxllxdKGCiKxUZM--
