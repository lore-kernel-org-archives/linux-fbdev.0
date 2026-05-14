Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5160739478D
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778760073; cv=none; b=ab/w+gPZstIg549ja+0KKDY8/l4uxLJCYlRHsKFxYqs2Bj1rDY6pEWt8GWCoX7v2WLeWxwkDImVylGXqDPBsT1QgJEEr0IeH52+qojvFRUK1Zcfh4bPqPwktYR7h0UIkqAz5tsKsovEKvjV/8weCo2RBXBJjjqyKwFKbyxqrH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778760073; c=relaxed/simple;
	bh=wOalxmODc4JSgALGC0wELwUByt7fm0coLkoMsnnMxT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uGdUgg9OmMg9L07L0j1NTsVioenvl3IFPgYnNWz5uv/ZE0WxoDYqJYm30kRHPoXaUmd82vX/ZKy4Eg2bbAuF1wt+H3f2q96PUbAh/3hvndW96+QJHBnDEaoApBVAskBk1mXgivMoK5fF2E3+t1GrniYRQID17UxdvHOzqGtTYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=orwfGnyj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orwfGnyj"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-834f1075805so5493131b3a.2
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778760071; x=1779364871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TrfEwjQI8X+NkXOCcXIf7gPoC4c3rfx8sQVHvDJPS2M=;
        b=orwfGnyjXiuGr7YbpB0FapqaCHmshegvhoLibq8gKQ0Jx6cSqTaFi0R+YU/SP3n1fU
         6H2IfATbzvIvff4w+riGyRDv4Eczv7KIASetNzi45P7yVzsD4gXyKCbmOstdbsWSE1NE
         aRkMjVw12ZfUeP4Eex1yjTPVqWy5UrO7lUuQO0/CxmpdJgTfhDg5CKITcruxYUuq9y1z
         0b8/3HLcOqdjwEh9Y5cUeAeywxmjTsh3CXAf6E41Ow48WD5OiHhFMWVXeqm0iu6y2OaZ
         N4Dq9wmyRZ86LYStMLrg0y5I1v98gTlk9u9DVYhPMZ/R2LueSNUfS95oFAZNnRXv33Zs
         s/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778760071; x=1779364871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrfEwjQI8X+NkXOCcXIf7gPoC4c3rfx8sQVHvDJPS2M=;
        b=m2skq8XWCtvtwdfvXfRdNlhtICFzQ9OgiBUOQyXVMmMMuOOro05VFSPfuAH8618RIT
         TxORCP5YVi6tw2xQnQjx7pXW2wglrg0/0p/1b9nftsiItl4J+y6RuT99ovDBPvEpGU4r
         6delrXNRQekOqK3LU3u0UdqJSej10VOSUx9uIbsLIwwTG7eV2zXw5jipI46yQWM/VFaG
         4KOzDPKO1fotjc7jM34rP7IkFPvglqMVibRJr4yoz8Ia+ycX0Jjh0SUDqcUsdqryKb9M
         98hd3VB6hOUr69WyZC/5kUnpHckDwxQzmfSUZZVN4zWB2kpHS12AJe65ELPXol09HoYy
         xosg==
X-Gm-Message-State: AOJu0YxrdnZqOm9MLvfQy9hxA9jcSk33ZJPb0CZ1/lQQUXggdTb9lw4W
	j5GGK7o1yp1mhFhntSLV+7EAWTSHC5WjCg7fECX8GhsTHEFAH1/9ialu
X-Gm-Gg: Acq92OGobrAhHD2IKLM8GZMlsBKeTWHn+acivoJG0YCRIRuVQoh8E0mQquN9eTkHCpm
	l0cocYw7EEpEjbgftGAC6SBMPDFPC5MO17xP4cEmG/C75HLo4rmrJWyz2pbVpsXeSe1s7i7eqWJ
	Bn9CuCmN6+VPZ/tloFD4X+jRto88E6ag4Y/9/kqoa03KrkOgnSiAFM+4fvmYmB9JDCWUFDiJjk5
	cYl+F54RQ++oFAxZpIXjgcA9iA0c/O5QBuPNqKuwxe4CQO/eNdOSza0jC0HOyiMiqad6OrbE8wu
	/Ba7BonYovsipPuq0ubIAxX1YzQX9sDSHiTg3w8rtuzwlsEHmYEoWYpIoz7nnxDlLYgcQVYreSr
	XtZOp9p54XfIZBr48M4Z90IvKiWRvmvAF1VY8ff0IQNKYBuhJEv+wr4wu+0b7vu6NIKdV4H2kwF
	z0BARgiByu2NxJ8IuqGfXJTWBymrxDrjM+VS5u669BiXJy2WAjig40cEMV8SCCCVTavnkoWeOWy
	Y2PzAAWIA==
X-Received: by 2002:a05:6a00:2347:b0:83e:b443:9651 with SMTP id d2e1a72fcca58-83f0542dbbemr7459819b3a.4.1778760071023;
        Thu, 14 May 2026 05:01:11 -0700 (PDT)
Received: from localhost ([2404:7c00:52:8f0e:aae2:91ff:fe57:5e15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19775c97sm2619734b3a.15.2026.05.14.05.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:01:10 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	devel@driverdev.osuosl.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH] staging: sm750fb: Add suspend checks to copyarea and imageblit
Date: Thu, 14 May 2026 17:46:02 +0545
Message-ID: <20260514120102.71615-1-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lynxfb_ops_fillrect() already checks info->state before accessing
the hardware 2D engine, but lynxfb_ops_copyarea() and
lynxfb_ops_imageblit() do not.

The suspend path calls fb_set_suspend(), which sets the framebuffer
state to FBINFO_STATE_SUSPENDED. Add matching state checks in the
remaining accelerated callbacks for consistency with fillrect().

Assisted-by: Claude Opus 4.6 (Anthropic LLM)
Compile-tested only.

Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 9f3e3d37e..025ac8fe3 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -204,6 +204,9 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	struct sm750_dev *sm750_dev;
 	unsigned int base, pitch, bpp;
 
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+
 	par = info->par;
 	sm750_dev = par->dev;
 
@@ -239,6 +242,9 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
 
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+
 	par = info->par;
 	sm750_dev = par->dev;
 	/*
-- 
2.54.0

