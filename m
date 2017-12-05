From: Finn Thain <fthain@telegraphics.com.au>
Date: Tue, 05 Dec 2017 06:20:02 +0000
Subject: [PATCH v3 12/14] nubus: Adopt standard linked list implementation
Message-Id: <7b1f483782e215b88dbd8945838e3b2d9a4a1dc1.1512454057.git.fthain@telegraphics.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1512454057.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1512454057.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, netdev@vger.kernel.org, linux-fbdev@vger.kernel.org

This increases code re-use and improves readability.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
---
 drivers/net/ethernet/8390/mac8390.c     |  7 +++--
 drivers/net/ethernet/cirrus/mac89x0.c   |  6 +++--
 drivers/net/ethernet/natsemi/macsonic.c |  8 +++---
 drivers/nubus/nubus.c                   | 45 ++++++++-------------------------
 drivers/nubus/proc.c                    | 11 +++-----
 drivers/video/fbdev/macfb.c             |  8 +++---
 include/linux/nubus.h                   | 15 +++++------
 7 files changed, 40 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/8390/mac8390.c b/drivers/net/ethernet/8390/mac8390.c
index 929ff6419621..2f91ce8dc614 100644
--- a/drivers/net/ethernet/8390/mac8390.c
+++ b/drivers/net/ethernet/8390/mac8390.c
@@ -416,8 +416,11 @@ struct net_device * __init mac8390_probe(int unit)
 	if (unit >= 0)
 		sprintf(dev->name, "eth%d", unit);
 
