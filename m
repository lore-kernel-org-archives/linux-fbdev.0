Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CDFC43460
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 May 2021 17:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADFCA61075
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 May 2021 17:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhECRWN (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 May 2021 13:22:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:60333 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232336AbhECRWM (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 3 May 2021 13:22:12 -0400
IronPort-SDR: zKDWtf7htbnvDNC0wOzvx6HU+W7f57xqDHFE0i/uB0QJ0yHQX1znKtIxfdOKgGMByKUf8SVqop
 K4lyCr2te8rQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="194650729"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="194650729"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 10:21:04 -0700
IronPort-SDR: 4TW0XYFU36o+hSO+aboCTFHM1Y3mAJNUgA2efHqh7aEzlfQBZS0KgEbDUhArKzt5KEaSk/mFuP
 tllYKeWpfBog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="468145196"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 03 May 2021 10:21:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D30112A7; Mon,  3 May 2021 20:21:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH v4 2/5] staging: fbtft: Don't spam logs when probe is deferred
Date:   Mon,  3 May 2021 20:21:11 +0300
Message-Id: <20210503172114.27891-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503172114.27891-1-andriy.shevchenko@linux.intel.com>
References: <20210503172114.27891-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

When requesting GPIO line the probe can be deferred.
In such case don't spam logs with an error message.
This can be achieved by switching to dev_err_probe().

Fixes: c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor interface")
Cc: Nishad Kamdar <nishadkamdar@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/fbtft/fbtft-core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 67c3b1975a4d..3723269890d5 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -75,20 +75,16 @@ static int fbtft_request_one_gpio(struct fbtft_par *par,
 				  struct gpio_desc **gpiop)
 {
 	struct device *dev = par->info->device;
-	int ret = 0;
 
 	*gpiop = devm_gpiod_get_index_optional(dev, name, index,
 					       GPIOD_OUT_LOW);
-	if (IS_ERR(*gpiop)) {
-		ret = PTR_ERR(*gpiop);
-		dev_err(dev,
-			"Failed to request %s GPIO: %d\n", name, ret);
-		return ret;
-	}
+	if (IS_ERR(*gpiop))
+		return dev_err_probe(dev, PTR_ERR(*gpiop), "Failed to request %s GPIO\n", name);
+
 	fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' GPIO\n",
 		      __func__, name);
 
-	return ret;
+	return 0;
 }
 
 static int fbtft_request_gpios(struct fbtft_par *par)
-- 
2.30.2

