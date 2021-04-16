Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ADAC433ED
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Apr 2021 12:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1186B6117A
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Apr 2021 12:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbhDPMbm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:31:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:56273 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235292AbhDPMbk (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 16 Apr 2021 08:31:40 -0400
IronPort-SDR: CQBbidF0kieiP8ggen32ipYGEx9UtPRmtQEdwypTpA5tNkFpt9LJJ38zjJ/rnQF+YSw6Cj7IuJ
 UEtNBmtY6qRQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="175140199"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="175140199"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 05:31:16 -0700
IronPort-SDR: IxumiiRIJwpJIuwk28rwAKWbEPw6iGRwlTfxtJIvWbuclrEnn3yybu9rpcJwu3q4mtazbBUoOp
 RDfvU03krWpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="522699204"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2021 05:31:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C093D142; Fri, 16 Apr 2021 15:31:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 2/2] fbtft: Don't spam logs when probe is deferred
Date:   Fri, 16 Apr 2021 15:31:17 +0300
Message-Id: <20210416123117.4993-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416123117.4993-1-andriy.shevchenko@linux.intel.com>
References: <20210416123117.4993-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

When requesting GPIO line the probe can be deferred.
In such case don't spam logs with an error message.
This can be achieved by switching to dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/fbtft/fbtft-core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 67c3b1975a4d..a564907c4fa1 100644
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
+		dev_err_probe(dev, PTR_ERR(*gpiop), "Failed to request %s GPIO\n", name);
+
 	fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' GPIO\n",
 		      __func__, name);
 
-	return ret;
+	return 0;
 }
 
 static int fbtft_request_gpios(struct fbtft_par *par)
-- 
2.30.2

