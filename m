From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] Allow core fb to be built as a module
Date: Wed, 2 Mar 2005 19:51:00 +0200
Message-ID: <20050302175059.GA9917@linux-sh.org>
References: <9e4733910502241239268ca595@mail.gmail.com> <Pine.LNX.4.56.0502282010070.16877@pentafluge.infradead.org> <200503012031.50512.adaplas@hotpop.com> <9e473391050302092834dc6e36@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6Y00-0000Km-ND
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 09:51:04 -0800
Received: from smtp3.pp.htv.fi ([213.243.153.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D6Xzy-0006D4-GC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 09:51:04 -0800
Content-Disposition: inline
In-Reply-To: <9e473391050302092834dc6e36@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@www.infradead.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2005 at 12:28:48PM -0500, Jon Smirl wrote:
> Then it is needs (FB =3D y) like this...
> If you leave them as checks they will be built and linked into the FB mod=
ule.
>=20
> [jonsmirl@jonsmirl video]$ bk diffs -u
> =3D=3D=3D=3D=3D Kconfig 1.76 vs edited =3D=3D=3D=3D=3D
> --- 1.76/drivers/video/Kconfig  2005-02-17 19:09:04 -05:00
> +++ edited/Kconfig      2005-03-02 12:25:28 -05:00
> @@ -269,11 +269,11 @@
>=20
>  config FB_ASILIANT
>         bool "Chips 69000 display support"
> -       depends on FB && PCI
> +       depends on (FB =3D y) && PCI
>=20
There's no reason asiliantfb can't be a module, lets get that cleaned up
instead..

It would also be nice to get this fb_get_options() stuff done in a clean
way, having all these MODULE ifdefs/ifndefs here is just as ugly as when
the module_init()'s had them.

 drivers/video/Kconfig      |    2 +-
 drivers/video/asiliantfb.c |    9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

=3D=3D=3D=3D=3D drivers/video/Kconfig 1.74 vs edited =3D=3D=3D=3D=3D
--- 1.74/drivers/video/Kconfig	2005-01-31 08:33:42 +02:00
+++ edited/drivers/video/Kconfig	2005-03-02 19:43:54 +02:00
@@ -268,7 +268,7 @@
 	  65550 graphics chip in PowerBooks.
=20
 config FB_ASILIANT
-	bool "Chips 69000 display support"
+	tristate "Chips 69000 display support"
 	depends on FB && PCI
=20
 config FB_IMSTT
=3D=3D=3D=3D=3D drivers/video/asiliantfb.c 1.6 vs edited =3D=3D=3D=3D=3D
--- 1.6/drivers/video/asiliantfb.c	2004-10-29 11:13:41 +03:00
+++ edited/drivers/video/asiliantfb.c	2005-03-02 19:49:50 +02:00
@@ -606,17 +606,20 @@
=20
 int __init asiliantfb_init(void)
 {
+#ifndef MODULE
 	if (fb_get_options("asiliantfb", NULL))
 		return -ENODEV;
+#endif
=20
-	return pci_module_init(&asiliantfb_driver);
+	return pci_register_driver(&asiliantfb_driver);
 }
=20
-module_init(asiliantfb_init);
-
 static void __exit asiliantfb_exit(void)
 {
 	pci_unregister_driver(&asiliantfb_driver);
 }
+
+module_init(asiliantfb_init);
+module_exit(asiliantfb_exit);
=20
 MODULE_LICENSE("GPL");

--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCJf0D1K+teJFxZ9wRAvPhAJ0QKa+5U7jEglfjKEk162fbdET+2ACeOfhS
/1Me//Prf67D+xnWuuNWGMI=
=vHoV
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
