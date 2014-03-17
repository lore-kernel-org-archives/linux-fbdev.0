From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 17 Mar 2014 10:30:02 +0000
Subject: Re: [PATCH v15][ 2/3] video: imxfb: Add DT default contrast control register property.
Message-Id: <5326CEAA.9090209@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lXpaJrd8hxW0Ld5DdsWC22T3xhg7gOn4t"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394794553-14719-1-git-send-email-denis@eukrea.com>
 <1394794553-14719-2-git-send-email-denis@eukrea.com>
In-Reply-To: <1394794553-14719-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org

--lXpaJrd8hxW0Ld5DdsWC22T3xhg7gOn4t
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/03/14 12:55, Denis Carikli wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> ---
> ChangeLog v14->v15:
> - Moved the Cc into git send-email.
> - Rebased.
>=20
> ChangeLog v5->v14:
> - Remove people not concerned by this patch from the Cc list.
> - Changed the property name to match the register name and function.
> - Updated the documentation, code and commit message accordingly.
> ---
>  .../devicetree/bindings/video/fsl,imx-fb.txt       |    3 +++
>  drivers/video/fbdev/imxfb.c                        |    3 +++
>  2 files changed, 6 insertions(+)

Queued for 3.15.

 Tomi




--lXpaJrd8hxW0Ld5DdsWC22T3xhg7gOn4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTJs6qAAoJEPo9qoy8lh71+tYQAK5drYGbIBjacLFkWIASZRWZ
U9QpMzuzpYDgaWYldUONy4sjKGWdK2/aYfo+cEDycqXz4w5A5HDX3MabObqJ+5dy
fcRf9cMkIJX5gdAybbwW/DbrdkJKgrqTNbGsT2s/sRMbpw6jzR9HrIFiXgRvStjK
kpq3eayD22dYmfyVbOTJ9zaMnX1mPFd2l5cTjP2tGTN8yrdGLy6+2VmiYd6s2Stl
p2aUML1zJlIUHSyCYrUNDvaUpF9NMzFr01emqKJ5gX5g3im+SnWzjJHuDp+AYyzM
MwxumQutS+KOy0SNqc/0m2ro98vfllNB7DmgBQ5mSxf+gJolNOWkC78LJFPY6VVy
UDR3pl1OUCLjdcSw/AQe+h1ICXBqo1WFzf4xtEheXod/hogMfvhnY4EPMutRWlPO
2AusUUJIQPsoszL7gScncrSqjjydY8uqER/FWPe5ZH+wYgHNILNlkvCrWdYHkALC
gIVCpv7Te3ewbyW3VuhRECNCq/4napIQskVH/eNeNf7iVNV6dXWPt2BaPJhimbTN
N+1z0WJIREiyPCo0DR0NnK/kt5Pl8WwP8w/r4lgxGqZpZGFOK7P3VOehHObpCHwu
2YZtCn2DYf3PhxjQHadx517hOSzIs55eUnUaBNpj6kyjyQhRK+sQ26sH7oFW9G+9
76oWgNY4gLCTtR8ZYz+Y
=mLPR
-----END PGP SIGNATURE-----

--lXpaJrd8hxW0Ld5DdsWC22T3xhg7gOn4t--
