From: Jan Kara <jack@suse.cz>
Date: Wed, 02 Oct 2013 14:27:53 +0000
Subject: [PATCH 12/26] pvr2fb: Convert pvr2fb_write() to use get_user_pages_fast()
Message-Id: <1380724087-13927-13-git-send-email-jack@suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380724087-13927-1-git-send-email-jack@suse.cz>
In-Reply-To: <1380724087-13927-1-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org, Jan Kara <jack@suse.cz>, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

CC: linux-fbdev@vger.kernel.org
CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/video/pvr2fb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index df07860563e6..31e1345a88a8 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -686,11 +686,7 @@ static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
 	if (!pages)
 		return -ENOMEM;
 
-	down_read(&current->mm->mmap_sem);
-	ret = get_user_pages(current, current->mm, (unsigned long)buf,
-			     nr_pages, WRITE, 0, pages, NULL);
-	up_read(&current->mm->mmap_sem);
-
+	ret = get_user_pages_fast((unsigned long)buf, nr_pages, WRITE, pages);
 	if (ret < nr_pages) {
 		nr_pages = ret;
 		ret = -EINVAL;
-- 
1.8.1.4