-	while ((ndev = nubus_find_type(NUBUS_CAT_NETWORK, NUBUS_TYPE_ETHERNET,
-				       ndev))) {
+	for_each_func_rsrc(ndev) {
+		if (ndev->category != NUBUS_CAT_NETWORK ||
+		    ndev->type != NUBUS_TYPE_ETHERNET)
+			continue;
+
 		/* Have we seen it already? */
 		if (slots & (1 << ndev->board->slot))
 			continue;
diff --git a/drivers/net/ethernet/cirrus/mac89x0.c b/drivers/net/ethernet/cirrus/mac89x0.c
index f910f0f386d6..977d4c2c759d 100644
--- a/drivers/net/ethernet/cirrus/mac89x0.c
+++ b/drivers/net/ethernet/cirrus/mac89x0.c
@@ -187,6 +187,7 @@ struct net_device * __init mac89x0_probe(int unit)
 	unsigned long ioaddr;
 	unsigned short sig;
 	int err = -ENODEV;
+	struct nubus_rsrc *fres;
 
 	if (!MACH_IS_MAC)
 		return ERR_PTR(-ENODEV);
@@ -207,8 +208,9 @@ struct net_device * __init mac89x0_probe(int unit)
 	/* We might have to parameterize this later */
 	slot = 0xE;
 	/* Get out now if there's a real NuBus card in slot E */
-	if (nubus_find_slot(slot, NULL) != NULL)
-		goto out;
+	for_each_func_rsrc(fres)
+		if (fres->board->slot = slot)
+			goto out;
 
 	/* The pseudo-ISA bits always live at offset 0x300 (gee,
            wonder why...) */
diff --git a/drivers/net/ethernet/natsemi/macsonic.c b/drivers/net/ethernet/natsemi/macsonic.c
index 14f3fb50dc21..313fe5e0184b 100644
--- a/drivers/net/ethernet/natsemi/macsonic.c
+++ b/drivers/net/ethernet/natsemi/macsonic.c
@@ -464,9 +464,11 @@ static int mac_nubus_sonic_probe(struct net_device *dev)
 	int reg_offset, dma_bitmode;
 
 	/* Find the first SONIC that hasn't been initialized already */
-	while ((ndev = nubus_find_type(NUBUS_CAT_NETWORK,
-				       NUBUS_TYPE_ETHERNET, ndev)) != NULL)
-	{
+	for_each_func_rsrc(ndev) {
+		if (ndev->category != NUBUS_CAT_NETWORK ||
+		    ndev->type != NUBUS_TYPE_ETHERNET)
+			continue;
+
 		/* Have we seen it already? */
 		if (slots & (1<<ndev->board->slot))
 			continue;
diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
index 324f6e4407c8..380f320c050f 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -32,7 +32,7 @@
 
 /* Globals */
 
-struct nubus_rsrc *nubus_func_rsrcs;
+LIST_HEAD(nubus_func_rsrcs);
 struct nubus_board *nubus_boards;
 
 /* Meaning of "bytelanes":
@@ -305,33 +305,20 @@ EXPORT_SYMBOL(nubus_rewinddir);
 
 /* Driver interface functions, more or less like in pci.c */
 
-struct nubus_rsrc *nubus_find_type(unsigned short category, unsigned short type,
-                                   const struct nubus_rsrc *from)
+struct nubus_rsrc *nubus_first_rsrc_or_null(void)
 {
-	struct nubus_rsrc *itor = from ? from->next : nubus_func_rsrcs;
-
-	while (itor) {
-		if (itor->category = category && itor->type = type)
-			return itor;
-		itor = itor->next;
-	}
-	return NULL;
+	return list_first_entry_or_null(&nubus_func_rsrcs, struct nubus_rsrc,
+	                                list);
 }
-EXPORT_SYMBOL(nubus_find_type);
+EXPORT_SYMBOL(nubus_first_rsrc_or_null);
 
-struct nubus_rsrc *nubus_find_slot(unsigned int slot,
-                                   const struct nubus_rsrc *from)
+struct nubus_rsrc *nubus_next_rsrc_or_null(struct nubus_rsrc *from)
 {
-	struct nubus_rsrc *itor = from ? from->next : nubus_func_rsrcs;
-
-	while (itor) {
-		if (itor->board->slot = slot)
-			return itor;
-		itor = itor->next;
-	}
-	return NULL;
+	if (list_is_last(&from->list, &nubus_func_rsrcs))
+		return NULL;
+	return list_next_entry(from, list);
 }
-EXPORT_SYMBOL(nubus_find_slot);
+EXPORT_SYMBOL(nubus_next_rsrc_or_null);
 
 int
 nubus_find_rsrc(struct nubus_dir *dir, unsigned char rsrc_type,
@@ -817,7 +804,6 @@ static struct nubus_board * __init nubus_add_board(int slot, int bytelanes)
 
 	while (nubus_readdir(&dir, &ent) != -1) {
 		struct nubus_rsrc *fres;
-		struct nubus_rsrc **fresp;
 
 		fres = nubus_get_functional_resource(board, slot, &ent);
 		if (fres = NULL)
@@ -832,16 +818,7 @@ static struct nubus_board * __init nubus_add_board(int slot, int bytelanes)
 		}
 		prev_resid = fres->resid;
 
-		/* We zeroed this out above */
-		if (board->first_func_rsrc = NULL)
-			board->first_func_rsrc = fres;
-
-		/* Put it on the func. resource list. Keep entries in order. */
-		for (fresp = &nubus_func_rsrcs; *fresp != NULL;
-		     fresp = &((*fresp)->next))
-			/* spin */;
-		*fresp = fres;
-		fres->next = NULL;
+		list_add_tail(&fres->list, &nubus_func_rsrcs);
 	}
 
 	/* Put it on the global NuBus board chain. Keep entries in order. */
diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
index 9ffaafdb3d2c..ccaaec4ed291 100644
--- a/drivers/nubus/proc.c
+++ b/drivers/nubus/proc.c
@@ -36,15 +36,12 @@
 static int
 nubus_devices_proc_show(struct seq_file *m, void *v)
 {
-	struct nubus_rsrc *fres = nubus_func_rsrcs;
+	struct nubus_rsrc *fres;
 
-	while (fres) {
-		seq_printf(m, "%x\t%04x %04x %04x %04x",
+	for_each_func_rsrc(fres)
+		seq_printf(m, "%x\t%04x %04x %04x %04x\t%08lx\n",
 		           fres->board->slot, fres->category, fres->type,
-		           fres->dr_sw, fres->dr_hw);
-		seq_printf(m, "\t%08lx\n", fres->board->slot_addr);
-		fres = fres->next;
-	}
+		           fres->dr_sw, fres->dr_hw, fres->board->slot_addr);
 	return 0;
 }
 
diff --git a/drivers/video/fbdev/macfb.c b/drivers/video/fbdev/macfb.c
index e86a2796e3d9..e707e617bf1c 100644
--- a/drivers/video/fbdev/macfb.c
+++ b/drivers/video/fbdev/macfb.c
@@ -670,15 +670,17 @@ static int __init macfb_init(void)
 	 * code is really broken :-)
 	 */
 
-	while ((ndev = nubus_find_type(NUBUS_CAT_DISPLAY,
-				       NUBUS_TYPE_VIDEO, ndev)))
-	{
+	for_each_func_rsrc(ndev) {
 		unsigned long base = ndev->board->slot_addr;
 
 		if (mac_bi_data.videoaddr < base ||
 		    mac_bi_data.videoaddr - base > 0xFFFFFF)
 			continue;
 
+		if (ndev->category != NUBUS_CAT_DISPLAY ||
+		    ndev->type != NUBUS_TYPE_VIDEO)
+			continue;
+
 		video_is_nubus = 1;
 		slot_addr = (unsigned char *)base;
 
diff --git a/include/linux/nubus.h b/include/linux/nubus.h
index 8a40505a52ef..aee7c50e9a2e 100644
--- a/include/linux/nubus.h
+++ b/include/linux/nubus.h
@@ -33,7 +33,6 @@ struct nubus_dirent {
 
 struct nubus_board {
 	struct nubus_board *next;
-	struct nubus_rsrc *first_func_rsrc;
 
 	/* Only 9-E actually exist, though 0-8 are also theoretically
 	   possible, and 0 is a special case which represents the
@@ -63,8 +62,7 @@ struct nubus_board {
 };
 
 struct nubus_rsrc {
-	/* Next link in list */
-	struct nubus_rsrc *next;
+	struct list_head list;
 
 	/* The functional resource ID */
 	unsigned char resid;
@@ -82,7 +80,7 @@ struct nubus_rsrc {
 };
 
 /* This is all NuBus functional resources (used to find devices later on) */
-extern struct nubus_rsrc *nubus_func_rsrcs;
+extern struct list_head nubus_func_rsrcs;
 /* This is all NuBus cards */
 extern struct nubus_board *nubus_boards;
 
@@ -115,12 +113,11 @@ static inline void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
                                        const struct nubus_dirent *ent) {}
 #endif
 
-struct nubus_rsrc *nubus_find_type(unsigned short category,
-                                   unsigned short type,
-                                   const struct nubus_rsrc *from);
+struct nubus_rsrc *nubus_first_rsrc_or_null(void);
+struct nubus_rsrc *nubus_next_rsrc_or_null(struct nubus_rsrc *from);
 
-struct nubus_rsrc *nubus_find_slot(unsigned int slot,
-                                   const struct nubus_rsrc *from);
+#define for_each_func_rsrc(f) \
+	for (f = nubus_first_rsrc_or_null(); f; f = nubus_next_rsrc_or_null(f))
 
 /* These are somewhat more NuBus-specific.  They all return 0 for
    success and -1 for failure, as you'd expect. */
-- 
2.13.6

