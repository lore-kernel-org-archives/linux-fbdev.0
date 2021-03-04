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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF84C433E0
	for <linux-fbdev@archiver.kernel.org>; Thu,  4 Mar 2021 09:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF2064F11
	for <linux-fbdev@archiver.kernel.org>; Thu,  4 Mar 2021 09:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhCDJE3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 4 Mar 2021 04:04:29 -0500
Received: from m12-14.163.com ([220.181.12.14]:47060 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237303AbhCDJEI (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 4 Mar 2021 04:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=XqR7Y
        MSkZJXyMrPRdGCfI1mzopJWNr2t2Xyn/TQd1K8=; b=CnZPW7rD+VFECVbW1hvAW
        eDYnmPIZx0beEiqe64kTS83tuHwEM+P0O0iJVQTE0T/wSg8jCC2nxGh9upyEIEpl
        qSfwez9mOkkCguHyN4ISV8SaAM/rTW0DNGhMwU5iBJJFBW1S+l6bebOTuqoDwsiT
        zOvbpQSV22IC7Zwu9oSXmA=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowABXZZmyoUBg0zCSng--.12062S2;
        Thu, 04 Mar 2021 17:00:37 +0800 (CST)
From:   zuoqilin1@163.com
To:     b.zolnierkie@samsung.com, rdunlap@infradead.org,
        tzimmermann@suse.de, vaibhavgupta40@gmail.com, joe@perches.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] video: Fix typo issue
Date:   Thu,  4 Mar 2021 17:00:31 +0800
Message-Id: <20210304090031.2359-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABXZZmyoUBg0zCSng--.12062S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy8AFW7Ww1rCr4DGw4UJwb_yoWfArb_A3
        48WF9rXrW29r1kGr1ktayDZrWay34xXr1UXwnxt34rJFW7Wr9Y934Dur1xWayjgrWUJa43
        Zw1vgFyxXF4fCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUY5HUDUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/xtbBRRVLiVPAKTvT+AAAs4
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Change 'frequncy' to 'frequency'.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 drivers/video/fbdev/aty/atyfb_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index e946903a..83b76d3 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3390,7 +3390,7 @@ static int init_from_bios(struct atyfb_par *par)
 
 		PRINTKI("Mach64 BIOS is located at %x, mapped at %x.\n", rom_addr, bios_base);
 
-		/* check for frequncy table */
+		/* check for frequency table */
 		bios_ptr = (u8*)bios_base;
 		rom_table_offset = (u16)(bios_ptr[0x48] | (bios_ptr[0x49] << 8));
 		freq_table_offset = bios_ptr[rom_table_offset + 16] | (bios_ptr[rom_table_offset + 17] << 8);
-- 
1.9.1


