From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Date: Sat, 31 Dec 2011 10:45:47 +0000
Subject: [PATCH] fb_defio: add first_io callback
Message-Id: <201112311145.47717.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

With this optional callback the driver is notified when the first page
is entered into the pagelist and a new deferred_io call is scheduled.

A possible use-case for this is runtime-pm. In the first_io call
	pm_runtime_get()
could be called, which starts an asynchronous runtime_resume of the
device. In the deferred_io callback a call to
	pm_runtime_barrier()
makes the sure, the device is resumed by then and a
	pm_runtime_put()
may put the device back to sleep.

Also, some SoCs may use the runtime-pm system to determine if they
are able to enter deeper idle states. Therefore it is necessary to
keep the use-count from the first written page until the conclusion
of the screen update, to prevent the system from going to sleep before
completing the pending update.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/video/fb_defio.c |    4 ++++
 include/linux/fb.h       |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
index c27e153..070f26f 100644
--- a/drivers/video/fb_defio.c
+++ b/drivers/video/fb_defio.c
@@ -107,6 +107,10 @@ static int fb_deferred_io_mkwrite(struct vm_area_struct *vma,
 	/* protect against the workqueue changing the page list */
 	mutex_lock(&fbdefio->lock);
 
+	/* first write in this cycle, notify the driver */
+	if (fbdefio->first_io && list_empty(&fbdefio->pagelist))
+		fbdefio->first_io(info);
+
 	/*
 	 * We want the page to remain locked from ->page_mkwrite until
 	 * the PTE is marked dirty to avoid page_mkclean() being called
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 1d6836c..b86cd41 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -602,6 +602,7 @@ struct fb_deferred_io {
 	struct mutex lock; /* mutex that protects the page list */
 	struct list_head pagelist; /* list of touched pages */
 	/* callback */
+	void (*first_io)(struct fb_info *info);
 	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
 };
 #endif
-- 
1.7.2.3

