From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Sep 2016 07:55:33 +0000
Subject: Re: [PATCH] video: fbdev: offb: Call pci_enable_device() before using the PCI VGA device
Message-Id: <a2103a60-46be-c693-eb3d-2879037cf880@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QwcCkpiuDfrcAvOO3vCmP7S3NoID2MJQV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1473746026-11695-1-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1473746026-11695-1-git-send-email-xyjxie@linux.vnet.ibm.com>
To: linux-fbdev@vger.kernel.org

--QwcCkpiuDfrcAvOO3vCmP7S3NoID2MJQV
Content-Type: multipart/mixed; boundary="UQUc1LRchN4HfhJU4esAjIRcONKweN3Fn";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>, linux-fbdev@vger.kernel.org
Cc: plagnioj@jcrosoft.com, bhelgaas@google.com
Message-ID: <a2103a60-46be-c693-eb3d-2879037cf880@ti.com>
Subject: Re: [PATCH] video: fbdev: offb: Call pci_enable_device() before using
 the PCI VGA device
References: <1473746026-11695-1-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1473746026-11695-1-git-send-email-xyjxie@linux.vnet.ibm.com>

--UQUc1LRchN4HfhJU4esAjIRcONKweN3Fn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/09/16 08:53, Yongji Xie wrote:
> Currently the offb module will use the PCI VGA device as frame
> buffer device without calling something like pci_enable_device().
> However, this would cause some problem if we disable memory
> decoding of the upstream bridge before. When the console driver
> issued memory access to the VGA device, the access cannot be
> supported by the bridge which will cause EEH error on Power machine.
>=20
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  drivers/video/fbdev/offb.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Thanks, queued for 4.9.

 Tomi


--UQUc1LRchN4HfhJU4esAjIRcONKweN3Fn--

--QwcCkpiuDfrcAvOO3vCmP7S3NoID2MJQV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX6iX1AAoJEPo9qoy8lh71sUUQAIg0uQczGMANLyN+SCktq3GN
8cZK2q+ej9y4qYimziRI1dfKQ69V+Sf8GHa6NM/VbgU2qbBiwaEARqOtspElHVDn
ftUEomnYtgD2HyVZBMgaJNTcJ4AW44ulDYMjnQtT8j/PED380Kof+MRGgKCNgcVj
oxxk+/L+JthudxgGHE7o/kv/j1hJJNQH8Uk5UTaLVqKsSJsWycXJCs8ozv7rW8OC
6wsVebXDhWs7XZnJkUmKlZxz1l/l0OmBRrsHjI+oHFttcY/GrU2d7y6+vbVZyFmz
oF30Ahc7LsiCXSFEMTuqf8oklyYtrsmCxtaDC/PkTgWmhOOKLH1YMirbEkF+r7AH
AA9Rtqcil9oZvBjzr4wH/YIpgP7nIdQa2nBGY1TCxkUICSm1It84UmWbW9gT0Jk7
HY2SYIqcaqVT1UJRpf/oI2kQJxapzXm9/JnG0ItM0Sfti7qr8xpdjGwCnlbA4Ktb
gsN/UJfMxtPhvgO1jv32FisT895RVl2SZFa/BXtkekE5BYvyYsyGTWteq+qydB1R
8hIeaoYhKA2deZe68xds1kuu2m6t4h5mPgXhLFmj3Bqfi1ZJSLQHPd/meYmF9xlz
zQXjhn3MOwCUhawAv7K4QSxbDPZ2wZ8I1H6grKhLlRblS9cdgWNOFATMMyfbbCzR
539r96oDVUDovfN3IM93
=vMk2
-----END PGP SIGNATURE-----

--QwcCkpiuDfrcAvOO3vCmP7S3NoID2MJQV--
