From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb: accelerated 24-bit fillrect
Date: Wed, 27 Jun 2007 17:00:37 +0200
Message-ID: <46827B95.7010409@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010003030002070405050909"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I3YyA-0002NT-3n for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Jun 2007 07:58:10 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I3Yy3-0006bE-KZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Jun 2007 07:58:05 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO [87.99.61.239])
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	27 Jun 2007 16:58:01 +0200
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010003030002070405050909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds accelerated fillrect for 24-bit depth.

Signed-off-by:  Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch requires at least the pm2fb source improvement patch.

--- linux-2.6.21/drivers/video/pm2fb.c	2007-06-26 16:46:12.040468472 +0200
+++ linux-2.6.22/drivers/video/pm2fb.c	2007-06-27 16:06:47.512285909 +0200
@@ -1077,7 +1077,13 @@ static void pm2fb_fillrect (struct fb_in
 		pm2_WR(par, PM2R_RENDER,
 				PM2F_RENDER_RECTANGLE | PM2F_RENDER_FASTFILL);
 	} else {
-		cfb_fillrect(info, region);
+		WAIT_FIFO(par, 4);
+		pm2_WR(par, PM2R_COLOR_DDA_MODE, 1);
+		pm2_WR(par, PM2R_CONSTANT_COLOR, color);
+		wmb();
+		pm2_WR(par, PM2R_RENDER,
+				PM2F_RENDER_RECTANGLE | PM2F_INCREASE_X | PM2F_INCREASE_Y );
+		pm2_WR(par, PM2R_COLOR_DDA_MODE, 0);
 	}
 }
 

--------------010003030002070405050909
Content-Type: text/plain;
 name="pm2fb-24bit-fillrect.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm2fb-24bit-fillrect.diff"

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds accelerated fillrect for 24-bit depth.

Signed-off-by:  Krzysztof Helt <krzysztof.h1@wp.pl>

--- linux-2.6.21/drivers/video/pm2fb.c	2007-06-26 16:46:12.040468472 +0200
+++ linux-2.6.22/drivers/video/pm2fb.c	2007-06-27 16:06:47.512285909 +0200
@@ -1077,7 +1077,13 @@ static void pm2fb_fillrect (struct fb_in
 		pm2_WR(par, PM2R_RENDER,
 				PM2F_RENDER_RECTANGLE | PM2F_RENDER_FASTFILL);
 	} else {
-		cfb_fillrect(info, region);
+		WAIT_FIFO(par, 4);
+		pm2_WR(par, PM2R_COLOR_DDA_MODE, 1);
+		pm2_WR(par, PM2R_CONSTANT_COLOR, color);
+		wmb();
+		pm2_WR(par, PM2R_RENDER,
+				PM2F_RENDER_RECTANGLE | PM2F_INCREASE_X | PM2F_INCREASE_Y );
+		pm2_WR(par, PM2R_COLOR_DDA_MODE, 0);
 	}
 }
 

--------------010003030002070405050909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------010003030002070405050909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------010003030002070405050909--
