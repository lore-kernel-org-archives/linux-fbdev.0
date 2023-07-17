Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A68DEB64DC
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 Jul 2023 14:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjGQOsp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 17 Jul 2023 10:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGQOso (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 17 Jul 2023 10:48:44 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55AE8B2
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Jul 2023 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=HBK5Q+ySw32oZrRHgS
        eByfZVcxU6Jl87fS5CHI/bjpM=; b=bw/wWvVRHt84u9u86fRD+6YnKmAtDXiQaI
        boRX/oRwlQ9xTsNdW2dwnwKQiEiCYJCYMtrT3xA1ItU+ssVRn3hA0yVWjtYmoQ89
        jF4CA/ssHgCKgB3ANGHhH7OFEkTMX7dEp1dwiqzaTYq9MaMZMxl4V97aLMKv7A27
        UZ1vybRlE=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wB3pXKrVLVk8jU1Ag--.34432S4;
        Mon, 17 Jul 2023 22:48:15 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Helge Deller <deller@gmx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 1/1] drivers:video: fix return value check in ep93xxfb_probe
Date:   Mon, 17 Jul 2023 22:48:09 +0800
Message-Id: <20230717144809.24895-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wB3pXKrVLVk8jU1Ag--.34432S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr1fKryrJry5XF1xCw48JFb_yoW3CwcEkw
        srZ39xW3WYvrs7Krn5Gr15ZryFk348XFs7WF1Iyay5try7WryfXrWDXrnru3yUWr4DKF90
        kr1qqw4Ivr1fCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRK2Nt5UUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiJxOv5V5vEy91pAAAsi
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

function clk_prepare_enable may fail in ep93xxfb_probe, therefore,
add a return value check to clk_prepare_enable and handle the
error.

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/video/fbdev/ep93xx-fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93xx-fb.c
index 94fe52928be2..22158d9ca8dd 100644
--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -548,7 +548,9 @@ static int ep93xxfb_probe(struct platform_device *pdev)
 	}
 
 	ep93xxfb_set_par(info);
-	clk_prepare_enable(fbi->clk);
+	err = clk_prepare_enable(fbi->clk);
+	if (err)
+		goto failed_check;
 
 	err = register_framebuffer(info);
 	if (err)
-- 
2.17.1

