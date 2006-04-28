From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 2.6.16] Add 1366x768 (WXGA) mode to modedb
Date: Fri, 28 Apr 2006 12:10:10 -0400
Message-ID: <B3DB462A-3D86-4803-AC99-52C8F94541F3@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZVV2-00050V-1a
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 09:07:20 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZVV2-0004vI-1D
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 09:07:20 -0700
Received: from mail8.sea5.speakeasy.net ([69.17.117.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FZVV1-0006lF-E2
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 09:07:19 -0700
Received: from lex098.cecropia.com (HELO [192.168.3.25]) (dmunsie@cecropia.com@[63.138.212.98])
          (envelope-sender <dmunsie@cecropia.com>)
          by mail8.sea5.speakeasy.net (qmail-ldap-1.03) with RC4-SHA encrypted SMTP
          for <linux-fbdev-devel@lists.sourceforge.net>; 28 Apr 2006 16:07:16 -0000
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
Content-Type: text/plain; charset="us-ascii"; delsp="yes"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

From: Dennis Munsie <dmunsie@cecropia.com>

Adds 1366x768 @ 60Hz to drivers/video/modedb.c.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

  drivers/video/modedb.c |    6 +++++-
1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6.16/drivers/video/modedb.c	2006-03-20 00:53:29.000000000  
-0500
+++ linux-2.6.16-wxga/drivers/video/modedb.c	2006-04-27  
17:08:11.000000000 -0500
@@ -255,7 +255,11 @@ static const struct fb_videomode modedb[
	/* 1152x768, 60 Hz, PowerBook G4 Titanium I and II */
	NULL, 60, 1152, 768, 15386, 158, 26, 29, 3, 136, 6,
	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
-    },
+    }, {
+	/* 1366x768, 60 Hz, 47.403 kHz hsync, WXGA 16:9 aspect ratio */
+	NULL, 60, 1366, 768, 13806, 120, 10, 14, 3, 32, 5,
+	0, FB_VMODE_NONINTERLACED
+	},
};
#ifdef CONFIG_FB_MODE_HELPERS


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
