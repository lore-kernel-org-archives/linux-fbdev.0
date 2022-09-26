Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FEBC32771
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Sep 2022 14:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiIZO6Y (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiIZO6A (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Sep 2022 10:58:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF3C937A9
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Sep 2022 06:28:39 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mbk6l0bpyzHqSH;
        Mon, 26 Sep 2022 21:26:23 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 21:28:38 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 21:28:37 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <linus.walleij@linaro.org>, <lee@kernel.org>,
        <daniel.thompson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next] backlight: ktd253: Switch to use dev_err_probe() helper
Date:   Mon, 26 Sep 2022 21:35:25 +0800
Message-ID: <20220926133525.1107096-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

In the probe path, dev_err() can be replaced with dev_err_probe()
which will check if error code is -EPROBE_DEFER and prints the
error name. It also sets the defer probe reason which can be
checked later through debugfs. It's more simple in error path.
---
 drivers/video/backlight/ktd253-backlight.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/ktd253-backlight.c b/drivers/video/backlight/ktd253-backlight.c
index 37aa5a669530..d7d43454f64a 100644
--- a/drivers/video/backlight/ktd253-backlight.c
+++ b/drivers/video/backlight/ktd253-backlight.c
@@ -173,12 +173,9 @@ static int ktd253_backlight_probe(struct platform_device *pdev)
 	}
 
 	ktd253->gpiod = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
-	if (IS_ERR(ktd253->gpiod)) {
-		ret = PTR_ERR(ktd253->gpiod);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "gpio line missing or invalid.\n");
-		return ret;
-	}
+	if (IS_ERR(ktd253->gpiod))
+		return dev_err_probe(dev, PTR_ERR(ktd253->gpiod),
+				     "gpio line missing or invalid.\n");
 	gpiod_set_consumer_name(ktd253->gpiod, dev_name(dev));
 	/* Bring backlight to a known off state */
 	msleep(KTD253_T_OFF_MS);
-- 
2.25.1

