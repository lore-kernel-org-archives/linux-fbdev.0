From: Luigi Gangitano <luigi@debian.org>
Subject: Re: Re: [Fwd: AtyFB in 2.6.10, still not
	perfect]
Date: Wed, 16 Mar 2005 00:20:40 +0100
Message-ID: <1110928841.6491.0.camel@willis>
References: <200503151826.46073.adaplas@hotpop.com>
	 <200503160439.05644.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-utDABb9OYEWocNLxCW+R"
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBLLe-0003Jy-2P
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 15:21:14 -0800
Received: from ms003msg.fastwebnet.it ([213.140.2.42])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DBLLa-0008FP-JO
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 15:21:13 -0800
In-Reply-To: <200503160439.05644.adaplas@hotpop.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Alexander Kern <alex.kern@gmx.de>


--=-utDABb9OYEWocNLxCW+R
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Il giorno mer, 16-03-2005 alle 04:39 +0800, Antonino A. Daplas ha
scritto:
> working:
> atyfb: 3D RAGE (XL) [0x4752 rev 0x27] 8M SDRAM, 29.498928 MHz XTAL, 230=20
> MHz PLL, 100 Mhz MCLK
>=20
> not working:
> atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752 rev 0x27]
> atyfb: 8M SDRAM (1:1), 29.498928 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63=20
> MHz XCLK
>=20
> The MCLK value is different.  Can you try booting with
>=20
> video=3Datyfb:mclk:100
>=20
> You can also experiment with xclk:
>=20
> video=3Datyfb:mclk:100,xclk:63

No luck, with neither option.

Regards,

--=20
 Luigi Gangitano -- <luigi@debian.org> -- <gangitano@lugroma3.org>
 GPG: 1024D/924C0C26: 12F8 9C03 89D3 DB4A 9972  C24A F19B A618 924C 0C26

--=-utDABb9OYEWocNLxCW+R
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Questa parte del messaggio =?ISO-8859-1?Q?=E8?= firmata

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCN23I8ZumGJJMDCYRAozeAJ93N055cYcnV80iJ32V/CestgXXogCbBKwP
+wXRDz4dbONYAe+Bo/8bLy0=
=gmUy
-----END PGP SIGNATURE-----

--=-utDABb9OYEWocNLxCW+R--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
