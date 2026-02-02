Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEBD2DCF58;
	Mon,  2 Feb 2026 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026269; cv=none; b=W+GRowxMOxfUgzi+PxFhl95r9t9pAZSfgJ7W19JZhev5MmsQIz40lmizSUgrsjZa9Qusji2L/p0CdGsz24xtHlTYaAYYx71xQm5G9ZeJlGF6fxyv/tk8iZl7Kt6c99UrkXv5dkEsfdmjZ4rvrBC7U9GzeTSQEEwDUD/tOvN6e8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026269; c=relaxed/simple;
	bh=AkL7o0Wfw7iHssc02m/M4/4sZ3UaU2Dt9iL/rr6LdKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MN+9A5DVT2nHw8bYvwOqsbslr6oS2mABODzsxXvsqdNR8lJFDALTrzOJdAmDLM2zhGJkQkYraUz6h0rAwNHzsJAfdZZDytVtBfVDMOR5poMn4SpQ7JEKU0JDankltJJ938x4vX+XR2jczv1HkQjqnC7hb6oHHdUbFpwM+81y1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTloF83+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTloF83+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEFDC116C6;
	Mon,  2 Feb 2026 09:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026269;
	bh=AkL7o0Wfw7iHssc02m/M4/4sZ3UaU2Dt9iL/rr6LdKE=;
	h=From:To:Cc:Subject:Date:From;
	b=OTloF83+Tj4wg4wWmrmdfDbFCpbyfYyWlXRhixx9hraDlWC/KUpnFqDW3JnUfOIHK
	 ujDFeyEZZRGBfKp6t8GPdrrUF/jwtXoTpuEgqGO9jVjz+38ski1sjIlH+uBjfFPmZE
	 pV8OVQXdo9sZ8kRMUMrfArN5Y8awQeCgR42uLn2iC641t38WPWrnXW8KgEGYgx0NPX
	 lfREMIBjs18NB7d5M8L0j8Orcjo/wpV7HYjTk34KkTcxzGvwVL0b6ZZTlK/7ts8Fuu
	 nQq04lGMbtx9WN9QJHNXjUqVki6ufB9We0LZHRSAVX8SHmKutHP4CfEgpzewOSbTC+
	 t6sktPhNb1W/A==
From: Arnd Bergmann <arnd@kernel.org>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Noralf Tronnes <notro@tronnes.org>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Chintan Patel <chintanlike@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jianglei Nie <niejianglei2021@163.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: fix dev_info() device arguments
Date: Mon,  2 Feb 2026 10:57:37 +0100
Message-Id: <20260202095743.1309162-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_FB_DEVICE is disabled, the fbtft driver fails to
build with:

In file included from include/linux/device.h:15,
                 from drivers/staging/fbtft/fbtft-core.c:18:
drivers/staging/fbtft/fbtft-core.c: In function 'fbtft_fb_setcolreg':
drivers/staging/fbtft/fbtft-core.c:368:21: error: 'struct fb_info' has no member named 'dev'
  368 |         dev_dbg(info->dev,
drivers/staging/fbtft/fbtft-core.c:394:21: error: 'struct fb_info' has no member named 'dev'
  394 |         dev_dbg(info->dev, "%s(blank=%d)\n",
drivers/staging/fbtft/fbtft-core.c:796:25: error: 'struct fb_info' has no member named 'dev'
  796 |         dev_info(fb_info->dev,
drivers/staging/fbtft/fbtft-core.c:796:9: note: in expansion of macro 'dev_info'
  796 |         dev_info(fb_info->dev,

Use fb_info->device instead of fb_info->dev here, which appears
to be what was intended in the first place.

Fixes: c296d5f9957c ("staging: fbtft: core support")
Fixes: bc9f9cb85a7d ("staging: fbtft: Make FB_DEVICE dependency optional")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/fbtft/fbtft-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 15affe6f1537..41326b1df733 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -365,7 +365,7 @@ static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red,
 	unsigned int val;
 	int ret = 1;
 
-	dev_dbg(info->dev,
+	dev_dbg(info->device,
 		"%s(regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X)\n",
 		__func__, regno, red, green, blue, transp);
 
@@ -391,7 +391,7 @@ static int fbtft_fb_blank(int blank, struct fb_info *info)
 	struct fbtft_par *par = info->par;
 	int ret = -EINVAL;
 
-	dev_dbg(info->dev, "%s(blank=%d)\n",
+	dev_dbg(info->device, "%s(blank=%d)\n",
 		__func__, blank);
 
 	if (!par->fbtftops.blank)
@@ -793,7 +793,7 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 	if (spi)
 		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
 			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
-	dev_info(fb_info->dev,
+	dev_info(fb_info->device,
 		 "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
 		 fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
 		 fb_info->fix.smem_len >> 10, text1,
-- 
2.39.5

