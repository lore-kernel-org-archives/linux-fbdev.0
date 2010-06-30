From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 30 Jun 2010 09:55:28 +0000
Subject: [PATCH 1/6] sh: add a list of parent configurations to struct clk
Message-Id: <Pine.LNX.4.64.1006301135470.17489@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Many system clocks can select a parent by writing a value to a specific field
in the configuration register. Add a list of parents and location and width of
the source selection field in the clock configuration register to struct clk to
assist in clk_set_parent() implementation.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/sh_clk.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 1636d1e..08a07b9 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -25,6 +25,10 @@ struct clk {
 	int			id;
 
 	struct clk		*parent;
+	struct clk		**parent_table;	/* list of parents to */
+	unsigned short		parent_num;	/* choose between */
+	unsigned char		src_shift;	/* source clock field in the */
+	unsigned char		src_width;	/* configuration register */
 	struct clk_ops		*ops;
 
 	struct list_head	children;
-- 
1.6.2.4

