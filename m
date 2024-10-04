Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D63B1862;
	Fri,  4 Oct 2024 01:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728006244; cv=none; b=Di4HYa8axFBapXezOwD4MeCrPijRfLEi6HQUfWUWWchBkHQrF6vql7YnDgPViQyQ77Sy1v4NB8R5VvCRyj3e2BK2ifEuOhHYGJU0cDHT8Oe4ZZynw2fGhOgRMhgvrqzLOYIJYepoHdMKmmariIMuqrGxufOmOvR5LCZa2lnhQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728006244; c=relaxed/simple;
	bh=kKiNpO/7wxBRneifIFDF+QBEIUYtc/mXbs5Fl64uxSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mutH9PL9PeB9vVMAcymAV9Hd9PCNeM8PTaGXzkrlK5VJ1X4D7WlCkidIjIr5mnh89Csd/vWKTkLAUyf9hnXJ/jSRe+9rHM6hbs9z2CrtYOPulN/miqeU80mxdmksJYOo/4CSa47H+t92cvoBCL9sHLHDDdkdoFc0WfNGr5IoC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VMOUPCPJ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VMOUPCPJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Jp8RG
	qANQrLfCe3AaUb/fHkN8BRM9XGU3Q2eDcKrytc=; b=VMOUPCPJT4QqgQveKESkU
	H+HtMU85b2QO2l6E0nf7CzrFKrQI+hU3PY6JQ3kjmTOnjIxM34fxVROxsKwPlTy4
	gZlujiH9Q0NhglfKvLzF9bX5obP0cBJ+Nnym0xDd4d6OxRacvpp1ZkcAbX/RKU2R
	MaywJ7zu/jEdW21rnVhxWY=
Received: from fedora.. (unknown [36.5.132.7])
	by gzsmtp4 (Coremail) with SMTP id sygvCgB3QtRVSP9mnEvTAQ--.26831S2;
	Fri, 04 Oct 2024 09:43:49 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: deller@gmx.de
Cc: tzimmermann@suse.de,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: clps711x-fb: Remove dead code
Date: Fri,  4 Oct 2024 09:43:48 +0800
Message-ID: <20241004014349.435006-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:sygvCgB3QtRVSP9mnEvTAQ--.26831S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur43Zry7XF18AFW8JFWrXwb_yoW3uFbEk3
	ykurZ7X34qyr1rKr1kGa1DZrW0y39rXrZa9F1DtFZak347uFWrXFyUZr4xW3yUWr48CFn3
	WF9Ygr4rZryfCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjCPftUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYBpuamb-Nh0GawACsj

The code can never be reached: unregister_framebuffer(info);

Fixes: 36462ac19308 ("fbdev: clps711x-fb: Replace check_fb in favor of struct fb_info.lcd_dev")
Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 drivers/video/fbdev/clps711x-fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index 9e3df1df5ac4..b57134bc63e7 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -332,8 +332,6 @@ static int clps711x_fb_probe(struct platform_device *pdev)
 
 	return 0;
 
-	unregister_framebuffer(info);
-
 out_fb_dealloc_cmap:
 	regmap_update_bits(cfb->syscon, SYSCON_OFFSET, SYSCON1_LCDEN, 0);
 	fb_dealloc_cmap(&info->cmap);
-- 
2.46.2

