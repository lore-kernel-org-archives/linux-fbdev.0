Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E851DFDAB
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Oct 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612145; cv=none; b=G9WMSGHUiwkpez/kTyNR0zAOi7ed+gixl+131LrPQm3QY5OjH3UNnzVBiO9+KOpYFZQtqzSjSuQNkmXzJ/Bjr8qxQfVMB6QO64XuqJjw2mjmnzUN6VInrPCgeUJbE68JaQhWbab3jWT3Qvfn63RluUXgNhRUE7kBJXq8DDJr4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612145; c=relaxed/simple;
	bh=4r1z6HtWUnySZNvtvG1gblMCYFFQ/7oF0GQ1wyfk/fA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mA5uUfyzd8ve+ixhnOLPgSYHxMLO5o0MSHz0HDVMpVBxHIrQbKgVLMR77m0OCE9F7a2O7v/nbIP4JaxSOnkDPhRVYO9303a6OrkxzQfd98+5I8f9f1YM8jfhwKVT2eVcHLA1KyDsuep00t+Mnb5m9KqiYNxZEraWcCvZZ9XQYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSYeA3HF; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSYeA3HF"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-88fa5974432so70129685a.2
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Oct 2025 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760612142; x=1761216942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tUv0dDyeU7y7WspWVqJNMNUdztGgUwvGxjkgJqZoga0=;
        b=bSYeA3HFh6BZtr3WrjNAhb9VuapbTjNDYM+wBozoQ2utR6P447I2KsR39hu61fsvX9
         Xv9Scp6E5jkxsE8mh4ne5gBXUBXK9+kA5fXFaX+SDxZEc71Ya5lntxedL9rsMhvgz46a
         yfCERzbQEjF5aD5QZyIR9gNGDJddS4wplrmIQ/0jncJ0O+zG+jKsq6R9P5M6jb17+KiY
         hcL0wD4++DzrfMppgfuCNeMA5GqAvc4u80UrIVBkoG1drjyWNNLDYtWt1oVLk2L7IRLK
         x6Awm13jgFuR1XdZ/BwmaicopjAn73PXHo0bGKWFX1nbYPxQlmAI4WDVD8Gaoc88cgVN
         2dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760612142; x=1761216942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUv0dDyeU7y7WspWVqJNMNUdztGgUwvGxjkgJqZoga0=;
        b=S6vHjzJeFEsIFk+LzzmNnzUiv9EyYIYuy+41WuBEqaG1AE0huz6MihPEWXHeW34j1e
         jj/Pn1/s9zo+7PbFKr+ZUqP7NHu9CgKTZtvM6BS+00CQ4nnj/UqbvvhpNOJiXAIYVGjN
         EWkfZ3udLN+kb9q0+MMs3tZFmM9nmxd9x/ChDA+wJcF32cq0HTd7veXfcMyl/1QYWMC7
         dFmzmTPnHbHAST9ux1N/nS1GxJaQoTcjc9mftuT0UBNmxt5sXNEx+EIKo81d595wTR/D
         CCwf9bVUij8/qpGmfBE3nAjmC5uFvBhqaZMP1TJT1hk5EXIx4qQJQMr2C3kgH6S++En8
         Eeqw==
X-Forwarded-Encrypted: i=1; AJvYcCX904fmJuzaVxrYGDbI401IeUg1rysFlHABCyh7KJF8TlFVpW1UPQL3FGQozoqdvrNBtfYLzKFbE6AI9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgZktMjH4ACqTuuPSnXE0t70bcCnf6p3Q/wCRXi4pnZV3GVcbd
	Xpzjvn/sRXvKe8dI8SAnxIwn7Ss5TzrcG2R6XALTqwmzS0Swa6NsysG2
