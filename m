Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96571E3DF9
	for <linux-fbdev@vger.kernel.org>; Mon, 19 May 2025 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747620337; cv=none; b=SwDL/nFwRb/SSCHQnSwAyqEqZSNQKvVxFw3itaeeQob5O67HtB0VYIHh8r/GV9jYMjR7laF+c0A29lnDusG6yPeQJ2Q/v06EnRhr45tlBaOkPXC5a11YgEJfE+jINqhZDD+SzFqfZXu1eGARudPH43WWRPwhF3LiLgznEUlhtvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747620337; c=relaxed/simple;
	bh=IfFT44CMKOeqhgB18hM6mEBUdjYOQnEMYuDX9zp4nOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CFfCgCTkHAkJWdM8cvO7pBY5q/KEV2PbNFPhn75DUhKVJx8eKeoSBCXEfPiotkCeQG/YzKVCjaO6S0B+OQ5HLUs4T9MSSXcLWgZp19f0mSchnAJri9GaIkmPQbJo1HvjMB0UXLWSRjltqvQ4WY8XoDwK64ju+VVWSvxrNnEVv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zgJ0OrZm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zgJ0OrZm"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742c03c0272so1709611b3a.1
        for <linux-fbdev@vger.kernel.org>; Sun, 18 May 2025 19:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747620335; x=1748225135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AD+qKyABAuEPOhwqIKzwOdRbg0T6mFFzu6xvbShhns0=;
        b=zgJ0OrZmXMppvjxA58u+pi1pcYI5YUlVnUEEGPvMO/QrACkzkzGObtPpEZoUJQWZhl
         /ZkEpHsHjZ46txh9lMrLa+wasbs5odB6epFBxeT9yBn9Cd15CsqtY1LGajhqCWg6EBYB
         xJGM3TKxdxOcdQg8TI6+DbrgO9GRjZ3dokiAAIepWCIPcH/rkZl/3MOi2WDh9p8VcT3y
         ZA3y+x9znM9YK6bhtmjvsN+4nIARixAAQAlnD03704CXSBpOcIfyBkB4/O7Ym+4KTbGG
         TxkrSfpnu2W2Nym/qKQWkPtJC1E/WcLMV7UErtymZg9mdCfmRQHy/NWULYRI0ugPQ2H4
         YjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747620335; x=1748225135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AD+qKyABAuEPOhwqIKzwOdRbg0T6mFFzu6xvbShhns0=;
        b=kVNAfOSS8/CYTnSnSlDwyaUisMEQz8qoM7uQUK72i/9BBTEtPgfKCgEjW2ZcDWXdkk
         BsaO3mR1t6p2graWHpGV/x2Nj+U5xlN0IDNVjG/Uh4tg0xCB4uTD4s/t8er9H3C2j0xd
         FIhOffjjgdOmPIYrayYaBPeW0ZwGxi6TjxSccPP1KPFnO2XEdnZrhM3jDgtS2qYu9+5O
         K9H85sZA1kbpPF6hF75BuD/P1phyEVPguYLL4d8gm7kIzm3e4N6d2ZRM70nY6xyynvFz
         zV/9sJXHix//NN7bNsh1C+TfAHIFR4/7zqHLCPmw4bITAscibHm7eagY+iYDDsvaRwIe
         451w==
X-Forwarded-Encrypted: i=1; AJvYcCV+SU1cemq3Yta/mF4JvM1GWIW95dhXEgEaevoSgRpli29A3dL0wV3Szhzb48jDlr1IavgiC0yhCFcbMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmG2Pf9iY4Msa3eCaOwqTkt5yIh6qx+BWc5zRfcKQ0yykLLSm
	XwaMssLaF1ZHGZPi9bK+V/ex7UW1igBF81vCK/xVyOmXp9L5U/auykbgPHpEKs4L3jJpf8B1V1I
	MuMI5jvZPfT3/hwUxCYdamQ==
X-Google-Smtp-Source: AGHT+IFTmsnoHAFhMA1zRkN1mPdnV4Wcu4biTLF+h1BYHSTMNVWf1xtSby4jD+8dGtwtPP3UAQYgEpSq1I/flB5d
X-Received: from pfhg21.prod.google.com ([2002:a62:e315:0:b0:742:9b06:323c])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:18a2:b0:736:4644:86ee with SMTP id d2e1a72fcca58-742a97f49eemr16898572b3a.14.1747620335197;
 Sun, 18 May 2025 19:05:35 -0700 (PDT)
Date: Sun, 18 May 2025 19:04:49 -0700
In-Reply-To: <cover.1747619816.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747619816.git.ericflorin@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <40d4a1f5b05bcb0eefdd787b9df329fceb96105e.1747619816.git.ericflorin@google.com>
Subject: [PATCH 6/9] staging: sm750fb: rename `hw_sm750_crtc_setMode`
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename `hw_sm750_crtc_setMode` to `hw_sm750_crtc_set_mode` to conform
with kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <hw_sm750_crtc_setMode>

Signed-off-by: Eric Florin <ericflorin@google.com>
---
 drivers/staging/sm750fb/sm750.c    | 2 +-
 drivers/staging/sm750fb/sm750.h    | 6 +++---
 drivers/staging/sm750fb/sm750_hw.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index d4596590e266..5f4b0064cf92 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -392,7 +392,7 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 		pr_err("bpp %d not supported\n", var->bits_per_pixel);
 		return ret;
 	}
-	ret = hw_sm750_crtc_setMode(crtc, var, fix);
+	ret = hw_sm750_crtc_set_mode(crtc, var, fix);
 	if (!ret)
 		ret = hw_sm750_output_set_mode(output, var, fix);
 	return ret;
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 8bf70a3731bf..db80dd295658 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -204,9 +204,9 @@ int hw_sm750_output_set_mode(struct lynxfb_output *output,
 int hw_sm750_crtc_check_mode(struct lynxfb_crtc *crtc,
 			     struct fb_var_screeninfo *var);
 
-int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
-			  struct fb_var_screeninfo *var,
-			  struct fb_fix_screeninfo *fix);
+int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
+			   struct fb_var_screeninfo *var,
+			   struct fb_fix_screeninfo *fix);
 
 int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
 		       ushort red, ushort green, ushort blue);
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 3cb69a471c0a..d3f218cb20f5 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -245,9 +245,9 @@ int hw_sm750_crtc_check_mode(struct lynxfb_crtc *crtc,
 }
 
 /* set the controller's mode for @crtc charged with @var and @fix parameters */
-int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
-			  struct fb_var_screeninfo *var,
-			  struct fb_fix_screeninfo *fix)
+int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
+			   struct fb_var_screeninfo *var,
+			   struct fb_fix_screeninfo *fix)
 {
 	int ret, fmt;
 	u32 reg;
-- 
2.49.0.1112.g889b7c5bd8-goog

