From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Fri, 22 Mar 2013 14:17:32 +0000
Subject: [PATCH 9/9] AUO-K190x: Add resolutions for portrait displays
Message-Id: <201303221517.33111.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

The controller also contains support for displays in a portrait
orientation and it seems devices which such displays really reached
the market - Pandigital Novell seems to be one example.

Signed-off-by: Heiko St=C3=BCbner <heiko@sntech.de>
---
 drivers/video/auo_k190x.c   |    8 ++++++++
 include/video/auo_k190xfb.h |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/video/auo_k190x.c b/drivers/video/auo_k190x.c
index 87cff5b..3bb32c2 100644
--- a/drivers/video/auo_k190x.c
+++ b/drivers/video/auo_k190x.c
@@ -39,6 +39,14 @@ static struct panel_info panel_table[] =3D {
 		.w =3D 1024,
 		.h =3D 768,
 	},
+	[AUOK190X_RESOLUTION_600_800] =3D {
+		.w =3D 600,
+		.h =3D 800,
+	},
+	[AUOK190X_RESOLUTION_768_1024] =3D {
+		.w =3D 768,
+		.h =3D 1024,
+	},
 };
=20
 /*
diff --git a/include/video/auo_k190xfb.h b/include/video/auo_k190xfb.h
index ad7bc51..ac329ee 100644
--- a/include/video/auo_k190xfb.h
+++ b/include/video/auo_k190xfb.h
@@ -22,6 +22,8 @@
  */
 #define AUOK190X_RESOLUTION_800_600		0
 #define AUOK190X_RESOLUTION_1024_768		1
+#define AUOK190X_RESOLUTION_600_800		4
+#define AUOK190X_RESOLUTION_768_1024		5
=20
 /*
  * struct used by auok190x. board specific stuff comes from *board
--=20
1.7.2.3

