From: daeinki <inki.dae@samsung.com>
Date: Thu, 18 Nov 2010 10:43:04 +0000
Subject: [PATCH 0/3] S5PV210: added MIPI-DSI Driver.
Message-Id: <4CE50338.8060000@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101118091735.GA24131@linux-sh.org>
In-Reply-To: <20101118091735.GA24131@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hello all,

This patch is a MIPI-DSI driver for S5PV210.

PATCH 1/3: add a structure for CPU interface to linux/fb.h
- RGB or CPU interfaces could be used as display mode but framebuffer
framework doesn't consider CPU interface so I added this structure
because fb_cpumode structure could be used commonly.

PATCH 2/3: add parameters for CPU interface to plat-samsung/fb.h
- MIPI-DSI driver would use s3c-fb driver so I added some parameters
because MIPI-DSI driver supports CPU interface also.

PATCH 3/3: add MIPI-DSI driver for S5PV210.

thank you.

signed-off-by: Inki Dae <inki.dae@samsung.com>
signed-off-by: Kyoungmin Park <kyoungmin.park@samsung.com>

