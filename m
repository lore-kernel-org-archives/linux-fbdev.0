Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F2B2DEA8F;
	Wed, 20 Aug 2025 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681456; cv=none; b=iGhWLTJepc8+N/EzKe0Rb1tqNQw7jerOupnwil2F9Q7hQUQjgN5LujuQcS5kt/rAat8l/yZmHdwHrqIoR7WD6+47ABmRhSmJC807ogvDf6zTou7p82HNIUh5MJ464hkYCHSqGwRvgccg5xfU/Zf1YC9eRL1P+iTNlA/L2OQGxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681456; c=relaxed/simple;
	bh=afuyi0bHmJOpsK0SZrSBUgp0mfKQIiPBQvG3BM0DIz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9jk21BZR6m9qaDVQM3OesilII7306py80iGwQktHl5eXZ5nqlLT/WmunNZgwHxi2qW3MgXjBs8u3ljeieYbQh9DM4KPOTS+keQ2fIS+2OQHoKJ9ztg38c8nxKUV1D4hyo+DLjOtNUToa9bZQDne/6a0W1oMGK+Gx2Sx0Pj+KIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FF2eUz/t; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF2eUz/t"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so562016b3a.0;
        Wed, 20 Aug 2025 02:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681454; x=1756286254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVI1k/pB0ixIWErdqLS9pw9F8W8NF+7vGjYmUvMOdxQ=;
        b=FF2eUz/tLFpL/UjSEshTtdCiLeAjGfs71M0QlNQjQDIKFBH3anKecdB5eFXM982vuA
         MJJ6FlWd4i4cyu+5zQ9cmA7kKnEpUSekJYB3R+263d+xtlEGkEbziURKOXGNNAU7w1tG
         EjJFCKSQ2F2rprEGGGYn5DHrs3y5FL/exPsHXn8tHaRIk5T3AOhRCToUD47YF8lvYq/9
         +FTS9pvDHaOavQYvyYYGglN3laCASowkLiZNXsFav2z3mxuoQDEOnuNqE69mxlbTzEnZ
         JtGEaUHldRsZtmKYfuaS9fV6jVgybxyGOKaGtibE7426K9KghYlu7cwJQIs6VdW86nJt
         DSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681454; x=1756286254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVI1k/pB0ixIWErdqLS9pw9F8W8NF+7vGjYmUvMOdxQ=;
        b=Wk2ktGut7SbTWiZZ8bWcKIIcC3yIQAA0EsrPVA+MJd9Sym8dPotUVl6x9JFiF06524
         DRt3zLbkn4lwxT6Lx6s2nAZgTtL0tjiWaDFcp9lDQ+lXR/SBF8yJpdSMd8ejyQaklqVI
         2Zxp5uwUepeApymi1NJE+jGu8izAgaRDSvRoGGpQnY/1mxiIB4egwVfLDnFpvRvjx6qu
         kzPM9DDai1NhTveQ3+nS1sKrDP+JgIfmlXNqYDOlDmZ76xE9YzVPGA1rcSnsCfgICqfy
         ruoAyfod3IPMLBr9D5+upAsPPYsV71H0VEcoXP5VaPjMad/PRef1wZ5FqrajbXYEk+uO
         A59w==
X-Forwarded-Encrypted: i=1; AJvYcCWtjMgN7ecVNXPNyHWUxr5dHRcM5jRvbRoXMkdXpo59YYj7UKCxf2pIJ4dSJF/aOsrDHXB0PF5QuZ5TzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVXNgzmAvfVEzNZoPuFJLycxOUmdv8h5EIfRrhJ3V7PMdAmwGF
	t3MmR3R1AZCJSVBWXHr0BG3gsO/Oo/Zc82O06rt/mUvVAi1sOwxtrE9G
X-Gm-Gg: ASbGncvIe91kXvBrdIWEt6HrUK82JibIqw//pSIIaJLmkm1JxgGFenZzhFS5M8YLrnk
	16sFdss03nqCREFlC5DjydnA767IW7jWB/lxUFJGHMHamsrh5RE7uc0/iUOul6uR/wdI0cAiAEg
	N1dysMdT7VV5eFBvPdSs//Mgh8klSst7lgv7vm9ktGeVXpI6kwjWibA30gF7OO9AT2ywuMmAqYX
	ouzi+RiAwTVt30n6kNX8SXUZgDeWPH40Y0IQdZLsYryZWVJ76iFgcgJ9BWh7k3shBcFMY6I/Tno
	g6yN0qy0HmU+ZW4ea9nDHLlWrs9wt2NHfK4rWZn4tEddqyRimO6qDweToL0pHIBr3XPA+fvOnWq
	6tePGYHlx3aW3QQa8aBoYAJYUufHkvNFsUdPjcFU5ztRKYQ7Dlzif6yTDJgNK7QFXOkx12d5WpT
	AVvUZuiDJc0nHYW1s=
X-Google-Smtp-Source: AGHT+IHx9qodfUsUtujF4WcGyv1bu3UXIDMU9WkHwudd4s28sPGdBAtDjIFUWtp2i3gI178EqoOB1w==
X-Received: by 2002:a05:6a21:6d8c:b0:23d:48fc:652b with SMTP id adf61e73a8af0-2431b7c805emr3407301637.12.1755681453721;
        Wed, 20 Aug 2025 02:17:33 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7ccfa8d1sm4847120b3a.0.2025.08.20.02.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:17:33 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: pmladek@suse.com,
	akpm@linux-foundation.org,
	Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Zsolt Kajtar <soci@c64.rulez.org>,
	Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	feng.tang@linux.alibaba.com,
	joel.granados@kernel.org,
	john.ogness@linutronix.de,
	namcao@linutronix.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 2/9] fbdev: Use panic_in_progress() helper
Date: Wed, 20 Aug 2025 17:14:47 +0800
Message-ID: <20250820091702.512524-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820091702.512524-2-wangjinchao600@gmail.com>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates the fbcon_skip_panic() function to use
the panic_in_progress() helper.

The previous direct access to panic_cpu is less
readable and is being replaced by a dedicated function
that more clearly expresses the intent.

This change is part of a series to refactor the kernel's
panic handling logic for better clarity and robustness.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 55f5731e94c3..b062b05f4128 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -279,14 +279,7 @@ static int fbcon_get_rotate(struct fb_info *info)
 
 static bool fbcon_skip_panic(struct fb_info *info)
 {
-/* panic_cpu is not exported, and can't be used if built as module. Use
- * oops_in_progress instead, but non-fatal oops won't be printed.
- */
-#if defined(MODULE)
-	return (info->skip_panic && unlikely(oops_in_progress));
-#else
-	return (info->skip_panic && unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID));
-#endif
+	return (info->skip_panic && unlikely(panic_in_progress()));
 }
 
 static inline bool fbcon_is_active(struct vc_data *vc, struct fb_info *info)
-- 
2.43.0

