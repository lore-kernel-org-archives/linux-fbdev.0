From: Meelis Roos <mroos@linux.ee>
Subject: [PATCH] fbcursor warning in 2.6.6-rc3
Date: Wed, 28 Apr 2004 12:31:40 +0300 (EEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.44.0404281221150.24906-100000@math.ut.ee>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BImNS-0001Ji-O3
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 03:33:18 -0700
Received: from math.ut.ee ([193.40.5.125] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BImNS-0006vB-6a
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 03:33:18 -0700
Received: from math.ut.ee (smmsp@localhost [IPv6:::1])
	by math.ut.ee (8.12.8+Sun/8.12.8/math-1.2) with ESMTP id i3SAWYRY010183
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Apr 2004 13:32:48 +0300 (EEST)
Received: from localhost (mroos@localhost)
	by math.ut.ee (8.12.8+Sun/8.12.2/Submit) with ESMTP id i3S9VfWx011267
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Apr 2004 12:31:41 +0300 (EEST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

This is 2.6.6-rc3 and I get the following warning on several
architectures:

  CC      drivers/video/fbmem.o
drivers/video/fbmem.c: In function `fb_cursor':
drivers/video/fbmem.c:917: warning: passing arg 1 of `copy_from_user' discards qualifiers from pointer target type

The code is
if (copy_from_user(cursor.image.data, sprite->image.data, size) ||

cursor.image.data is const char *. Since copy_from_user actually changes
that, we should probably cast it manually:

===== drivers/video/fbmem.c 1.96 vs edited =====
--- 1.96/drivers/video/fbmem.c	Wed Apr 21 22:02:56 2004
+++ edited/drivers/video/fbmem.c	Wed Apr 28 12:25:21 2004
@@ -914,7 +914,7 @@
 			return -ENOMEM;
 		}

-		if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
+		if (copy_from_user((char *)cursor.image.data, sprite->image.data, size) ||
 		    copy_from_user(cursor.mask, sprite->mask, size)) {
 			kfree(cursor.image.data);
 			kfree(cursor.mask);

-- 
Meelis Roos (mroos@linux.ee)



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
