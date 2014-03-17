From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 17 Mar 2014 10:24:05 +0000
Subject: Re: [PATCH v15][ 1/3] video: Kconfig: fbdev: restore the broader selection of FB_IMX
Message-Id: <5326CD45.2010506@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="VAfc9K08xRpDxkl00GjCD9ghd18nxNa4F"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394794553-14719-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1394794553-14719-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org

--VAfc9K08xRpDxkl00GjCD9ghd18nxNa4F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/03/14 12:55, Denis Carikli wrote:
> The following patch:
>   b359bb0 video: Kconfig: Allow more broad selection of the imxfb frame=
buffer driver.
> Was accidentally reverted by this one:
>   ed3b5f2 Merge branch '3.15/fb-reorder' into for-next
>=20
> Signed-off-by: Denis Carikli <denis@eukrea.com>

Thanks. I've fixed it.

It was my merge mistake.

 Tomi



--VAfc9K08xRpDxkl00GjCD9ghd18nxNa4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTJs1FAAoJEPo9qoy8lh71XGAQAJzr+MVuH4iA7ZnSApIEhcif
f/bPe+hZuNl2tEMTjClM/UMz43bglSK8BQDQDGhThAIcwLR6Qq6t12+wmxfzEvxT
q0ERmmwqFT00p0osnAmgmtnvjbR1gBn/7DhtBTyq2OBqYlD8PQev02piSDD3k0w3
4D5Y+mz3zwK4mlXjr7kT+7mCMNyc73NSDcx+R7dreNv9Sw0iSVNNhP+QQYPqLyBi
GqiaPV3tN0b+doqoTUWhf0Mx0R1XTcRY9IKwcI593BlFo4OmivMM17H7FQJQW+mQ
zjYb2sFu2b4Ky4Ocmm40jzaNEbLHuwYXXXFcwCmZPZGvZnTEOstrlXiLeJxmp15j
+IQcJBIXP+rP1EE8k8uaKGDrQQppRAAOQKN7X6OqIQMK+7+NJr99JucZFw04z680
LMoCRAWhmr+kYjvdMpVmC1W6NLvIO4SK5NHnBfPyOeo/XbL3Tqe6+tQStMmkYe8+
EVSxisEWsix2VRUD1f1Bc9XilINFl4o+/WcLd/VNKZvrtn+yvulV++j4WO7oCgoy
jabTHtWmZmZw1SxIPO09ylKKuatMiXJdmTCRU8b7MVQbfDl/SWzMG31RliM96yP6
cRJjhroekvVtt0wxq6ebFrihRxXgt4bZIKbv3k24SKgmUqw9DnaRgxsMT4DV+08i
RAKIuIKpT6AgZhcpBFSN
=FBGH
-----END PGP SIGNATURE-----

--VAfc9K08xRpDxkl00GjCD9ghd18nxNa4F--
