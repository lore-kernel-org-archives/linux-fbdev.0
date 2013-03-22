From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Fri, 22 Mar 2013 14:14:22 +0000
Subject: [PATCH 3/9] AUO-K190x: set the correct runtime-pm state in recover
Message-Id: <201303221514.22888.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

In the recover function the device gets powercycled and is after
this again active, independent of its previous state.

Signed-off-by: Heiko St=C3=BCbner <heiko@sntech.de>
---
 drivers/video/auo_k190x.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/video/auo_k190x.c b/drivers/video/auo_k190x.c
index 6c2879d..954b781 100644
--- a/drivers/video/auo_k190x.c
+++ b/drivers/video/auo_k190x.c
@@ -587,10 +587,16 @@ static int auok190x_power(struct auok190xfb_par *par,=
 bool on)
=20
 static void auok190x_recover(struct auok190xfb_par *par)
 {
+	struct device *dev =3D par->info->device;
+
 	auok190x_power(par, 0);
 	msleep(100);
 	auok190x_power(par, 1);
=20
+	/* after powercycling the device, it's always active */
+	pm_runtime_set_active(dev);
+	par->standby =3D 0;
+
 	par->init(par);
=20
 	/* wait for init to complete */
--=20
1.7.2.3

