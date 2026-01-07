Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8CD26158B
	for <linux-fbdev@vger.kernel.org>; Wed,  7 Jan 2026 04:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767760997; cv=none; b=W9kAS5+clkhu7EKH9EJ1LPr8Qdu3E5P0Aog/w+0o1dxlrrzG7HW9NIBcWNakvnAsQsCPFFkXCWrmaW6l8iTHk1tTLUKFsyR2EQQqoCfkTxGDHrixNbtpc6MvPNK23LviKQ3dYbjIL3kvqtsXKsNOUFepDzAd+ZVe8GEQIeR4h9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767760997; c=relaxed/simple;
	bh=MkQ4XoQfjzxb5Bd22BM0zqSZxNNCZ/iSlC3xOfhPAgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuI4/uBRXxuN9kDFMHV2Vom/Bw+6a+pms2jdZNWk1KtYVfXb9A2FFzisKSvDmWS3ZWO7FhY6itPlniTK5qmUxtPt8O28jkQm/Fv5oUJNSmpKsS5wUYXrksFSv8I5Ze1XQ2UTt057dzhGcXtUBwPfcbK+6CqzyneAv3f6nxJtsh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG7zYWX/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG7zYWX/"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a12ed4d205so13323915ad.0
        for <linux-fbdev@vger.kernel.org>; Tue, 06 Jan 2026 20:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767760995; x=1768365795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thb/F5AmFMs9ckn4s6Vf7Io+bFyVo1RiT6S4i8FpYAM=;
        b=JG7zYWX/FjhL7HpVb4rFz2BAlgK+eaKtkHRlqawbqC7OpGnRCJY8rohzUlw0ld4bfS
         c7nnNYT/XygubUATnfbuEHozZrXIoqn/mWygovd/72udEh78xrlp3PQN79a1X+BbeC25
         4ySGRZw8TjVq7InWZhEKZef6fBFlQQnwj0tMsXFlww/VnoQR8bkJwCpynAQqaf+oLL1a
         ua3z7H4IEfcyb/gq2vccH7/RlI4+q8ZMqVED1dH/afSH5BmdALHq1n1LTMIuI/hjtP7D
         fFycLaHbnvVWJIOSgc0LY/t+3Dnb8EMkL16AnQCTQ2WAGNEG8U7Vhh/2iiMI7Xy+tjTR
         xlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767760995; x=1768365795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thb/F5AmFMs9ckn4s6Vf7Io+bFyVo1RiT6S4i8FpYAM=;
        b=hxN6McYO+ENt+8cFhqd8mmvnbu0RxgYOImnVk9aMCh/yr5f+Pe3tF6sdx4Z1rQdhJB
         q3KC/9DMUBvgEdgg1b2yN5Rk/sNRDK0nVWjeDlPwguZnj1K8jbrLLgv/GZuLGqJMfwtS
         D+Nh3bEuU8WGhxG75PcjigED5r9+Ux3lF+6BHD2y98HXSjhY40mcLsd61uSgpd4T9jCD
         e1t8uB2tU9NfJ04vE6Qqtzf7HUELT5VXwU+f1LE1v1ktsUFQHbeY6Pi9lOkvGCWhCLKV
         RPK/NgT5oGCo5BuKU19DnKVnnpGgUEusow3gSxVaDDeFrJ54zIgJsX5i0bdzub4Rrqv5
         fYnA==
X-Gm-Message-State: AOJu0YxzBttBeYcSZpsPAZnq/2TlL+Sn8RiJ4PpGnSECxU1kthw1I9O5
	LtUztiWI4FcgZMoLkeBETeO1eIxIhfd49Af+DQ1QtoLOMXT+0YX+sETeLJPg1GY+
X-Gm-Gg: AY/fxX7/D3HG5XN5hfS+bmXN8iBZPNSw0DmJ0Jd0+IjbbBUNOO9Ksi67d54PEKPADc/
	ZBFIc6IqMGIRQjpdy9JLfOsKQ2QtL2e4PohKhNJP+m7gozOOMVJCk9YcRE0YSO6PRtb5K9cJSkx
	fpgSmMntkx4zce3hmFNFUqE/z+D0xORweNjHBhS1ULKH/5FtGFHao+GE7g9QcKXzyo6Ho7UYmFH
	wDXJoEusq0QAWw+qBOb/1T3+0zFVk2IK4GAFa4h5SvUC8Zm44ulX/+MkA1FDQCwlA6YzMkKYJeA
	Up6UVJYj4+FltzonIKN+MgACNzcE1lSUKwCg//mBPzG3a+07oLQx7TrHUbnDzhdJVqV7gKsL/Y9
	ApZuOenxHNTxbL8SdErljfrH20vkRqnoUQWawn6+2IPNYFeDZS15L+Cx3kaNwm5vss2RETi4Seu
	661QZNprqJXL/umjpAQUWctm1D7TrAmyq/lSL4XPu+lHw=
X-Google-Smtp-Source: AGHT+IHEaO2WdOiPYRPaVMlPLug2wHz5JWNqR4SeeEsDG6lB5tEtYaBOclypPoot3PX+4+bsXooZ1w==
X-Received: by 2002:a17:902:ce92:b0:2a0:d63c:784d with SMTP id d9443c01a7336-2a3ee4a7dccmr11794585ad.40.1767760995098;
        Tue, 06 Jan 2026 20:43:15 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:d1c8:9d76:637a:6957])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c39ef2sm36866225ad.14.2026.01.06.20.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 20:43:14 -0800 (PST)
From: Chintan Patel <chintanlike@gmail.com>
To: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	tzimmermann@suse.de,
	andy@kernel.org,
	deller@gmx.de,
	gregkh@linuxfoundation.org,
	Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH v4 1/4] fb: Add dev_of_fbinfo() helper for optional sysfs support
Date: Tue,  6 Jan 2026 20:42:54 -0800
Message-ID: <20260107044258.528624-2-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107044258.528624-1-chintanlike@gmail.com>
References: <20260107044258.528624-1-chintanlike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dev_of_fbinfo() to return the framebuffer struct device when
CONFIG_FB_DEVICE is enabled, or NULL otherwise.

This allows fbdev drivers to use sysfs interfaces via runtime checks
instead of CONFIG_FB_DEVICE ifdefs, keeping the code clean while
remaining fully buildable.

Suggested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
 include/linux/fb.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 05cc251035da..dad3fb61a06a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -628,6 +628,15 @@ static inline void unlock_fb_info(struct fb_info *info)
 	mutex_unlock(&info->lock);
 }
 
+static inline struct device *dev_of_fbinfo(const struct fb_info *info)
+{
+#ifdef CONFIG_FB_DEVICE
+	return info->dev;
+#else
+	return NULL;
+#endif
+}
+
 static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
 					   u8 *src, u32 s_pitch, u32 height)
 {
-- 
2.43.0

