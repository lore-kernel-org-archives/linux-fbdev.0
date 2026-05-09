Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D82F1FEC;
	Sat,  9 May 2026 18:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778351926; cv=none; b=jL2sSEBGH+cwH5UK0ekb5U2EanYTUpyvXqKAk4Z7cDkEj+NtBI1+CDvtHdubUXFQqSyTMtczQecvYK/h2zjF+i1wEZSP4nuX7uJqYB6IKshn+jZfxlE4Dknyosv/WH3vwf1nXtEFOH33YwtIt6QJhroSpblHEuseNq1TUhYch38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778351926; c=relaxed/simple;
	bh=Y/xnyxEFbHZBKB2MVM4dgWEgVG1WzqN3nPRzGJcwfVI=;
	h=Message-Id:From:Date:Subject:To:Cc; b=B+o4VqvxOyZ1ryEuZRWeguBBpEoqXb/11Qxwjg3JfLXluUAft65hkD+wPEshPWhjxdr3iscx7X2TA/zXu4jt6DfxEq80ElOwCIMfppdjLGgWFtbLrPThYiZZ7iE0Wh5nqTHxzOa0ICRvhFUFvPPuSFG9MfNwPeOgvqQrarTgsSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noirlang.tr; spf=pass smtp.mailfrom=noirlang.tr; dkim=pass (1024-bit key) header.d=noirlang.tr header.i=@noirlang.tr header.b=QlDCuGws; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noirlang.tr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noirlang.tr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=noirlang.tr header.i=@noirlang.tr header.b="QlDCuGws"
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id C6B8E816E2;
	Sat, 09 May 2026 21:30:51 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:2310:0:640:2452:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id D59008066C;
	Sat, 09 May 2026 21:30:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (smtp) with ESMTPSA id dUMYMmJYG0U0-BqkXfeyP;
	Sat, 09 May 2026 21:30:41 +0300
Message-Id: <20260509213041.BqkXfeyP@66089470-6549-4c3e-ae4b-211f3f79ee1e>
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noirlang.tr; s=mail;
	t=1778351441; bh=Bp1lpEdGx5nyLUEtZLqEmurnQKaZI2oN+0ztgGaM980=;
	h=Cc:Date:To:Subject:From;
	b=QlDCuGwsT5jyUpLK8gDBBtdZODJBr8CQb5L/+uem7FC9HRG2chmeOOdZzKirn/YOG
	 Z3iGg1gVOWu9r4LBQDSd1M9dNkbDTF3yP5JYTfml8z/f5h+MkezEHOA/Pp0cSxKiH7
	 er9yLXllR//RHyKFiM9o9oJol8Wuk8yLJq+o88eM=
Authentication-Results: mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net; dkim=pass header.i=@noirlang.tr
From: Melih Emik <melihemik@noirlang.tr>
Date: Sat, 9 May 2026 21:27:44 +0300
Subject: [PATCH] fbdev: make sh_mobile_lcdc independent of FB_DEVICE
To: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Wei Liu <wei.liu@kernel.org>,
 Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 Zsolt Kajtar <soci@c64.rulez.org>,
 Mukesh Rathor <mrathor@linux.microsoft.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

CONFIG_FB_DEVICE controls the fbdev character device interface. SH Mobile
LCDC does not need that interface to build framebuffer support. Tying the
driver option to FB_DEVICE unnecessarily prevents it from being enabled
where device node support is disabled.

Relax the Kconfig dependency so the driver can be built independently of
the fbdev device interface.

Signed-off-by: Melih Emik <melihemik@noirlang.tr>
---
 drivers/video/fbdev/Kconfig            | 1 -
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 085d3a202148..762c4369e00f 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1521,7 +1521,6 @@ config FB_SH_MOBILE_LCDC
 	tristate "SuperH Mobile LCDC framebuffer support"
 	depends on FB && HAVE_CLK && HAS_IOMEM
 	depends on SUPERH || COMPILE_TEST
-	depends on FB_DEVICE
 	depends on BACKLIGHT_CLASS_DEVICE
 	select FB_BACKLIGHT
 	select FB_DEFERRED_IO
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 72969fe8e513..b522b76b402d 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1511,7 +1511,7 @@ sh_mobile_lcdc_overlay_fb_unregister(struct sh_mobile_lcdc_overlay *ovl)
 {
 	struct fb_info *info = ovl->info;
 
-	if (info == NULL || info->dev == NULL)
+	if (!info || !refcount_read(&info->count))
 		return;
 
 	unregister_framebuffer(ovl->info);
@@ -1983,7 +1983,7 @@ static const struct fb_ops sh_mobile_lcdc_ops = {
 static void
 sh_mobile_lcdc_channel_fb_unregister(struct sh_mobile_lcdc_chan *ch)
 {
-	if (ch->info && ch->info->dev)
+	if (ch->info && refcount_read(&ch->info->count))
 		unregister_framebuffer(ch->info);
 }
 
@@ -2640,7 +2640,9 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 static struct platform_driver sh_mobile_lcdc_driver = {
 	.driver		= {
 		.name		= "sh_mobile_lcdc_fb",
+#ifdef CONFIG_FB_DEVICE
 		.dev_groups	= overlay_sysfs_groups,
+#endif
 		.pm		= &sh_mobile_lcdc_dev_pm_ops,
 	},
 	.probe		= sh_mobile_lcdc_probe,
-- 
2.54.0

