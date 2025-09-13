Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5F23D7E7
	for <linux-fbdev@vger.kernel.org>; Sat, 13 Sep 2025 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757797568; cv=none; b=K79AlVM50gouQSzpGFPLEKfi5NdMroUq5niQrxFddL81JdYaFpVwrc9yM8OgeieWU9QBWRKqeMMmAdchaQb3jiOoIrpJiDSQVSIbXutAbrXfr8uIYe8/bI+irj+InPHL9SOztdb63y30MWqls+MRw2U0ryCOotJrEski7wlh47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757797568; c=relaxed/simple;
	bh=6cB1PIjaQQyA3kiM2J7WpK5U80/7n0eJSfHZG2fZr44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KZGlFCl0imVbkk9XQpp+DO1blRyUI9dStw6FvXaO0jPv5sVZI+WDVOUFRt4XQnWLcvPpOzPxjEZxbVvXyB7SoVE/Er2YyfKg66LvF92rQYF8IlIC4lXnS1YZ9Rb64/WrrXDB4OlgbcugmGrdPOdWCxb5LiBsCVxwZ+eJd4RsOyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXmGco/0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXmGco/0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so19413275e9.0
        for <linux-fbdev@vger.kernel.org>; Sat, 13 Sep 2025 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757797565; x=1758402365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QmIep1wDMXSCh9cFnFi6p5dn6PsaCtoTytyMPukDvHg=;
        b=DXmGco/0uk0XJ0FEoKVngxNzkb8ZUWOE14iZBFF6eGZGFpGOd+3PbV+3JsRHGqFwBS
         tkh3sFzYMbmIldgPLkTYoc7kexugY8xYZBu/OyePE8pSF/ZqceOs851rTzsWtFTp2k6v
         svVWdQQlkBHM0hG6PcNIIzkcvNgGmay6/N9h2XfYF+s92VcXw4iuj1LQoKyROVRII/k3
         BSk35MYDmllSGtCSjhF0UAcTCepAKW9XIWieRxVNHPC45c55iFkKa9Gya1nfu06oGRBx
         Nh8kyXiTCjm85wmA34O6KfktbRdq5zjQnD8KgtkaernEmhSUUBOr3Yq1SjFfv6CTQ4S4
         yblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757797565; x=1758402365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmIep1wDMXSCh9cFnFi6p5dn6PsaCtoTytyMPukDvHg=;
        b=b0fA1zTrLodvUzNmefPY+3awjsmTHwqtn9vbqK4FYNiR6ayr0TpwhuqoVXpviXPlak
         hmtItUVIwn+IKtQoqZWgnVdKxrfON/U4gEDmsQHMXT9RVeEXhWwlOlAV828yQkNpfSff
         sQhrYP/htQ1I4v9HD89iQ6n5+E+UltfJ7/eSe2xDZNWxA6wGnHeyfCQv0tJ1/NASwqEx
         FSb8mR38HNP3yPaVU/GuTudU8x2vxTPv67Nr3BtRyJRFs4IrYj8T+3LysdYJeOApLuBS
         EBDmVoWvXiBD9af7TOgz8fs4rQvGnCJytkkZBZLvtUpIwu6tFlWdfiW8Y9YBZFItTaM1
         u4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWJaoeZPkUhbUBO34JF5WEA9YHVobU8hUR9P8Frd52lNZQslAMJ/MRLGyc4n+zA9G3h/koYbMEB4lTFGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcaoim+sOeJaj42B2emJDZ2xscpuFGVdxlCUV15nXi4A0BuKzK
	ZukwzEmYC9jzZWdgsqWwaFT/ZOSuTyptfJ04nYfHUknxZTSVl21fRvSs
X-Gm-Gg: ASbGncsfNjVfJbJsQ3vRVxguhvcFgmxS/lnTchTAigNc800loOObNbt5iFffvGh3X0U
	zjfEgJ9f9/rOzpoIwX/oGBFKJnlEWmD4j1hLqkPUUwD4UFak+cIE9EuywBO56BcfDQeUQuqlTit
	hPpwpnS4UyQRKYvlIt12k+CDorJYX1jmzI8mxznZH5pqBKZpGU0Eocmsv+X1PNFF6lJYCF0Zk8F
	6DuzrGXH/D22iVNJDM1r4UMcJT1zRcSy79V1MR9MADmTzl+9y3f3CsOOV3bgoPVnNQ56MWNICsP
	zfXEkA/aqAEtfFRNPJPmGiyBWNDuZz227pwp5pdadgljsG2U+rslPJSEEQeLe1Pc/62wOkdyup2
	Tl7x9ab0lJwYy4Ird83Oy8fMLjiJ8ou1lodmfUNxaN4wf4UYnpn7KB+M+X5gctEzJGXRzLQTvAI
	2XRECC3oLRwB9g18EGYA==
X-Google-Smtp-Source: AGHT+IEYwuoz3GBF+LcAApgP3wlOqXjd/zQg0xRvpKkhECl0nmQkywM1C4DsgdjMud4YB9ZOC1LytQ==
X-Received: by 2002:a05:600c:1991:b0:45d:d522:5b2c with SMTP id 5b1f17b1804b1-45f2120717dmr63479955e9.34.1757797564602;
        Sat, 13 Sep 2025 14:06:04 -0700 (PDT)
Received: from localhost (86-42-187-225-dynamic.agg2.cty.lmk-pgs.eircom.net. [86.42.187.225])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e0156abecsm112655735e9.4.2025.09.13.14.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:06:03 -0700 (PDT)
From: Shay Power <shaythomaspower@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andy@kernel.org,
	linux-fbdev@vger.kernel.org,
	Shay Power <shaythomaspower@gmail.com>
Subject: [PATCH] staging: fbtft/fbtft-bus: remove empty macro argument
Date: Sat, 13 Sep 2025 22:06:00 +0100
Message-ID: <20250913210600.36986-1-shaythomaspower@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed the trailing empty argument in define_fbtft_write_reg calls to
fix SPACING ERROR reported by checkpatch.pl.

Signed-off-by: Shay Power <shaythomaspower@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..409770891c54 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
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
2.50.1

