Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1A9358387
	for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776015212; cv=none; b=tj44cYjnad0El2AJLQXKFVam0w1ob31sTeVFYgNZFaEAFgiwKqx8O5SQMQvPGxTf5ThtcMEEWneHHDz0Nahinqg4XPEoPq3YLHBnsB8MDLeqtRH8NCs6GAmLt5KFTyX0xhFfjkertPWvquumrACJSlydq2mLhzvbG8xElK5ZpY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776015212; c=relaxed/simple;
	bh=EckK7HKSoogmAQ4Aqmi+PsMjy4ZRkQDzoh2xQMPmW5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYcxXzTZUw6JYMh3Ip+V0szRtizGPK1LWH/Lfjo1fDLtH0RWBa4hVYEwmAAaSNuSw6vD47pkQWuJLidlw4gzmx0KjE8hRMeNIdR2b47W7tGiK3yQz42NqVv1tM4ZwePuvohLXRa2UtKM3Zk2zFdlBLxi9F5c7grjvlSNNKs3kts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZL0sHjm6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL0sHjm6"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfd832155so2409397f8f.1
        for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776015209; x=1776620009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SbvXgjGPphhAE2I9ElLsnXiA+UjDwBVBpN1/DptNsY=;
        b=ZL0sHjm6yTD8kkkGi4aGD3Sjcnxvg3A9JuMVefl2miX6tS3DzssRqnCCPoIB23AKwX
         p+63AIXLg/wVfXL81+uhplrRZe+sl1WdIm8H4t/2yb7XTAC4EvLxUeWNYcLNqjFZVT8w
         SweUmneG5rAXPgSQc6BXhm+JltMWg6JhD+zEKGPxoKlePuJKvUfrEZ1/Nm2WcGwf/Bh9
         /PKoCBobzo6uUncGyZUa2Ee6srJqGiiYhT4FtNkdMdhpaz/W5fxQx/mqDmd3zpDdJKOG
         zMClgX6wi28/Svvime2DMgv4kZV1qzPoN8mglbBB9dly7/uiM7TaOrXJ2ruy30zfFbqg
         QXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776015209; x=1776620009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9SbvXgjGPphhAE2I9ElLsnXiA+UjDwBVBpN1/DptNsY=;
        b=GHZdZMMkGkSBmAIXazmQWVRT2RA37nzju6U+yDGUIVMg55eyPLnxch5pWxTmjjf3C9
         RpGZaysyW0LWVelVZ/ZcwcZrOeF0DUrxkrATZrWZIeEBH9CFA3BsvpSB4bdH/M9K15d+
         cuzNiDhr3Xm7Xsfhpk4Xn5A51HwTLXlyNWXsjM5ggJblcNoooS/XXUPSWzt2JdAS0MgL
         lIzP+WFgrVQWNUKsIqBRWXyx6FN6vl0N+/gsuigeEGP32HGAf/9lfTBSXFN6TMzXmtOP
         YwrNFCt4LVW/YPO8ONVobdZFYGr/ooXdsX8TI1DDEp97mpJt0xscNsgbmpuj9zY4eRMJ
         XN/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+OKRoMrqLHx4jKXQu4xtyxFRLpN6WL9lNTAe5onuv4nYHYffVlnF3p+pj+NlNfdZWHeIWFEkqPMg41uA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwojRyM5ODAtRe4M47Z5CQjx4rrZxp2pmUbC7RwJLkj1nstMHVN
	k9yYbA/vgII5hrf+On9B+mLgqYrlfVsP0ePd6z1+8MXqQBuhrR7R5mpx
X-Gm-Gg: AeBDieuJ6d0ARHHhGU2B/p9YHEMmlphcp5MO5RBQmQyFq/Q5iqHZyBNMJXx/1QzmSE+
	ZSC6lSdXUPzr2xqRAuqF46jImBJ4y4I77tTXjSw7VJpfdj8acGg0+z7Bs1rVOtoZM8hm/23IC41
	YzbJXBpeFhaSekY7qHynLcqbXfcaKn53XIHt0OMxeahfgEBZl9cODBYADNeUNtBEyn8bEVRHq5i
	gqCrj98Xnxf3NV7AgL2kTrGzOyIkfj8BunxCt74+8mve8sXKq0Q1/yt1AlYjzcy0zklJjkJ+aks
	UWqVLKvJsvzL4RwEGUt6e4N0FUzi2T+yfdDIsmYjoXGkGTg1fhcbcgb1hM4qXeD7AJuXRN9nSpB
	/PUZlvGFoZ788B+K21XPxXOqNjilNcwGiy7qH9h2t6JXkwnvv8ym+TKMZGzkReMyecGXpx3PYRu
	ojefWhjWagTOvlp/Y+CRjuWG9ZzbapJ4g=
X-Received: by 2002:a05:6000:25c4:b0:43d:4a74:8ec7 with SMTP id ffacd0b85a97d-43d64286af4mr15611203f8f.20.1776015209362;
        Sun, 12 Apr 2026 10:33:29 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6c0:2682::3d6:8f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d76eeb2d1sm5499983f8f.22.2026.04.12.10.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 10:33:29 -0700 (PDT)
From: Baker <mzndmzn@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Baker <mzndmzn@gmail.com>
Subject: [PATCH v3] staging: fbtft: replace empty macro args with identity converter
Date: Sun, 12 Apr 2026 12:33:17 -0500
Message-ID: <20260412173317.3329-2-mzndmzn@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260412173317.3329-1-mzndmzn@gmail.com>
References: <20260412173317.3329-1-mzndmzn@gmail.com>
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
index 30e436ff19e4..7f3fd30576ab 100644
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
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_no_conv)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_no_conv)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.47.3

