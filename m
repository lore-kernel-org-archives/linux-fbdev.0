From: Peter Samuelson <peter@p12n.org>
Subject: [uPATCH] matroxfb undefined parameter
Date: Thu, 18 Mar 2004 00:36:01 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040318003601.GA1105@p12n.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3lW2-0005rm-Nb
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 16:36:06 -0800
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B3lVz-0002Rc-Pz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 16:36:03 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


With CONFIG_MTRR=n, the matroxfb_base module refuses to load properly,
because a MODULE_PARM doesn't have a corresponding global variable.
Trivial patch appended, please apply.

Peter

--- 2.6.4/drivers/video/matrox/matroxfb_base.c~	2004-02-04 03:44:04.000000000 +0000
+++ 2.6.4/drivers/video/matrox/matroxfb_base.c	2004-03-18 00:23:20.000000000 +0000
@@ -2409,8 +2409,10 @@
 MODULE_PARM_DESC(noinit, "Disables W/SG/SD-RAM and bus interface initialization (0 or 1=do not initialize) (default=0)");
 MODULE_PARM(memtype, "i");
 MODULE_PARM_DESC(memtype, "Memory type for G200/G400 (see Documentation/fb/matroxfb.txt for explanation) (default=3 for G200, 0 for G400)");
+#ifdef CONFIG_MTRR
 MODULE_PARM(mtrr, "i");
 MODULE_PARM_DESC(mtrr, "This speeds up video memory accesses (0=disabled or 1) (default=1)");
+#endif
 MODULE_PARM(sgram, "i");
 MODULE_PARM_DESC(sgram, "Indicates that G100/G200/G400 has SGRAM memory (0=SDRAM, 1=SGRAM) (default=0)");
 MODULE_PARM(inv24, "i");

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAWO7xXk7sIRPQRh0RAvNwAJ97Cba1sHc2iSEYMx8ypMhilBASaQCgv4cQ
ognIlMjbZL8FrEUDPgRHtgQ=
=2dZ2
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
