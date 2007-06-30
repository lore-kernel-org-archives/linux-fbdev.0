From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH v2 1/5] uvesafb: export
	fb_destroy_modelist
Date: Sat, 30 Jun 2007 18:32:00 +0200
Message-ID: <20070630163200.GB3838@spock.one.pl>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I4frf-000471-3M for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Jun 2007 09:32:03 -0700
Received: from ipn26-148.piekary.net ([83.238.26.148])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I4fre-0000oW-GX
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Jun 2007 09:32:02 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com

Make fb_destroy_modelist an exported symbol for use in the uvesafb driver.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
 drivers/video/modedb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 3741ad7..d351eed 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -938,6 +938,7 @@ void fb_destroy_modelist(struct list_head *head)
 		kfree(pos);
 	}
 }
+EXPORT_SYMBOL_GPL(fb_destroy_modelist);
 
 /**
  * fb_videomode_to_modelist: convert mode array to mode list


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
