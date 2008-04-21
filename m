From: Sebastian Siewior <frame+buffer@ml.breakpoint.cc>
Subject: [PATCH] [FB] metronomefb: don't free firmware
	twice in error path.
Date: Mon, 21 Apr 2008 14:09:31 +0200
Message-ID: <20080421120931.GD11534@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jnuq1-0002DD-2x for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 05:09:41 -0700
Received: from chamillionaire.breakpoint.cc ([85.10.199.196]
	ident=G2wL6ZuayTZo\z0haXx|IP)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jnupx-0002f8-FR
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 05:09:37 -0700
Content-Disposition: inline
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@gmail.com>

Right now, if request_irq or anthing after it fails than we free the
firmware for the second time what migh end bad :)

Signed-off-by: Sebastian Siewior <sebastian@breakpoint.cc>
---
 drivers/video/metronomefb.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index e9a89fd..110985f 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -861,12 +861,13 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
 
 	retval = load_waveform((u8 *) fw_entry->data, fw_entry->size,
 				par->metromem_wfm, 3, 31, &par->frame_count);
+
+	release_firmware(fw_entry);
+
 	if (retval < 0) {
 		printk(KERN_ERR "metronomefb: couldn't process waveform\n");
-		goto err_ld_wfm;
+		goto err_dma_free;
 	}
-	release_firmware(fw_entry);
-
 	retval = request_irq(IRQ_GPIO(RDY_GPIO_PIN), metronome_handle_irq,
 				IRQF_DISABLED, "Metronome", info);
 	if (retval) {
@@ -914,8 +915,6 @@ err_fb_rel:
 	framebuffer_release(info);
 err_free_irq:
 	free_irq(IRQ_GPIO(RDY_GPIO_PIN), info);
-err_ld_wfm:
-	release_firmware(fw_entry);
 err_dma_free:
 	dma_free_writecombine(&dev->dev, par->metromemsize, par->metromem,
 				par->metromem_dma);
-- 
1.5.4.4


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
