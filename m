From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 27 Jan 2012 12:55:43 +0000
Subject: Re: [patch] intelfb: remove some dead code
Message-Id: <20120127125542.GC3356@mwanda>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="V7LzxcfGKRikha15"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120127124536.GA14136@elgon.mountain>
In-Reply-To: <20120127124536.GA14136@elgon.mountain>
To: linux-fbdev@vger.kernel.org


--V7LzxcfGKRikha15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 27, 2012 at 03:45:36PM +0300, Dan Carpenter wrote:
> The goto on the line before means the return is unreachable.  The goto
> also returns -ENOMEM so no changes are needed there.

I meant ENODEV there.  Let me resend this.

regards,
dan carpenter


--V7LzxcfGKRikha15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPIp7NAAoJEOnZkXI/YHqRiY0QAI6v007F27MErV1ulOkG5J/U
nzQQy+5hvRWoIQEDqBMpT7l8mcuUHL9mJrBmm+aUYPCHUUwKumuDjpUllxMgnFt+
AdR8Un5M460n4e3F1FB2EJMtQ+Wn4Qz38QO01ZdaV9NGWmFgILPmIBwe2T0VWY0c
KxqdeqmPj7Fw5JenDWtLSSpy4yYPllGmCxcp61EB973ZPwqm8GQK7pPWpeiJPZlu
tOAoAYBGKhHmdXB/WgaoPqviMCCUYmKtO8FDkrMFz8DAeVSIMiksbXwGL7FQuLci
CBRILw0+rZIeZOM3XocNNgm7P54TpjMOAyfMLHZXwC2zFRl/XgmnXGRMJH8clR90
6PnuMdpvR1juI3+jmstxV+45Eks7oVCd5R1hVIYkxC4UjhmmmruhBvQDf5PEUuK1
nV9lzKcEZiM00uPITRJe2RiO6kLuzEx7Cvn46dOEDdXu56fT2vMqQ2I7aCCQUBUx
NiLFB/3eAMpplPpgybqOtLDUFCwJfZQrW/7OFWpBJ+518ObL2vITwhPNACvuSAsv
ftCHD0/GmssLI+3jD8cELj6x//SDs2AFIQgLK9FIJL0+3qHV5MCgYbEPt0yJGsvu
FsdMkMNuv+w4gSpx23JwnEioMh6TwxhrRRRdEEOPlagnv9PExJp8orlbHNIGynT4
5ZKbNCYxlRjhsNJg+Sny
=t4BZ
-----END PGP SIGNATURE-----

--V7LzxcfGKRikha15--
