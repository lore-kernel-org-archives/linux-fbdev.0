From: Jim Hague <jim.hague@acm.org>
Subject: [PATCH 1/2] pm2fb: Blanking fixes
Date: Fri, 22 Oct 2004 10:54:32 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041022105432.06df798a@hagrid.bear-cave.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKw8A-0005Iv-I8
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Oct 2004 02:54:42 -0700
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CKw89-0003xF-PT
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Oct 2004 02:54:42 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>


- Current blanking code forces +ve (h|v)sync. Correct, match 2.4
  behaviour, and introduce VESA constants for clarity.

Signed-off-by: Jim Hague <jim.hague@acm.org>

diff -u -p -r1.24 pm2fb.c
--- drivers/video/pm2fb.c	23 Sep 2004 01:19:45 -0000	1.24
+++ drivers/video/pm2fb.c	19 Oct 2004 08:51:23 -0000
@@ -973,24 +971,26 @@ static int pm2fb_blank(int blank_mode, s
 
 	DPRINTK("blank_mode %d\n", blank_mode);
 
-	/* Turn everything on, then disable as requested. */
-	video |= (PM2F_VIDEO_ENABLE | PM2F_HSYNC_MASK | PM2F_VSYNC_MASK);
-
 	switch (blank_mode) {
-	case 0: 	/* Screen: On; HSync: On, VSync: On */
+	case 0:
+		/* Screen: On */
+		video |= PM2F_VIDEO_ENABLE;
 		break;
-	case 1: 	/* Screen: Off; HSync: On, VSync: On */
+	case VESA_NO_BLANKING + 1:
+		/* Screen: Off */
 		video &= ~PM2F_VIDEO_ENABLE;
 		break;
-	case 2: /* Screen: Off; HSync: On, VSync: Off */
-		video &= ~(PM2F_VIDEO_ENABLE | PM2F_VSYNC_MASK | PM2F_BLANK_LOW );
-		break;
-	case 3: /* Screen: Off; HSync: Off, VSync: On */
-		video &= ~(PM2F_VIDEO_ENABLE | PM2F_HSYNC_MASK | PM2F_BLANK_LOW );
-		break;
-	case 4: /* Screen: Off; HSync: Off, VSync: Off */
-		video &= ~(PM2F_VIDEO_ENABLE | PM2F_VSYNC_MASK | PM2F_HSYNC_MASK|
-			   PM2F_BLANK_LOW);
+	case VESA_VSYNC_SUSPEND + 1:
+		/* VSync: Off */
+		video &= ~(PM2F_VSYNC_MASK | PM2F_BLANK_LOW );
+		break;
+	case VESA_HSYNC_SUSPEND + 1:
+		/* HSync: Off */
+		video &= ~(PM2F_HSYNC_MASK | PM2F_BLANK_LOW );
+		break;
+	case VESA_POWERDOWN + 1:
+		/* HSync: Off, VSync: Off */
+		video &= ~(PM2F_VSYNC_MASK | PM2F_HSYNC_MASK| PM2F_BLANK_LOW);
 		break;
 	}
 	set_video(par, video);



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
