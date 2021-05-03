Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEBCC433B4
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 May 2021 17:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0912C61026
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 May 2021 17:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhECRWI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 May 2021 13:22:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:7412 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231299AbhECRWE (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 3 May 2021 13:22:04 -0400
IronPort-SDR: RGlBeDZXWglezH/HjeR/cRqIBjnXxao28zNUnZ+0q4/3W8e5hm6DyoV39ZIO/eJa903S2GVwbz
 9wlwyq6DAFeg==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="259080140"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="259080140"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 10:21:05 -0700
IronPort-SDR: QFj6XrTZZjjDNCdv/d0EwzzJ5NTva9iC54/5d99ziVuUUgvD9NKjBQ0WKD4PO6ZyQXZceOlnDY
 tntO1a87N82A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="606706383"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2021 10:21:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 00C9129A; Mon,  3 May 2021 20:21:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 5/5] staging: fbtft: Update TODO
Date:   Mon,  3 May 2021 20:21:14 +0300
Message-Id: <20210503172114.27891-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503172114.27891-1-andriy.shevchenko@linux.intel.com>
References: <20210503172114.27891-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Now, after a few fixes we may consider the conversion to
the GPIO descriptor API is done.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/fbtft/TODO | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/fbtft/TODO b/drivers/staging/fbtft/TODO
index a9f4802bb6be..e72a08bf221c 100644
--- a/drivers/staging/fbtft/TODO
+++ b/drivers/staging/fbtft/TODO
@@ -1,8 +1,3 @@
-* convert all uses of the old GPIO API from <linux/gpio.h> to the
-  GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
-  lines from device tree, ACPI or board files, board files should
-  use <linux/gpio/machine.h>
-
 * convert all these over to drm_simple_display_pipe and submit for inclusion
   into the DRM subsystem under drivers/gpu/drm - fbdev doesn't take any new
   drivers anymore.
-- 
2.30.2

