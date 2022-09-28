Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FEFC32771
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Sep 2022 15:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiI1PBY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 28 Sep 2022 11:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiI1PBH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 28 Sep 2022 11:01:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2053F67CA6
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Sep 2022 08:01:03 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Md0240j6Sz1P6mn;
        Wed, 28 Sep 2022 22:56:44 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 23:01:00 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <deller@gmx.de>, <javierm@redhat.com>, <tzimmermann@suse.de>,
        <maxime@cerno.tech>, <zengheng4@huawei.com>
CC:     <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <liwei391@huawei.com>
Subject: [PATCH -next] video: fbdev: add missing MODULE_DEVICE_TABLE
Date:   Wed, 28 Sep 2022 23:17:10 +0800
Message-ID: <20220928151710.1951969-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition
which generates correct modalias for automatic loading
of this driver when it is built as an external module.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/video/fbdev/vga16fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index 35cf51ae3292..af47f8217095 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1421,6 +1421,7 @@ static const struct platform_device_id vga16fb_driver_id_table[] = {
 	{"vga-framebuffer", 0},
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, vga16fb_driver_id_table);
 
 static struct platform_driver vga16fb_driver = {
 	.probe = vga16fb_probe,
-- 
2.25.1

