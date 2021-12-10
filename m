Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85CBC433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Dec 2021 10:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhLJKcI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:32:08 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:41067 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhLJKcI (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 10 Dec 2021 05:32:08 -0500
X-QQ-mid: bizesmtp41t1639132106te84a0qj
Received: from localhost.localdomain (unknown [182.148.15.171])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 10 Dec 2021 18:28:22 +0800 (CST)
X-QQ-SSF: 01000000002000905000B00A0000000
X-QQ-FEAT: 2YircyAZcttVhO3fNgRwuEXtz87LTwFhcBlCiG1QLK3XgbXoBrgSmwW3KZlln
        ClgP9V7qQ+F75WRCB1RUIwPgBENsseluzGqw03+lzOpbJvLsS5UksoEO1map0Kxx4g0QVuW
        wtcfC6FcMQHIvQzqM2/5kDwHlAdNdg9eECDrvtNEOPN+UNR6M1I50ZkJGx0r57ztQxqVqNi
        RZDCTqr4j4Axjk0KtOertRlyuRinAhpTXVrBWgqfkDgEFNijbKM+CK2zwSCKcoVmNuS9J1n
        gFRnT79e96iHkEFbjdX+XTjMfVdsp10FiYKZmoCQFVj1zF1gpa6UfMiVwnKXyHvA5QIg==
X-QQ-GoodBg: 0
From:   Chunyang Zhong <zhongchunyang@cdjrlc.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyang Zhong <zhongchunyang@cdjrlc.com>
Subject: [PATCH] =?UTF-8?q?video:=20ocfb:=20add=20const=20to=20of=5Fdevice?= =?UTF-8?q?=5Fid=C2=A0?=
Date:   Fri, 10 Dec 2021 18:28:16 +0800
Message-Id: <20211210102816.9187-1-zhongchunyang@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

struct of_device_id should normally be const.

Signed-off-by: Chunyang Zhong <zhongchunyang@cdjrlc.com>
---
 drivers/video/fbdev/ocfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ocfb.c b/drivers/video/fbdev/ocfb.c
index bfa4ed421148..da7e1457e58f 100644
--- a/drivers/video/fbdev/ocfb.c
+++ b/drivers/video/fbdev/ocfb.c
@@ -387,7 +387,7 @@ static int ocfb_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id ocfb_match[] = {
+static const struct of_device_id ocfb_match[] = {
 	{ .compatible = "opencores,ocfb", },
 	{},
 };
-- 
2.34.1

