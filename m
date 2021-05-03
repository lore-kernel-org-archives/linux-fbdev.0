Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ED3C43460
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 May 2021 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF0261075
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 May 2021 17:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhECRWL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 May 2021 13:22:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:7412 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbhECRWF (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 3 May 2021 13:22:05 -0400
IronPort-SDR: yAw9VnzlIjvMC6a+bMkoBl75FEPl9uC0hanC846QCcGiRnAhSDFgjIhsSYkzulP2tpjfskIu3j
 zI9A2fP1kXZA==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="259080114"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="259080114"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 10:21:03 -0700
IronPort-SDR: 96bxu0AiS3P5X6A43cWBaiY/Fm37+dvIa566SwGUL8xzMt5zPjOG6VzmFn8rCuKBbcBzrDpj/Y
 1MRHZqwX68EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="606706347"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2021 10:21:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EA90C348; Mon,  3 May 2021 20:21:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 4/5] staging: fbtft: Replace custom ->reset() with generic one
Date:   Mon,  3 May 2021 20:21:13 +0300
Message-Id: <20210503172114.27891-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503172114.27891-1-andriy.shevchenko@linux.intel.com>
References: <20210503172114.27891-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The custom ->reset() repeats the generic one, replace it.

Note, in newer kernels the context of the function is a sleeping one,
it's fine to switch over to the sleeping functions. Keeping the reset
line asserted longer than 20 microseconds is also okay, it's an idling
state of the hardware.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/fbtft/fb_agm1264k-fl.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index b545c2ca80a4..207d578547cd 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -77,19 +77,6 @@ static int init_display(struct fbtft_par *par)
 	return 0;
 }
 
-static void reset(struct fbtft_par *par)
-{
-	if (!par->gpio.reset)
-		return;
-
-	dev_dbg(par->info->device, "%s()\n", __func__);
-
-	gpiod_set_value(par->gpio.reset, 1);
-	udelay(20);
-	gpiod_set_value(par->gpio.reset, 0);
-	mdelay(120);
-}
-
 /* Check if all necessary GPIOS defined */
 static int verify_gpios(struct fbtft_par *par)
 {
@@ -439,7 +426,6 @@ static struct fbtft_display display = {
 		.set_addr_win = set_addr_win,
 		.verify_gpios = verify_gpios,
 		.request_gpios_match = request_gpios_match,
-		.reset = reset,
 		.write = write,
 		.write_register = write_reg8_bus8,
 		.write_vmem = write_vmem,
-- 
2.30.2

