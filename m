From: John Hubbard <jhubbard@nvidia.com>
Date: Fri, 22 May 2020 04:15:06 +0000
Subject: [PATCH 2/2] video: fbdev: convert get_user_pages() --> pin_user_pages()
Message-Id: <20200522041506.39638-3-jhubbard@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200522041506.39638-1-jhubbard@nvidia.com>
In-Reply-To: <20200522041506.39638-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Gustavo A . R . Silva" <gustavo@embeddedor.com>, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, John Hubbard <jhubbard@nvidia.com>

This code was using get_user_pages*(), in a "Case 2" scenario
(DMA/RDMA), using the categorization from [1]. That means that it's
time to convert the get_user_pages*() + put_page() calls to
pin_user_pages*() + unpin_user_pages() calls.

There is some helpful background in [2]: basically, this is a small
part of fixing a long-standing disconnect between pinning pages, and
file systems' use of those pages.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/video/fbdev/pvr2fb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index ceb6ef590597..2d9f69b93392 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -652,7 +652,7 @@ static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
 	if (!pages)
 		return -ENOMEM;
 
-	ret = get_user_pages_fast((unsigned long)buf, nr_pages, FOLL_WRITE, pages);
+	ret = pin_user_pages_fast((unsigned long)buf, nr_pages, FOLL_WRITE, pages);
 	if (ret < nr_pages) {
 		if (ret < 0) {
 			/*
@@ -712,9 +712,7 @@ static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
 	ret = count;
 
 out_unmap:
-	for (i = 0; i < nr_pages; i++)
-		put_page(pages[i]);
-
+	unpin_user_pages(pages, nr_pages);
 	kfree(pages);
 
 	return ret;
-- 
2.26.2
