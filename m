Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554A8C4332F
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Nov 2022 08:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiKNIiy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Nov 2022 03:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbiKNIiy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Nov 2022 03:38:54 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D816A5585
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Nov 2022 00:38:52 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N9jQ25VKlzRpNj;
        Mon, 14 Nov 2022 16:38:34 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 16:38:51 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 16:38:50 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <deller@gmx.de>, <javierm@redhat.com>, <b.zolnierkie@samsung.com>,
        <tzimmermann@suse.de>, <alanh@fairlite.demon.co.uk>
CC:     <yangyingliang@huawei.com>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] video: fbdev: vermilion: decrease reference count in error path
Date:   Mon, 14 Nov 2022 16:56:54 +0800
Message-ID: <20221114085654.179249-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

pci_get_device() will increase the reference count for the returned
pci_dev. For the error path, we need to use pci_dev_put() to decrease
the reference count.

Fixes: dbe7e429fedb ("vmlfb: framebuffer driver for Intel Vermilion Range")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/video/fbdev/vermilion/vermilion.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vermilion/vermilion.c b/drivers/video/fbdev/vermilion/vermilion.c
index 82b36dbb5b1a..33051e3a2561 100644
--- a/drivers/video/fbdev/vermilion/vermilion.c
+++ b/drivers/video/fbdev/vermilion/vermilion.c
@@ -278,8 +278,10 @@ static int vmlfb_get_gpu(struct vml_par *par)
 
 	mutex_unlock(&vml_mutex);
 
-	if (pci_enable_device(par->gpu) < 0)
+	if (pci_enable_device(par->gpu) < 0) {
+		pci_dev_put(par->gpu);
 		return -ENODEV;
+	}
 
 	return 0;
 }
-- 
2.20.1

