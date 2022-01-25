Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BA0C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Jan 2022 09:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457927AbiAYJRZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:17:25 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36618 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1456728AbiAYJMl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Jan 2022 04:12:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 44B251F3B6;
        Tue, 25 Jan 2022 09:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643101946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5o2faQlOKiyq5cv9yZez58oi/sJWMWZMrw7MryH/28=;
        b=o+9nekmRv42hp0YUUl8smnuNN/y37EUf4Kdk5icrM37mjj7FbT+q9QsK/D9FuLFxj37CRi
        0uGt9a0fl1wMSkWmnrKKgw6wIwfoArqTMhpkVct5Ja3Qw8nxZlNOgZDRWHzdA/GbIlsm48
        xcpduVpSqjH11tSDom7zXpus598YvRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643101946;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5o2faQlOKiyq5cv9yZez58oi/sJWMWZMrw7MryH/28=;
        b=IY7X6QLuIQcBK3S94bZ+5qIW0vd06lpNhgSI2KjhtJzJ6IGkd2+wL4uOEhh8TSEx/RsBrW
        eZdx/zsqMgpPmpDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFE5F13DA2;
        Tue, 25 Jan 2022 09:12:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oGG6Ofm+72GGQAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 25 Jan 2022 09:12:25 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     zackr@vmware.com, javierm@redhat.com, jfalempe@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de,
        hdegoede@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/5] fbdev/simplefb: Request memory region in driver
Date:   Tue, 25 Jan 2022 10:12:21 +0100
Message-Id: <20220125091222.21457-5-tzimmermann@suse.de>
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
	* store memory region in struct for later cleanup (Javier)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/simplefb.c | 65 +++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 57541887188b..94fc9c6d0411 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -66,16 +66,36 @@ static int simplefb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 	return 0;
 }
 
-struct simplefb_par;
+struct simplefb_par {
+	u32 palette[PSEUDO_PALETTE_SIZE];
+	struct resource *mem;
+#if defined CONFIG_OF && defined CONFIG_COMMON_CLK
+	bool clks_enabled;
+	unsigned int clk_count;
+	struct clk **clks;
+#endif
+#if defined CONFIG_OF && defined CONFIG_REGULATOR
+	bool regulators_enabled;
+	u32 regulator_count;
+	struct regulator **regulators;
+#endif
+};
+
 static void simplefb_clocks_destroy(struct simplefb_par *par);
 static void simplefb_regulators_destroy(struct simplefb_par *par);
 
 static void simplefb_destroy(struct fb_info *info)
 {
+	struct simplefb_par *par = info->par;
+	struct resource *mem = par->mem;
+
 	simplefb_regulators_destroy(info->par);
 	simplefb_clocks_destroy(info->par);
 	if (info->screen_base)
 		iounmap(info->screen_base);
+
+	if (mem)
+		release_mem_region(mem->start, resource_size(mem));
 }
 
 static const struct fb_ops simplefb_ops = {
@@ -169,20 +189,6 @@ static int simplefb_parse_pd(struct platform_device *pdev,
 	return 0;
 }
 
-struct simplefb_par {
-	u32 palette[PSEUDO_PALETTE_SIZE];
-#if defined CONFIG_OF && defined CONFIG_COMMON_CLK
-	bool clks_enabled;
-	unsigned int clk_count;
-	struct clk **clks;
-#endif
-#if defined CONFIG_OF && defined CONFIG_REGULATOR
-	bool regulators_enabled;
-	u32 regulator_count;
-	struct regulator **regulators;
-#endif
-};
-
 #if defined CONFIG_OF && defined CONFIG_COMMON_CLK
 /*
  * Clock handling code.
@@ -405,7 +411,7 @@ static int simplefb_probe(struct platform_device *pdev)
 	struct simplefb_params params;
 	struct fb_info *info;
 	struct simplefb_par *par;
-	struct resource *mem;
+	struct resource *res, *mem;
 
 	/*
 	 * Generic drivers must not be registered if a framebuffer exists.
@@ -430,15 +436,28 @@ static int simplefb_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
 		dev_err(&pdev->dev, "No memory resource\n");
 		return -EINVAL;
 	}
 
+	mem = request_mem_region(res->start, resource_size(res), "simplefb");
+	if (!mem) {
+		/*
+		 * We cannot make this fatal. Sometimes this comes from magic
+		 * spaces our resource handlers simply don't know about. Use
+		 * the I/O-memory resource as-is and try to map that instead.
+		 */
+		dev_warn(&pdev->dev, "simplefb: cannot reserve video memory at %pR\n", res);
+		mem = res;
+	}
+
 	info = framebuffer_alloc(sizeof(struct simplefb_par), &pdev->dev);
-	if (!info)
-		return -ENOMEM;
+	if (!info) {
+		ret = -ENOMEM;
+		goto error_release_mem_region;
+	}
 	platform_set_drvdata(pdev, info);
 
 	par = info->par;
@@ -495,6 +514,9 @@ static int simplefb_probe(struct platform_device *pdev)
 			     info->var.xres, info->var.yres,
 			     info->var.bits_per_pixel, info->fix.line_length);
 
+	if (mem != res)
+		par->mem = mem; /* release in clean-up handler */
+
 	ret = register_framebuffer(info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
@@ -513,6 +535,9 @@ static int simplefb_probe(struct platform_device *pdev)
 	iounmap(info->screen_base);
 error_fb_release:
 	framebuffer_release(info);
+error_release_mem_region:
+	if (mem != res)
+		release_mem_region(mem->start, resource_size(mem));
 	return ret;
 }
 
-- 
2.34.1

