Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA319C43461
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 May 2021 03:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C37A5610A7
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 May 2021 03:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhEQDeI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 16 May 2021 23:34:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2982 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhEQDeI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 16 May 2021 23:34:08 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fk4PH3pXPzQpKb;
        Mon, 17 May 2021 11:29:23 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 11:32:51 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 17 May
 2021 11:32:50 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>
CC:     <b.zolnierkie@samsung.com>
Subject: [PATCH -next] fbdev: fbmon: Correct function name fb_get_hblank_by_hfreq()
Date:   Mon, 17 May 2021 11:35:10 +0800
Message-ID: <20210517033510.2974343-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix the following make W=1 kernel build warning:

  drivers/video/fbdev/core/fbmon.c:1073: warning: expecting prototype for fb_get_hblank_by_freq(). Prototype was for fb_get_hblank_by_hfreq() instead

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/video/fbdev/core/fbmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index b0e690f41025..79e5bfbdd34c 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1050,7 +1050,7 @@ static u32 fb_get_vblank(u32 hfreq)
 }
 
 /**
- * fb_get_hblank_by_freq - get horizontal blank time given hfreq
+ * fb_get_hblank_by_hfreq - get horizontal blank time given hfreq
  * @hfreq: horizontal freq
  * @xres: horizontal resolution in pixels
  *
-- 
2.25.1

