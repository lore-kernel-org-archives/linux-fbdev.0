From: Peter 'p2' De Schrijver <p2@mind.be>
Subject: pm2 driver
Date: Tue, 27 Sep 2005 20:46:34 +0200
Message-ID: <20050927184633.GH4320@codecarver>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ee6FjwWxuMujAVRe"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKKVA-0001KY-3e
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Sep 2005 11:48:28 -0700
Received: from nat.office.mind.be ([62.166.230.82])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1EKKV8-0002WZ-Ei
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Sep 2005 11:48:28 -0700
Content-Disposition: inline
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
To: jim.hague@acm.org, linux-fbdev-devel@lists.sourceforge.net


--ee6FjwWxuMujAVRe
Content-Type: multipart/mixed; boundary="PEkEgRdBLZYkpbX2"
Content-Disposition: inline


--PEkEgRdBLZYkpbX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Attached is a small patch which configures the correct memory clock and
timings on the Elsa Winner 2000 Office pm2 based card. This is necessary
when the card is used on a platform which does not support PC style BIOS
initialization.

Thanks,

Peter (p2).

--=20
goa is a state of mind

--PEkEgRdBLZYkpbX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-sb1-pm2
Content-Transfer-Encoding: quoted-printable

diff -urN -x asm -x scripts -x config linux/drivers/video/pm2fb.c linux-my/=
drivers/video/pm2fb.c
--- linux/drivers/video/pm2fb.c	2005-08-01 20:24:38.000000000 +0200
+++ linux-my/drivers/video/pm2fb.c	2005-09-22 16:40:11.000000000 +0200
@@ -52,7 +52,7 @@
 #error "Only generic PCI cards supported."
 #endif
=20
-#undef PM2FB_MASTER_DEBUG
+#define PM2FB_MASTER_DEBUG 1
 #ifdef PM2FB_MASTER_DEBUG
 #define DPRINTK(a,b...)	printk(KERN_DEBUG "pm2fb: %s: " a, __FUNCTION__ , =
## b)
 #else
@@ -1121,6 +1121,22 @@
 		default_par->mem_control, default_par->boot_address,
 		default_par->mem_config);
=20
+	if(default_par->mem_control =3D=3D 0 &&
+		default_par->boot_address =3D=3D 0x31 &&
+		default_par->mem_config =3D=3D 0x259fffff &&
+		pdev->subsystem_vendor =3D=3D 0x1048 &&
+		pdev->subsystem_device =3D=3D 0x0a31) {
+		DPRINTK("subsystem_vendor: %04x, subsystem_device: %04x\n",
+			pdev->subsystem_vendor, pdev->subsystem_device);
+		DPRINTK("We have not been initialized by VGA BIOS "
+			"and are running on an Elsa Winner 2000 Office\n");
+		DPRINTK("Initializing card timings manually...\n");
+		default_par->mem_control=3D0;
+		default_par->boot_address=3D0x20;
+		default_par->mem_config=3D0xe6002021;
+		default_par->memclock=3D100000;
+	}
+
 	/* Now work out how big lfb is going to be. */
 	switch(default_par->mem_config & PM2F_MEM_CONFIG_RAM_MASK) {
 	case PM2F_MEM_BANKS_1:

--PEkEgRdBLZYkpbX2--

--ee6FjwWxuMujAVRe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDOZOJKLKVw/RurbsRAkoGAJ9zkEOmdRHtuZZcJCul8wN9W85JKwCfdGFX
+06cDu1CgDyzIqJQvRy4H5Q=
=u76U
-----END PGP SIGNATURE-----

--ee6FjwWxuMujAVRe--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
