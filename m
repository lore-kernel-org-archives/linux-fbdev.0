Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576DFC47082
	for <linux-fbdev@archiver.kernel.org>; Fri,  4 Jun 2021 03:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3517761407
	for <linux-fbdev@archiver.kernel.org>; Fri,  4 Jun 2021 03:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFDDJe (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 3 Jun 2021 23:09:34 -0400
Received: from m12-13.163.com ([220.181.12.13]:42951 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhFDDJd (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 3 Jun 2021 23:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=u8CRh
        j9NpaNynNgg7yQQS2uC6hLXKsf/LnEpS7op8Ps=; b=CB6+FNRz1ov9FW7tYjI2D
        Ujq9hLCfPez8RuLsPH8wFoFu6URp7nYrGsQAXaqEYOzDYGtjqYhrZ2u0CiREpkMk
        zzOOfZLsO5vrlp8mHDBbN/3EYdWwEjk8UXVL1LC8eZUNBTLhacVBsOsFLz8yIas9
        CXqXeMqe2uKzQf9JsV5fE4=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowAAnK7fqmLlglFyrEQ--.1587S2;
        Fri, 04 Jun 2021 11:07:23 +0800 (CST)
From:   lijian_8010a29@163.com
To:     tzimmermann@suse.de, sam@ravnborg.org, gustavoars@kernel.org,
        rppt@kernel.org, saeed.mirzamohammadi@oracle.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lijian <lijian@yulong.com>
Subject: [PATCH] video: fbdev: cirrusfb: Removed unnecessary 'return'
Date:   Fri,  4 Jun 2021 11:06:24 +0800
Message-Id: <20210604030624.122085-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAnK7fqmLlglFyrEQ--.1587S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWxGrW3CF45Cw1fZry7KFg_yoWxAFX_Cr
        12vr93WrWqkr1vkr10gFyayryvyFn8Zasav3ZFg34Syry7W34rZr18uw12qryagr92vFnr
        WFyqgr4vywn5CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5rWrtUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/xtbBEROnUFaEEmK0EAABsy
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: lijian <lijian@yulong.com>

Removed unnecessary 'return' in void function init_vgachip().

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/video/fbdev/cirrusfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index 93802abbbc72..e726e7ac3eeb 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -1662,7 +1662,6 @@ static void init_vgachip(struct fb_info *info)
 
 	/* misc... */
 	WHDR(cinfo, 0);	/* Hidden DAC register: - */
-	return;
 }
 
 static void switch_monitor(struct cirrusfb_info *cinfo, int on)
-- 
2.25.1


