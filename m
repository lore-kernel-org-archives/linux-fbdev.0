Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866C2C11D7
	for <linux-fbdev@vger.kernel.org>; Mon, 12 Jan 2026 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768213539; cv=none; b=Eh+S+ruPiiDjwhJndhvNl3PoUX+g2O5A3AosclggrBhYfkndoZ1hET+CsbZoduHIs+RRtthcDGQdNnuLZw21TIEgcQfNmt+bt0ISaqAxc/lk7zggbAmPw0qz7iuXOSFmj/xu9n6E+dh9iP2kLGmrpXlhdtUl78tJnsvb/D6W9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768213539; c=relaxed/simple;
	bh=BCEOec4n6CnSdrjH6Beytmr8Zelj/J4sgZA/LLYgTlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oveF7aa0EYpJquxdTYM+HeMERH5b21PPQf5SHwF5xzkw1yhIbW2PAswFrjdS/lYG2BRYVhCvqUBFtS8jvxQO+8gzHqLJWCNhPlVZSrb2cdamcndeJ43OZxCWB6HLYyxhlMWmkVwgaodov1VM0fRIRoHuGpMEtRZcM6aqXicZTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjDGlwHV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjDGlwHV"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so3991795a12.0
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jan 2026 02:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768213537; x=1768818337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qfsvwBs0vj27nE+nU84x5+gWK2xF5JTsgNfOA8vgNzM=;
        b=TjDGlwHV1uL8DfsB6ArQ8uyvreqg8+jwiRc+NVdoBxthepfhON+YcDVdkfo43J847B
         I26mnSAyJuQwYdT4vJjfMVpaGfTh8koDoJWXcwdSxEwFuqiMt8dyem55CNw5fGO1PJ/c
         Rw+yqZMZM+YIIsXrB4ADmcuNlxANk3KhaIU03w5Ww+Se55Xgd7o7T/+o0bdvjVUS1c3F
         TF9yCJ7E0BYbE7oz6k66ZVGJWQemO2G3mbUR2o2F1ukWmJlri1Q+RkC02aXXIZbQOvgu
         FU/B9+2jqSUN28RM2ZwlFCCoTRz9ub+HmemvsQawo7qB0lDZbbRhb5n5GAMXjgxH+OfX
         ajuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768213537; x=1768818337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfsvwBs0vj27nE+nU84x5+gWK2xF5JTsgNfOA8vgNzM=;
        b=c4ld+iEeU0LGi4BqxM5YxTerpYJnHM0+njGh5uacq4bLFB9MxiMbSL6W7QSP0W40d1
         NhyjfpHzBw1oqya1i2ia00FhAUrllBOy65CpzJ100plO9UWhaERzpkDjd+yeWX1yh4XL
         IWjCEHgYwlszNAOZfTrHL5+5nkIELbJWcS45ecddMv64xjp3rzFrJFIyV8xyKdivN+Gs
         +B5a6ADT5/jPoLdbZ/ev3P4WQkCGvZVrBQpigN1Nb02pGRnfi/QMLWdsK4TUAJedSHAf
         tDldbX2XpLetzf9tL6++JfGmI0H7Z2og/GztvVZH/m+kEIiro1TaUbvvEeIsNK4VMXzX
         t3RA==
X-Gm-Message-State: AOJu0YzoZUTI0TjtFBAVX0mMyCzE6I1mUdzCbp5bGWmJaMPx90Ls5yFZ
	dWmjZzSBcRsgFf3pzZsd0wj8CprLMGCqiBjFMzO+MhufPIdVUO6FIXMU
X-Gm-Gg: AY/fxX72h2pkkMFgdX+GcHiJSaKoTPyMVj/mZe+OzVGwuaFBD2Z/+y/rB4XPcs2A8UZ
	D4jAFC01EPTKjCWGUwEjH1Vg3H41Vo58xngZhDqdxw295jSWz5ox5icgzmklCrUJ9+OIhzaVGLB
	ZR4JT6wEGCjO0mh48+CD8kCQpnEEuz23zNbsG26WF+MwR3FPFkPyF/xZNLRfpV73g8yXHhsMaIL
	WwyjRfBmxhG4/HEwjeOTY/vteVgJuVW7LiMcvkH6AGavhAy7/v6KWBhdUtAcl56Sds5DMQXyYAY
	46po47LHQcNVBnxWRVVr8nqJqBiNOmahLKyCvpnGulSmMlaYRg6VHV60QIxKxtxQcE2FySPmaev
	fPtjx5MJWcAjUySHS8oxJA6E7l1S96+HNouPwakrDDC2XJ+tdkp6Lyt6Ot5pNgxN/bsAjuvwDOl
	+7589FRbtTGeEREHICWF3y6OmHQTtzkw==
X-Google-Smtp-Source: AGHT+IEYLmmC/hIssXQxrxzG8iOIBPP2fHvyARgDQjvopeOP370d51Vu0DqlZYxtTRqHLoOKJjFvWQ==
X-Received: by 2002:a17:90b:1b03:b0:340:ff89:8b62 with SMTP id 98e67ed59e1d1-34f68cbe4c9mr16271428a91.21.1768213537490;
        Mon, 12 Jan 2026 02:25:37 -0800 (PST)
Received: from localhost.localdomain ([103.215.237.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f6b9a1881sm5452431a91.13.2026.01.12.02.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:25:36 -0800 (PST)
From: Karthikey Kadati <karthikey3608@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Karthikey Kadati <karthikey3608@gmail.com>,
	Unix Antigravity <unix.antigravity@test.com>
Subject: [PATCH 1/4] staging: sm750fb: Convert sw_i2c_read_sda to return bool
Date: Mon, 12 Jan 2026 15:55:02 +0530
Message-ID: <20260112102502.19761-1-karthikey3608@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sw_i2c_read_sda function currently returns unsigned char (1 or 0).

Standardize it to return bool (true or false) to match kernel standards.

Signed-off-by: Unix Antigravity <unix.antigravity@test.com>
Signed-off-by: Karthikey Kadati <karthikey3608@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 0ef8d4ff2..9d48673d3 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -180,7 +180,7 @@ static void sw_i2c_sda(unsigned char value)
  *  Return Value:
  *      The SDA data bit sent by the Slave
  */
-static unsigned char sw_i2c_read_sda(void)
+static bool sw_i2c_read_sda(void)
 {
 	unsigned long gpio_dir;
 	unsigned long gpio_data;
@@ -196,9 +196,9 @@ static unsigned char sw_i2c_read_sda(void)
 	/* Now read the SDA line */
 	gpio_data = peek32(sw_i2c_data_gpio_data_reg);
 	if (gpio_data & (1 << sw_i2c_data_gpio))
-		return 1;
+		return true;
 	else
-		return 0;
+		return false;
 }
 
 /*
-- 
2.43.0

