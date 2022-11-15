Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D334FC433FE
	for <linux-fbdev@archiver.kernel.org>; Tue, 15 Nov 2022 02:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiKOCzL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Nov 2022 21:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbiKOCys (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Nov 2022 21:54:48 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBA917062
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Nov 2022 18:54:38 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NB9kJ04t7zmVtl;
        Tue, 15 Nov 2022 10:54:15 +0800 (CST)
Received: from huawei.com (10.175.100.227) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 10:54:35 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <FlorianSchandinat@gmx.de>, <deller@gmx.de>, <corbet@lwn.net>,
        <sfr@canb.auug.org.au>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH -next] fbdev: via: Fix section mismatch warning in via_core_init()
Date:   Tue, 15 Nov 2022 10:53:06 +0800
Message-ID: <20221115025306.2602-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Due to viafb_exit() with "__exit" tag, it should not be called by the
__init function via_core_init().

WARNING: modpost: drivers/video/fbdev/via/viafb.o: section mismatch in
reference: init_module (section: .init.text) -> viafb_exit (section:
.exit.text)

Fixes: ab885d8c7e15 ("fbdev: via: Fix error in via_core_init()")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 drivers/video/fbdev/via/via-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/via/via-core.c b/drivers/video/fbdev/via/via-core.c
index b2e3b5df38cd..b8cd04defc5e 100644
--- a/drivers/video/fbdev/via/via-core.c
+++ b/drivers/video/fbdev/via/via-core.c
@@ -734,7 +734,6 @@ static int __init via_core_init(void)
 	if (ret) {
 		viafb_gpio_exit();
 		viafb_i2c_exit();
-		viafb_exit();
 		return ret;
 	}
 
-- 
2.17.1

