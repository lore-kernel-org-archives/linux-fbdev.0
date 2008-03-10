From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] atmel_lcdfb: adjust fifo size for at91sam9rl
Date: Mon, 10 Mar 2008 17:36:42 +0100
Message-ID: <47D5639A.3090609@atmel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753813AbYCJQhR@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: ARM Linux Mailing List <linux-arm-kernel@lists.arm.linux.org.uk>, Andrew Victor <linux@maxim.org.za>, Sedji GAOUAOU <sedji.gaouaou@atmel.com>, Patrice VILCHEZ <patrice.vilchez@atmel.com>

AT91SAM9RL soc has a 2048 bytes deep FIFO, like AT91SAM9263.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---

--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -30,7 +30,7 @@
 #define ATMEL_LCDC_CVAL_DEFAULT		0xc8
 #define ATMEL_LCDC_DMA_BURST_LEN	8
 
-#if defined(CONFIG_ARCH_AT91SAM9263)
+#if defined(CONFIG_ARCH_AT91SAM9263) || defined(CONFIG_ARCH_AT91SAM9RL)
 #define ATMEL_LCDC_FIFO_SIZE		2048
 #else
 #define ATMEL_LCDC_FIFO_SIZE		512
