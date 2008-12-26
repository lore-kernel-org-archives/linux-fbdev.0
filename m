From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/4 v6] dmaengine: add async_tx_clear_ack() macro
Date: Fri, 26 Dec 2008 18:11:18 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812261720240.4895@axis700.grange>
References: <Pine.LNX.4.64.0812261714290.4895@axis700.grange>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754343AbYLZRLh@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0812261714290.4895@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.arm.linux.org.uk, Dan Williams <dan.j.williams@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Guennadi Liakhovetski <lg@denx.de>

To complete the DMA_CTRL_ACK handling API add a async_tx_clear_ack() macro.

Signed-off-by: Guennadi Liakhovetski <lg@denx.de>
---

No change since v2

 include/linux/dmaengine.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 64dea2a..c820a3f 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -287,6 +287,11 @@ static inline void async_tx_ack(struct dma_async_tx_descriptor *tx)
 	tx->flags |= DMA_CTRL_ACK;
 }
 
+static inline void async_tx_clear_ack(struct dma_async_tx_descriptor *tx)
+{
+	tx->flags &= ~DMA_CTRL_ACK;
+}
+
 static inline bool async_tx_test_ack(struct dma_async_tx_descriptor *tx)
 {
 	return (tx->flags & DMA_CTRL_ACK) == DMA_CTRL_ACK;
-- 
1.5.4
