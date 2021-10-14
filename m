Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74039C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 14 Oct 2021 13:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F80610CC
	for <linux-fbdev@archiver.kernel.org>; Thu, 14 Oct 2021 13:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhJNNZd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 14 Oct 2021 09:25:33 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:24314 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhJNNZc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 14 Oct 2021 09:25:32 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HVVNH3zCYzQpZ6;
        Thu, 14 Oct 2021 21:18:55 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 21:23:24 +0800
Received: from huawei.com (10.175.104.82) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 21:23:23 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <steve.glendinning@shawell.net>, <FlorianSchandinat@gmx.de>,
        <gregkh@suse.de>
CC:     <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] video: smscufx: Fix null-ptr-deref in ufx_usb_probe()
Date:   Thu, 14 Oct 2021 21:22:31 +0800
Message-ID: <20211014132231.555138-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

I got a null-ptr-deref report:

BUG: kernel NULL pointer dereference, address: 0000000000000000
...
RIP: 0010:fb_destroy_modelist+0x38/0x100
...
Call Trace:
 ufx_usb_probe.cold+0x2b5/0xac1 [smscufx]
 usb_probe_interface+0x1aa/0x3c0 [usbcore]
 really_probe+0x167/0x460
...
 ret_from_fork+0x1f/0x30

If fb_alloc_cmap() fails in ufx_usb_probe(), fb_destroy_modelist() will
be called to destroy modelist in the error handling path. But modelist
has not been initialized yet, so it will result in null-ptr-deref.

Initialize modelist before calling fb_alloc_cmap() to fix this bug.

Fixes: 3c8a63e22a08 ("Add support for SMSC UFX6000/7000 USB display adapters")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/video/fbdev/smscufx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index bfac3ee4a642..28768c272b73 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1656,6 +1656,7 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	info->par = dev;
 	info->pseudo_palette = dev->pseudo_palette;
 	info->fbops = &ufx_ops;
+	INIT_LIST_HEAD(&info->modelist);
 
 	retval = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (retval < 0) {
@@ -1666,8 +1667,6 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	INIT_DELAYED_WORK(&dev->free_framebuffer_work,
 			  ufx_free_framebuffer_work);
 
-	INIT_LIST_HEAD(&info->modelist);
-
 	retval = ufx_reg_read(dev, 0x3000, &id_rev);
 	check_warn_goto_error(retval, "error %d reading 0x3000 register from device", retval);
 	dev_dbg(dev->gdev, "ID_REV register value 0x%08x", id_rev);
-- 
2.25.1

