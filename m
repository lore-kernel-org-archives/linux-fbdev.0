From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Mon, 30 Jul 2012 10:54:16 +0000
Subject: [PATCH] Fix newport con crashes
Message-Id: <20120730105416.DBB961D1CF@solo.franken.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org
Cc: ralf@linux-mips.org, FlorianSchandinat@gmx.de

Because of commit e84de0c61905030a0fe66b7210b6f1bb7c3e1eab
[MIPS: GIO bus support for SGI IP22/28] newport con is now taking over
console from dummy con, therefore it's necessary to resize the VC to
the correct size to avoid crashes and garbage on console

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 drivers/video/console/newport_con.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 6d15966..b05afd0 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -327,9 +327,16 @@ out_unmap:
 
 static void newport_init(struct vc_data *vc, int init)
 {
-	vc->vc_cols = newport_xsize / 8;
-	vc->vc_rows = newport_ysize / 16;
+	int cols, rows;
+
+	cols = newport_xsize / 8;
+	rows = newport_ysize / 16;
 	vc->vc_can_do_color = 1;
+	if (init) {
+		vc->vc_cols = cols;
+		vc->vc_rows = rows;
+	} else
+		vc_resize(vc, cols, rows);
 }
 
 static void newport_deinit(struct vc_data *c)
