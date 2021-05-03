Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDF3C433B4
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 May 2021 17:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012D461026
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 May 2021 17:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhECRWQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 May 2021 13:22:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:63289 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232381AbhECRWO (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 3 May 2021 13:22:14 -0400
IronPort-SDR: 1ABURqoDmOBEfn4n1B3i4bkFCnmzpZGExPFx6qzpxQLpDhyCoJVfUHKmBRj2Ny4epPhLD5Hv1C
 ZzxXdw1+8fSQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="218587847"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="218587847"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 10:21:02 -0700
IronPort-SDR: VrOy76AmqL4T0zx2YUWVBg0Fv1E91Qppz4mp+c/5r3/3lWJQrPK0ypGqdfbZu+NHR3lcBMLMk6
 nr5JcqrYUv0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="450456779"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 03 May 2021 10:21:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AA8C414B; Mon,  3 May 2021 20:21:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 0/5] staging: fbtft: Fixing GPIO handling issues
Date:   Mon,  3 May 2021 20:21:09 +0300
Message-Id: <20210503172114.27891-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This series fixes a number of GPIO handling issues after converting this driver
to use descriptors.

The series has been tested on HX8347d display with parallel interface. Without
first patch it's not working.

In v4:
- fixed Fixes tags (Greg)
- added return statement to dev_err_probe() (Dan)
- new patch to support orientation on HX8347d

In v3:
- added staging prefix (Fabio)
- slightly amended commit message in the patch 1
- added Rb tag (Phil)
- dropped Fixes tag from the patch 2 (Greg)

Andy Shevchenko (5):
  staging: fbtft: Rectify GPIO handling
  staging: fbtft: Don't spam logs when probe is deferred
  staging: fbtft: Add support for orientation on Himax HX8347d
  staging: fbtft: Replace custom ->reset() with generic one
  staging: fbtft: Update TODO

 drivers/staging/fbtft/TODO             |  5 -----
 drivers/staging/fbtft/fb_agm1264k-fl.c | 30 +++++++-------------------
 drivers/staging/fbtft/fb_bd663474.c    |  4 ----
 drivers/staging/fbtft/fb_hx8347d.c     | 29 ++++++++++++++++++++++---
 drivers/staging/fbtft/fb_ili9163.c     |  4 ----
 drivers/staging/fbtft/fb_ili9320.c     |  1 -
 drivers/staging/fbtft/fb_ili9325.c     |  4 ----
 drivers/staging/fbtft/fb_ili9340.c     |  1 -
 drivers/staging/fbtft/fb_s6d1121.c     |  4 ----
 drivers/staging/fbtft/fb_sh1106.c      |  1 -
 drivers/staging/fbtft/fb_ssd1289.c     |  4 ----
 drivers/staging/fbtft/fb_ssd1325.c     |  2 --
 drivers/staging/fbtft/fb_ssd1331.c     |  6 ++----
 drivers/staging/fbtft/fb_ssd1351.c     |  1 -
 drivers/staging/fbtft/fb_upd161704.c   |  4 ----
 drivers/staging/fbtft/fb_watterott.c   |  1 -
 drivers/staging/fbtft/fbtft-bus.c      |  3 +--
 drivers/staging/fbtft/fbtft-core.c     | 25 +++++++++------------
 drivers/staging/fbtft/fbtft-io.c       | 12 +++++------
 19 files changed, 53 insertions(+), 88 deletions(-)

-- 
2.30.2

