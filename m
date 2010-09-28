From: Donghwa Lee <dh09.lee@samsung.com>
Date: Tue, 28 Sep 2010 02:04:48 +0000
Subject: [PATCH v3 0/3] ARM: S5PV210: Add MIPI-DSI support
Message-Id: <4CA14D40.7000801@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

 This patch is for MIPI-DSI controller based on S5PV210 (or S5PC110).

I send v3 patch on behalf of Inki Dae.
This patch is separated from FB that described v2 patches.

This version includes below contents.
- fb_cmdmode structure that used s3c_fb_win
it can be used command mode (CPI or I80 interface)
- several header files related mipi-dsi
- mipi-dsi drivers


This patch was tested on cpu interface based on MIPI-DSI.
It consists of the flowing patches,

[PATCH v3 1/3] S5PV210: FB: support command mode
[PATCH v3 2/3] S5PV210: MIPI-DSI: add machine specific header files
[PATCH v3 3/3] S5PV210: add MIPI-DSI driver

Best regards,
Donghwa Lee
