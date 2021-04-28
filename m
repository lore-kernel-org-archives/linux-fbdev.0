Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AEDC433B4
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Apr 2021 13:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FEB610A5
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Apr 2021 13:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbhD1NFU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 28 Apr 2021 09:05:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:4685 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239745AbhD1NFT (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 28 Apr 2021 09:05:19 -0400
IronPort-SDR: KvyN1lMQDdej1+1Fibb0MlATUhDG0vnbNiUVmqfsb8Z3F9iO1AuoveFYsJI12/GDgxEbVl/0sF
 b2jOPhEjYI6A==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="196289506"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="196289506"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 06:04:05 -0700
IronPort-SDR: LCb8ytZ5DpUUp6TqZ49kybIvrXvBLwhl5TPK//VQtD7kncGDp8hBVtff6CyvaO3R9ZAomrD/1i
 jjYn9d59PM+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="423528754"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2021 06:04:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C75AC425; Wed, 28 Apr 2021 16:04:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 2/4] staging: fbtft: Replace custom ->reset() with generic one
Date:   Wed, 28 Apr 2021 16:04:13 +0300
Message-Id: <20210428130415.55406-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210428130415.55406-1-andriy.shevchenko@linux.intel.com>
References: <20210428130415.55406-1-andriy.shevchenko@linux.intel.com>
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

