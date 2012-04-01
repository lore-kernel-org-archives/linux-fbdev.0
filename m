From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Date: Sun, 01 Apr 2012 19:51:07 +0000
Subject: [PATCH v2] fb_defio: add first_io callback
Message-Id: <201204012151.08472.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

Two users of defio were using kmalloc to allocate the structure.
These allocations are changed to kzalloc, to prevent uninitialised
.first_io members in those drivers.

Signed-off-by: Heiko St=FCbner <heiko@sntech.de>
---
changes since v1: convert fb_deferred_io kmalloc calls to kzalloc

 drivers/video/fb_defio.c |    4 ++++
 drivers/video/smscufx.c  |    2 +-
 drivers/video/udlfb.c    |    2 +-
 include/linux/fb.h       |    1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
index c27e153..070f26f 100644
--- a/drivers/video/fb_defio.c
+++ b/drivers/video/fb_defio.c
@@ -107,6 +107,10 @@ static int fb_deferred_io_mkwrite(struct vm_area_struc=
t=20
*vma,
 	/* protect against the workqueue changing the page list */
 	mutex_lock(&fbdefio->lock);
=20
+	/* first write in this cycle, notify the driver */
+	if (fbdefio->first_io && list_empty(&fbdefio->pagelist))
+		fbdefio->first_io(info);
+
 	/*
 	 * We want the page to remain locked from ->page_mkwrite until
 	 * the PTE is marked dirty to avoid page_mkclean() being called
diff --git a/drivers/video/smscufx.c b/drivers/video/smscufx.c
index ccbfef5..9985785 100644
--- a/drivers/video/smscufx.c
+++ b/drivers/video/smscufx.c
@@ -1083,7 +1083,7 @@ static int ufx_ops_open(struct fb_info *info, int use=
r)
=20
 		struct fb_deferred_io *fbdefio;
=20
-		fbdefio =3D kmalloc(sizeof(struct fb_deferred_io), GFP_KERNEL);
+		fbdefio =3D kzalloc(sizeof(struct fb_deferred_io), GFP_KERNEL);
=20
 		if (fbdefio) {
 			fbdefio->delay =3D UFX_DEFIO_WRITE_DELAY;
diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index 157df78..8909d47 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -893,7 +893,7 @@ static int dlfb_ops_open(struct fb_info *info, int user)
=20
 		struct fb_deferred_io *fbdefio;
=20
-		fbdefio =3D kmalloc(sizeof(struct fb_deferred_io), GFP_KERNEL);
+		fbdefio =3D kzalloc(sizeof(struct fb_deferred_io), GFP_KERNEL);
=20
 		if (fbdefio) {
 			fbdefio->delay =3D DL_DEFIO_WRITE_DELAY;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index d31cb68..c10e71e 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -607,6 +607,7 @@ struct fb_deferred_io {
 	struct mutex lock; /* mutex that protects the page list */
 	struct list_head pagelist; /* list of touched pages */
 	/* callback */
+	void (*first_io)(struct fb_info *info);
 	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
 };
 #endif
--=20
1.7.2.3

