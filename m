From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 10 Aug 2016 10:53:06 +0000
Subject: Re: [PATCH RESEND] fbdev/efifb: Fix 16 color palette entry calculation
Message-Id: <07806cc4-cf6a-5fd9-cd42-6323abe4e3e9@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5S2nGpf4EDua5xk0DeE1tavNE9EKGFfnI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1465307143-21398-1-git-send-email-mstaudt@suse.de>
 <1465838159-12940-1-git-send-email-mstaudt@suse.de>
In-Reply-To: <1465838159-12940-1-git-send-email-mstaudt@suse.de>
To: Max Staudt <mstaudt@suse.de>, pjones@redhat.com, plagnioj@jcrosoft.com
Cc: eich@suse.de, tiwai@suse.de, agraf@suse.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, matt@codeblueprint.co.uk, stable@vger.kernel.org

--5S2nGpf4EDua5xk0DeE1tavNE9EKGFfnI
Content-Type: multipart/mixed; boundary="v6i7Dc81qAIGDitB5vkTTULusOo33UUgC"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Max Staudt <mstaudt@suse.de>, pjones@redhat.com, plagnioj@jcrosoft.com
Cc: eich@suse.de, tiwai@suse.de, agraf@suse.de, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, matt@codeblueprint.co.uk,
 stable@vger.kernel.org
Message-ID: <07806cc4-cf6a-5fd9-cd42-6323abe4e3e9@ti.com>
Subject: Re: [PATCH RESEND] fbdev/efifb: Fix 16 color palette entry
 calculation
References: <1465307143-21398-1-git-send-email-mstaudt@suse.de>
 <1465838159-12940-1-git-send-email-mstaudt@suse.de>
In-Reply-To: <1465838159-12940-1-git-send-email-mstaudt@suse.de>

--v6i7Dc81qAIGDitB5vkTTULusOo33UUgC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13/06/16 20:15, Max Staudt wrote:
> When using efifb with a 16-bit (5:6:5) visual, fbcon's text is rendered=

> in the wrong colors - e.g. text gray (#aaaaaa) is rendered as green
> (#50bc50) and neighboring pixels have slightly different values
> (such as #50bc78).
>=20
> The reason is that fbcon loads its 16 color palette through
> efifb_setcolreg(), which in turn calculates a 32-bit value to write
> into memory for each palette index.
> Until now, this code could only handle 8-bit visuals and didn't mask
> overlapping values when ORing them.
>=20
> With this patch, fbcon displays the correct colors when a qemu VM is
> booted in 16-bit mode (in GRUB: "set gfxpayload=3D800x600x16").
>=20
> Fixes: 7c83172b98e5 ("x86_64 EFI boot support: EFI frame buffer driver"=
)  # v2.6.24+
> Signed-off-by: Max Staudt <mstaudt@suse.de>
> Acked-By: Peter Jones <pjones@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/video/fbdev/efifb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, queued for v4.9.

 Tomi



--v6i7Dc81qAIGDitB5vkTTULusOo33UUgC--

--5S2nGpf4EDua5xk0DeE1tavNE9EKGFfnI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXqweSAAoJEPo9qoy8lh71qF8P/0GaeVxilOeWljCwdgrr9bud
geZFJ7VC9vhjEYC1mWBKHEeTE9Fuzr/PWOR2fX5xBtPbF19e0Q8GgZj+5rERPJZH
0fyXl2mCRCGxXfTxqW9UleRL9dR6VQDrzFlUSF2V0V3yzvQLlZQjUdBgWVk/D+Jo
BJ/tKHhBb5TAWKH/9kfYIt8YNFLQjz158xGz8ziLeqpJMu13IBEYxCgs3SLE/IVS
nO6pIPWYkhxeuIud1PFDbvzqzwYaP3szgNHsunUGyVqN5p2uYFkuuDsXIpqqBrpF
vYjl3A1iweLwFrHOaGS0YTVKOblyYYNyCF8ucrvMM0gIFOKRzoEyQ/VqrYYJI3e+
LZD/Aqnj8wWjRNuAbcqcOl5A4KW+yFcRT905VEC53NlnIeFKwuO4W2sI2f7F1cJG
lCY7HTxhwCS4Q5Lacg2n7TdHjrBNu7rv8N56uCD27YnM7EU45Kuic60iOOQV41zt
/b5R3YCuuz2AYfi4Zb92JvdQ8WmOh01BOyPlne2jCCWEz2Xjqxyb2APObTVxgvoU
8HxY2j3aGwV2J7cuLWcOCDtKNqEL5U1T966PYO9F1INzl7TAERlPQ4LSkeIqYQK7
Ao5yIN8eiI1Bf2myGuI57Fb0u0iUmuUn5AsNAYl3P+GAMIyVy5jtID/UeMcoDXru
QKoEQEBDAVnJF1/J1KoO
=6CFZ
-----END PGP SIGNATURE-----

--5S2nGpf4EDua5xk0DeE1tavNE9EKGFfnI--
