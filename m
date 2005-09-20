From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbdev: Fix reversed back and front porches
Date: Wed, 21 Sep 2005 07:32:49 +0800
Message-ID: <43309C21.6040901@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHrku-0003Ao-7p
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Sep 2005 16:42:32 -0700
Received: from zproxy.gmail.com ([64.233.162.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EHrku-0004Tu-4d
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Sep 2005 16:42:32 -0700
Received: by zproxy.gmail.com with SMTP id i11so1595838nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Sep 2005 16:42:26 -0700 (PDT)
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
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

In fbdev perspective, the frontporch is the lower/right margin and the
backporch is the upper/left margin.

Correct.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 fbcvt.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff --git a/drivers/video/fbcvt.c b/drivers/video/fbcvt.c
--- a/drivers/video/fbcvt.c
+++ b/drivers/video/fbcvt.c
@@ -272,11 +272,11 @@ static void fb_cvt_convert_to_mode(struc
 {
 	mode->refresh = cvt->f_refresh;
 	mode->pixclock = KHZ2PICOS(cvt->pixclock/1000);
-	mode->left_margin = cvt->h_front_porch;
-	mode->right_margin = cvt->h_back_porch;
+	mode->left_margin = cvt->h_back_porch;
+	mode->right_margin = cvt->h_front_porch;
 	mode->hsync_len = cvt->hsync;
-	mode->upper_margin = cvt->v_front_porch;
-	mode->lower_margin = cvt->v_back_porch;
+	mode->upper_margin = cvt->v_back_porch;
+	mode->lower_margin = cvt->v_front_porch;
 	mode->vsync_len = cvt->vsync;
 
 	mode->sync &= ~(FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT);



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
