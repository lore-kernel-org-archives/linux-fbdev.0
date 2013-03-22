From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 22 Mar 2013 18:53:33 +0000
Subject: Re: [PATCH v3 2/3] regulator: as3711: add OF support
Message-Id: <20130322185333.GN22890@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="K4LMwn8CgX2KMboP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363968949-12151-1-git-send-email-g.liakhovetski@gmx.de>
 <1363968949-12151-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1363968949-12151-3-git-send-email-g.liakhovetski@gmx.de>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, devicetree-discuss@lists.ozlabs.org, Samuel Ortiz <sameo@linux.intel.com>, Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>


--K4LMwn8CgX2KMboP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 22, 2013 at 05:15:48PM +0100, Guennadi Liakhovetski wrote:
> AS3711 regulator OF support only evaluates standard regulator DT
> properties.

It looks like this has no dependencies on the MFD patch, is that
correct?

--K4LMwn8CgX2KMboP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRTKieAAoJELSic+t+oim9ss0QAIsLAPknMA0YSoPbQaNFMyZl
LqgwM4qc03lDHMJw3ukOHPlgx4Ml+HgMAN51tcpHUPClsCnjNDXS0PN8vdDBSima
3qEnGjd0iVuVeY/Q/Goj/6bSXAes5vyFfh7kxyLYMY7Vv+JdhmJji8AGvMJFbmTP
et2qjoVlpybuXdMrXDOU92d1Cy9/A0ZuFpOe2GNb4WIUQ2fRZOB5JP6oz1AeRftc
3WHZHBr0SaINueKD63co2SbTmvUzKElBL/sVTDK335YxdAZmSwJ3lXetDcNPcLJc
BHWEBFQ8IqNX5vftXz7Zj7J70wzhQNZbempPrKtwH6PjonGEU+gRIHiMjlCOt4L/
9TkxhOdUBhUcT+G4TNYcTtUKE4KCsTih59NPCeiRLQMPn2DtIIBsiTqVFYENne2C
uWqnxvjhjg9OkjAM8E+aKLxgEtXIkvLwir3PvFqRF7f6msdM8oio11OGrQt8LMZX
cGUsHkQUPG7SKlUQv53ogSEJIWkryU6Vw4TQ979IUHdsJdFxfYOqgGjeaqXrzykI
mx3Lauu3Yc/FZCd0JzJoqqqMHLkrRvJXoYj2fUQJ/h2SzGdQXbV3bDuxVmndriW7
bU5vsAwJFcwkbAk8owSMthtlrTVWQytrCiGN/Wrt94dwk4zPQ1KkpCBOC5VNZoV+
KaCuJXtuSLcx5UVeGwMr
=bps1
-----END PGP SIGNATURE-----

--K4LMwn8CgX2KMboP--
