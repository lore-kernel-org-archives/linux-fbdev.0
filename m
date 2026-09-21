Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D44E66C9
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014479; cv=none; b=H7Y2V2a0ah57MKdIiKkvERSiY89oXmlY6igCbPPJTUI2bGW+tkYQSTPm9XBbjGT1gnh11czIKLBQUpFaV6jum9Z4IE8CswEoA3y7raPP5/9eE3hhADIgWfhR0U5jA2ZXpi1H4pF0Z84bv2SLDfcr6XFLJkwIcDj7f6dlPV0RC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014479; c=relaxed/simple;
	bh=BhklwgvkpUrE+CC+vXjr1M0j6bhRvxIIJDO2uMkw5I0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJ247Vymx12lOMkr6h4hBeMNXD2VVYpVs2IAJZyZEOwHsQ8dOtMZdblDAM+se/ZWks9GSIrKhDkfYd/ycWhFY477aAswHMU1oe9Lbuuk3FSVcFAMZXK9QIF0Eg5hBMamtPb+qS2Vx8qqtvBPw3mO4A89VMzd+92H1bzCENT/RYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHv3lfSe; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHv3lfSe"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49fd4ea3409so5010865e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 11:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790014476; x=1790619276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8njTdDuR2VjcLI0zLlnQh6RcubDIwEA0WzrR3t+nYKc=;
        b=sHv3lfSeMeG2AjFf9qcoqs2YuQUC1YVlK19hpSPlOGXBFudL/boTMcNub5wHs50y43
         4nqYG7gY8L2db4DfXmj8jAVZbSmOJAB9S7cppiLsaywuUYQJs99VZCamfo/OF8FIVfVs
         QwB+8ZKEc9Jtu4SI0j0eRzD0upcW0KebS5wbhIHbBBscfD254+1QQYsuU/cIo6KB6SkV
         lnmoFxp9tIOUv16VqNqqO0K/zfk8yDADdV60JazkotxnzIqJq84GkIRIxG/kVBUA09Cb
         ed/bnDuux6J/pLxhw0TPUUURO9tQ5P+qFbMfjbzJROhZcwvWRswkiAPsQJhSE/bglNQS
         gamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790014476; x=1790619276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8njTdDuR2VjcLI0zLlnQh6RcubDIwEA0WzrR3t+nYKc=;
        b=X68tqhvijQwmbwegNC2WCLXiI4WhAr/p/0i160F+aGgU9zVqLFGMD9w0rcNacnOjqc
         Ku1okDOcbOxl0Se7G4TpolclRidvD3THnvRgce/PjvuGxwO45EfzavVNY2XVyZWW9n02
         UwrdTLLQPpI8WhplBnWYG0kg+vlXTjB+1Wl93pqDgSO6lmwhYtCtlRYJZNt9MY2/K5zz
         1Wgvc0x7XguVguiG2mQoQ7wGsrt8U6MneZIvuD8KxA5gauNWXUMM5hF/fxlnAsjJWGum
         lc200BbVLSV2N1sAUxFUo5i85GyHLTKuynGSh0WLWigHzHU5HneLWsdisxPkRhUW91vU
         UY3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxyjqZIeB6CcrBK3tLE6FHVLGi9h6/Mfl85uXF6TGmWwdgMLmkE1jPo6w5ZNWlBMLqzI/i0OTbiPleNxA==@vger.kernel.org
X-Gm-Message-State: AFuF++nuD0i7fXL2wd6L6tdBCd7tSVSydlVC6tofVIV5dLh8QAaZt0du
	Ju2MLffkc8A1vSW3vgk3PfFN0hVQ9YQRJEfT+VUN4MJJwEvUtsOShz3nzBLxkrxmyWN5yw==
X-Gm-Gg: AYBFou3MorGQfhJK+CUsDxg92YwD3GAqJ3ofSaV1mQcJ5P65gZsfPnT4Gr0V95zmOVK
	/aRFCiw+XpoYGlEst4skJehkJzhG39lsCcwEoqEFcmZAbKeTY/1unS4ZBEfgULVm2onRg9+/Vjj
	MhTUqBg73BH0vunenbc3iSEoy0ZYuLfEKRVjgDs1ZyUq72o9K5Xx3kfTJ/MjE6JiszzMF4dGZp0
	cmI+SffzUn9QQSPyyxGPib8CoYJOw5DgSC1g1cV8Kv15REPmz0yMdVCzdDQXaglmdcWNA2yY44B
	cwvxEWcblClQKMnYJb71u3FsuWJm2R6rhE5lnZOlyivdtC0/yG0nYBHUFpXVXUqKduY2JJD7fwc
	BXP9f1bPtYzBSH1poNO5Vq4s1ko5oGMSUItw4CCtItF+Lua4pllQ8DyVd9z87zyfis2AN244oFf
	Eitr8Zc81ndqDDZw3i3sU6VDxxLQhnrlxjisc+Da7jSgiEF6jfjWZVxYr9XPQ42S+Y+830SQoHz
	YkSWJyJrQd1WMjX
X-Received: by 2002:a05:600c:4f8c:b0:49f:c18a:61c8 with SMTP id 5b1f17b1804b1-49fc573f858mr164351925e9.29.1790014476102;
        Mon, 21 Sep 2026 11:14:36 -0700 (PDT)
Received: from gbox.chicasongroup.com ([197.210.105.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8a636d1sm10754875e9.0.2026.09.21.11.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:14:35 -0700 (PDT)
From: UgwuRhema <hikarialiyev@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Andy Shevchenko <andy@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: fbtft-bus: remove space before close parenthesis
Date: Mon, 21 Sep 2026 18:13:50 +0000
Message-ID: <20260921181350.89925-1-hikarialiyev@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch.pl errors regarding prohibited spaces before closing
parentheses in fbtft-bus.c.

Signed-off-by: UgwuRhema <hikarialiyev@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff1..409770891 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.55.0

