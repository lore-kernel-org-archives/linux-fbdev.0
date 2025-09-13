Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8AD1F63D9
	for <linux-fbdev@vger.kernel.org>; Sat, 13 Sep 2025 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757796139; cv=none; b=R3BTAwI+AZJFvDHjpw9VRDqzGLK8F0OwLDAMIytnNWTn78Bg/r3oqf3pC+DI7VdI4XQGtJR8s9LEcOtkBbLEiFwW3M908+uo5IZufnB+O1o1os7NzvKHWBLioH2kS9Qm1kfyvzU9rTW5qsx9d1+OYZ2e4O+eiUFvebC4FG3Iv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757796139; c=relaxed/simple;
	bh=/P/qxo+yyhtCd2WG67Ww2v62Ig3zgNGIDT8HLN0TCu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ut8OpN0zQvoKOu0+8KIW3wbaN2KART3tu59ywrmHenw3UDsA5eBT0Yyk2YWUhrEwhBIw+OkF95LoxnHANtM/f7fcf/yIWCqYKAVIqrSeXWaG2jY7MHAbreAnTWPd8QzeOWMHb74xMNySUmcSt9cjFnf4UxZd+nmdliq22z38Il4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC1xCqiD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC1xCqiD"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e9c5faa858so71546f8f.3
        for <linux-fbdev@vger.kernel.org>; Sat, 13 Sep 2025 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757796136; x=1758400936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+lV53uizaZ+F2RLP0bqdZS+lXR7ayYbIemsvFkoydw=;
        b=HC1xCqiDsq/nkeyjy2UYQ/V6p1+8KmjFTZFtjIq3HX9PqcxX8Jf+fetCBMJEcogR3s
         vTYPT+lPmsQW+lDYnPy1y4ttm33u4cRcr271XIzTn1u/9FpmMrHISFbqcKTNJMquNWee
         bPB09BjJY44nUWnbNrlGmqCXwftnriiLbPDlyOTT0YUDDoW6Ku77YA6M5KL3gI7hr+B1
         lLojeFq1E9L+Zhi5wedwxRHC7UMzs+xpcYq5OccvtBT6ddhdL0uY61tHJC3An7wTs76b
         iq0d7OUhVUcFYZrh6Oyk0HXk8XStPP0WMkKEc9iuEPSq/fA+fX681R0EQojKcko7zstT
         Ol1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757796136; x=1758400936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+lV53uizaZ+F2RLP0bqdZS+lXR7ayYbIemsvFkoydw=;
        b=kGJAkVhDEdjedIE82GNYr7HGSjbzGidFX8c5QMFTIALLDoLb93mVFSrPieCg86OPlM
         7fOA/biVWeRrxsMe45h4KdRQKNenoCfX/AOEVzqF1rqZomPQBsjlLUdY1+1SrL7vtV5n
         RZaRXEkDkqS2rcLSCuX6bwgHeNsUi5ypXC44BuU+jkXB83z48rc2mEpfOmivqqjyHSbS
         TTqBN3MR+RBS7WLU/VqlzoqcA31E+zVpb1PZci7dU5p3Bot0WnPaG5EF3iE6/4pnJj7O
         lX+08YRCm4fw3eAOaZVdO70iOxvqB5GndRw8sDYntscGEmAa1cq7rknaTQgaQtyfP1f2
         bcmg==
X-Forwarded-Encrypted: i=1; AJvYcCUH9Wxj5VS2MKWSdT79kN+ERwCQJPskkTcwJio3GHKnIbiRLhW+XdcbjpQgp/kEUULOLboj/5Icyr903Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7vif1CJvJceB4o1d0MgPTyGLLj8tqArJQWYZ7C2S1xFYjR3j
	vohZWU+Qn1MEKXAAZkqSstXpA5bDw7Wrs+zQSfc2nPSfANOa7GhXjIbM3nCGKwzWbAQ=
X-Gm-Gg: ASbGncvNMpUmVnmS5Niyhk4vdgKqQo/Doe00WZ1bGzaF4L2TccLiLhv7O+KCgPHE7TN
	17g2/tQWAIURqAn2ZWfaX+R/9NU0Yz9LhEwGRCPOZD9rnNz4moYPCW6eNzwdoA3WwF3IIuXVPL5
	RwscUK7Z80o6EBtPexhZFc5Z9TBHygiTfW5vQ025mkTx5o5TbbdrBPZet2dS+dBqnjx6eE1Ovus
	pyVeq7uvxcIc3wZfh7hMDUmjAuR9ttlMynixcttt5LWe6ueXbQWo7l7p+4tGIAxmn+PCVtz3nsj
	o4piXrotczqf5RN7nNWk3e2bsZncI4I3MoI8KyKfuplc6hsdjdTM3hR8jHt/2WiyyqpjXG3QS3E
	ph/Gzd/hz96a5aKz/5gBoefwIV5kaR3I4s2/o8QDWhln3QZifZyr16nLBNAUJo2BatGxk8V1NDa
	r0sFylnTJGhwkRgf8iIg==
X-Google-Smtp-Source: AGHT+IH0uXG2lGFiqqlltX/cdJclGu6EeCpbeRw9akH3b1yiw6P/wxLThUCO3KVM56ssT1Ub693z0w==
X-Received: by 2002:a05:6000:1a86:b0:3e1:3b1c:2c13 with SMTP id ffacd0b85a97d-3e765a172f2mr5973449f8f.59.1757796135508;
        Sat, 13 Sep 2025 13:42:15 -0700 (PDT)
Received: from localhost (86-42-187-225-dynamic.agg2.cty.lmk-pgs.eircom.net. [86.42.187.225])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e91b2519d9sm2144423f8f.22.2025.09.13.13.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 13:42:14 -0700 (PDT)
From: Shay Power <shaythomaspower@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andy@kernel.org,
	linux-fbdev@vger.kernel.org,
	Shay Power <shaythomaspower@gmail.com>
Subject: [PATCH] staging: fbtft/fb_ra8875: replace udelay with usleep_range
Date: Sat, 13 Sep 2025 21:41:10 +0100
Message-ID: <20250913204110.24980-1-shaythomaspower@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Shay Power <shaythomaspower@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de6647d0..edd467c6bf1a 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;
 
-	udelay(100);
+	usleep_range(100, 150);
 
 	if (len) {
 		buf = (u8 *)par->buf;
@@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 
 	/* restore user spi-speed */
 	par->fbtftops.write = fbtft_write_spi;
-	udelay(100);
+	usleep_range(100, 150);
 }
 
 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
-- 
2.50.1

