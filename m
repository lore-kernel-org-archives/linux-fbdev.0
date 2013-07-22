From: Chen Gang <gang.chen@asianux.com>
Date: Mon, 22 Jul 2013 08:45:33 +0000
Subject: [PATCH] drivers: video: i740fb: add 'default' processing contents for 'switch'.
Message-Id: <51ECF12D.8060903@asianux.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Need add related 'default' processing contents for 'switch', or may
report 'wm' uninitialized warning.

The related warning:

  drivers/video/i740fb.c:662:26: warning: =91wm=92 may be used uninitialize=
d in this function [-Wmaybe-uninitialized]


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 drivers/video/i740fb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/i740fb.c b/drivers/video/i740fb.c
index 6c48388..e82e767 100644
--- a/drivers/video/i740fb.c
+++ b/drivers/video/i740fb.c
@@ -336,6 +336,9 @@ static u32 i740_calc_fifo(struct i740fb_par *par, u32 f=
req, int bpp)
 				wm =3D 0x16110000;
 		}
 		break;
+	default:
+		wm =3D 0;
+		BUG();
 	}
=20
 	return wm;
--=20
1.7.7.6
