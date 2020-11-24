Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3E6C56202
	for <linux-fbdev@archiver.kernel.org>; Tue, 24 Nov 2020 00:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BDE520731
	for <linux-fbdev@archiver.kernel.org>; Tue, 24 Nov 2020 00:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2TJrHna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgKXAHw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 23 Nov 2020 19:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbgKXAHv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 23 Nov 2020 19:07:51 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBACC0613CF
        for <linux-fbdev@vger.kernel.org>; Mon, 23 Nov 2020 16:07:49 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id n9so3497399qvp.5
        for <linux-fbdev@vger.kernel.org>; Mon, 23 Nov 2020 16:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u190n8JYHsaDkgFF1kr4s3A8WCLfCTnQiR+FuG/fuVU=;
        b=k2TJrHnaLAJykt89O/yL/AHnKVPp9ZWxwuZ+I3TLPsH+ubhCzygJWhUY7/WJ7WIlA4
         Pm9OTlDZPtYoW4cavKB7tp8me6fkB77id6owdq4nvpw+vZ7u02qMiOKlGtBBLXZjhnuR
         bZ5Xjciq9CeVjM1aQ+rYO/dQCaKAyLTfCdKh67zQLlRfFnaFtosV6QDyuysZ3FJUrAXC
         vOoSJLrtpd6kdQqjHYZVQv8/XgLk65s87IaaiRUJsipM8dfK9vPu/wvNHsisXg/P6Ie1
         qQkIu/07Y+X4xvAb3iFN4P1OukVDa/tnODS19DfNI+itaKDxEjfKF0Y6wEZpJ3kcI31w
         wRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u190n8JYHsaDkgFF1kr4s3A8WCLfCTnQiR+FuG/fuVU=;
        b=uZTHTHx0tV2LPD4NMC1xVxiISrHyhJBD52bpLjW+wCFGNqAiL2B86EfDILvYu7UMMF
         S2P6DnPdkuUlmTZl9CpGhC8NP64l66bpVkR1Rnh1izn5pf2nQE4pbuR9Utm2Z1R/lPWH
         KZeExJXzMAj7eUSM2urQnkL8H1yTw83ovSYyhkCYyiC0MhWfaublmgRr0Vpsosn2Z9UD
         AvYcTNN1Soj3J39tfU+Yd4YzdeC7AaC35ALOMx0o2AJ30mWpvae85lqWa2Bt6RuuTaPR
         EPEti0z2iMWyuAuELwXpstLd4fzOuts/LRIWm+5Uxl7QtHLBQIgXFPOtO8vlaEE3SSOZ
         Fo7w==
X-Gm-Message-State: AOAM533QQ6XJRopZHATDRfKCkkj2JxRpxvEgUYk5EKauwbvmzKUjmZLQ
        nOdhoHzUfRabF0MIBDKgSkY=
X-Google-Smtp-Source: ABdhPJzRjA39WduPgOm11B06If5NffpYCnX2lsk2juvxvRJ6DIGeF7XBMqCOZA6ilw4WcXpRJ43cPQ==
X-Received: by 2002:a0c:b508:: with SMTP id d8mr2039043qve.8.1606176469066;
        Mon, 23 Nov 2020 16:07:49 -0800 (PST)
Received: from localhost.localdomain ([177.194.72.74])
        by smtp.gmail.com with ESMTPSA id o22sm2845922qto.96.2020.11.23.16.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:07:48 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     b.zolnierkie@samsung.com
Cc:     linux-fbdev@vger.kernel.org, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] video: fbdev: imxfb: Remove unused .id_table
Date:   Mon, 23 Nov 2020 21:05:06 -0300
Message-Id: <20201124000506.25866-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Since 5.10-rc1 i.MX is a devicetree-only platform and the existing
.id_table support in this driver was only useful for old non-devicetree
platforms.

Get rid of the .id_table since it is no longer used.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/video/fbdev/imxfb.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 884b16efa7e8..c10f82f4172b 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -175,26 +175,13 @@ struct imxfb_info {
 	int			lcd_pwr_enabled;
 };
 
-static const struct platform_device_id imxfb_devtype[] = {
-	{
-		.name = "imx1-fb",
-		.driver_data = IMX1_FB,
-	}, {
-		.name = "imx21-fb",
-		.driver_data = IMX21_FB,
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(platform, imxfb_devtype);
-
 static const struct of_device_id imxfb_of_dev_id[] = {
 	{
 		.compatible = "fsl,imx1-fb",
-		.data = &imxfb_devtype[IMX1_FB],
+		.data = (void *)IMX1_FB,
 	}, {
 		.compatible = "fsl,imx21-fb",
-		.data = &imxfb_devtype[IMX21_FB],
+		.data = (void *)IMX21_FB,
 	}, {
 		/* sentinel */
 	}
@@ -669,7 +656,7 @@ static int imxfb_init_fbinfo(struct platform_device *pdev)
 
 	memset(fbi, 0, sizeof(struct imxfb_info));
 
-	fbi->devtype = pdev->id_entry->driver_data;
+	fbi->devtype = (enum imxfb_type)of_device_get_match_data(&pdev->dev);
 
 	strlcpy(info->fix.id, IMX_NAME, sizeof(info->fix.id));
 
@@ -866,7 +853,6 @@ static int imxfb_probe(struct platform_device *pdev)
 	struct imx_fb_platform_data *pdata;
 	struct resource *res;
 	struct imx_fb_videomode *m;
-	const struct of_device_id *of_id;
 	int ret, i;
 	int bytes_per_pixel;
 
@@ -876,10 +862,6 @@ static int imxfb_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	of_id = of_match_device(imxfb_of_dev_id, &pdev->dev);
-	if (of_id)
-		pdev->id_entry = of_id->data;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
@@ -1131,7 +1113,6 @@ static struct platform_driver imxfb_driver = {
 	},
 	.probe		= imxfb_probe,
 	.remove		= imxfb_remove,
-	.id_table	= imxfb_devtype,
 };
 module_platform_driver(imxfb_driver);
 
-- 
2.17.1

