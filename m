Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3231FC43219
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Jan 2022 09:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1458017AbiAYJRp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:17:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36592 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1456726AbiAYJMl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Jan 2022 04:12:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC9201F3A0;
        Tue, 25 Jan 2022 09:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643101945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rAKAvI4dXY/7IH6KZFQKwWFIIjeH+NB1MSCR2pDGsIg=;
        b=Yuzuz64sRKemBmXtLoZZDAmydZ+3elhJ2xiFqtMx/H4IntsoBjfce344jUBVeeUMr6dEUl
        96yZfscFh4Z0hHW20thQtSkmvb+1fi1zu3slngqFM53J86lfgwY+uSL8VhFkMqxa2LVE4T
        nzNu5ME9RVFMjUKqCD2cSpjjEh2OpXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643101945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rAKAvI4dXY/7IH6KZFQKwWFIIjeH+NB1MSCR2pDGsIg=;
        b=4UHngqbUT2pb55fXTeY/bKenOuZAD8HhPBaPSi6ek4350GkANvBgpdS2Swrn/WQNVn3qXe
        rvUi6y7k5T88m0Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD49913DA3;
        Tue, 25 Jan 2022 09:12:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id COUqKfm+72GGQAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 25 Jan 2022 09:12:25 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     zackr@vmware.com, javierm@redhat.com, jfalempe@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de,
        hdegoede@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/5] drm/simpledrm: Request memory region in driver
Date:   Tue, 25 Jan 2022 10:12:20 +0100
Message-Id: <20220125091222.21457-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125091222.21457-1-tzimmermann@suse.de>
References: <20220125091222.21457-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Requesting the framebuffer memory in simpledrm marks the memory
range as busy. This used to be done by the firmware sysfb code,
but the driver is the correct place.

v2:
	* use I/O memory if request_mem_region() fails (Jocelyn)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/tiny/simpledrm.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 04146da2d1d8..d191e87a37b5 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -526,21 +526,33 @@ static int simpledrm_device_init_mm(struct simpledrm_device *sdev)
 {
 	struct drm_device *dev = &sdev->dev;
 	struct platform_device *pdev = sdev->pdev;
-	struct resource *mem;
+	struct resource *res, *mem;
 	void __iomem *screen_base;
 	int ret;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem)
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
 		return -EINVAL;
 
-	ret = devm_aperture_acquire_from_firmware(dev, mem->start, resource_size(mem));
+	ret = devm_aperture_acquire_from_firmware(dev, res->start, resource_size(res));
 	if (ret) {
 		drm_err(dev, "could not acquire memory range %pr: error %d\n",
-			mem, ret);
+			res, ret);
 		return ret;
 	}
 
+	mem = devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
+				      sdev->dev.driver->name);
+	if (!mem) {
+		/*
+		 * We cannot make this fatal. Sometimes this comes from magic
+		 * spaces our resource handlers simply don't know about. Use
+		 * the I/O-memory resource as-is and try to map that instead.
+		 */
+		drm_warn(dev, "could not acquire memory region %pr\n", res);
+		mem = res;
+	}
+
 	screen_base = devm_ioremap_wc(&pdev->dev, mem->start,
 				      resource_size(mem));
 	if (!screen_base)
-- 
2.34.1

