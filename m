From: Robert Schiele <rschiele@uni-mannheim.de>
Subject: [PATCH] export fb_blank in fbmem.c
Date: Tue, 31 Dec 2002 10:16:32 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021231091632.GA20498@schiele.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailout08.sul.t-online.com ([194.25.134.20])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18TIW8-0006xO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 31 Dec 2002 01:16:56 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

fb_blank() from fbmem.c is used in fbcon.ko, so this function should
be exported.

This is done by the following trivial fix.

Robert

--- linux-2.5.53/drivers/video/fbmem.c~	2002-12-31 09:28:23.000000000 +0100
+++ linux-2.5.53/drivers/video/fbmem.c	2002-12-31 09:28:45.000000000 +0100
@@ -930,5 +930,6 @@
 EXPORT_SYMBOL(unregister_framebuffer);
 EXPORT_SYMBOL(registered_fb);
 EXPORT_SYMBOL(num_registered_fb);
+EXPORT_SYMBOL(fb_blank)
=20
 MODULE_LICENSE("GPL");

--=20
Robert Schiele			Tel.: +49-621-181-2517
Dipl.-Wirtsch.informatiker	mailto:rschiele@uni-mannheim.de

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iQEVAwUBPhFgb8QAnns5HcHpAQF7pwf/V3OdH5Po/2mQ46gLRPRzMeCX7Ws2+Bkp
R+WU4n4PYH4cTiaL+Llre+V8NEmS3AIkL63/r69l4P0BC2my078gQMdmwEK4tumF
3ion7dl7yqu0jKr+xPnzwQh3eEc798KYiill4aVPM2nG599VEgduWBCd73Am1L9t
2GFKei3qOrJbWvsh4/kWoScDexMIQQzs28yqZNm+hAjgqQp+4D4rBbncKAyxYRk/
uFrAahMtUBnolVN/30w3QOsFxwF62Z2nkGXt+40+iNyt/ifypWwZQkFuShjisick
CUMeS94rrYNB2mFqEjehyjgdtJjuRt8gGsogY4/dbE9+O2e8Hx63dg==
=xllZ
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
