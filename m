From: Geert.Uytterhoeven@sonycom.com
Subject: [patch 2/5] ps3fb: atomic fixes
Date: Tue, 13 Mar 2007 15:19:12 +0100
Message-ID: <20070313142153.080502000@sonycom.com>
References: <20070313141910.001573000@sonycom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HR7tN-0007iw-52 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Mar 2007 07:22:21 -0700
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HR7tM-0003D9-N1
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Mar 2007 07:22:21 -0700
Content-Disposition: inline; filename=ps3-stable/ps3fb-atomic.diff
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@gmail.com>, linuxppc-dev@ozlabs.org

ps3fb: Use atomic_dec_if_positive() instead of bogus atomic_read()/atomic_dec()
combinations

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

--- ps3-linux-2.6.21-rc3.orig/drivers/video/ps3fb.c
+++ ps3-linux-2.6.21-rc3/drivers/video/ps3fb.c
@@ -680,13 +680,10 @@ EXPORT_SYMBOL_GPL(ps3fb_wait_for_vsync);
 
 void ps3fb_flip_ctl(int on)
 {
-	if (on) {
-		if (atomic_read(&ps3fb.ext_flip) > 0) {
-			atomic_dec(&ps3fb.ext_flip);
-		}
-	} else {
+	if (on)
+		atomic_dec_if_positive(&ps3fb.ext_flip);
+	else
 		atomic_inc(&ps3fb.ext_flip);
-	}
 }
 
 EXPORT_SYMBOL_GPL(ps3fb_flip_ctl);
@@ -786,8 +783,7 @@ static int ps3fb_ioctl(struct fb_info *i
 
 	case PS3FB_IOCTL_OFF:
 		DPRINTK("PS3FB_IOCTL_OFF:\n");
-		if (atomic_read(&ps3fb.ext_flip) > 0)
-			atomic_dec(&ps3fb.ext_flip);
+		atomic_dec_if_positive(&ps3fb.ext_flip);
 		retval = 0;
 		break;
 

--
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
