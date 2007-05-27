From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] pm3fb: switching between X and fb fix
Date: Sun, 27 May 2007 17:23:50 +0000 (UTC)
Message-ID: <465B103C.9050800@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060307050103020006040504"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HsMSx-0000h3-Uz for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 10:23:39 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HsMSw-0001e6-Df
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 10:23:39 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO [87.99.61.239])
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	27 May 2007 19:23:29 +0200
Date: Mon, 28 May 2007 19:24:12 +0200
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060307050103020006040504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch correctly restores console state after switching from X.
Otherwise, screen is always off after switching from X.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.21.old/drivers/video/pm3fb.c	2007-05-28 14:42:00.431762000 +0200
+++ linux-2.6.21/drivers/video/pm3fb.c	2007-05-28 19:19:46.001429935 +0200
@@ -498,7 +498,7 @@ static int pm3fb_set_par(struct fb_info 
 	else
 		par->video |= PM3VideoControl_LINE_DOUBLE_OFF;
 
-	if (info->var.activate == FB_ACTIVATE_NOW)
+	if ((info->var.activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW)
 		par->video |= PM3VideoControl_ENABLE;
 	else {
 		par->video |= PM3VideoControl_DISABLE;

--------------060307050103020006040504
Content-Type: text/plain;
 name="pm3fb-x-vt-switching-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm3fb-x-vt-switching-fix.diff"

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch correctly restores console state after switching from X.
Otherwise, screen is always off after switching from X.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.21.old/drivers/video/pm3fb.c	2007-05-28 14:42:00.431762000 +0200
+++ linux-2.6.21/drivers/video/pm3fb.c	2007-05-28 19:19:46.001429935 +0200
@@ -498,7 +498,7 @@ static int pm3fb_set_par(struct fb_info 
 	else
 		par->video |= PM3VideoControl_LINE_DOUBLE_OFF;
 
-	if (info->var.activate == FB_ACTIVATE_NOW)
+	if ((info->var.activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW)
 		par->video |= PM3VideoControl_ENABLE;
 	else {
 		par->video |= PM3VideoControl_DISABLE;

--------------060307050103020006040504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------060307050103020006040504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------060307050103020006040504--
