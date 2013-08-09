From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 09 Aug 2013 11:22:26 +0000
Subject: Re: [PATCH v3 00/20] video: da8xx-fb: driver enhance to support TI am335x SoC
Message-Id: <5204D0F2.1020701@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FIKfUdRcBfMcjrIQgP5XV215j8L5chEAU"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375740159-1045-1-git-send-email-detheridge@ti.com>
In-Reply-To: <1375740159-1045-1-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

--FIKfUdRcBfMcjrIQgP5XV215j8L5chEAU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/08/13 01:02, Darren Etheridge wrote:
> Changes in v3:
> 	Address the patch authorship requirements
> 	Pull out the DT changes into a separate series
> 	Fix an issue where FB_MODE_HELPERS was not included in build
> 		but is a dependency.
> 	Include the devm_ changes and error reporting that Prabhakar Lad=20
> 		had pushed a patch for,
> 	A few more cosmetic changes
> 	Add a patch to remove the use on inline from a number of functions
>=20
>=20
> Changes in v2:
> 	Addressing review comments from Tomi Valkeinen:
> 	Dropped readl/writel patch as it is not necessary for non-cached,=20
> 		non-buffered memory.
> 	Many cosmetic changes to make code easier to understand
>=20
>=20
> This is primarily a resend of a series of patches that were original
> submitted to linux-fbdev back in January of 2013 for 3.8 by Afzal
> Mohammed. I have rebased them on 3.10 and also made sure they
> apply cleanly to the 'for-next' branch of linux-fbdev git.
> The patches enable use of the current mainline da8xx-fb driver on the
> TI AM335x SOC along with some bug fixes and cleanup.
>=20
> The original patch series can be found here:
> https://patchwork.kernel.org/project/linux-fbdev/list/?submitter=3D3910=
1
> if you want to see the history.

I think the series looks fine. I've applied it to:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git 3.12/da8xx

 Tomi



--FIKfUdRcBfMcjrIQgP5XV215j8L5chEAU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSBNDyAAoJEPo9qoy8lh713J4P/RuT4PixMyL/27fcsXGwe1tu
nXfYfttWtHYrv0XG1Gfsxg6VOIqL4QZy9P33tQIr9SZgptgm4itdUlyhBdb1VwgY
+XCJCYUcXgwOJglHgsFgjefRUGuPywmM0P4jrZ7/v8X6YDnpKd5ldomHUu1sE4gY
JkWIkj/uTzfQauwrpm8Dxrs6HeX8Bx+bVyDbznjVe03/NNnxdaCb0cST2bnMntZo
6RfLG5QLG0EXHLifdQzpZ0xVaAtzkrO41PJZiEHaMBqUCxV6OeW95InQ2ANQ16Ll
02seNpmItJFMOSbYpgonXI9vM5fTbmtumbqImqmbyTbPgRCUY2R+mp7CIpA7HP5g
IzOAetp3L7bVIO50q65FnR8SFVSUC2sR5n5JQ3ATG/js6shF2rzPV461GKXeu5T3
ZbTF3mKKCDqD/SZ8CkiBNC9T2w2cfBLQ3LdolX+ANhIeFXPn/eD1+0QdR+P+9Xw8
jcGHiuAM9oh+u3uS8qKdAIm7yH5nnds//HM4m99K87vR5vT00p19NR8IhOB69Mvr
2eJs4gCXjnuFdWIcCTbA6aN3Uxh3XDVdSjnUvhBttI4DJd5UeuC4gZdDvvnaRFCm
qo8sKJ/IJp3vSSG9zyRBOVdiUi5Kn44FBXRp3F9H6njht94N8nR1BlGBqO1aYPcX
1bX5IyzddPnnBJ5906Nh
=frHQ
-----END PGP SIGNATURE-----

--FIKfUdRcBfMcjrIQgP5XV215j8L5chEAU--
