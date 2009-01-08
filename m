From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/4 v8] dmaengine: add async_tx_clear_ack() macro
Date: Thu, 8 Jan 2009 19:04:25 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901081856020.6387@axis700.grange>
References: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761618AbZAHSEy@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Dan Williams <dan.j.williams@intel.com>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org

From: Guennadi Liakhovetski <lg@denx.de>

To complete the DMA_CTRL_ACK handling API add a async_tx_clear_ack() macro.

Signed-off-by: Guennadi Liakhovetski <lg@denx.de>
---

No change. Here for completeness.

 include/linux/dmaengine.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index adb0b08..bd76c01 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -380,6 +380,11 @@ static inline void async_tx_ack(struct dma_async_tx_descriptor *tx)
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
