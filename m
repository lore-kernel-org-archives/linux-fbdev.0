From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] nvidiafb: Fix initial display corruption on certain laptops
Date: Mon, 08 Aug 2005 14:22:43 +0800
Message-ID: <42F6FA33.4050309@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E213D-0002jh-AF
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 23:23:55 -0700
Received: from wproxy.gmail.com ([64.233.184.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E213C-0002Bs-Va
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 23:23:55 -0700
Received: by wproxy.gmail.com with SMTP id i3so979498wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 23:23:49 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Vincent Fortier <vinctre@videotron.ca>

Reported by:Vincent Fortier (Bugzilla Bug 4768)

"At boot time the screen appears moved to the mid right portion of the actual
video pannel making the end of the line appears at the left edge...  It simply
looks like moved half way to the right"

His particular hardware has a display with an unusual dimension (1920x1200) but
unfortunately has no EDID block. None of the entries in the global mode
database is correct for this particular display, and it particularly has
difficulty scaling up 640x480 (the default startup mode of nvidiafb) to
1920x1200 which causes the above described problem.

1, Add 1920x1200 to the global mode database.

2. Let nvidiafb base the startup mode from the flatpanel dimensions only if the
  EDID block is absent, no boot mode parameter is specified by the user, and
  a flatpanel/LCD display is attached.

From: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

modedb.c        |    5 +++++
nvidia/nvidia.c |    7 +++++++
2 files changed, 12 insertions(+)

--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -246,6 +246,11 @@ static const struct fb_videomode modedb[
 	/* 480x300 @ 72 Hz, 48.0 kHz hsync */
 	NULL, 72, 480, 300, 33386, 40, 24, 11, 19, 80, 3,
 	0, FB_VMODE_DOUBLE
+    }, {
+	/* 1920x1200 @ 60 Hz, 74.5 Khz hsync */
+	NULL, 60, 1920, 1200, 5177, 128, 336, 1, 38, 208, 3,
+	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	FB_VMODE_NONINTERLACED
     },
 };
 
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1325,6 +1325,13 @@ static int __devinit nvidia_set_fbinfo(s
 
 		fb_videomode_to_var(&nvidiafb_default_var, &modedb);
 		nvidiafb_default_var.bits_per_pixel = 8;
+	} else if (par->fpWidth && par->fpHeight) {
+		char buf[16];
+
+		memset(buf, 0, 16);
+		snprintf(buf, 15, "%dx%d", par->fpWidth, par->fpHeight);
+		fb_find_mode(&nvidiafb_default_var, info, buf, specs->modedb,
+			     specs->modedb_len, &modedb, 8);
 	}
 
 	if (mode_option)




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
