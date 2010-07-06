From: James Simmons <jsimmons@infradead.org>
Date: Tue, 06 Jul 2010 15:29:49 +0000
Subject: [PATCH 0/3] ARM: S5PV210: Add MIPI-DSI support.
Message-Id: <alpine.LFD.2.00.1007061629271.3285@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hello all,

This patch is for MIPI-DSI controller based on S5PV210 (or S5PC110).

LCD Panel can use following interfaces,
- RGB or CPU Interface.
- RGB or CPU Interface based on MIPI-DSI.

In case of small size lcd panel, it was ok only rgb or cpu interface not
using mipi controller.
But big size panel(more then 480x800) needs MIPI-DSI Interface or other
hardwares like LVDS
To transfer image data to lcd panel fine.

I tested this patch on cpu interface based on MIPI so for this patch,
Some mainline codes should be modified and also considered RGB interface.

This patch set consists of the following patches,

[PATCH 1/3] FB: Add some members for CPU Interface.
[PATCH 2/3] S5PV210: FB: Add MIPI-DSI and CPU Interface features.
[PATCH 3/3] S5PV210: Add MIPI-DSI Driver.

Best regards,
InKi Dae

