Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BD0C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 21 Sep 2021 21:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2154060F70
	for <linux-fbdev@archiver.kernel.org>; Tue, 21 Sep 2021 21:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhIUVXV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 21 Sep 2021 17:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhIUVXU (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 21 Sep 2021 17:23:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4559760F24;
        Tue, 21 Sep 2021 21:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632259311;
        bh=/qSWIbShMWBa5x9vPNqVBXY3/tfR8X1Q/6APO+n3E8M=;
        h=From:To:Cc:Subject:Date:From;
        b=u+C4MxQyIHJogdIwFLOJnhMhHM+MjSY0I4hqwKXbS2eaXmMvybZtz3hLRy/zN2Kkh
         4VbmovxiSEaNdqSMHf6s0wVZHuIyVjazh1jEWzU39NWQI/vYihl4s5NJl8mGem+Okd
         0Zw9qlsbPmXkD22NFaRx6G9QdSHdBS5bzRUcaakuQyuPPQBZE/t9REnqJBxWoamhEt
         Y1Hw/jhACRoOZDlH2VajCJjL8J4jpcc9xBnJew4QW+ERRqOWCKck1YEnqXvxrobU5y
         NHfjdtv2OnkC8ZNnV7QYDBwm0mxWpXk0WZYxxRy+0Yf1yPoPAcncT869ozzew7DJgp
         XAz0XB4nwsTGg==
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] video: fbdev: gbefb: Only instantiate device when built for IP32
Date:   Tue, 21 Sep 2021 22:21:02 +0100
Message-Id: <20210921212102.30803-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; h=from:subject; bh=/qSWIbShMWBa5x9vPNqVBXY3/tfR8X1Q/6APO+n3E8M=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhSkyy+ZgVzBZM7oBzf1FmoKw3YCH+vFjPuiZuIgHt 1OBvB0aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUpMsgAKCRAk1otyXVSH0KKyB/ 4hmzdZd71Qc0N3hTk+UlgM+anFiOMJZszXSBDnPXecSmwPJuB5Fc3terGOa/H3xRUqI2osAqBQoPii SqSv5/RgR/+mqYcgU4BOMe3AesZ9dycqOrIWZ9G95gTkWo/oMcF/4AAHVDNnDhsaHLZ3t0V4BQtcA2 As7ZgFBHUVqTRHiNsQMXOqm6xsGt/Ax3dipbYdCKOFeuFlVvGD50g19U+q8XgIUV8JrFJjG+/3pELF Q2y0hHeC1opGO8u3POmgcBlszTJHvvQphb2MIhiPCQEE25fa1m70RtNSlQoiynaFSvh55rE/Xmey8j mHTSwfT+GQzXz+f7GsEFuN4R+ougOU
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The gbefb driver not only registers a driver but also the device for that
driver. This is all well and good when run on the IP32 machines that are
supported by the driver but since the driver supports building with
COMPILE_TEST we might also be building on other platforms which do not have
this hardware and will crash instantiating the driver. Add an IS_ENABLED()
check so we compile out the device registration if we don't have the Kconfig
option for the machine enabled.

Fixes: 552ccf6b259d290c0c ("video: fbdev: gbefb: add COMPILE_TEST support")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/gbefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index c5b99a4861e8..6b4d5a7f3e15 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -1267,7 +1267,7 @@ static struct platform_device *gbefb_device;
 static int __init gbefb_init(void)
 {
 	int ret = platform_driver_register(&gbefb_driver);
-	if (!ret) {
+	if (IS_ENABLED(CONFIG_SGI_IP32) && !ret) {
 		gbefb_device = platform_device_alloc("gbefb", 0);
 		if (gbefb_device) {
 			ret = platform_device_add(gbefb_device);
-- 
2.20.1

