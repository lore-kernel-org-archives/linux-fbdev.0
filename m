Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1210386C36
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613969; cv=none; b=gvq7ZconCsFpdBbzO9uNG/cjv+27vmyqkaY1JUhHdXidUt8TQUZtt//x21rZZKrwcBr4MVu/fXSRsgq9cYeF8lCf7ki/GecxbRtfOdtp9TpS+gpWodLVMZt+Moq8QYwUtxt6cR/00rxCB75lC0VSFTiuSI/sJDNJyBAqqR3JidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613969; c=relaxed/simple;
	bh=3F2Xe9MSsTeaAIiOzoWVA5GTBbp73iMfn/lprySLtwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lPGJR8KiKWTPY108Icx7Da/F2sBPhcIiJ2XNOxnMmeEZHD5MjPHlk9pscyRHnCPgGUWHMzCekBVElqISX0SPy5o1Brw+DrTxWH8g/VNMuOlEOV6QT8+XLyh7ob7DRZG5CcecQmwb/mlAmaVgDD2ued6i+BbdguzpXCfxOUvSL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEEw+BF1; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEEw+BF1"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c46d4a02ff5so257975a12.1
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 00:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772613968; x=1773218768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYEhFSH2QiR/Cp+sFvQyOBwINQ7A/pZyDrDPlhVTTes=;
        b=CEEw+BF1Kp3Rwp1yWgV7nkxNxshSh/jY5M1BAEoFCImbBjd1yXN5FZkCEMe0Kj4Tjx
         ozqZHGVNy7mdzwTOJgAgZCII4Mw6UV/0qpYDiSZHtchV4EjftPupEwN37wks2XV+AqbQ
         YkLNeDooSk+uP8WkyhGDo9dz4ZHfTI8lX4/KDpa9+szy2ofqMFGo//spV/dG8pbnnb/B
         8wbnMZC6dSBahdWVqTG4c715VrhPWqzT6W6xT5fVC8946lFRyiuD8QayeqdbKg0tZ+uD
         1ESQsE67+qm7RQqRt+MgHqOVsUCm97fyZ17ihmIHn4S/I+pSdRu+/M3XFgsq6rGSakTi
         cDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772613968; x=1773218768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oYEhFSH2QiR/Cp+sFvQyOBwINQ7A/pZyDrDPlhVTTes=;
        b=FHYeof+YwXPofwx2vdvdgtcoywXqaYoMCXuAW/IrOmGuJfRzWkd5YBPF/att6ANnqC
         dRTfLCd3bt4wZYDBTB2kIhO0egFA+dm/XA59i49vbX8tClmi08Rh3Lm4fPo+hb5pVtDV
         MQZrz37XYTDFX5PhNK81JOr/6tm+zzsPfm/iKtgzuRKzgkam9tkG0LyOD9YKcXLSNo+o
         0TaP3ek9uY4uJnzrCUSDGmg3XclxCLhKDmj0og2PDGR/D6fcRwWU4CfYuVsC7jaPnaya
         1QYOPxkYkJ9wW9mUR0jk6Ti8ypw52xEbyxrKLkIbDu0/Xv22UqNXXXzuPh2H8jKbygbq
         5O8w==
X-Forwarded-Encrypted: i=1; AJvYcCU+6TxC5KRylYuWV3FD+ljVYfKVR1w3tfQ+Xr9hKq89wrlB0AjvTLlUMrPl/C636xYVFrvzAL1f6EpmPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjx39hNz3CnLvBms7U4Jc+pZ5hdBUxULoMYk2QLkpjMSXKPBm
	eQ9QT8xI3EH/NgLQO6VBfpKQqCF69FUrNng8ofVUlGkdQhemuihrRyT2
X-Gm-Gg: ATEYQzx+fUjKJfMalHV7ccWuGVS0FGZuac3joTpNpT+hNmJy5EICopn15T2fkO4PrsZ
	Z82pD4MppMHwIml2bvJWGJUOsYfC+sKMivOEuUkoMiF5Hhk3Ooy0+4l8FhQPz7mw6KBWWO1l5nz
	DAfDw+X3peT7Hzxq8fs50ixQL+uBslGs543yx4xla85mIU6oGL3Gr21yix5ab6sPhXB9XtEnYiS
	e2jKZLtTfasEhPrrgq0mo0QWn7HS+IGFzXFiBi3XTttbvLdIue6zcN/Q2Eb8RhDMPanOYHXUpi9
	icP3kNkpaH1KXIPI0P2ZqUGcLH+HYrp7fE4AENl5xZDUMKOsEX6VK/51Foq1BI26fwdrsYg+7Nr
	zD+8ufdfpylxrkNr/Sv8ORCkHmK/eHps8ydjVKG2nMjXwQaaFpAbt4bOLTgCfIGZsy4yYemVE/T
	OmVCv3+iw2PD83wLjiCPhw+/UVn/OwdaLGkHqNQwMQIjdC1DzzEQ0tIwRpPBQulWWoIjh16xwxL
	wUOkmVlEvT18nc=
X-Received: by 2002:a17:902:cf04:b0:2ae:3f3f:67c4 with SMTP id d9443c01a7336-2ae6a8c0867mr11344515ad.0.1772613968144;
        Wed, 04 Mar 2026 00:46:08 -0800 (PST)
Received: from cute.. ([2405:201:31:d01f:950d:ab7d:5e5c:5244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d1b2c5esm122010285ad.6.2026.03.04.00.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:46:07 -0800 (PST)
From: Soham Kute <officialsohamkute@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	Soham Kute <officialsohamkute@gmail.com>
Subject: [PATCH 3/6] staging: sm750fb: sm750_hw_copyarea: propagate de_wait() error
Date: Wed,  4 Mar 2026 14:15:42 +0530
Message-Id: <20260304084545.156170-4-officialsohamkute@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304084545.156170-1-officialsohamkute@gmail.com>
References: <aaVT1mSeKrSSlrha@stanley.mountain>
 <20260304084545.156170-1-officialsohamkute@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate the error from accel->de_wait() instead of returning -1.
The caller treats all non-zero return values as failure.

Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 1bd0502db039..f2fde011e7ca 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -152,6 +152,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int rop2)
 {
 	unsigned int nDirection, de_ctrl;
+	int ret;
 
 	nDirection = LEFT_TO_RIGHT;
 	/* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
@@ -261,8 +262,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		   DE_WINDOW_WIDTH_DST_MASK) |
 		  (sPitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
-	if (accel->de_wait() != 0)
-		return -1;
+	ret = accel->de_wait();
+	if (ret)
+		return ret;
 
 	write_dpr(accel, DE_SOURCE,
 		  ((sx << DE_SOURCE_X_K1_SHIFT) & DE_SOURCE_X_K1_MASK) |
-- 
2.34.1

