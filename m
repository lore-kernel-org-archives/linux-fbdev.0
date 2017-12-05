From: Finn Thain <fthain@telegraphics.com.au>
Date: Tue, 05 Dec 2017 06:20:02 +0000
Subject: [PATCH v3 11/14] nubus: Rename struct nubus_dev
Message-Id: <60d598946ac219440cbb1fabed05964e806ebc5f.1512454057.git.fthain@telegraphics.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1512454057.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1512454057.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, netdev@vger.kernel.org, linux-fbdev@vger.kernel.org

It is misleading to call a functional resource a "device". In adopting
the Linux Driver Model, the struct device will be embedded in struct
nubus_board. That will compound the terminlogy problem because drivers
will bind with boards, not with functional resources. Avoid this by
renaming struct nubus_dev as struct nubus_rsrc. "Functional resource"
is the vendor's terminology so this helps avoid confusion.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/8390/mac8390.c     |  26 ++++----
 drivers/net/ethernet/natsemi/macsonic.c |  22 +++----
 drivers/nubus/nubus.c                   | 105 ++++++++++++++++----------------
 drivers/nubus/proc.c                    |  15 ++---
 drivers/video/fbdev/macfb.c             |   2 +-
 include/linux/nubus.h                   |  30 +++++----
 6 files changed, 98 insertions(+), 102 deletions(-)

diff --git a/drivers/net/ethernet/8390/mac8390.c b/drivers/net/ethernet/8390/mac8390.c
index 9497f18eaba0..929ff6419621 100644
--- a/drivers/net/ethernet/8390/mac8390.c
+++ b/drivers/net/ethernet/8390/mac8390.c
@@ -123,7 +123,8 @@ enum mac8390_access {
 };
 
 extern int mac8390_memtest(struct net_device *dev);
