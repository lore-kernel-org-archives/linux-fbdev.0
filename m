From: John Hubbard <jhubbard@nvidia.com>
Date: Fri, 22 May 2020 04:15:05 +0000
Subject: [PATCH 1/2] video: fbdev: fix error handling for get_user_pages_fast()
Message-Id: <20200522041506.39638-2-jhubbard@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200522041506.39638-1-jhubbard@nvidia.com>
In-Reply-To: <20200522041506.39638-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Gustavo A . R . Silva" <gustavo@embeddedor.com>, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, John Hubbard <jhubbard@nvidia.com>

Dealing with the return value of get_user_pages*() variants has a few
classic pitfalls, and this driver found one of them: the return value
might be zero, positive, or -errno. And if positive, it might be fewer
pages than were requested. And if fewer pages than requested, then
the caller should return (via put_page()) the pages that *were*
pinned.

This driver was doing that *except* that it had a problem with the
-errno case, which was being stored in an unsigned int, and which
would case an interesting mess if it ever happened: nr_pages would be
interpreted as a spectacularly huge unsigned value, rather than a
small negative value. Also, it was unnecessarily overriding a
potentially informative -errno, with -EINVAL, in some cases.

Instead: clamp the nr_pages to zero or positive, so that the error
handling works. And return the -errno value from get_user_pages*(),
unchanged, if we get one. And explain this with comments, seeing as
how it is error-prone.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/video/fbdev/pvr2fb.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index f18d457175d9..ceb6ef590597 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -654,8 +654,22 @@ static ssize_t pvr2fb_write(struct fb_info *info, const char *buf,
 
 	ret = get_user_pages_fast((unsigned long)buf, nr_pages, FOLL_WRITE, pages);
 	if (ret < nr_pages) {
-		nr_pages = ret;
-		ret = -EINVAL;
+		if (ret < 0) {
+			/*
+			 *  Clamp the unsigned nr_pages to zero so that the
+			 *  error handling works. And leave ret at whatever
+			 *  -errno value was returned from GUP.
+			 */
+			nr_pages = 0;
+		} else {
+			nr_pages = ret;
+			/*
+			 * Use -EINVAL to represent a mildly desperate guess at
+			 * why we got fewer pages (maybe even zero pages) than
+			 * requested.
+			 */
+			ret = -EINVAL;
+		}
 		goto out_unmap;
 	}
 
-- 
2.26.2
