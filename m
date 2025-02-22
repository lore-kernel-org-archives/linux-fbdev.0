Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FB178F46;
	Sat, 22 Feb 2025 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740255342; cv=none; b=Z3ljBvYSlIZgd/+FGxyypjfjSFEpoRlj+G8lGmjn3L3dIuzNDZ2+AsnD3KCFpphWVYWmepy3dSUzepHdKjX/WjeYvtzFqizdrmXYZqeKnF4KmuXqEhfQxV7bWtBPqpONjKDpFtuwGwVQt+kQvj0j00E2rj95rNrgH05R2l0Da6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740255342; c=relaxed/simple;
	bh=e9Zy8BkzBcuQBUPJbx9biU7FYNTy1hMCEWFyhs9Nh8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROedDQRO7Akh0hBePdP9ySRDwVkfhhD3qtAYnhoZ5AKNXlCjd4h5jORvwZu2ezv4NgYv56H1rcIlT+UuFPN+xnMWsCHFxzdGJgMwuv7+KQD0HijFMXduu8w6P+nafRDDAYQZoeSgys74yQVIXNCv8pEj+sGeEVtpog6CM6QxHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOUzimFr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOUzimFr"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fc291f7ddbso5219768a91.1;
        Sat, 22 Feb 2025 12:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740255340; x=1740860140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YzPFAwTq8Xyfo7fDkHC2dxzwSB9waPNiWa9hehCRfqc=;
        b=AOUzimFrz6rCPJVu0t/255Qel+ZXNbUdws+88tr6zAkgN+H4W5zFvetkizDPlOqDZr
         lm6lGEiafHIuAFxh4TeYsC0M/jd87lUt1D1QBPWp8d9HcDV6oRyr7NYVY44LI17E1G1Q
         7btdJbzYlKLi33/FxGY+FjfF+ko9OniDLTdzN+9ycGD4O9kWjRtIGda3pIgxO7sFXRLj
         f+U8A1YBa5PHw5ljRxvMhHdxh9kWdYGdxgx933054l+o1xsK7efusy8cGKJ414gS6z+K
         mKnbhWsGFoesM/tkCE2hNIZ8szDAZ2J1hrwZod0+oAdz7rlwivCxxr1rmIPJ0tR6C/d1
         pfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740255340; x=1740860140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzPFAwTq8Xyfo7fDkHC2dxzwSB9waPNiWa9hehCRfqc=;
        b=dWpWwLl9yMfdph9oJWJza4aUe1SG+T68Iy3Q1BnrCp28m+BIJ1PdDtnN1jSi+CVlPP
         BGNK/qAcNjWPXb9loEqYtp4r6COFfSdgc3ML0fbJUnopd+VcPKDJ66MPuGTCDYCAQG7D
         nPfs8RC7X2AJs5h3zaXtTkhhjMGfCLlr5X3dsLM1peOmvG8gYkTKICpgPmktwkMIxBS0
         njLMPjT9WqUawUGrPtPlvWJ7Tw8eIXQEkNib9Plo+23RmzdIKFpEX4mPcwAdyyElTYw5
         5L2oGmxLF9f/VDRD6dC6XCT6YGLznwlNIMB8Wz7EAmjpEt3ese+IsE+Zj4k2YMNL6+Mm
         nJzw==
X-Forwarded-Encrypted: i=1; AJvYcCU02f9U4FghghZIw9faZGCW7tC+BjzOGtk95q38OdirAGqr1Wqh9vpJmAh65k+5OREL+OcfxLV98wPzAbI/@vger.kernel.org, AJvYcCWA9Lef5/ZBC5C1LEYPMNZgFPF4juCqLlqO7BkNfueXgT1S5CFRmVQnMyBuVTTA9e1szUPIs8mIvlG6JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn3N9YnEQtDq3T0dOxKHfxJ5dR0nQbkh/KeWY3vrySbqYXJkCt
	p80dRey2wBbDTmV77MxVoFetuOCcfQ8At9G8iRGxh4xTF0tJs0ZW
X-Gm-Gg: ASbGncvOCNk+uwDD+g+hBygNsz7aFCghU05eN/RiW5YC+ylGWBcR69wAhCH4DppBs5/
	cDwCb4zjZ2Np5HD4aE75pQSAvqJdTfw3CGLWosO1nVIM2cD5CfcwCyBdACSDGAAhhgyHQmOsfI3
	rehqnfm4jXp7Wc67kOHZAhSIVnrjeosEPnerKod7hddaukyAKm3CGjCbXsVL/aJia8FrEhG0u5r
	1iS/YSQk5+YNv4S4BlQ//CAu8zp5OUHZZzwJb2mHlqZLSQXjarWPJpFTyXQoTp7DMrq6lrF8j3g
	LSNZQnXObC/NRqIdqXsMHLcUdzHtPV8eoq/7FPaO3es=
X-Google-Smtp-Source: AGHT+IEQ53UYyrtVg7Uxaj9UGmPpVi8BT70TjxI+xlbx+kZZpGjX5XGY3L/XsYrqjV4Q2OIrQ7R5ZQ==
X-Received: by 2002:a17:90b:17c4:b0:2ee:f80c:6889 with SMTP id 98e67ed59e1d1-2fce7b44472mr14352996a91.33.1740255340404;
        Sat, 22 Feb 2025 12:15:40 -0800 (PST)
Received: from localhost.localdomain ([36.255.84.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb05f715sm3572997a91.24.2025.02.22.12.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 12:15:40 -0800 (PST)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] [PATCH v2] staging: sm750fb: Make g_fbmode truly constant
Date: Sun, 23 Feb 2025 01:45:14 +0530
Message-ID: <20250222201514.15730-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declare g_fbmode as a pointer to constant data. This ensures that both
array and its element are immutable.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
Changes in v2:
- Added commit message
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 04c1b32a2..aa154032f 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
-- 
2.48.1

