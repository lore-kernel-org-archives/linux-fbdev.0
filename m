From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbcon: Store struct display when setting all vcs
Date: Sun, 20 Nov 2005 20:44:54 +0800
Message-ID: <43806FC6.4030403@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdxKa-000873-My
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Nov 2005 14:06:40 -0800
Received: from zproxy.gmail.com ([64.233.162.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdxKZ-0004yH-9j
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Nov 2005 14:06:40 -0800
Received: by zproxy.gmail.com with SMTP id r28so602670nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Nov 2005 14:06:38 -0800 (PST)
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

Store struct display when setting all vc's.  Otherwise, fbcon's behavior
becomes undefined, such as malpositioning of the cursor.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Not for 2.6.15, unless you push this - fbcon-sanitize-fbcon.patch

 drivers/video/console/fbcon.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index efb5064..1a8f0ea 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2779,6 +2779,8 @@ static void fbcon_set_all_vcs(struct fb_
 				fbcon_update_softback(vc);
 		}
 	}
+
+	ops->p = &fb_display[ops->currcon];
 }
 
 static int fbcon_mode_deleted(struct fb_info *info,



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
