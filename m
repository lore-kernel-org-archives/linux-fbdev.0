From: Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH] FB deffered io: keep pagelist sorted
Date: Mon,  7 Jul 2008 16:09:29 +0300
Message-ID: <1215436169-21632-2-git-send-email-jekhor@gmail.com>
References: <1215436169-21632-1-git-send-email-jekhor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KFqTP-0003Vz-N5 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Jul 2008 06:09:46 -0700
Received: from nf-out-0910.google.com ([64.233.182.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KFqTN-0004dD-VB
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Jul 2008 06:09:43 -0700
Received: by nf-out-0910.google.com with SMTP id g16so589813nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 07 Jul 2008 06:09:40 -0700 (PDT)
In-Reply-To: <1215436169-21632-1-git-send-email-jekhor@gmail.com>
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
Cc: Antonino Daplas <adaplas@gmail.com>

eInk display drivers will do less work if list of
changed pages will be sorted.

Apollo controller has 'Partial Update' feature ---
updating only a part of a image, which can be done in
small time.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/video/fb_defio.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
index 24843fd..5517e51 100644
--- a/drivers/video/fb_defio.c
+++ b/drivers/video/fb_defio.c
@@ -74,6 +74,7 @@ static int fb_deferred_io_mkwrite(struct vm_area_struct *vma,
 {
 	struct fb_info *info = vma->vm_private_data;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct page *cur;
 
 	/* this is a callback we get when userspace first tries to
 	write to the page. we schedule a workqueue. that workqueue
@@ -83,7 +84,11 @@ static int fb_deferred_io_mkwrite(struct vm_area_struct *vma,
 
 	/* protect against the workqueue changing the page list */
 	mutex_lock(&fbdefio->lock);
-	list_add(&page->lru, &fbdefio->pagelist);
+	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
+		if (cur->index > page->index)
+			break;
+	}
+	list_add(&page->lru, cur->lru.prev);
 	mutex_unlock(&fbdefio->lock);
 
 	/* come back after delay to process the deferred IO */
-- 
1.5.6


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
