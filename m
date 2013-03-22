From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Fri, 22 Mar 2013 14:13:37 +0000
Subject: [PATCH 2/9] AUO-K190x: add runtime-pm calls to controller init functions
Message-Id: <201303221513.38091.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

The controller init may be called from a context where the device
is runtime suspended, leading to a deadlock, as the controllers only
accepts the wakeup command when suspended.

Signed-off-by: Heiko St=C3=BCbner <heiko@sntech.de>
---
 drivers/video/auo_k1900fb.c |    6 ++++++
 drivers/video/auo_k1901fb.c |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/video/auo_k1900fb.c b/drivers/video/auo_k1900fb.c
index b02fab5d..8cf4847 100644
--- a/drivers/video/auo_k1900fb.c
+++ b/drivers/video/auo_k1900fb.c
@@ -60,9 +60,12 @@
=20
 static void auok1900_init(struct auok190xfb_par *par)
 {
+	struct device *dev =3D par->info->device;
 	struct auok190x_board *board =3D par->board;
 	u16 init_param =3D 0;
=20
+	pm_runtime_get_sync(dev);
+
 	init_param |=3D AUOK1900_INIT_TEMP_AVERAGE;
 	init_param |=3D AUOK1900_INIT_ROTATE(par->rotation);
 	init_param |=3D AUOK190X_INIT_INVERSE_WHITE;
@@ -74,6 +77,9 @@ static void auok1900_init(struct auok190xfb_par *par)
=20
 	/* let the controller finish */
 	board->wait_for_rdy(par);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 }
=20
 static void auok1900_update_region(struct auok190xfb_par *par, int mode,
diff --git a/drivers/video/auo_k1901fb.c b/drivers/video/auo_k1901fb.c
index ece99b8..98aa222 100644
--- a/drivers/video/auo_k1901fb.c
+++ b/drivers/video/auo_k1901fb.c
@@ -101,9 +101,12 @@
=20
 static void auok1901_init(struct auok190xfb_par *par)
 {
+	struct device *dev =3D par->info->device;
 	struct auok190x_board *board =3D par->board;
 	u16 init_param =3D 0;
=20
+	pm_runtime_get_sync(dev);
+
 	init_param |=3D AUOK190X_INIT_INVERSE_WHITE;
 	init_param |=3D AUOK190X_INIT_FORMAT0;
 	init_param |=3D AUOK1901_INIT_RESOLUTION(par->resolution);
@@ -113,6 +116,9 @@ static void auok1901_init(struct auok190xfb_par *par)
=20
 	/* let the controller finish */
 	board->wait_for_rdy(par);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 }
=20
 static void auok1901_update_region(struct auok190xfb_par *par, int mode,
--=20
1.7.2.3

