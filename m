From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] Fix fb.h breaking compilation of userspace programs
Date: Sat, 4 Sep 2004 18:35:16 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040904163516.GA23640@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3dVl-0003mn-K0
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Sep 2004 09:35:33 -0700
Received: from pcws2.piekary.net ([80.48.23.131] helo=spock.one.pl)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1C3dVg-0006iO-Pq
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Sep 2004 09:35:30 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net


--aM3YZ0Iwxop3KEKx
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The latest changes introduced to the fb structs in linux/fb.h make
compilation of userspace programs break with:

include/linux/fb.h:305: error: field `modelist' has incomplete type

This is caused by struct list_head not being seen from userspace. The
attached patch is a possible fix for this problem.

Live long and prosper.
--=20
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fb-list.patch"
Content-Transfer-Encoding: quoted-printable

diff -Naur linux-2.6.9-rc1/include/linux/list.h linux-2.6.9-rc1-a/include/l=
inux/list.h
--- linux-2.6.9-rc1/include/linux/list.h	2004-09-04 18:18:18.000000000 +0200
+++ linux-2.6.9-rc1-a/include/linux/list.h	2004-09-04 18:23:55.401859688 +0=
200
@@ -1,6 +1,10 @@
 #ifndef _LINUX_LIST_H
 #define _LINUX_LIST_H
=20
+struct list_head {
+	struct list_head *next, *prev;
+};
+
 #ifdef __KERNEL__
=20
 #include <linux/stddef.h>
@@ -25,10 +29,6 @@
  * using the generic single-entry routines.
  */
=20
-struct list_head {
-	struct list_head *next, *prev;
-};
-
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
=20
 #define LIST_HEAD(name) \
@@ -696,7 +696,5 @@
 		({ tpos =3D hlist_entry(pos, typeof(*tpos), member); 1;}); \
 	     pos =3D rcu_dereference(pos->next))
=20
-#else
-#warning "don't include kernel headers in userspace"
 #endif /* __KERNEL__ */
 #endif

--FL5UXtIhxfXey3p5--

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBOe7EaQ0HSaOUe+YRAtOYAJwIvbhCr7n/z52v9VXtqyoz88oj/wCfQh3F
vx6n0VHTk1xk03jlJZnYqQw=
=ys5/
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
