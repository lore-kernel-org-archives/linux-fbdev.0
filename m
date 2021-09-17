Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEB8C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Sep 2021 03:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529CC61019
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Sep 2021 03:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhIQDOl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Sep 2021 23:14:41 -0400
Received: from mx22.baidu.com ([220.181.50.185]:47476 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232364AbhIQDOk (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Sep 2021 23:14:40 -0400
Received: from BJHW-Mail-Ex08.internal.baidu.com (unknown [10.127.64.18])
        by Forcepoint Email with ESMTPS id E3F661BD0EB5B06CFFC0;
        Fri, 17 Sep 2021 11:13:16 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex08.internal.baidu.com (10.127.64.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 17 Sep 2021 11:13:16 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 17 Sep 2021 11:13:16 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] backlight: bd6107: Make use of the helper function dev_err_probe()
Date:   Fri, 17 Sep 2021 11:13:06 +0800
Message-ID: <20210917031308.17623-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex08_2021-09-17 11:13:16:946
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

When possible use dev_err_probe help to properly deal with the
PROBE_DEFER error, the benefit is that DEFER issue will be logged
in the devices_deferred debugfs file.
Using dev_err_probe() can reduce code size, and the error value
gets printed.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/video/backlight/bd6107.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
index 515184fbe33a..e21b793302a2 100644
--- a/drivers/video/backlight/bd6107.c
+++ b/drivers/video/backlight/bd6107.c
@@ -120,7 +120,6 @@ static int bd6107_probe(struct i2c_client *client,
 	struct backlight_device *backlight;
 	struct backlight_properties props;
 	struct bd6107 *bd;
-	int ret;
 
 	if (pdata == NULL) {
 		dev_err(&client->dev, "No platform data\n");
@@ -148,11 +147,9 @@ static int bd6107_probe(struct i2c_client *client,
 	 * the reset.
 	 */
 	bd->reset = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(bd->reset)) {
-		dev_err(&client->dev, "unable to request reset GPIO\n");
-		ret = PTR_ERR(bd->reset);
-		return ret;
-	}
+	if (IS_ERR(bd->reset))
+		return dev_err_probe(&client->dev, PTR_ERR(bd->reset),
+				     "unable to request reset GPIO\n");
 
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_RAW;
@@ -164,10 +161,9 @@ static int bd6107_probe(struct i2c_client *client,
 					      dev_name(&client->dev),
 					      &bd->client->dev, bd,
 					      &bd6107_backlight_ops, &props);
-	if (IS_ERR(backlight)) {
-		dev_err(&client->dev, "failed to register backlight\n");
-		return PTR_ERR(backlight);
-	}
+	if (IS_ERR(backlight))
+		return dev_err_probe(&client->dev, PTR_ERR(backlight),
+				     "failed to register backlight\n");
 
 	backlight_update_status(backlight);
 	i2c_set_clientdata(client, backlight);
-- 
2.25.1

