Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A511C433B4
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Apr 2021 16:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697C36108B
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Apr 2021 16:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhDIQlu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 9 Apr 2021 12:41:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:52343 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhDIQlo (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 9 Apr 2021 12:41:44 -0400
IronPort-SDR: I8hNrpxm/BI4dmXMMsV9I5sfBaMBh16F8XajCmxlxiid3ZpyDO7JGC5RUNkiTgwIx99Adm24cS
 8tmpQeYIZyIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="193838014"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="193838014"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 09:41:31 -0700
IronPort-SDR: jRjMIhkQHwFvaGBbqRIpkcEqBHXTBK1ZYjfu2iqnia4QHR1yZRXaNTpCqUoIm5SXJKUGVMFEWs
 3JMikjRXdnOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="520337221"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2021 09:41:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E6399FC; Fri,  9 Apr 2021 19:41:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] video: ssd1307fb: Drop OF dependency
Date:   Fri,  9 Apr 2021 19:41:40 +0300
Message-Id: <20210409164140.17337-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

After the commit 72915994e028 ("video: ssd1307fb: Make use of device
properties") driver does not depend on OF, drop unneeded dependency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/fbdev/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 4f02db65dede..7506b5949eb0 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2209,7 +2209,6 @@ config FB_SIMPLE
 config FB_SSD1307
 	tristate "Solomon SSD1307 framebuffer support"
 	depends on FB && I2C
-	depends on OF
 	depends on GPIOLIB || COMPILE_TEST
 	select FB_SYS_FOPS
 	select FB_SYS_FILLRECT
-- 
2.30.2

