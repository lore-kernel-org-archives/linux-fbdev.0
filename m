Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1353CF05D
	for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383467; cv=none; b=VOpyxvCfq3ZzBH9oBqhpT9qWU4i1kifGaLN1mX8T1f8OS0w6pF/YcUocYdTCGorxlN8L/y0tWApnwpPNwZeppJGrXO1d9xOSPQ0am9fqO/5PnCPeZEseX71GJf9X4QHcovJRNuBCbr+iawi4x95CB7gZuFDbvDodlzF/+PEeAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383467; c=relaxed/simple;
	bh=MC81b1n8cWE023+2RKmMuPWPjQOWGqTfXMyWCkJ8a/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wy8yUc4qf/CiM73xXjnQ7LLhq9lH6TW43Gs7iGne9fWzlFEw6W9PZCae0PUZDLYysRRNUdfoNnIHSmsxAdjNWvwzBX/mPLUMaRGqm97w/mZ1u1WP7+3Oeo5v24KwpvE+AZVm7muqwMppI74/Y6iGn61efE5XRhJsX591htMIy0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oUvbsmqY; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUvbsmqY"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30c713f37c2so711014eec.0
        for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 03:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782383465; x=1782988265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TKJsVWDIVCaWALiuCSmxIi+GmrzYP0RWrh9s3UMN5KM=;
        b=oUvbsmqYrnIT5w6bYroQd4S0QWhisudiCUju/8yfzhqIzEEEy4mjeoC++ZxzXcMreS
         kqDfGfaSF2XhjPFEU4dC6+tm6C9XoRDqmEVH9XH89GhG2HlTp3QAruuRJZycIYYlnxhe
         uOWXZU+W9Z/He4DMU2+fZwgcT95p5kg9fhuYq+OPSGtjjRgi1Nri7DI2MGzLMZA7/zPp
         nx0ntXYngghr7+GzVzLPVFDxHmxFzkxa/0ZHae/G8TQQ2Eu3Fv1Guqc82SY5hMJlrq26
         4eLqfYlzFHotnSDjadu4o0Lj2TzuzBs/Wl59ZYHEinc7FFO9E1wwshUlo7yNHXeTdpkp
         uh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782383465; x=1782988265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKJsVWDIVCaWALiuCSmxIi+GmrzYP0RWrh9s3UMN5KM=;
        b=j8AEPmuS4EP44B4GSAjhjJEyE/hRPsztuUa0BNLHABERwkyfN7Kdk91S6/L4K/FW1q
         VhZM1tGfVYQdD0+UYWTHjecsv0/8b6CY+4UU4OLIUNXb+yNDbsz0VNtrOSJ6pU3io6NE
         yn93uL5vTj3e+WbopdYMOMcl4URhjWG3EshusIG7WXhqpXKM7SNkAlcC0PWKDgwkXCF1
         +KRHegNnYx0jhNp756Zh9PZOL/3vrY3AOJIISpafCvC2KY21gBcBUBG614nJyblkA40Y
         7W1T/v9S4m/9UHvAvKWpW4qax8/FZvt83arHmSk9B5vqouoxMDBR9Zc6Luf2gTost4ho
         IsNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rre2lV/+LEPBHCETCI7hln63Z9k8ZPllHggh90TGmfABI0NI+gCBhBUleWIvijzhf/isGwmFSmAEx6SHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPeWJJpoMhbkUcA6MY4OofFDrq+07uucA8Q6KGGvSnR5QnoczK
	ERuyyAUOq6m4EWPGb+ICE14tA/q6UY4XTsdXSmmTb01wO+ymhxrxkDcZ
X-Gm-Gg: AfdE7cmqmGIcT7wYCnDuN7zvRgF+7lblYqhbdvaHZHZtzVm3ALxAgY1HI6SFsjnA/8Q
	BB7Pg4kaR0VRGfcvpUA5x4uCKJMQnzGUqLMrWd6j6W3NR6BsORtnpIz/f5vbEN5MEps3VPG2Yv0
	IFCruyzYgXJHUNKHbGBmWh8V75He2fAwn+FcVI45HIAEBxWvl4yO4f9rWp9RUJ497xtFXHnBfaE
	fJeTA+sGtuOEpXp4Pv8ZtyKXKnGIkMQyKXnrm+QIAVqivCKyVnuuk/CQFolfkbFa2cNszRqOzuh
	F5R+nM/BEv19rKEFyUcNjf3epSfisJilH7VLjDwDjbJOe5hMn1MZzj6wS6j4ChXkz/krbOEsJnX
	wQAO4fAGKUImOaKjqV44Br0CdX6NqOKqZcS2cVxRK3J/fl300bBG6QY/CNf4syx/kh4auLPfksi
	F1iWN5h7szaRn0v3oGP5OeqUTvySKOlXHrrw==
X-Received: by 2002:a05:7300:a485:b0:30b:8878:9c8e with SMTP id 5a478bee46e88-30c85468412mr1914301eec.2.1782383464754;
        Thu, 25 Jun 2026 03:31:04 -0700 (PDT)
Received: from 10-86-27-11.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca5e601sm7458658eec.25.2026.06.25.03.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 03:31:04 -0700 (PDT)
From: suryasaimadhu <suryasaimadhu369@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: [PATCH] staging: fbtft: fix unaligned access and buffer size when startbyte is used
Date: Thu, 25 Jun 2026 18:30:41 +0800
Message-ID: <20260625103041.281190-1-suryasaimadhu369@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When par->startbyte is non-zero, buf is advanced by one byte creating
an unaligned pointer for 16-bit types (u16, __be16). Dereferencing this
unaligned pointer can cause a kernel panic on strict-alignment
architectures.

Fix by using put_unaligned() instead of direct pointer dereference.

Also fix incorrect buffer size calculation in fbtft_write_buf_dc() call:
  len * (sizeof(data_type) + offset)  /* wrong: multiplies offset by len */
  len * sizeof(data_type) + offset    /* correct: one startbyte +
                                         len items */

Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 2169f8d1d..cfcf4d7e7 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -4,6 +4,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include "fbtft.h"
+#include <linux/unaligned.h>
 
 /*****************************************************************************
  *
@@ -40,7 +41,7 @@ void func(struct fbtft_par *par, int len, ...)                                \
 		offset = 1;                                                   \
 	}                                                                     \
 									      \
-	*buf = modifier((data_type)va_arg(args, unsigned int));               \
+	put_unaligned(modifier((data_type)va_arg(args, unsigned int)), buf);  \
 	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset,   \
 				 0);                                          \
 	if (ret < 0)							      \
@@ -52,11 +53,13 @@ void func(struct fbtft_par *par, int len, ...)                                \
 									      \
 	if (len) {                                                            \
 		i = len;                                                      \
-		while (i--)						      \
-			*buf++ = modifier((data_type)va_arg(args,             \
-							    unsigned int));   \
+		while (i--) {                                                 \
+			put_unaligned(modifier((data_type)va_arg(args,        \
+					       unsigned int)), buf);          \
+			buf++;                                                \
+		}                                                             \
 		fbtft_write_buf_dc(par, par->buf,			      \
-				   len * (sizeof(data_type) + offset), 1);    \
+				   len * sizeof(data_type) + offset, 1);      \
 	}                                                                     \
 out:									      \
 	va_end(args);                                                         \
-- 
2.47.3

