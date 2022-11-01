Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1193C4332F
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Nov 2022 15:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiKAPOP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiKAPN5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 1 Nov 2022 11:13:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2631EC5E;
        Tue,  1 Nov 2022 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667315374; x=1698851374;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s75q2MsgxsQuSoRbKCZULbXrGHbPl+xDbnix/pI6B6E=;
  b=MUkxF3f57Xvt82P/+U5quBLfEzT08ERs6YDzNbxKxNLWbRZK6Q8TrCzE
   5MScQqT4NJj7/dYyXhisP4nIvCpWA+CgCq+8JaxIG99Z7vsrPgj+Wm7RK
   psQEcreM3fVXMaAd8RpVxn+pw0eJyP8uHyOaWxSHyF6xMVF9Dink7Qad0
   kfHX96WOTUuJ1LGKl2UCGkbTw1UQqBAbF7KexGf31r8aksFCmbTDOZVtJ
   rYW8sg1xe1v6KFidp0dI9ujWAuTn8RLt8gG/sL0yuQsfe4jjbLhnNE6T2
   qsQotO+NfRv0kY8oNofber+/bn055/ZFwp2yZDaZs2DnY8caOZaC+YTSc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395468737"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="395468737"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="667221094"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="667221094"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 01 Nov 2022 08:09:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5620DF7; Tue,  1 Nov 2022 17:09:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] fbdev: ssd1307fb: Drop optional dependency
Date:   Tue,  1 Nov 2022 17:09:46 +0200
Message-Id: <20221101150947.67377-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Only a single out of three devices need a PWM, so from driver it's
optional. Moreover it's a single driver in the entire kernel that
currently selects PWM. Unfortunately this selection is a root cause
of the circular dependencies when we want to enable optional PWM
for some other drivers that select GPIOLIB.

Fixes: a2ed00da5047 ("drivers/video: add support for the Solomon SSD1307 OLED Controller")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/fbdev/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index a98987aa2784..b88d8bfe992e 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2218,7 +2218,6 @@ config FB_SSD1307
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
 	select FB_DEFERRED_IO
-	select PWM
 	select FB_BACKLIGHT
 	help
 	  This driver implements support for the Solomon SSD1307
-- 
2.35.1

