From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/4 v2] dmaengine: add a tx_free method to struct
 dma_async_tx_descriptor
Date: Wed, 10 Dec 2008 11:36:03 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812101129340.4578@axis700.grange>
References: <Pine.LNX.4.64.0812101122250.4578@axis700.grange>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756198AbYLJKg1@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0812101122250.4578@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.arm.linux.org.uk, Dan Williams <dan.j.williams@intel.com>

From: Guennadi Liakhovetski <lg@denx.de>

Some users reuse DMA transaction descriptors multiple times and need an
explicit call to release them. An example of such a user is Video4Linux, which
has to be able to release descriptors on ioctl(VIDIOC_DQBUF).

Signed-off-by: Guennadi Liakhovetski <lg@denx.de>
---
 include/linux/dmaengine.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 64dea2a..58b2268 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -183,6 +183,7 @@ typedef void (*dma_async_tx_callback)(void *dma_async_param);
  *	descriptors
  * @chan: target channel for this operation
  * @tx_submit: set the prepared descriptor(s) to be executed by the engine
+ * @tx_free: release a transaction descriptor
  * @callback: routine to call after this operation is complete
  * @callback_param: general parameter to pass to the callback routine
  * ---async_tx api specific fields---
@@ -197,6 +198,7 @@ struct dma_async_tx_descriptor {
 	struct list_head tx_list;
 	struct dma_chan *chan;
 	dma_cookie_t (*tx_submit)(struct dma_async_tx_descriptor *tx);
+	void (*tx_free)(struct dma_async_tx_descriptor *tx);
 	dma_async_tx_callback callback;
 	void *callback_param;
 	struct dma_async_tx_descriptor *next;
-- 
1.5.4
