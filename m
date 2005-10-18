From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/17] fbcon: Initialize new driver when old driver is released
Date: Tue, 18 Oct 2005 17:15:23 +0800
Message-ID: <4354BD2B.6010906@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyI3-0000aY-P0
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:42:31 -0700
Received: from zproxy.gmail.com ([64.233.162.199])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyI3-0000hV-Lz
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:42:31 -0700
Received: by zproxy.gmail.com with SMTP id s18so1165220nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 13:42:31 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

If machine has more than 1 driver installed, and they all drive the same
hardware, it's possible that the driver's fb_release() method will attempt
to restore the hardware state to the initial state.  This will leave
the new driver in an undefined state.  To prevent this problem, initialize
the new driver by calling fb_set_par() when the old driver is released by
fbcon.

Signed-off-by: Antonino Daplas<adaplas@pol.net>
---
 fbcon.c |    9 +++++++++
 1 files changed, 9 insertions(+)


diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -630,6 +630,15 @@ static int con2fb_release_oldinfo(struct
 		kfree(oldinfo->fbcon_par);
 		oldinfo->fbcon_par = NULL;
 		module_put(oldinfo->fbops->owner);
+		/*
+		  If oldinfo and newinfo are driving the same hardware,
+		  the fb_release() method of oldinfo may attempt to
+		  restore the hardware state.  This will leave the
+		  newinfo in an undefined state. Thus, a call to
+		  fb_set_par() may be needed for the newinfo.
+		*/
+		if (newinfo->fbops->fb_set_par)
+			newinfo->fbops->fb_set_par(newinfo);
 	}
 
 	return err;




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
