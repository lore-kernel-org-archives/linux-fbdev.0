From: Scott Matheina <scott@matheina.com>
Date: Tue, 10 Jan 2017 02:23:27 +0000
Subject: [PATCH 2/2] staging:sm750fb:ddk750_chip.c removes un-necessary blank lines
Message-Id: <1484015010-6058-2-git-send-email-scott@matheina.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484015010-6058-1-git-send-email-scott@matheina.com>
In-Reply-To: <1484015010-6058-1-git-send-email-scott@matheina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org

Fixes checkpatch warning - Please don't use multiple blank lines

Signed-off-by: Scott Matheina <scott@matheina.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index ec33f1f..9aaf1fd 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -245,7 +245,6 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
 	/* Set up master clock */
 	set_master_clock(MHz(pInitParam->masterClock));
 
-
 	/*
 	 * Reset the memory controller.
 	 * If the memory controller is not reset in SM750,
@@ -408,5 +407,3 @@ unsigned int sm750_format_pll_reg(struct pll_value *pPLL)
 
 	return reg;
 }
-
-
-- 
2.7.4

