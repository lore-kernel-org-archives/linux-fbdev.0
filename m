From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 27 Jun 2012 10:42:27 +0000
Subject: Re: [PATCH v2] OMAPDSS: add clk_prepare and clk_unprepare
Message-Id: <1340793747.2649.32.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-yyNgSXk7Jgw6QdwPiAnW"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340787086-29619-1-git-send-email-rnayak@ti.com>
In-Reply-To: <1340787086-29619-1-git-send-email-rnayak@ti.com>
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>


--=-yyNgSXk7Jgw6QdwPiAnW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-06-27 at 14:21 +0530, Rajendra Nayak wrote:
> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepar=
e()
> and clk_unprepare() for the omapdss clocks.

Looks fine, and works fine with a quick test.

I'll update the subject and desc to match the use of clk_prepare_enable
and clk_disable_unprepare, and apply this to omapdss tree.

 Tomi


--=-yyNgSXk7Jgw6QdwPiAnW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6uOTAAoJEPo9qoy8lh71vIQQAJFS0kgaRaorT2BF/vhCd8j1
UsEipLqleNCR97qF93ucoYZgU6pa0QL1qlgoyae98XuR1YdvVrjupCLhiyomwqRv
KGhqT9+4cnjakr/IMfQp/ghHc4BPj+x39A4gH2p/t/knEU/Wr+uUl+ejK0lcrR5j
lunYlNm0xSEHCwR+icNSerVLuQqS5oxd15kSMhEhHFaTRARmZ7WvGrpEtBN0vr9T
IAm8SG0HZ2Yc6cIIJCneKcuwvea3Xlx7d657X7ojqBovN5VfZuZaYvtP/rZo3GzR
sLXxICY3ivggQ8AbY3XuAoUoaPLLq23SnGOHttSuDnpovhlLb0GbDXXocXbcjq1w
DwR74i/+IG8dDjnnB3JZ1/eJ9n5u21azx3jNKdK7XY1xz408G7QU7LU1BJdKshKC
g3qgSDXW1bFiYJIgK9SM0HY6A9kjcSc7IsemiYdfCOx+wh/+CzOI8K+Qz5IDLbU7
LwAWTEUKzcn2Xq8SVyq8de0SXydEVMeC/1jmDmmtZqwjVIds7fRD05ohElnodTcj
iY0jjy5n7v8pl4xtQK+EdMhlDZtM7LbWeZiM/bh9TX4dn14H//SxxljAj2fyTFXe
t3Ef33MnenTTcgtwbotulzBheyT3TeDT188LcRI/JbKZQECCz61vVDP5U7ajEjvD
n3o9Nhftev7/n4l5i3F+
=mv3c
-----END PGP SIGNATURE-----

--=-yyNgSXk7Jgw6QdwPiAnW--

