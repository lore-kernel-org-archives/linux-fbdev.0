Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A621C4332F
	for <linux-fbdev@archiver.kernel.org>; Sat, 12 Nov 2022 09:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiKLJ4l (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 12 Nov 2022 04:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLJ4k (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 12 Nov 2022 04:56:40 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F872715D
        for <linux-fbdev@vger.kernel.org>; Sat, 12 Nov 2022 01:56:40 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N8WDk1j6tz15MPC
        for <linux-fbdev@vger.kernel.org>; Sat, 12 Nov 2022 17:56:22 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 17:56:38 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 12 Nov
 2022 17:56:38 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-fbdev@vger.kernel.org>
CC:     <deller@gmx.de>, <yangyingliang@huawei.com>
Subject: [PATCH] video: fbdev: pm2fb: fix missing pci_disable_device()
Date:   Sat, 12 Nov 2022 17:55:10 +0800
Message-ID: <20221112095510.3639570-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add missing pci_disable_device() in error path of probe() and remove() path.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/video/fbdev/pm2fb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index 7da715d31a93..7a8609c40ae9 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -1533,8 +1533,10 @@ static int pm2fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	info = framebuffer_alloc(sizeof(struct pm2fb_par), &pdev->dev);
-	if (!info)
-		return -ENOMEM;
+	if (!info) {
+		err = -ENOMEM;
+		goto err_exit_disable;
+	}
 	default_par = info->par;
 
 	switch (pdev->device) {
@@ -1715,6 +1717,8 @@ static int pm2fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	release_mem_region(pm2fb_fix.mmio_start, pm2fb_fix.mmio_len);
  err_exit_neither:
 	framebuffer_release(info);
+ err_exit_disable:
+	pci_disable_device(pdev);
 	return retval;
 }
 
@@ -1739,6 +1743,7 @@ static void pm2fb_remove(struct pci_dev *pdev)
 	fb_dealloc_cmap(&info->cmap);
 	kfree(info->pixmap.addr);
 	framebuffer_release(info);
+	pci_disable_device(pdev);
 }
 
 static const struct pci_device_id pm2fb_id_table[] = {
-- 
2.25.1

