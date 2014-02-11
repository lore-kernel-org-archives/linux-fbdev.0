From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 11 Feb 2014 13:00:51 +0000
Subject: Re: [PATCH 0/10] framebuffer patches
Message-Id: <52FA1F03.3050505@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="aRTsvRjjVciemQ4K8Cr1djktMgcKa6ueA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1401231436400.7971@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1401231436400.7971@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-fbdev@vger.kernel.org

--aRTsvRjjVciemQ4K8Cr1djktMgcKa6ueA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 14:58, Tomi Valkeinen wrote:
> On 23/01/14 21:37, Mikulas Patocka wrote:
>> Hi
>>
>> Here I'm sending some framebuffer patches for matrox, mach64, tga and =
a=20
>> fix for copying on vesafb.
>>
>> Mikulas
>>
>=20
> Looks fine to me. Queuing for 3.15.

Oh, I did some conflict resolution on "tgafb: fix mode setting with
fbset". It was trivial, so I think I got it right. But please check
anyway in a few days when these get into linux-next.

 Tomi



--aRTsvRjjVciemQ4K8Cr1djktMgcKa6ueA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+h8DAAoJEPo9qoy8lh71yGAP/0uRhmDNOVjwYxcM0zzB+ikS
BG3I2qd0qNTHe6Osi22v/ibCFCdqIDfC73WM9mvxoIERVBz8T30g7otLvEyJvtHQ
rtWRBjUw78NWMmjX8bGgJaiK1cdx0VJAISmY4QVhjdvB1xz1ib3Ji1m0rc1Aq5nT
+iBJUKRdXyzvmF+/0u8fLcwC1hF/T77/n4AaAk+f7cNZ7zFajD1sHWDM5FXNWYsV
K/P1onk1htp3v8B9RYdjnMFVAheS8Ydt57si0Vo0EjNJn2W4scd1exqW3sDyHT+T
Vh4jjcVjDjJlVuMdDuYp31yRZOECOHcQuynf7EO440xyykfHAKgm2mYD4UNODW92
DTl5qfNRjJv+u8XodjHjwEi7X5CM9enpu9NcKIJ9HI304k7buvFHCGgsl7AlQQV5
iEO4VRgTGQeH+SK1273++0ac1YmMq7dueVO5WPKjhLGv0UyQ7g5lPLqyV5VUe2f5
el2lDsfzvMXC2actq7cNMSvhmI+F1YzmFKkKLjK+OKcLhMW2tP8DInQYDhbSxTNG
RFu6hQZPftxgZ558hqkTS1IxzY9tGE/PB6uadD3rsUJof9XLbNnVYVXkCWU2Xg9h
PxH1/F3ZHjnBxgcNyw1xMpv0fxtEsdmcurU35ueB3qpjhXuYBaGKHH9gpA3AdpZS
btVdWtjbK0pweiwyutFi
=HVUa
-----END PGP SIGNATURE-----

--aRTsvRjjVciemQ4K8Cr1djktMgcKa6ueA--
