From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 May 2015 08:03:51 +0000
Subject: Re: [PATCH v3 0/4] pci: add and use pci_ioremap_wc_bar()
Message-Id: <556428E7.3050606@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="s3DSXlEJ5Bn40qGn2WHAWHehgNDNrI5tW"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647634-17169-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429647634-17169-1-git-send-email-mcgrof@do-not-panic.com>
To: linux-fbdev@vger.kernel.org

--s3DSXlEJ5Bn40qGn2WHAWHehgNDNrI5tW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Louis,

On 21/04/15 23:20, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>=20
> This series adds pci_ioremap_wc_bar() and makes use of it
> on a few framebuffer device drivers.
>=20
> Luis R. Rodriguez (4):
>   pci: add pci_ioremap_wc_bar()
>   video: fbdev: i740fb: use arch_phys_wc_add() and pci_ioremap_wc_bar()=

>   video: fbdev: kyrofb: use arch_phys_wc_add() and pci_ioremap_wc_bar()=

>   video: fbdev: gxt4500: use pci_ioremap_wc_bar() for framebuffer
>=20
>  drivers/pci/pci.c                | 14 ++++++++++++++
>  drivers/video/fbdev/gxt4500.c    |  2 +-
>  drivers/video/fbdev/i740fb.c     | 35 ++++++--------------------------=
---
>  drivers/video/fbdev/kyro/fbdev.c | 33 +++++++++++---------------------=
-
>  include/linux/pci.h              |  1 +
>  include/video/kyro.h             |  4 +---
>  6 files changed, 34 insertions(+), 55 deletions(-)

About this and other related series: rather than having multiple
different patch series containing fbdev changes, going via separate
trees, I would very much prefer to get all the requisite pci/mtrr
related patches merged in the next merge window, and only then change
the fbdev drivers in one series, merged via fbdev tree.

 Tomi


--s3DSXlEJ5Bn40qGn2WHAWHehgNDNrI5tW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVZCjnAAoJEPo9qoy8lh71pFYQAKLqKgFdMNEb2OcfelYyv491
DgbESplbdKHbLXN3cP+05zSfnGT3w1OM5YtmiwcAm+65CM+sdnJxjYWQX/j7RJF3
q0AbKTlZXzW3o20HvshJbu1xY9W5PVUlbCfM9Ot/MQU8Vv79Ae3jk5ZPb/ASrfU1
ZozDzOv+7ZewSXYbrL6SzlP3fKTbJIZQkSrSNa2ED2TPOZswgzrjIYy8vKvOcjYY
wFgrxiHs8BLtrWE3xq6iebM3Iv0UwQQ4QLsBA3So1ZuOtbNpGopnjwjuvTWcT4g9
60wwFxWCG1f8nylk/mPj1Ai51nbqttyjjBTw4Wblo1hqwF5Gk/TUWmtpq1af5FmO
fJUXwWiFaco7Bu8cmj3c11AUNo69n3Phi0DZqtqiBFDiDZa4Xgql4aTLX+EfTTLm
Cmob74IvNgacehq1Th14mfhz2L5N9wbJUhZBEr+aDQ2eWxm3JoQULtPDvHE+Pj7F
eTUdO4rpXwPePs3ruVGI+rTM2dF39OLXH+7TAnKLXSNOxHay4QPhwBcdjZYFR1Ms
EN/obGk2BKWPjc/exadxpI63qlb6DGVOu9wenw216lw+R0ExV37CqcuMeMnZJMPS
CXjZ9xxm/MQ2T9gIYF7hgyw95p8Bt64IcRolUWxhjtgeapMsT+o+5rTM8fmlqxxw
uSQ8mzfc57O4E2VnliRb
=I0hd
-----END PGP SIGNATURE-----

--s3DSXlEJ5Bn40qGn2WHAWHehgNDNrI5tW--