X-Gm-Gg: ASbGncvmHRRVUeYKcU7+4EjoFtpraJ06UzXNB7YHidHWvqvnNAxpO/sY7XNgUpmscTh
	sJmVH/6tdncbqA3hgiHD3TdA2PUU509xt5GWFkbI/WhJreRLP5zKYLOXcoUcPJmj0F69h+MIvpn
	vJRK7dUtVGvN0KELDJ++5rHC5N+GrytZ0nJw4UreIVrKYfWhReuNWvo0gGdDJ9U6muku4xT7Wkm
	p1+Ul0cTIgDmVl0w2Dwn6uWnl39ORW09e+k7EQ6YCYjljub/+OZ9HtBNlsIze0df2wf2zh9/QB1
	ICCb92Mnb261GMQ0JgJdoMhYCIxTwQOWiW5MYVohXY5IqSSsRg/E/0nRN3uSykBKMkOhogiw+rt
	PTiQsuP+gAT3C7eSD/kn45KPeHYwwzexziMT/kVHXCxXZgWJor6HMkxGJC956PNrT2o/YzHpZ6k
	Zf+RJeCmctiOeqm5lY5Zf29Wen4r6yVaKwD5OuPtO9bE8=
X-Google-Smtp-Source: AGHT+IHSbCNA4gKXGQ79Apbh6UBdRta7p0DwiGGgBt4gE+gkwTjNxJ3W0SoZh5OSP96PJHmnX5Q4Lw==
X-Received: by 2002:a05:620a:2982:b0:827:1bda:ca68 with SMTP id af79cd13be357-883544f4c00mr3625404985a.46.1760612142108;
        Thu, 16 Oct 2025 03:55:42 -0700 (PDT)
Received: from kernel-internship-machine.. ([143.110.209.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f35c67577sm173681985a.25.2025.10.16.03.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:55:41 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: deller@gmx.de,
	soci@c64.rulez.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH] fbdev: vga16fb: replace printk() with dev_*() in probe
Date: Thu, 16 Oct 2025 10:54:46 +0000
Message-Id: <20251016105446.3646544-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dev_*() with &dev->dev and drop the hard-coded prefix. Keep
original severities. No functional change.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/video/fbdev/vga16fb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index eedab14c7d51..85852bca2d23 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1319,7 +1319,7 @@ static int vga16fb_probe(struct platform_device *dev)
 	if (ret)
 		return ret;
 
-	printk(KERN_DEBUG "vga16fb: initializing\n");
+	dev_dbg(&dev->dev, "initializing\n");
 	info = framebuffer_alloc(sizeof(struct vga16fb_par), &dev->dev);
 
 	if (!info) {
@@ -1331,12 +1331,12 @@ static int vga16fb_probe(struct platform_device *dev)
 	info->screen_base = (void __iomem *)VGA_MAP_MEM(VGA_FB_PHYS_BASE, 0);
 
 	if (!info->screen_base) {
-		printk(KERN_ERR "vga16fb: unable to map device\n");
+		dev_err(&dev->dev, "unable to map device\n");
 		ret = -ENOMEM;
 		goto err_ioremap;
 	}
 
-	printk(KERN_INFO "vga16fb: mapped to 0x%p\n", info->screen_base);
+	dev_info(&dev->dev, "mapped to 0x%p\n", info->screen_base);
 	par = info->par;
 
 	par->isVGA = screen_info_video_type(si) == VIDEO_TYPE_VGAC;
@@ -1364,13 +1364,13 @@ static int vga16fb_probe(struct platform_device *dev)
 	i = (info->var.bits_per_pixel == 8) ? 256 : 16;
 	ret = fb_alloc_cmap(&info->cmap, i, 0);
 	if (ret) {
-		printk(KERN_ERR "vga16fb: unable to allocate colormap\n");
+		dev_err(&dev->dev, "unable to allocate colormap\n");
 		ret = -ENOMEM;
 		goto err_alloc_cmap;
 	}
 
 	if (vga16fb_check_var(&info->var, info)) {
-		printk(KERN_ERR "vga16fb: unable to validate variable\n");
+		dev_err(&dev->dev, "unable to validate variable\n");
 		ret = -EINVAL;
 		goto err_check_var;
 	}
@@ -1381,7 +1381,7 @@ static int vga16fb_probe(struct platform_device *dev)
 	if (ret)
 		goto err_check_var;
 	if (register_framebuffer(info) < 0) {
-		printk(KERN_ERR "vga16fb: unable to register framebuffer\n");
+		dev_err(&dev->dev, "unable to register framebuffer\n");
 		ret = -EINVAL;
 		goto err_check_var;
 	}
-- 
2.34.1

