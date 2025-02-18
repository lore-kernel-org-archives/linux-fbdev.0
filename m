Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B881E5215;
	Tue, 18 Feb 2025 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905152; cv=none; b=eD+C2d6fZK8tT7guU6DvlsOF77Xp+o22DsieVghuaBK/dJ9KK3BhDDHGtlacPvQYoLICTfv+Xrzlh8suPS7bHE3HQf6hzy+EC37c7Am6/6NMqAUV/Kbb1y4fY/XCrCeXGTCyDfhsMm02d6u1wn340oomBKn36E8K3whOvvjhloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905152; c=relaxed/simple;
	bh=NAVr74VW51YOUG+zso1Op1HBKkPxspaNT6SS3XlwKFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vit0A3mtSAj102PjEaEKlUvTi+ly3Dg/n+lXk7qQDz/HI2/BRcFipmlcj6vx7HydZPvHCZdA94JITycyVB/UskrGGsJxjip/mjIDs/cgcPPsehEOXfwrIVyJvBUH5O3qPHK6Tx7ZrTeglBV/z/UA1HWR7uUGti7AT2COFf3QIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0PP9jFc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0PP9jFc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220d398bea9so82103485ad.3;
        Tue, 18 Feb 2025 10:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739905150; x=1740509950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2kYKvzzn3lnf/7s387qyzmIyaz3OrVD3UKrYZvFboM=;
        b=Y0PP9jFc8mqGblh2uqO2fXA2vocuHqsfGX1lTGozuH0GIc5DqAFGejDtv83U8AwzSj
         fMnyF0NpazMq9J0eRcVD+oRLsuKCgvyB++ufC8vFAPb21SYGyT3Pc+pTdNugJk4Y6uEK
         UPYS+/uZuN77sFERV5m745YGhLoNgJF7WFilNEse5s51QlOfB6AfDADJzpfXN+xzM8vE
         RjgayIM0Hb9aY4LX82kKAh/i/PaZkYmheehtKNiZ9D+m4GSJtFKenZ/V4TcZjONnl6mW
         SeL77pI+kfyp5lz4WWjTZimYsVVlwG1L+syQsVc5dJe/RZrS440eZho4s62820jEMnIE
         Kp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905150; x=1740509950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2kYKvzzn3lnf/7s387qyzmIyaz3OrVD3UKrYZvFboM=;
        b=TtsZIBxdfrWVj7vcd+jQDruI1WEiGR6JA/4RAUzdHBvLG6aLFp2o2qEuMTKis5O2G8
         TROg0ftC7DLX7Yeg5TH2Aa7IgaUGue08vF4lSX3OvmjTpScBZG5nETx8FVe6h+uoGprN
         CttF3lYg4H/zV1U94czwCkSgQ8aKq1Ou5tzdcwrrMBygE3TSKcFi20nKXC90vLM2RDWr
         3jAZqskc6HEt4wQ2MT4Ne0Tz2Y+Ey+udNJgZVLJXD8CsGBPtu8fI+BOwYy0QpyQ++Q2P
         3XyYEC9+XJm5IL26nHsvo0drQxvcnHah6cZhn8hlIdU+ekeas/Ue1HobaX1KtDgnpNuY
         VpFg==
X-Forwarded-Encrypted: i=1; AJvYcCWBR7Pp2egeaxCg0wV+/o87FhfML7ztRocTOcL1SJ8WiXjhvU3ijKaDqdopWb8lyIgGrn7SAnNgL+pHkQ==@vger.kernel.org, AJvYcCWcSqMC7us0e7tl/zQkJSpbfrLppPmkxxtMIUnAr3t8JyEMaW4btkS/Nef9WXxnyFPokxD+iVt6nqZlAlWa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3mwwT9o9lZ3/tLW13lQk1u1F9ancf7/wFZZ4OMaeCf41MdkNB
	ENlxS2eSO2hzTLCXsWzkgNYCvcFDT4FhBAyIqEc92SaRjpK/Ppuy
X-Gm-Gg: ASbGncu8NJWUCfeTBDl2OUB4cwdgbKSprjeqleeie8KmdVTHYb/Vsp31JHJx/YDu7Lp
	RD92xSUe0TIkkIZUbMBcSwlwpfPATXQv0+ZC634lmDVmufSDF9mv3yJUQLd/PH66+jtPNW7yHmt
	Bl0kL+zw9k5TDQg8sFf4uL5MDjYNnYw0GVTXw/pO/drKTh99DBC3KyrCRZATj1Uw9mocYke+ogf
	VGApxPsi3PQOJjAdJyNKg88qEOfSr0kXhQo6SeG0leaWuBtM4eTkTJNaekPR1OqIW6tw/uTjG+A
	ji8dgSINezvL4E4qoLR4QKxhqyTnCfcf
X-Google-Smtp-Source: AGHT+IH5tb+e+tk+EJnYVSllRelw0h9SjG47BaGOE/to0hwJO41mZiGf7NcDeXif2nGa++9e7YBZ9w==
X-Received: by 2002:a05:6a00:3d55:b0:730:9446:4d8a with SMTP id d2e1a72fcca58-732618b7abemr24682912b3a.16.1739905149918;
        Tue, 18 Feb 2025 10:59:09 -0800 (PST)
Received: from localhost.localdomain ([36.255.84.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73276f20c30sm4903499b3a.21.2025.02.18.10.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:59:09 -0800 (PST)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH 1/2] staging: sm750fb: Remove unnecessary volatile qualifiers from the file
Date: Wed, 19 Feb 2025 00:27:48 +0530
Message-ID: <20250218185749.22144-3-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 drivers/staging/sm750fb/sm750.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 097d6558b7fc..8eab90f0f33b 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -50,9 +50,9 @@ struct init_status {
 
 struct lynx_accel {
 	/* base virtual address of DPR registers */
-	volatile unsigned char __iomem *dpr_base;
+	unsigned char __iomem *dpr_base;
 	/* base virtual address of de data port */
-	volatile unsigned char __iomem *dp_port_base;
+	unsigned char __iomem *dp_port_base;
 
 	/* function pointers */
 	void (*de_init)(struct lynx_accel *accel);
@@ -128,7 +128,7 @@ struct lynx_cursor {
 	char __iomem *vstart;
 	int offset;
 	/* mmio addr of hw cursor */
-	volatile char __iomem *mmio;
+	char __iomem *mmio;
 };
 
 struct lynxfb_crtc {
-- 
2.48.1

