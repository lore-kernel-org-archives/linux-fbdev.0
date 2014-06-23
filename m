From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 23 Jun 2014 10:58:42 +0000
Subject: Re: [PATCH v2 1/2] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <53A80862.1080905@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RHER67PsXVUDJaqwxTpXKX0j95vCWVIM8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403194843-32574-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1403194843-32574-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--RHER67PsXVUDJaqwxTpXKX0j95vCWVIM8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 19/06/14 19:20, Alexander Shiyan wrote:
> This adds support for the framebuffer available in the Cirrus
> Logic CLPS711X CPUs.
> FB features:
> - 1-2-4 bits per pixel.
> - Programmable panel size to a maximum of 1024x256 at 4 bps.
> - Relocatible Frame Buffer (SRAM or SDRAM).
> - Programmable refresh rates.
> - 16 gray scale values.
> This new driver is designed to usage with devicetree only.
> The driver have been tested with custom board equipped
> Cirrus Logic EP7312.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/video/fbdev/Kconfig       |  21 +-
>  drivers/video/fbdev/Makefile      |   3 +-
>  drivers/video/fbdev/clps711x-fb.c | 397 ++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 415 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/video/fbdev/clps711x-fb.c

I'll queue this for 3.17, and I'll push it to my for-next branch
shortly. Let's see if anyone complains.

 Tomi



--RHER67PsXVUDJaqwxTpXKX0j95vCWVIM8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTqAhlAAoJEPo9qoy8lh71EFEP/A5dXnUc/QLxS7MiNrVZPNPI
3I42YL25uU3xPZVstmsyzQ6oO1vAr/iEUcqaLzgJ/Z6mOTlLP3Qc4fh6ab/0nGI2
GAJN/sYaORHYjP+SVip2ZOGYyIiI1scLuzQFq3aHcBk3D9cAj4Sywka9WfEJvY+k
fZ4c9wwW8Qz/a0eHFPB4MyO7E90me3tw49inwG0tx2YR79hUTjshrKuWJuPFciLj
Y5PRNRFDcUnddr1rTgqI7ys+WZYamMuiNn+VI2tlq4/W+PCo4bJyXXIr7fDKu4Jk
f71ifn0d7wN40ZMVVNldkkGbVUQHvrv8s9BMUgXiCPGc4mljN058Bg8DPrmb5EQ4
2Q+nTv8gaG82iltVJiH6cZrTsU95Fqg863N86okRBycjI8IwLeX1MO9PYEF3ek1L
9h6FxBZKrRoho9rb0eCWRLz6kbQEoIcTk215jR4Gu/W0IU5gzdgtilD3thob/1y/
b6Oqb+wK2zgmR8qov5aM2DA+ICg69cqjqyvzhJJNmenf8kUiTx6C558U8dI8jFUK
96XEkXmGA2EhOVpwTdDeXIcPADxfLMeP6qG0mYR0YfjkTsNYxajcbESRjmI+F9nh
8YSQmqpHzWMNvO7mNnNt1+NC4ZpcOkFzZTa5y4ofWzKj+tNTAMrpuzb6Za5/a8ZC
mrC7S3YWJlD2R/6pEQ2W
=LZxW
-----END PGP SIGNATURE-----

--RHER67PsXVUDJaqwxTpXKX0j95vCWVIM8--
