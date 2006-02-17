From: Freddy Spierenburg <freddy@dusktilldawn.nl>
Subject: [PATCH] replaced io_remap_page_range() with io_remap_pfn_range()
Date: Fri, 17 Feb 2006 19:37:29 +0100
Message-ID: <20060217183729.GI14066@dusktilldawn.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JLiXfqD9/Kt1b+Pq"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FAAU8-0007BS-Cp
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Feb 2006 10:37:40 -0800
Received: from tool.snarl.nl ([213.84.251.124])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FAAU6-0008Nt-TT
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Feb 2006 10:37:40 -0800
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id D677D5DF5B
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Feb 2006 19:37:29 +0100 (CET)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 31047-03 for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 17 Feb 2006 19:37:29 +0100 (CET)
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
To: linux-fbdev-devel@lists.sourceforge.net


--JLiXfqD9/Kt1b+Pq
Content-Type: multipart/mixed; boundary="xtx0sNU5lZ46KfgK"
Content-Disposition: inline


--xtx0sNU5lZ46KfgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Replaced the no longer existing io_remap_page_range() routine
with the io_remap_pfn_range() routine. Did not have a chance yet
to test the functionality of the driver, but at least the kernel
compiles cleanly again.

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl> http://snarl.nl/~freddy/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--xtx0sNU5lZ46KfgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fb.patch"
Content-Transfer-Encoding: quoted-printable

diff -Naur master.orig/drivers/video/au1100fb.c master.good/drivers/video/a=
u1100fb.c
--- master.orig/drivers/video/au1100fb.c	2006-02-17 16:50:31.000000000 +0000
+++ master.good/drivers/video/au1100fb.c	2006-02-17 18:34:20.000000000 +0000
@@ -49,6 +49,7 @@
 #include <linux/interrupt.h>
 #include <linux/ctype.h>
 #include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
=20
 #include <asm/mach-au1x00/au1000.h>
=20
@@ -406,7 +407,7 @@
=20
 	vma->vm_flags |=3D VM_IO;
=20
-	if (io_remap_page_range(vma, vma->vm_start, off,
+	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
 				vma->vm_end - vma->vm_start,
 				vma->vm_page_prot)) {
 		return -EAGAIN;

--xtx0sNU5lZ46KfgK--

--JLiXfqD9/Kt1b+Pq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9hfpbxf9XXlB0eERAi7/AKDm1LVwl3nzx8Yp3ySa6OZinL3tBgCg0uuw
w8BLt8Zag0r8Yx/Ddanoq4A=
=U60p
-----END PGP SIGNATURE-----

--JLiXfqD9/Kt1b+Pq--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
