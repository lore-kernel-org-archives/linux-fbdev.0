Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5E1C93AF;
	Tue, 27 Aug 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772364; cv=none; b=jTk3XwJFYM6JEFv+m8oOsr1mjDYu5WJe3tmmD3Ls8y7BVU43gAJUhYG8YawCf8OJtTkcEjLgVbevjvJrDY5Nz5O1EfScfotAp6kVm/6+8H/Reoymff88/MkCCT6DxKdu4s6J+cgm7VdmbHKEnZO6OqFNL5fPT6UKDGG/rlLzJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772364; c=relaxed/simple;
	bh=iZHa8sxD6VzxS56Wiia/CBINwT4dds6hEws/m9z7Qyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mi8RpqW0k15Hy5un+XakKbSaXGyTixi9NR3VpwTVz7tdjDNkJaOHYsr++lqvLumrVSSLPL7t+fMh38Mw5xeJgo1XyYDnvef9Kk449Ndfy6qw77OqnZCg1Ixa6xqDfGir8tlBjSZREIuhnaA53oDObj+5BEV2bev0WueL3LLs1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AXL8RrMW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AXL8RrMW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724772359;
	bh=iZHa8sxD6VzxS56Wiia/CBINwT4dds6hEws/m9z7Qyc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AXL8RrMWVHeeUiMpd7h0QA1RqW47PggK65uqz7shee0v+B7fcNQFHgqv7XwuKAuOb
	 8WPE8EgxznKRIebDmPSnM0XH+5tEDao4he2IjenlIupKO9zGOwcJh74RZu0xDG3Agl
	 eRh0OlzeJ8gClS1utkoS5jI4ZpbqNRnuCkO4CG1E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 27 Aug 2024 17:25:15 +0200
Subject: [PATCH 4/5] fbdev/efifb: Use devm_register_framebuffer()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240827-efifb-sysfs-v1-4-c9cc3e052180@weissschuh.net>
References: <20240827-efifb-sysfs-v1-0-c9cc3e052180@weissschuh.net>
In-Reply-To: <20240827-efifb-sysfs-v1-0-c9cc3e052180@weissschuh.net>
To: Peter Jones <pjones@redhat.com>, Helge Deller <deller@gmx.de>, 
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724772358; l=1590;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iZHa8sxD6VzxS56Wiia/CBINwT4dds6hEws/m9z7Qyc=;
 b=dXtcqh+lvUHCooHxFhjBUo0CAWGLafEFqjCKX5bR6GiC4GIpeihEQY2Ft7LEsBzbXr6lrLEQt
 OuKiWsfDc1OCz9k6JOIPtzVRz0aq6ox8fYZMewi8PR59ICxo746jkCO
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This simplifies the error handling.
Also the drvdata slot is now unused and can be used for other usecases.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/video/fbdev/efifb.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index d36b95856dd0..7215973ef602 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -449,7 +449,6 @@ static int efifb_probe(struct platform_device *dev)
 		err = -ENOMEM;
 		goto err_release_mem;
 	}
-	platform_set_drvdata(dev, info);
 	par = info->par;
 	info->pseudo_palette = par->pseudo_palette;
 
@@ -572,7 +571,7 @@ static int efifb_probe(struct platform_device *dev)
 		pr_err("efifb: cannot acquire aperture\n");
 		goto err_fb_dealloc_cmap;
 	}
-	err = register_framebuffer(info);
+	err = devm_register_framebuffer(&dev->dev, info);
 	if (err < 0) {
 		pr_err("efifb: cannot register framebuffer\n");
 		goto err_fb_dealloc_cmap;
@@ -595,21 +594,12 @@ static int efifb_probe(struct platform_device *dev)
 	return err;
 }
 
-static void efifb_remove(struct platform_device *pdev)
-{
-	struct fb_info *info = platform_get_drvdata(pdev);
-
-	/* efifb_destroy takes care of info cleanup */
-	unregister_framebuffer(info);
-}
-
 static struct platform_driver efifb_driver = {
 	.driver = {
 		.name = "efi-framebuffer",
 		.dev_groups = efifb_groups,
 	},
 	.probe = efifb_probe,
-	.remove_new = efifb_remove,
 };
 
 builtin_platform_driver(efifb_driver);

-- 
2.46.0

