From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 08 Apr 2014 09:19:15 +0000
Subject: Re: [PATCH] video: Check EDID for HDMI connection
Message-Id: <5343BF13.3050206@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="C4FhDePECVxjiLjJO56JExjoCl2tfPHX6"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395873337-41305-1-git-send-email-cfreeman@nvidia.com>
In-Reply-To: <1395873337-41305-1-git-send-email-cfreeman@nvidia.com>
To: linux-fbdev@vger.kernel.org

--C4FhDePECVxjiLjJO56JExjoCl2tfPHX6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 27/03/14 00:35, cfreeman@nvidia.com wrote:
> From: David Ung <davidu@nvidia.com>
>=20
> Check EDID Vendor Specific Data Block bytes to see if the connection
> is HDMI and set FB_MISC_HDMI.
>=20
> Signed-off-by: David Ung <davidu@nvidia.com>
> Signed-off-by: Christopher Freeman<cfreeman@nvidia.com>
> ---

Patch looks fine, but how do you use the flag? Shouldn't things like
detecting if the monitor supports audio be done with some more detailed
bits in the EDID data (not that I remember much from the HDMI spec).

 Tomi



--C4FhDePECVxjiLjJO56JExjoCl2tfPHX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTQ78TAAoJEPo9qoy8lh71lzoQAKYYlogimCWvut/bGJa/c+//
Cn3qTUrkoF80jmyla4uucc+pHXebEaM0sNz54PtaHUZLq1MNscG3CVnqlUBSx+ST
Jp0dYxkBMHUVEhbLam06FaAryCs4PK09BwnG0ok1Df7yRT3dfYzmjZ/inE0m7ZsE
UeZcAq/nwnU+qavA+ZntvYMeK4w6uTqIGMCN0fbXvnC/xPWqRKqmzrfBMXJCWipa
UYA0+8UU4WDbX8zTsnfKEpMJITW3DxVEOEl+vfw4ycdc45XY7uvftJIRpDYvKhA4
rDk7ZAYx/+R3UQLWJFd44FMKzM4KzbC2InCRmcsPHY9SVpHbYYglNsWkXMLOpT0A
RGwLykmiaFzwvf5rq7FcDRgm5wXc52oC2kEqjAkQF4F3lyjMKbnKchew+Xhe3Qp+
oxhSeelC7+PQAdLH9pktLCX4mEVhNO5jokI6fsf5AA7VinPMeYX/F99gQsZCjeoH
OxwpevytVD0OsTDA2eoX/BO8XyNfCYP1PpbyE1ay1oSv5Z2+FXKZZ+3tGhlca3GO
YMb9PFmbWdURBwRXXR0VdhcAl+dEQTiuMYTkUSXR4Jmj9bEDHqRR2g9StZJTH/cZ
8C89f7e2AxPBgME2UvnVEMNAPBlBPBfjkPoZjRjFbx+2lvQidsSSjW2LOeOH/se3
52G7qpqbp6C+S/bnufdT
=1R6K
-----END PGP SIGNATURE-----

--C4FhDePECVxjiLjJO56JExjoCl2tfPHX6--