-static int mac8390_initdev(struct net_device *dev, struct nubus_dev *ndev,
+static int mac8390_initdev(struct net_device *dev,
+			   struct nubus_rsrc *ndev,
 			   enum mac8390_type type);
 
 static int mac8390_open(struct net_device *dev);
@@ -169,11 +170,11 @@ static void word_memcpy_tocard(unsigned long tp, const void *fp, int count);
 static void word_memcpy_fromcard(void *tp, unsigned long fp, int count);
 static u32 mac8390_msg_enable;
 
-static enum mac8390_type __init mac8390_ident(struct nubus_dev *dev)
+static enum mac8390_type __init mac8390_ident(struct nubus_rsrc *fres)
 {
-	switch (dev->dr_sw) {
+	switch (fres->dr_sw) {
 	case NUBUS_DRSW_3COM:
-		switch (dev->dr_hw) {
+		switch (fres->dr_hw) {
 		case NUBUS_DRHW_APPLE_SONIC_NB:
 		case NUBUS_DRHW_APPLE_SONIC_LC:
 		case NUBUS_DRHW_SONNET:
@@ -184,7 +185,7 @@ static enum mac8390_type __init mac8390_ident(struct nubus_dev *dev)
 		break;
 
 	case NUBUS_DRSW_APPLE:
-		switch (dev->dr_hw) {
+		switch (fres->dr_hw) {
 		case NUBUS_DRHW_ASANTE_LC:
 			return MAC8390_NONE;
 		case NUBUS_DRHW_CABLETRON:
@@ -201,7 +202,7 @@ static enum mac8390_type __init mac8390_ident(struct nubus_dev *dev)
 	case NUBUS_DRSW_TECHWORKS:
 	case NUBUS_DRSW_DAYNA2:
 	case NUBUS_DRSW_DAYNA_LC:
-		if (dev->dr_hw = NUBUS_DRHW_CABLETRON)
+		if (fres->dr_hw = NUBUS_DRHW_CABLETRON)
 			return MAC8390_CABLETRON;
 		else
 			return MAC8390_APPLE;
@@ -212,7 +213,7 @@ static enum mac8390_type __init mac8390_ident(struct nubus_dev *dev)
 		break;
 
 	case NUBUS_DRSW_KINETICS:
-		switch (dev->dr_hw) {
+		switch (fres->dr_hw) {
 		case NUBUS_DRHW_INTERLAN:
 			return MAC8390_INTERLAN;
 		default:
@@ -225,8 +226,8 @@ static enum mac8390_type __init mac8390_ident(struct nubus_dev *dev)
 		 * These correspond to Dayna Sonic cards
 		 * which use the macsonic driver
 		 */
-		if (dev->dr_hw = NUBUS_DRHW_SMC9194 ||
-		    dev->dr_hw = NUBUS_DRHW_INTERLAN)
+		if (fres->dr_hw = NUBUS_DRHW_SMC9194 ||
+		    fres->dr_hw = NUBUS_DRHW_INTERLAN)
 			return MAC8390_NONE;
 		else
 			return MAC8390_DAYNA;
@@ -289,7 +290,8 @@ static int __init mac8390_memsize(unsigned long membase)
 	return i * 0x1000;
 }
 
-static bool __init mac8390_init(struct net_device *dev, struct nubus_dev *ndev,
+static bool __init mac8390_init(struct net_device *dev,
+				struct nubus_rsrc *ndev,
 				enum mac8390_type cardtype)
 {
 	struct nubus_dir dir;
@@ -394,7 +396,7 @@ static bool __init mac8390_init(struct net_device *dev, struct nubus_dev *ndev,
 struct net_device * __init mac8390_probe(int unit)
 {
 	struct net_device *dev;
-	struct nubus_dev *ndev = NULL;
+	struct nubus_rsrc *ndev = NULL;
 	int err = -ENODEV;
 	struct ei_device *ei_local;
 
@@ -489,7 +491,7 @@ static const struct net_device_ops mac8390_netdev_ops = {
 };
 
 static int __init mac8390_initdev(struct net_device *dev,
-				  struct nubus_dev *ndev,
+				  struct nubus_rsrc *ndev,
 				  enum mac8390_type type)
 {
 	static u32 fwrd4_offsets[16] = {
diff --git a/drivers/net/ethernet/natsemi/macsonic.c b/drivers/net/ethernet/natsemi/macsonic.c
index a42433fb6949..14f3fb50dc21 100644
--- a/drivers/net/ethernet/natsemi/macsonic.c
+++ b/drivers/net/ethernet/natsemi/macsonic.c
@@ -428,26 +428,26 @@ static int mac_nubus_sonic_ethernet_addr(struct net_device *dev,
 	return 0;
 }
 
-static int macsonic_ident(struct nubus_dev *ndev)
+static int macsonic_ident(struct nubus_rsrc *fres)
 {
-	if (ndev->dr_hw = NUBUS_DRHW_ASANTE_LC &&
-	    ndev->dr_sw = NUBUS_DRSW_SONIC_LC)
+	if (fres->dr_hw = NUBUS_DRHW_ASANTE_LC &&
+	    fres->dr_sw = NUBUS_DRSW_SONIC_LC)
 		return MACSONIC_DAYNALINK;
-	if (ndev->dr_hw = NUBUS_DRHW_SONIC &&
-	    ndev->dr_sw = NUBUS_DRSW_APPLE) {
+	if (fres->dr_hw = NUBUS_DRHW_SONIC &&
+	    fres->dr_sw = NUBUS_DRSW_APPLE) {
 		/* There has to be a better way to do this... */
-		if (strstr(ndev->board->name, "DuoDock"))
+		if (strstr(fres->board->name, "DuoDock"))
 			return MACSONIC_DUODOCK;
 		else
 			return MACSONIC_APPLE;
 	}
 
-	if (ndev->dr_hw = NUBUS_DRHW_SMC9194 &&
-	    ndev->dr_sw = NUBUS_DRSW_DAYNA)
+	if (fres->dr_hw = NUBUS_DRHW_SMC9194 &&
+	    fres->dr_sw = NUBUS_DRSW_DAYNA)
 		return MACSONIC_DAYNA;
 
-	if (ndev->dr_hw = NUBUS_DRHW_APPLE_SONIC_LC &&
-	    ndev->dr_sw = 0) { /* huh? */
+	if (fres->dr_hw = NUBUS_DRHW_APPLE_SONIC_LC &&
+	    fres->dr_sw = 0) { /* huh? */
 		return MACSONIC_APPLE16;
 	}
 	return -1;
@@ -456,7 +456,7 @@ static int macsonic_ident(struct nubus_dev *ndev)
 static int mac_nubus_sonic_probe(struct net_device *dev)
 {
 	static int slots;
-	struct nubus_dev* ndev = NULL;
+	struct nubus_rsrc *ndev = NULL;
 	struct sonic_local* lp = netdev_priv(dev);
 	unsigned long base_addr, prom_addr;
 	u16 sonic_dcr;
diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
index b0d8aa721173..324f6e4407c8 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -32,7 +32,7 @@
 
 /* Globals */
 
-struct nubus_dev *nubus_devices;
+struct nubus_rsrc *nubus_func_rsrcs;
 struct nubus_board *nubus_boards;
 
 /* Meaning of "bytelanes":
@@ -228,12 +228,11 @@ int nubus_get_root_dir(const struct nubus_board *board,
 EXPORT_SYMBOL(nubus_get_root_dir);
 
 /* This is a slyly renamed version of the above */
-int nubus_get_func_dir(const struct nubus_dev *dev,
-		       struct nubus_dir *dir)
+int nubus_get_func_dir(const struct nubus_rsrc *fres, struct nubus_dir *dir)
 {
-	dir->ptr = dir->base = dev->directory;
+	dir->ptr = dir->base = fres->directory;
 	dir->done = 0;
-	dir->mask = dev->board->lanes;
+	dir->mask = fres->board->lanes;
 	return 0;
 }
 EXPORT_SYMBOL(nubus_get_func_dir);
@@ -306,11 +305,10 @@ EXPORT_SYMBOL(nubus_rewinddir);
 
 /* Driver interface functions, more or less like in pci.c */
 
-struct nubus_dev*
-nubus_find_type(unsigned short category, unsigned short type,
-		const struct nubus_dev *from)
+struct nubus_rsrc *nubus_find_type(unsigned short category, unsigned short type,
+                                   const struct nubus_rsrc *from)
 {
-	struct nubus_dev *itor = from ? from->next : nubus_devices;
+	struct nubus_rsrc *itor = from ? from->next : nubus_func_rsrcs;
 
 	while (itor) {
 		if (itor->category = category && itor->type = type)
@@ -321,10 +319,10 @@ nubus_find_type(unsigned short category, unsigned short type,
 }
 EXPORT_SYMBOL(nubus_find_type);
 
-struct nubus_dev*
-nubus_find_slot(unsigned int slot, const struct nubus_dev *from)
+struct nubus_rsrc *nubus_find_slot(unsigned int slot,
+                                   const struct nubus_rsrc *from)
 {
-	struct nubus_dev *itor = from ? from->next : nubus_devices;
+	struct nubus_rsrc *itor = from ? from->next : nubus_func_rsrcs;
 
 	while (itor) {
 		if (itor->board->slot = slot)
@@ -403,19 +401,19 @@ static int __init nubus_get_display_vidmode(struct nubus_board *board,
 	return 0;
 }
 
-static int __init nubus_get_display_resource(struct nubus_dev *dev,
+static int __init nubus_get_display_resource(struct nubus_rsrc *fres,
                                              struct proc_dir_entry *procdir,
                                              const struct nubus_dirent *ent)
 {
 	switch (ent->type) {
 	case NUBUS_RESID_GAMMADIR:
 		pr_debug("    gamma directory offset: 0x%06x\n", ent->data);
-		nubus_get_block_rsrc_dir(dev->board, procdir, ent);
+		nubus_get_block_rsrc_dir(fres->board, procdir, ent);
 		break;
 	case 0x0080 ... 0x0085:
 		pr_debug("    mode 0x%02x info offset: 0x%06x\n",
 			ent->type, ent->data);
-		nubus_get_display_vidmode(dev->board, procdir, ent);
+		nubus_get_display_vidmode(fres->board, procdir, ent);
 		break;
 	default:
 		pr_debug("    unknown resource 0x%02x, data 0x%06x\n",
@@ -425,7 +423,7 @@ static int __init nubus_get_display_resource(struct nubus_dev *dev,
 	return 0;
 }
 
-static int __init nubus_get_network_resource(struct nubus_dev *dev,
+static int __init nubus_get_network_resource(struct nubus_rsrc *fres,
                                              struct proc_dir_entry *procdir,
                                              const struct nubus_dirent *ent)
 {
@@ -447,7 +445,7 @@ static int __init nubus_get_network_resource(struct nubus_dev *dev,
 	return 0;
 }
 
-static int __init nubus_get_cpu_resource(struct nubus_dev *dev,
+static int __init nubus_get_cpu_resource(struct nubus_rsrc *fres,
                                          struct proc_dir_entry *procdir,
                                          const struct nubus_dirent *ent)
 {
@@ -480,19 +478,19 @@ static int __init nubus_get_cpu_resource(struct nubus_dev *dev,
 	return 0;
 }
 
-static int __init nubus_get_private_resource(struct nubus_dev *dev,
+static int __init nubus_get_private_resource(struct nubus_rsrc *fres,
                                              struct proc_dir_entry *procdir,
                                              const struct nubus_dirent *ent)
 {
-	switch (dev->category) {
+	switch (fres->category) {
 	case NUBUS_CAT_DISPLAY:
-		nubus_get_display_resource(dev, procdir, ent);
+		nubus_get_display_resource(fres, procdir, ent);
 		break;
 	case NUBUS_CAT_NETWORK:
-		nubus_get_network_resource(dev, procdir, ent);
+		nubus_get_network_resource(fres, procdir, ent);
 		break;
 	case NUBUS_CAT_CPU:
-		nubus_get_cpu_resource(dev, procdir, ent);
+		nubus_get_cpu_resource(fres, procdir, ent);
 		break;
 	default:
 		pr_debug("    unknown resource 0x%02x, data 0x%06x\n",
@@ -502,24 +500,25 @@ static int __init nubus_get_private_resource(struct nubus_dev *dev,
 	return 0;
 }
 
-static struct nubus_dev * __init
+static struct nubus_rsrc * __init
 nubus_get_functional_resource(struct nubus_board *board, int slot,
 			      const struct nubus_dirent *parent)
 {
 	struct nubus_dir dir;
 	struct nubus_dirent ent;
-	struct nubus_dev *dev;
+	struct nubus_rsrc *fres;
 
 	pr_debug("  Functional resource 0x%02x:\n", parent->type);
 	nubus_get_subdir(parent, &dir);
 	dir.procdir = nubus_proc_add_rsrc_dir(board->procdir, parent, board);
 
 	/* Actually we should probably panic if this fails */
-	if ((dev = kzalloc(sizeof(*dev), GFP_ATOMIC)) = NULL)
+	fres = kzalloc(sizeof(*fres), GFP_ATOMIC);
+	if (!fres)
 		return NULL;
-	dev->resid = parent->type;
-	dev->directory = dir.base;
-	dev->board = board;
+	fres->resid = parent->type;
+	fres->directory = dir.base;
+	fres->board = board;
 
 	while (nubus_readdir(&dir, &ent) != -1) {
 		switch (ent.type) {
@@ -528,10 +527,10 @@ nubus_get_functional_resource(struct nubus_board *board, int slot,
 			unsigned short nbtdata[4];
 
 			nubus_get_rsrc_mem(nbtdata, &ent, 8);
-			dev->category = nbtdata[0];
-			dev->type     = nbtdata[1];
-			dev->dr_sw    = nbtdata[2];
-			dev->dr_hw    = nbtdata[3];
+			fres->category = nbtdata[0];
+			fres->type     = nbtdata[1];
+			fres->dr_sw    = nbtdata[2];
+			fres->dr_hw    = nbtdata[3];
 			pr_debug("    type: [cat 0x%x type 0x%x sw 0x%x hw 0x%x]\n",
 				nbtdata[0], nbtdata[1], nbtdata[2], nbtdata[3]);
 			nubus_proc_add_rsrc_mem(dir.procdir, &ent, 8);
@@ -589,11 +588,11 @@ nubus_get_functional_resource(struct nubus_board *board, int slot,
 		default:
 			/* Local/Private resources have their own
 			   function */
-			nubus_get_private_resource(dev, dir.procdir, &ent);
+			nubus_get_private_resource(fres, dir.procdir, &ent);
 		}
 	}
 
-	return dev;
+	return fres;
 }
 
 /* This is *really* cool. */
@@ -727,7 +726,6 @@ static int __init nubus_get_board_resource(struct nubus_board *board, int slot,
 	return 0;
 }
 
-/* Add a board (might be many devices) to the list */
 static struct nubus_board * __init nubus_add_board(int slot, int bytelanes)
 {
 	struct nubus_board *board;
@@ -799,10 +797,11 @@ static struct nubus_board * __init nubus_add_board(int slot, int bytelanes)
 	pr_debug("Slot %X resources:\n", slot);
 
 	/* Each slot should have one board resource and any number of
-	   functional resources.  So we'll fill in some fields in the
-	   struct nubus_board from the board resource, then walk down
-	   the list of functional resources, spinning out a nubus_dev
-	   for each of them. */
+	 * functional resources.  So we'll fill in some fields in the
+	 * struct nubus_board from the board resource, then walk down
+	 * the list of functional resources, spinning out a nubus_rsrc
+	 * for each of them.
+	 */
 	if (nubus_readdir(&dir, &ent) = -1) {
 		/* We can't have this! */
 		pr_err("Slot %X: Board resource not found!\n", slot);
@@ -817,32 +816,32 @@ static struct nubus_board * __init nubus_add_board(int slot, int bytelanes)
 	nubus_get_board_resource(board, slot, &ent);
 
 	while (nubus_readdir(&dir, &ent) != -1) {
-		struct nubus_dev *dev;
-		struct nubus_dev **devp;
+		struct nubus_rsrc *fres;
+		struct nubus_rsrc **fresp;
 
-		dev = nubus_get_functional_resource(board, slot, &ent);
-		if (dev = NULL)
+		fres = nubus_get_functional_resource(board, slot, &ent);
+		if (fres = NULL)
 			continue;
 
 		/* Resources should appear in ascending ID order. This sanity
 		 * check prevents duplicate resource IDs.
 		 */
-		if (dev->resid <= prev_resid) {
-			kfree(dev);
+		if (fres->resid <= prev_resid) {
+			kfree(fres);
 			continue;
 		}
-		prev_resid = dev->resid;
+		prev_resid = fres->resid;
 
 		/* We zeroed this out above */
-		if (board->first_dev = NULL)
-			board->first_dev = dev;
+		if (board->first_func_rsrc = NULL)
+			board->first_func_rsrc = fres;
 
-		/* Put it on the global NuBus device chain. Keep entries in order. */
-		for (devp = &nubus_devices; *devp != NULL;
-		     devp = &((*devp)->next))
+		/* Put it on the func. resource list. Keep entries in order. */
+		for (fresp = &nubus_func_rsrcs; *fresp != NULL;
+		     fresp = &((*fresp)->next))
 			/* spin */;
-		*devp = dev;
-		dev->next = NULL;
+		*fresp = fres;
+		fres->next = NULL;
 	}
 
 	/* Put it on the global NuBus board chain. Keep entries in order. */
diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
index ad8b0648a6c0..9ffaafdb3d2c 100644
--- a/drivers/nubus/proc.c
+++ b/drivers/nubus/proc.c
@@ -36,17 +36,14 @@
 static int
 nubus_devices_proc_show(struct seq_file *m, void *v)
 {
-	struct nubus_dev *dev = nubus_devices;
+	struct nubus_rsrc *fres = nubus_func_rsrcs;
 
-	while (dev) {
+	while (fres) {
 		seq_printf(m, "%x\t%04x %04x %04x %04x",
-			      dev->board->slot,
-			      dev->category,
-			      dev->type,
-			      dev->dr_sw,
-			      dev->dr_hw);
-		seq_printf(m, "\t%08lx\n", dev->board->slot_addr);
-		dev = dev->next;
+		           fres->board->slot, fres->category, fres->type,
+		           fres->dr_sw, fres->dr_hw);
+		seq_printf(m, "\t%08lx\n", fres->board->slot_addr);
+		fres = fres->next;
 	}
 	return 0;
 }
diff --git a/drivers/video/fbdev/macfb.c b/drivers/video/fbdev/macfb.c
index cda7587cbc86..e86a2796e3d9 100644
--- a/drivers/video/fbdev/macfb.c
+++ b/drivers/video/fbdev/macfb.c
@@ -556,7 +556,7 @@ static void __init iounmap_macfb(void)
 static int __init macfb_init(void)
 {
 	int video_cmap_len, video_is_nubus = 0;
-	struct nubus_dev* ndev = NULL;
+	struct nubus_rsrc *ndev = NULL;
 	char *option = NULL;
 	int err;
 
diff --git a/include/linux/nubus.h b/include/linux/nubus.h
index 0e40c9d6b977..8a40505a52ef 100644
--- a/include/linux/nubus.h
+++ b/include/linux/nubus.h
@@ -33,7 +33,7 @@ struct nubus_dirent {
 
 struct nubus_board {
 	struct nubus_board *next;
-	struct nubus_dev *first_dev;
+	struct nubus_rsrc *first_func_rsrc;
 
 	/* Only 9-E actually exist, though 0-8 are also theoretically
 	   possible, and 0 is a special case which represents the
@@ -62,11 +62,11 @@ struct nubus_board {
 	struct proc_dir_entry *procdir;
 };
 
-struct nubus_dev {
-	/* Next link in device list */
-	struct nubus_dev *next;
+struct nubus_rsrc {
+	/* Next link in list */
+	struct nubus_rsrc *next;
 
-	/* The functional resource ID of this device */
+	/* The functional resource ID */
 	unsigned char resid;
 	/* These are mostly here for convenience; we could always read
 	   them from the ROMs if we wanted to */
@@ -81,8 +81,8 @@ struct nubus_dev {
 	struct nubus_board *board;
 };
 
-/* This is all NuBus devices (used to find devices later on) */
-extern struct nubus_dev *nubus_devices;
+/* This is all NuBus functional resources (used to find devices later on) */
+extern struct nubus_rsrc *nubus_func_rsrcs;
 /* This is all NuBus cards */
 extern struct nubus_board *nubus_boards;
 
@@ -115,13 +115,12 @@ static inline void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
                                        const struct nubus_dirent *ent) {}
 #endif
 
-/* If we need more precision we can add some more of these */
-struct nubus_dev *nubus_find_type(unsigned short category,
-				  unsigned short type,
-				  const struct nubus_dev *from);
-/* Might have more than one device in a slot, you know... */
-struct nubus_dev *nubus_find_slot(unsigned int slot,
-				  const struct nubus_dev *from);
+struct nubus_rsrc *nubus_find_type(unsigned short category,
+                                   unsigned short type,
+                                   const struct nubus_rsrc *from);
+
+struct nubus_rsrc *nubus_find_slot(unsigned int slot,
+                                   const struct nubus_rsrc *from);
 
 /* These are somewhat more NuBus-specific.  They all return 0 for
    success and -1 for failure, as you'd expect. */
@@ -134,8 +133,7 @@ int nubus_get_root_dir(const struct nubus_board *board,
 int nubus_get_board_dir(const struct nubus_board* board,
 			struct nubus_dir* dir);
 /* The functional directory */
-int nubus_get_func_dir(const struct nubus_dev *dev,
-		       struct nubus_dir *dir);
+int nubus_get_func_dir(const struct nubus_rsrc *fres, struct nubus_dir *dir);
 
 /* These work on any directory gotten via the above */
 int nubus_readdir(struct nubus_dir *dir,
-- 
2.13.6

