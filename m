From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc9 1/5] metronomefb: convert
	printk to dev_dbg/err messages
Date: Wed, 30 Jul 2008 08:51:05 -0400
Message-ID: <1217422269-11093-2-git-send-email-jayakumar.lkml@gmail.com>
References: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOC1Z-00010o-4F for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jul 2008 06:47:29 -0700
Received: from yw-out-1718.google.com ([74.125.46.156])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOC1Y-0001fS-NM
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jul 2008 06:47:29 -0700
Received: by yw-out-1718.google.com with SMTP id 6so10226ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 30 Jul 2008 06:47:28 -0700 (PDT)
In-Reply-To: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ymiao3@marvell.com
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

This patch converts the printk messages in metronomefb to dev_dbg/err type
messages.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
Acked-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/video/metronomefb.c |   47 ++++++++++++++++++------------------------
 1 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index cc4c038..7cda4f8 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -40,15 +40,6 @@
 
 #include <asm/unaligned.h>
 
-
-#define DEBUG 1
-#ifdef DEBUG
-#define DPRINTK(f, a...) printk(KERN_DEBUG "%s: " f, __func__ , ## a)
-#else
-#define DPRINTK(f, a...)
-#endif
-
-
 /* Display specific information */
 #define DPY_W 832
 #define DPY_H 622
@@ -135,8 +126,8 @@ static u16 calc_img_cksum(u16 *start, int length)
 
 /* here we decode the incoming waveform file and populate metromem */
 #define EXP_WFORM_SIZE 47001
-static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
-				u8 *frame_count)
+static int __devinit load_waveform(u8 *mem, size_t size, int m, int t,
+				struct metronomefb_par *par)
 {
 	int tta;
 	int wmta;
@@ -148,9 +139,11 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 	int wfm_idx, owfm_idx;
 	int mem_idx = 0;
 	struct waveform_hdr *wfm_hdr;
+	u8 *metromem = par->metromem_wfm;
+	struct device *dev = par->info->dev;
 
 	if (size != EXP_WFORM_SIZE) {
-		printk(KERN_ERR "Error: unexpected size %d != %d\n", size,
+		dev_err(dev, "Error: unexpected size %d != %d\n", size,
 					EXP_WFORM_SIZE);
 		return -EINVAL;
 	}
@@ -158,16 +151,16 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 	wfm_hdr = (struct waveform_hdr *) mem;
 
 	if (wfm_hdr->fvsn != 1) {
-		printk(KERN_ERR "Error: bad fvsn %x\n", wfm_hdr->fvsn);
+		dev_err(dev, "Error: bad fvsn %x\n", wfm_hdr->fvsn);
 		return -EINVAL;
 	}
 	if (wfm_hdr->luts != 0) {
-		printk(KERN_ERR "Error: bad luts %x\n", wfm_hdr->luts);
+		dev_err(dev, "Error: bad luts %x\n", wfm_hdr->luts);
 		return -EINVAL;
 	}
 	cksum = calc_cksum(32, 47, mem);
 	if (cksum != wfm_hdr->wfm_cs) {
-		printk(KERN_ERR "Error: bad cksum %x != %x\n", cksum,
+		dev_err(dev, "Error: bad cksum %x != %x\n", cksum,
 					wfm_hdr->wfm_cs);
 		return -EINVAL;
 	}
@@ -175,7 +168,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 	wfm_hdr->trc += 1;
 	for (i = 0; i < 5; i++) {
 		if (*(wfm_hdr->stuff2a + i) != 0) {
-			printk(KERN_ERR "Error: unexpected value in padding\n");
+			dev_err(dev, "Error: unexpected value in padding\n");
 			return -EINVAL;
 		}
 	}
@@ -200,7 +193,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 		return -EINVAL;
 	cksum = calc_cksum(sizeof(*wfm_hdr), cksum_idx, mem);
 	if (cksum != mem[cksum_idx]) {
-		printk(KERN_ERR "Error: bad temperature range table cksum"
+		dev_err(dev, "Error: bad temperature range table cksum"
 				" %x != %x\n", cksum, mem[cksum_idx]);
 		return -EINVAL;
 	}
@@ -212,7 +205,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 		return -EINVAL;
 	cksum = calc_cksum(cksum_idx - 3, cksum_idx, mem);
 	if (cksum != mem[cksum_idx]) {
-		printk(KERN_ERR "Error: bad mode table address cksum"
+		dev_err(dev, "Error: bad mode table address cksum"
 				" %x != %x\n", cksum, mem[cksum_idx]);
 		return -EINVAL;
 	}
@@ -224,7 +217,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 		return -EINVAL;
 	cksum = calc_cksum(cksum_idx - 3, cksum_idx, mem);
 	if (cksum != mem[cksum_idx]) {
-		printk(KERN_ERR "Error: bad temperature table address cksum"
+		dev_err(dev, "Error: bad temperature table address cksum"
 			" %x != %x\n", cksum, mem[cksum_idx]);
 		return -EINVAL;
 	}
@@ -259,11 +252,11 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 		return -EINVAL;
 	cksum = calc_cksum(owfm_idx, cksum_idx, mem);
 	if (cksum != mem[cksum_idx]) {
-		printk(KERN_ERR "Error: bad waveform data cksum"
+		dev_err(dev, "Error: bad waveform data cksum"
 				" %x != %x\n", cksum, mem[cksum_idx]);
 		return -EINVAL;
 	}
-	*frame_count = (mem_idx/64);
+	par->frame_count = (mem_idx/64);
 
 	return 0;
 }
@@ -662,15 +655,15 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 		b) process waveform and decode into metromem */
 	retval = request_firmware(&fw_entry, "metronome.wbf", &dev->dev);
 	if (retval < 0) {
-		printk(KERN_ERR "metronomefb: couldn't get waveform\n");
+		dev_err(&dev->dev, "Failed to get waveform\n");
 		goto err_dma_free;
 	}
 
-	retval = load_waveform((u8 *) fw_entry->data, fw_entry->size,
-				par->metromem_wfm, 3, 31, &par->frame_count);
+	retval = load_waveform((u8 *) fw_entry->data, fw_entry->size, 3, 31,
+				par);
 	release_firmware(fw_entry);
 	if (retval < 0) {
-		printk(KERN_ERR "metronomefb: couldn't process waveform\n");
+		dev_err(&dev->dev, "Failed processing waveform\n");
 		goto err_dma_free;
 	}
 
@@ -688,7 +681,7 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 
 	retval = fb_alloc_cmap(&info->cmap, 8, 0);
 	if (retval < 0) {
-		printk(KERN_ERR "Failed to allocate colormap\n");
+		dev_err(&dev->dev, "Failed to allocate colormap\n");
 		goto err_fb_rel;
 	}
 
@@ -704,7 +697,7 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, info);
 
-	printk(KERN_INFO
+	dev_dbg(&dev->dev,
 		"fb%d: Metronome frame buffer device, using %dK of video"
 		" memory\n", info->node, videomemorysize >> 10);
 
-- 
1.5.3.6


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
