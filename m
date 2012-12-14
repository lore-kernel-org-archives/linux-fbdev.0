From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 14 Dec 2012 15:01:33 +0000
Subject: [patch] OMAPDSS: reading past end of array in dispc_dump_regs()
Message-Id: <20121214150133.GB15839@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Archit Taneja <archit@ti.com>, Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org

We added another kind of plane in 66a0f9e4ac "OMAPDSS: Use WB fifo for
GFX overlay" so this array needs a new entry as well.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static checker work.  I don't have a way to test this.

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index fedbd2c..bfe62cc 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3163,6 +3163,7 @@ static void dispc_dump_regs(struct seq_file *s)
 		[OMAP_DSS_VIDEO1]	= "VID1",
 		[OMAP_DSS_VIDEO2]	= "VID2",
 		[OMAP_DSS_VIDEO3]	= "VID3",
+		[OMAP_DSS_WB]		= "WB",
 	};
 	const char **p_names;
 
