From: Freddy Spierenburg <freddy@dusktilldawn.nl>
Subject: [PATCH] Fix to remove flickering.
Date: Tue, 12 Sep 2006 17:46:57 +0200
Message-ID: <20060912154656.GY10006@dusktilldawn.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i/VKSWANvDZSIhsB"
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: <fbdev-devel.lists.sourceforge.net
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-mips@linux-mips.org


--i/VKSWANvDZSIhsB
Content-Type: multipart/mixed; boundary="yC91f7qSViS67v3c"
Content-Disposition: inline


--yC91f7qSViS67v3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Antonino,

Currently a lot of flickering is seen on the VGA and LCD port
when one starts a DBAu1100 board, with 'CONFIG_PRINTK=3Dy'.

This patch removes the flickering and as a result all kernel
messages come by in a nice steady fashion.

Please apply.

Signed-off-by: Freddy Spierenburg <freddy@dusktilldawn.nl>

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--yC91f7qSViS67v3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="au1100fb.patch"

diff -Naur linux-2.6.17.13-orig/drivers/video/au1100fb.h linux-2.6.17.13/drivers/video/au1100fb.h
--- linux-2.6.17.13-orig/drivers/video/au1100fb.h	2006-09-09 03:23:25.000000000 +0000
+++ linux-2.6.17.13/drivers/video/au1100fb.h	2006-09-12 15:26:52.000000000 +0000
@@ -274,7 +274,7 @@
 		.bpp = 16,
 		.control_base =	0x0004886A |
 			LCD_CONTROL_DEFAULT_PO | LCD_CONTROL_DEFAULT_SBPPF |
-			LCD_CONTROL_BPP_16,
+			LCD_CONTROL_BPP_16 | LCD_CONTROL_SBB_4,
 		.clkcontrol_base = 0x00020000,
 		.horztiming = 0x005aff1f,
 		.verttiming = 0x16000e57,

--yC91f7qSViS67v3c--

--i/VKSWANvDZSIhsB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFBtZwbxf9XXlB0eERAtcRAJ98NI4P0gat6ROB3UcIs37ebhNqbQCgibi+
sKl0Oq602P5FsbJhrqksMXA=
=RJn2
-----END PGP SIGNATURE-----

--i/VKSWANvDZSIhsB--
