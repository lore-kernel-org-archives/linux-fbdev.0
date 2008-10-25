From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Typo in drivers/video/modedb.c (fwd)
Date: Sat, 25 Oct 2008 18:16:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0810251816270.15317@anakin>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463808415-1904761223-1224951393=:15317"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@linux-m68k.org>) id 1Ktlp3-0001Qo-JO
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 25 Oct 2008 16:17:05 +0000
Received: from yergi.telenet-ops.be ([195.130.132.36])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ktlou-0007pA-3a for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 25 Oct 2008 16:17:05 +0000
Received: from winston.telenet-ops.be (unknown [195.130.137.75])
	by yergi.telenet-ops.be (Postfix) with ESMTP id C7D365CB2E0
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 25 Oct 2008 18:16:35 +0200 (CEST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808415-1904761223-1224951393=:15317
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ----------
Date: Sat, 25 Oct 2008 17:27:32 +0200
From: Ji=C5~Y=C3=AD Moravec <jim.lkml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Typo in drivers/video/modedb.c

When I viewed drivers/video/modedb.c, so I accidentally noticed a very ol=
d typo already contained in 2.6.0.
This typo remained unheeded at least 5 years. Clear evidence of its impor=
tance.  ;)=20
---
diff -Nupr a/drivers/video/modedb.c b/drivers/video/modedb.c
--- a/drivers/video/modedb.c	2008-10-25 16:18:00.000000000 +0200
+++ b/drivers/video/modedb.c	2008-10-25 16:18:10.000000000 +0200
@@ -329,7 +329,7 @@ const struct fb_videomode vesa_modes[] =3D
 	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
 	/* 17 1152x864-75 VESA */
-	{ NULL, 75, 1153, 864, 9259, 256, 64, 32, 1, 128, 3,
+	{ NULL, 75, 1152, 864, 9259, 256, 64, 32, 1, 128, 3,
 	  FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	  FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
 	/* 18 1280x960-60 VESA */
---
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
---1463808415-1904761223-1224951393=:15317
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
---1463808415-1904761223-1224951393=:15317
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---1463808415-1904761223-1224951393=:15317--
