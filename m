From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 10 Jan 2014 11:24:13 +0000
Subject: Re: [PATCH] fbcon: Avoid corrupting active workqueue entries
Message-Id: <52CFD85D.8020204@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="H2GGRhx48DCGMT74M90Hepwkd3rLcbc52"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387290459-26440-1-git-send-email-chris@chris-wilson.co.uk>
In-Reply-To: <1387290459-26440-1-git-send-email-chris@chris-wilson.co.uk>
To: Chris Wilson <chris@chris-wilson.co.uk>, intel-gfx@lists.freedesktop.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, stable@vger.kernel.org

--H2GGRhx48DCGMT74M90Hepwkd3rLcbc52
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 2013-12-17 16:27, Chris Wilson wrote:
> We attempt to reschedule an active work which can itself corrupt the
> workqueue lists, and we may then free the work item whilst the task is
> still pending. Both of these may lead to a system deadlock and an
> unresponsive machine without any outputs for a panic to even be shown.

This gives the following warning:

drivers/video/console/fbcon.c:407:20: warning: unused variable =91ops=92
[-Wunused-variable]

I can fix that. Or maybe it's better if you send a v2 with that fixed,
so that this gets properly to stable-kernel.

However, I wouldn't mind an acked-by or reviewed-by from someone.

 Tomi



--H2GGRhx48DCGMT74M90Hepwkd3rLcbc52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSz9hdAAoJEPo9qoy8lh71B9EQAI3P+wujZKsNj3ADCtXy3Td6
yi14rhWZr6FDc/T5tSqVl7TEH1z+tbFc1NxsKorVc04QitMqZOgm1VWLBUR5GbjU
zKWY5eCrcFoKdwzvSHe8NfQVGSc7Rc4WwtM1kt33XZy8kcOWYBKvOzHaeRg9m9Sr
Gehlpdp97Pmxadz86ECZRFTRPPNropnCq/Sv7dzhVxjrzLBn0o4eOYE5QItWtYfB
NALjg/jXo7d1U3sxF26WIIS+0OP9+Tt55Tb0s1Jo2WiOTa5SHkdrxpWmikkkylwx
W6aXkdv2CilM3i3+GpqB3yaLysiaapfvoP2jEkcptidmXOZAZqw0v5EeIZLXzNTG
b/Qr/pyBHcIYkT5tImXJ1WChadummtRE+g/WDGXIWD2PHOC9nVMZjsOUw6UNG1yE
XLuRiKeHOVtLZPmE/l51R1ds9YZe5ZFivMz4iI7suYynIr75K+ECq/PBU5EEjGiE
26G2gFJWeY+KCO7mGn7Vr7iCGYDLP48NGlsdeeCjVScFeGMdCkDkIA1d7e6YXa2Q
YhZwyUzHB26GowNLoA88nHKuAx2MINCk7B6m/dLJfRdP5UW29a3yCX+Ve58OML2N
7UqvDIcgAWR/rsjt/k0+j0qZLRmy0w8fn/gX+mpNvxW7P9D9YcpnIsEfMqSkxdrX
579zo55pFlyPK+T3hnpK
=fz3g
-----END PGP SIGNATURE-----

--H2GGRhx48DCGMT74M90Hepwkd3rLcbc52--
