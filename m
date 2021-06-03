Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D52C47096
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Jun 2021 07:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11396136E
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Jun 2021 07:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhFCH0S (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 3 Jun 2021 03:26:18 -0400
Received: from m12-16.163.com ([220.181.12.16]:38785 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhFCH0S (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 3 Jun 2021 03:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Cu7Es
        3G/4F3KvdpCSwvOPH/npsuhFA7k0V+dMtpqY64=; b=Ao5rV/5D9jzHwD8pop+Ds
        10BS9LpGuhm94achYR/vzS+iVkmJkcDNtRV6eHSysul5y9XQqA3aTU2Qfm1Oya86
        DNRC7ZwY/+a3x7Q2oBxNbpt8ajN8QVPnkPibYLtp7Gompm30M2GnpZxbh/pNx91t
        +IlefjpW+LWDDNTzsZmV6c=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp12 (Coremail) with SMTP id EMCowADHz9ekg7hgadPSuw--.2698S2;
        Thu, 03 Jun 2021 15:24:21 +0800 (CST)
From:   lijian_8010a29@163.com
To:     FlorianSchandinat@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lijian <lijian@yulong.com>
Subject: [PATCH] video: fbdev: via: hw.c:  Fix a typo
Date:   Thu,  3 Jun 2021 15:23:22 +0800
Message-Id: <20210603072322.19235-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowADHz9ekg7hgadPSuw--.2698S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrykArW5Aw1UGr1fAr1fWFg_yoWxZFc_CF
        yxZ393WrWqyw109w18JFW3C340vay8uF9av3WDtryfAry7u343trykurySg3y7Ww4UXFnr
        WF4qgr10krySkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUexgA7UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbi3x+lUGB0GZ9+KwABsz
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'orignal' to 'original'.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/video/fbdev/via/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/via/hw.c b/drivers/video/fbdev/via/hw.c
index 66afd7be00cc..e9d0fac8fb17 100644
--- a/drivers/video/fbdev/via/hw.c
+++ b/drivers/video/fbdev/via/hw.c
@@ -1542,7 +1542,7 @@ static void init_gfx_chip_info(int chip_type)
 		else
 			viaparinfo->chip_info->gfx_chip_revision =
 			CLE266_REVISION_CX;
-		/* restore orignal CR4F value */
+		/* restore original CR4F value */
 		viafb_write_reg(CR4F, VIACR, tmp);
 	}
 
-- 
2.25.1


