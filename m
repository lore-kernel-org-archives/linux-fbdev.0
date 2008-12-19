From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 02/05] video: deferred io cleanup
Date: Fri, 19 Dec 2008 15:34:23 +0900
Message-ID: <20081219063423.2703.88796.sendpatchset@rx1.opensource.se>
References: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, adaplas@gmail.com, linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Make sure the mmap callback is set to NULL in the deferred io
cleanup function. This way we can enable and disable deferred
io on the fly.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/fb_defio.c |    3 +++
 1 file changed, 3 insertions(+)

--- 0004/drivers/video/fb_defio.c
+++ work/drivers/video/fb_defio.c	2008-12-17 15:32:04.000000000 +0900
@@ -202,6 +202,9 @@ void fb_deferred_io_cleanup(struct fb_in
 		page = vmalloc_to_page(screen_base + i);
 		page->mapping = NULL;
 	}
+
+	info->fbops->fb_mmap = NULL;
+	mutex_destroy(&fbdefio->lock);
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
 
