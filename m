Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393EA2DCF57
	for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776014524; cv=none; b=P1G2G1j8eJmZWqv8+UbNhc+U5WLgDk5+K9ai6/5Fm9e4IlePTfe6oCXRT9J98A1Cj48lFx5WB42UTRNcGGkQ7oal6Bqe70yA+EWbapCS7+X7Pj0KhADe9QQJMpKkp8Y8grlElXa/tx5H1wJgevOMmY19wl4GrixaKqAN3Crhehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776014524; c=relaxed/simple;
	bh=wIKNV/TU52GcyeaVfrYa9wEhn2NZaQpyu7cNGZKhRuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+VXpiUcJG9XXdtjwLWFVqqExLOWEK9YRUrP60vcYsiqVh1Ut0dA6od0wA9L+6WCIrqpJ0EBR090yfBmjodo6smpYRdZVTrF9zsH/ZW3Bwa5/U3UXyNNYQY0Hm9qI5MteT1XxHUC3pwPLa0l07fcrOWWYyfj0O8YN2CWsvE2msk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFgPyySO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFgPyySO"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488ba840146so34734295e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776014522; x=1776619322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7F4lbNQWtZXtoROCb8OY9JzSy1iP1R3hy25K3QPEtAo=;
        b=UFgPyySOt4drdRcucFhb2hNwslFpJHiyBpUXg0fGQSnc4uqcrKbyTX3rJooiSlvLGn
         nrcNKFNRxTkATTRWZ4DgSv2Lm6dMRrq9ZJ763U0xzwPZ0WGZcNh08BzmsVL+8Nt/26bH
         K5EyM4RIfDC/pbq9LI50/5vNbc5ziMWJuYmn5gRfprHbuiDbnP82f2DdmIlDMcD1FO1Z
         VJAEjQTzXhHNWQ3q8LhhNShGnuqXfCfO9YRuRiA3UZQqTLsKPEsG2X4lsbLSj8yZrXBP
         q1quAGIRYiCqV9uXyOWHKnA8elplOI9JgwMaT1mJXfTbqDx+RTkPZpr3rL7Dm34Jr0RB
         mFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776014522; x=1776619322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7F4lbNQWtZXtoROCb8OY9JzSy1iP1R3hy25K3QPEtAo=;
        b=mxi5f52OAVHrNG5jm7ZcQwGtEa0VcaeIzjNYyNqr3viAALhZypQ3Q6RuEUVtCWTsS/
         McaERWcNiB2lpM9eQ04Z2RDBTRGvuw6dXwZ4MOqUWnC96V7ce0ABLCXL3sQZZ86owDMz
         bmhpQsB2Bbx82ZfpPfxxlZPEa7xsqgSRWR7R5wcYL+vkfs0bpoVQdFXYALTr2dAoJ8kP
         TBouzYS9/l2tG3k2RQj/uZspXtFXHwmRi/BabDKKyuFf3KW+oiHoBziAqovsNUdx+EP4
         /++0Rx6qGOvNFkw00L7Tea1WlBLbhBnof/xzM0x6ZNFSrWcZY7DJRELsBnmiak17mYdS
         l1AA==
X-Forwarded-Encrypted: i=1; AJvYcCU/4irViGX+D221q7IKgMk4rYzgvC0y93vUH2Fr2yPUOwqlm2zGLcF0u6VAheQSvTwcKUrkt6hnvQDssQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJRwzWa+pnoNFpuZh5J0NxQ9bTqdHIdadf0g3MVHbm5YCgFdV
	JVZ4uvFUVbifdhxC9vA+dY3a3BLndKHGU9SYUdBtJNdWhqumcHP5jgnP
X-Gm-Gg: AeBDieuI1GHBqyEXNaug7cgVTjYlw2FgUoxmZXOHaG2k9fa1sbpJj15R5Vm2BLG90np
	LGmYTfBfAA6L9yzS5dVy5pvs4UBGzydWzCKAFwczmiLjKSgFfR7ix+5NEj4Dk2JzXxQdgPVRgnC
	C9g3/38mWycUn9i0IUDc7u9WmQZL8rMBEHP6r+EOb66L41VJx3jG2cShQK50EdpLkRV5PQB3wzb
	a083T4OIn93TWPM+wG7D/5W8V0C+Q00tTp60rc5Dg7bq2GWmcAxvEcmmNtljqMZOv3ljiTxsWaU
	0JzaqrIBlSobMNuaY/FVJenoLe62ti+F9mqBL028VAEXV1HPK7/+gTcrbnIfoBZQaU/ic1ycn7P
	hmbq5OHp32XDrmnuNGd402/CYH3GnE0LKNNT2zAVfn6UtFwynwAKNkb945InxWDN2qIyKM3Rppg
	P3u/pNEKQpMOfPqOOBO2PPUVp73YvSgN8=
X-Received: by 2002:a05:600c:a109:b0:488:af7f:7751 with SMTP id 5b1f17b1804b1-488d6836508mr100895415e9.15.1776014521398;
        Sun, 12 Apr 2026 10:22:01 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:58be:2682::3d6:8f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5380feesm287047045e9.9.2026.04.12.10.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 10:22:01 -0700 (PDT)
From: Baker <mzndmzn@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Baker <mzndmzn@gmail.com>
Subject: [PATCH] staging: fbtft: replace empty macro args with identity converter
Date: Sun, 12 Apr 2026 12:21:47 -0500
Message-ID: <20260412172147.2817-2-mzndmzn@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260412172147.2817-1-mzndmzn@gmail.com>
References: <20260412172147.2817-1-mzndmzn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The define_fbtft_write_reg macro calls 'modifier' as a function.
Passing an empty token as modifier is undefined behavior in C for
fixed-arity macros. Introduce fbtft_no_conv() as an identity
function to replace the empty args in the no-conversion cases.

Signed-off-by: Baker <mzndmzn@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..8ce263f68ed2 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -11,6 +11,8 @@
  *
  *****************************************************************************/
 
+#define fbtft_no_conv(x) (x)
+
 #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
 void func(struct fbtft_par *par, int len, ...)                                \
 {                                                                             \
@@ -62,9 +64,9 @@ out:									      \
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
2.47.3

