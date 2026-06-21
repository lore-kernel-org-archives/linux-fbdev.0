Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690022A4E1
	for <linux-fbdev@vger.kernel.org>; Sun, 21 Jun 2026 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782023413; cv=none; b=u1gnki59tlBuIVplOqhmcyCthpjPl6oEbB8vVhANjkD1DxzwlWg6WEsZ8HfnVqQoULiRKe4xXwZiQm5c139QRLDNsBr+gTuQQOghb40JDARrYnqqCSYVjCnAYdFCjTNxJair83Cxp2mKoMbC/33uaKhEyY0G4axqvOLWa6t28iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782023413; c=relaxed/simple;
	bh=LPBX5peVu2+CGfivQVGZ27pn3uwBQKahf3dtTK2W6jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1FCSH+mLND3zrTucsDsCtvJNhL0Z7QT66GQK+kgmnGbA5Kw1OWgXz0dHF5v34wFk/jBbJUl9uZbSRu5eD9z9xpqYjC/HR2FFdNSVVczCMQP1MS6NR4P7eEzMSGzo3Ci+A14HWB3dHpuGAz98TVVhWE+xPRKLGIEYyG5hm9BBdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHcN1kbA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHcN1kbA"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8454160043aso2590149b3a.3
        for <linux-fbdev@vger.kernel.org>; Sat, 20 Jun 2026 23:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782023411; x=1782628211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6tpylLWP859Y5GaGz8xWvHuAS1IpP/+yGasAke1UnQ=;
        b=bHcN1kbAaVFX+WZ+1Uc7UZaHJbbo+klo3MdlrbcvW0j6kgCdNuHwQdxmwZZzA1q9Ym
         uhwAvM7ZEd6ZN+ydB/4lTRV+BM6SGQB5pKRrnzi6uWuZ/hfh/iwrhhUVnQ3xaIpa/Lcn
         GmyMfNE39piZ/CO3j3K/wOxMUSOWTl0LzhGNzh32B/x3xY2BJp6Hk2530AOaUMxj8ok3
         f41zNmupRKsqHxcZUbLTB4DkZEvlGrtSdyD0Eo6LnFz91My/fwtJdWtHuHBs0MDY/sC3
         tP4l1aDsV1a51juSZI/7UNtC1dgmclMbR9Z+7NqrmwqdoOvWGSew5/MBkBljYqYqSugE
         LVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782023411; x=1782628211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6tpylLWP859Y5GaGz8xWvHuAS1IpP/+yGasAke1UnQ=;
        b=aUI/P4dMcXISSwBMDu290vjrhETfGqOlwHuHAQU6X22K2h1PgSmNk1y51/PneDubxZ
         Rrm2+Q2fFZXRF8j+Ab5atIQX5CBBtHwyqCe39+kHemb07pdW/RlqNMy/ex0G+k+cgACC
         8LsKiJ3q4w5V+n4zJ05r5mj7oEAstD/S+TRr0H34+FxZ08C0FAcVLi8cNXtETGkbkqqa
         DiXYJBtokFAzVhDFWuSpDZnJaMOTT9or72YK1fNcS9J0SmUOVhB+g4MRKcVdv2kKzuzT
         EAEGBz1IDrpFZyrPykq06OBsuLZ+vfqfGJArZk+BNkawMD8U51tuX9Y7MmIA9DA9bDxC
         heRA==
X-Forwarded-Encrypted: i=1; AFNElJ9jBp9Wnhv7yxMNknnXqVasJt37rG5FBThCUrpkYFHBQgafiLb+T/TIipzPi2uhKOvwzbPG30pBgIMHVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0XyhRWzf951iQQjjYasJRdIP7HjwuL/F+hsNJw26i4+55Ep95
	vB5+mGIZfIKGKCTRaxqhtcu8Z85xEEJb90U3I33dYDysa6gYtxmcaaMJ
X-Gm-Gg: AfdE7ckX44mtI9c/jNzl1e0vYssJRacmLF/nB7WYgDpuBy1GkC4VNDskURspb/4Qu5+
	NlES6r1gRRyZ9qiQahexRtMenv4dQivrtlIdL3kSqBJHIKsJ/gaLDTtR4UR1p8Wj+qgPG6KxzB9
	MIeaIYP9L6p259wo8wOXyMYLhxqxByJTGnb5iOecERWiOCQMarZsTCTc/Qwctc5yPI1EQ/r1v+U
	waGpNWKCNDjx7L8iE1MR7uy1zpyVXqF/ZmcEfNVfuzuTON0M41I9yHZRzGJcj9ddf4y38V4VIDk
	pRC/Uj5L5HUfWRYjpi6SimtaSTolrsiP4hrY8+AY4uiqfhslfcBbOnpFw850g9qrGXtjj5++Zkq
	kDukJb/t5DEWs2aB5lKIhwJkLoP3daakDX8ESRBUZW0Uro4AZQylnR/RnVaWjzXSlSdLeI1uYVU
	dG5Bxyy2Myhz8OuMwL6ZQHmEyC8eyXjEehXqwS+NUO3g==
X-Received: by 2002:a05:6a00:2a0c:b0:842:5d9b:d590 with SMTP id d2e1a72fcca58-84550887d3cmr11687574b3a.30.1782023411053;
        Sat, 20 Jun 2026 23:30:11 -0700 (PDT)
Received: from kernel-dev ([49.36.101.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e76d3csm3812486b3a.30.2026.06.20.23.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 23:30:10 -0700 (PDT)
From: Aditya Chari <adi25charis@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aditya Chari <adi25charis@gmail.com>
Subject: [PATCH] staging: fbtft: fix parenthesis alignment in fb_tinylcd.c
Date: Sun, 21 Jun 2026 11:59:45 +0530
Message-ID: <20260621062945.42519-1-adi25charis@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a checkpatch.pl
CHECK:PARENTHESIS_ALIGNMENT warning by aligning the wrapped
argument list of write_reg() with the line above it.

Signed-off-by: Aditya Chari <adi25charis@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index afa8f1c74..d58b12472 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	fsleep(250);
-- 
2.53.0

