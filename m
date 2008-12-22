From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/4 v5] dmaengine: add
	async_tx_clear_ack() macro
Date: Mon, 22 Dec 2008 19:31:48 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812221927260.5241@axis700.grange>
References: <Pine.LNX.4.64.0812221922200.5241@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <g.liakhovetski@gmx.de>) id 1LEpZO-0006CH-0I
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Dec 2008 18:31:58 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LEpZK-0002uI-Qt for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Dec 2008 18:31:58 +0000
In-Reply-To: <Pine.LNX.4.64.0812221922200.5241@axis700.grange>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk, adaplas@gmail.com

From: Guennadi Liakhovetski <lg@denx.de>

To complete the DMA_CTRL_ACK handling API add a async_tx_clear_ack() macro.

Signed-off-by: Guennadi Liakhovetski <lg@denx.de>
---

No change since v2 or v3

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


------------------------------------------------------------------------------
