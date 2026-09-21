Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CAC4DDB3E
	for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015618; cv=none; b=Fl4uJg+uE35OO0ku8QDxkyiyytdK4yaqGUnDL/tIIw0VsIXSQj4C48RAIN5Zdmn7ywbR/j8VcGnB5uru0njFvcQT55TDVXF1rMGYtishPqeqAtYZMjo9TMkWndCqgVhzgzIW+Ki3ff/4YHRYQTNVjTKBrcFJoGJe/Y4ivVlpWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015618; c=relaxed/simple;
	bh=imLjrTU5t3+H3A0cVIp6sUg0tHEbyxjPqqF20TYdT/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VUjVZKmtJYMi8E9lN2M8SCbTkzRNcEq7LPXa2ehy0ax1JsaJ5uGyx9xIHtCMBefIOJxLqYsoVJjLHcQcY4BxHXl1wonceHXU1qFUQX3TvElO1cmTw6PQXeDRYJzSK1zuxeOsnd632sdpsGPKQV2uouC5Kj07Zi5Hr7R/Xbzg8TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtQPH/ZH; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtQPH/ZH"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48351e5bb47so1121679f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Sep 2026 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015615; x=1790620415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8qwDua38LIyW1TawgxN9o1m0hOow5CaSBoRxma0znMA=;
        b=PtQPH/ZHdy+itixSuLw+kW0HSNxEJXpuPMVZVJWFbK6pAfGD1mAlz7bxeZAt7ZpY16
         BnLHaafkJCojR83SDQ7YEqlIoobnVUBpQMz9mbOggapIo6/J6y2GBPg4onlPhcZF4qQR
         n2d4mo6zwPI6R9UIQR5nyRx4A2YnOSr2kG8vXLA+r3fPRbavOhzxj2vmGqCa94Kre2r4
         nvc1c7eZ89Kuitn+VimTIifXw5UjX39bs9+OpazRwQfeHbJ/28Wk3QaBWwdtet24n3Ao
         kBSPlN+42xlAjjQvlXmDepXdX3TOhnNDjzJfpol+vtM+gaJpHl6B5eymyN2GlfBxg7lh
         c37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015615; x=1790620415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8qwDua38LIyW1TawgxN9o1m0hOow5CaSBoRxma0znMA=;
        b=k0H76NeOfkbnLRmg1K1jF3GoPJfNDi08G4y6d8y6rUCZRIp/DzOfLV8goU3FrCXHgN
         ja6w40CU6Xs0x7nESfYuGKLTKPbS0jwYWzQDNty5HB8zsdFfNjCxpQyT1+elo9DagDmy
         91NH4QOcbb9prJjR1jiHSc7OBsppzSI5qCHNj51UbHjv14Nj6zgt0RTMERRmv9pacbWg
         2OlPt8PdiQwPsnhApy/tLHQbO6z0mDvxazG4lM4rw0AQKHbrQ49eX9Tl3Y8x4m9IHFym
         xDHjTJLdE2sy7d+mTlR3/EGBeqC50+ibGH1rpYCsoDtzgU6bJiSNa26EoJOBEJ6YyHZt
         DRyg==
X-Forwarded-Encrypted: i=1; AKwUvBxmaBJc6oGcZnQt4saBuAKFAMX+I5VDNYfICBlIeTyJ4hgW4UEi/LY1GI3EYpszfWG1c4Zg/yIu1gHraw==@vger.kernel.org
X-Gm-Message-State: AFuF++k10rHgNkrJBHLwzW/XZyRiUMnB00mXR3WJwfQbYSFrZLtSbgCr
	NrkmNZWBOsnAjn4mcBbg5HjssiwdnFnHueHzeNsZbxoE+UYMS6FV72EK
X-Gm-Gg: AYBFou2wPdOtoTS/81FZN9hNmTGDPyYbdv6IFQ/Qtr5rIe4KaoOk4d8e/o7LLV5ENnU
	5bMcThZ230B3JegFmaA3j1IgzsH7vFMDviqDgIRMVW3TMXrcWYcZnXLB7BlbEupCHYb5xpDiV7V
	213Ka5fc8L3KjBGdnKjfFfOaBgQyLEan3NgwH20a9kVDvEUICg1b14KHMnWKaWEU2EuzSa4vHpr
	R233DEhWiLr5Ns+s6MTMHHufxfDH5fPdNKokYiS7S3TSXg7LorHHQeljsNRfGAGoRGBw0z6g4fv
	5S4jfBugDL7tln1SbWHzZe3Kk7LeX0Wzw1nS40y2UPGMpTODbU+V75AoKmFVEJvETsvKb0Wg5RB
	D+JT2cY0I+doC1f0oKHS46zi3z07jrcqfE+b6FQW82/7sF18ZlN/giBzfwI0NOb9U8HydeZa6fB
	k5c1lVjxCY7oVi+hxkRVVzR6Ru39LMn91LSvJC98KS2Kn4JL+iQvS5UmObqyG+rOZ8lx+78R4Yf
	fdUiB6f7YpXN+yI
X-Received: by 2002:a05:6000:2584:b0:487:27f6:a4d5 with SMTP id ffacd0b85a97d-48727f6a645mr11933217f8f.37.1790015614392;
        Mon, 21 Sep 2026 11:33:34 -0700 (PDT)
Received: from gbox.chicasongroup.com ([197.210.105.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872456ee4esm23679114f8f.21.2026.09.21.11.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:33:32 -0700 (PDT)
From: UgwuRhema <hikarialiyev@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Andy Shevchenko <andy@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: fbtft: fbtft-bus: remove space before close parenthesis
Date: Mon, 21 Sep 2026 18:33:12 +0000
Message-ID: <20260921183313.92795-1-hikarialiyev@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch.pl errors regarding prohibited spaces before closing
parentheses in fbtft-bus.c while retaining trailing commas required
by macro definitions.

Signed-off-by: UgwuRhema <hikarialiyev@gmail.com>
---
v2: Keep trailing commas in define_fbtft_write_reg invocations to prevent
    preprocessor build errors from missing macro arguments.
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff1..38697992f 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8,)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16,)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.55.0

