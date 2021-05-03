Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E2BC433ED
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 May 2021 17:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3191661075
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 May 2021 17:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhECRWM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 May 2021 13:22:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:37177 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232253AbhECRWK (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 3 May 2021 13:22:10 -0400
IronPort-SDR: mYBSUEwAIj4QU39wweOLrt9NoMuRYCTjdj54ItTdkcqqCPkIpLgKjpa7diyST5CV1PDlhgNmLJ
 zOY7GQ/+yIZw==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="261744319"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="261744319"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 10:21:03 -0700
IronPort-SDR: nlS4Frt1SdF8kCykuPTDbddhTHcV1QLR3BF/vtEqPMuajwN2ShenForDcwU71gV7p98WRLf5Rz
 02PKb9a+94qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="618062686"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 03 May 2021 10:21:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DEEFD2E4; Mon,  3 May 2021 20:21:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 3/5] staging: fbtft: Add support for orientation on Himax HX8347d
Date:   Mon,  3 May 2021 20:21:12 +0300
Message-Id: <20210503172114.27891-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503172114.27891-1-andriy.shevchenko@linux.intel.com>
References: <20210503172114.27891-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Himax HX8347d has non-standard register to control orientation.
Add support for different orientation values.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/fbtft/fb_hx8347d.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_hx8347d.c b/drivers/staging/fbtft/fb_hx8347d.c
index 37eaf0862c5b..a9b72a8b42b5 100644
--- a/drivers/staging/fbtft/fb_hx8347d.c
+++ b/drivers/staging/fbtft/fb_hx8347d.c
@@ -68,9 +68,6 @@ static int init_display(struct fbtft_par *par)
 	mdelay(40);
 	write_reg(par, 0x28, 0x3C);
 
-	/* orientation */
-	write_reg(par, 0x16, 0x60 | (par->bgr << 3));
-
 	return 0;
 }
 
@@ -87,6 +84,31 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 	write_reg(par, 0x22);
 }
 
+#define MEM_Y   BIT(7) /* MY row address order */
+#define MEM_X   BIT(6) /* MX column address order */
+#define MEM_V   BIT(5) /* MV row / column exchange */
+#define MEM_L   BIT(4) /* ML vertical refresh order */
+#define MEM_BGR (3) /* RGB-BGR Order */
+static int set_var(struct fbtft_par *par)
+{
+	switch (par->info->var.rotate) {
+	case 0:
+		write_reg(par, 0x16, MEM_V | MEM_X | (par->bgr << MEM_BGR));
+		break;
+	case 270:
+		write_reg(par, 0x16, par->bgr << MEM_BGR);
+		break;
+	case 180:
+		write_reg(par, 0x16, MEM_V | MEM_Y | (par->bgr << MEM_BGR));
+		break;
+	case 90:
+		write_reg(par, 0x16, MEM_X | MEM_Y | (par->bgr << MEM_BGR));
+		break;
+	}
+
+	return 0;
+}
+
 /*
  * Gamma string format:
  *   VRP0 VRP1 VRP2 VRP3 VRP4 VRP5 PRP0 PRP1 PKP0 PKP1 PKP2 PKP3 PKP4 CGM
@@ -144,6 +166,7 @@ static struct fbtft_display display = {
 	.fbtftops = {
 		.init_display = init_display,
 		.set_addr_win = set_addr_win,
+		.set_var = set_var,
 		.set_gamma = set_gamma,
 	},
 };
-- 
2.30.2

