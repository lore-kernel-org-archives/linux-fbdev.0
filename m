Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F72ECD05;
	Wed, 18 Jun 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257424; cv=none; b=J0FRfTrsVa0qkNgA8muMlGwc6LBvNi7Dowfog9ZCCxKaitV5m6iJeb89YgsAHazBrxw1ZA9Hs2ETmCZLieDUL6j+1GcDJ83OLsJDU1b8jPNOYq53OgCISpzJo8RpMGxV/bvvstCTHj3hDmTYLhQ7vb2zEFRJhsZtNNtu4lkC5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257424; c=relaxed/simple;
	bh=vyr/GHGO6xfTWq6buMng2zgyugvAz16GZ1LMGwzKwlY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qpg0Mg36tqxSc2gLkzs1Yox251bNc18Nk5B7uqSNiWXdySA+I7nSOrR2nivJdMazTtorN4Ze+UTvJ4VlE4k2Ow2msX/YpsXXSCCFQZiuSq9mvD8GGwK/g+M+sFeAZKE+9S25bxh9t4oHtaoB5G63wMPxj0xpnUr2O25BML+RsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmCHxPUT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmCHxPUT"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso8028842a91.0;
        Wed, 18 Jun 2025 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750257421; x=1750862221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kd3C6/3Ctr7DBwFDySkUZ6vFzUEoBWHbZrpLkfWxSyk=;
        b=SmCHxPUT3OqjhX99Kcumn9bpz5492JtPdBFPL1whv6foTADi1u8nhry2I4MouUgFQF
         W70eoPSgZbX3dd/MCZNi/HE6LqVDfcddtXngxAD9dQTFgWspEb2m/BicSN8UDxcJ/SAI
         Zg/JjFRePrKs++dFi+JpVqTaRTWqAsENO81hiYF/4qYIV3PgjCpS+wmcekuxxESVB29r
         3q6IG+b1nUjfCCYeuwMvoQFOKgqtSkYDwwqNja6BQxGUwWbY5VHMxOG/49WAXWLcxsxy
         R+Q+Ex05UN2IOIcPzXB8Shz2wcE+K1fByCKm8ZEElhLoUy0Tt6OZe9wRZBozD7nKyPWE
         U3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750257421; x=1750862221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kd3C6/3Ctr7DBwFDySkUZ6vFzUEoBWHbZrpLkfWxSyk=;
        b=m6Y7//0spz/Ip+Gj+fR3jRvTbNE6Q8S3/sLuM/ncVgnmYLZN2BQRXEdgMz1bDTVdRv
         PiO5x5mm5bNeGmzwtlnf0aFsHdUiOoC/ASHo3OGW1D0EzNPZo9tHhgHIZXHdSvwivwO0
         kWij0PzyeUi71P1LSPmCrjwJ2kIA9ZuGW1tpPjaKXY/Pnw4E7tISl3LBYuXs2cr2i618
         ZbWlG4IBZt4KrbuWBOl2Pc0ar2TzxhEMz/iNMeJFlf71aIb73nhZruDwAU+U/jqqk9r9
         DHMUuyhYuQ+HZ6oGEfv1hfN7I9qg0Li4vZ766yPYC4Lj8XAj/QW8zkdZks67FYNAc+fj
         BOZA==
X-Forwarded-Encrypted: i=1; AJvYcCUYfGbNOQiKBKZqCtfipfjTe/ppMTXv28EhyBXpLV6x0JAaGbftQ51fgnvuoEkRlbraukFPSH7GYMRzfdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFmgM9+C3T9PlNXlwN0VhuhAuQ3uxGXH+vfyUd47ZGi/+9nciG
	8Y6kkDN2DPgXlqZwptVrdCzcE+3ciznQlyAz4KIcTeKVT0KkkLwRshQD
X-Gm-Gg: ASbGncsA6YTsKtzVIoqlgrCMfiSOuJ8QEFfzewGXCePNk816e//Ik/G9S24YZLiGlYu
	yrgRnMpqy8X1Wvl0yZpuGuSyjuVbTDIkb0a/DookqLTX0eVDuEffTpZGB9MHwyggZU+JlNFZ1Bv
	4YZZe/NEa0TyovPQRAMJS8Y4wMFh0l8zepGdv2oyvYybEJPpuclAXbUvMWtUVENh7EEfkYRWre/
	rswf8a4iEtewVmoZPZMb5fUvQD8v+ElCSNWxvLW1SvgieSMf60ZdpPZDe3okgFuhxgQIEeltQU5
	1vKiGGUbllXWd/lst8x3RnWXiQFbBLa2clFFiNYjBAG7IoolItkfSE+uS7aS
X-Google-Smtp-Source: AGHT+IF4PFBEgS42FhKIoke8rPoBIVhGT5/T0QrFVR80PDyAFSLZkjMc9mwlCqeSuoGjRMwER4MFSA==
X-Received: by 2002:a17:90b:3c8e:b0:308:7270:d6ea with SMTP id 98e67ed59e1d1-313f1d2f830mr29006301a91.30.1750257421149;
        Wed, 18 Jun 2025 07:37:01 -0700 (PDT)
Received: from zinc.. ([182.216.63.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deaaa05sm100699905ad.174.2025.06.18.07.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 07:37:00 -0700 (PDT)
From: Kisub Choe <kisub.choe.0x1@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kisub.choe.0x1@gmail.com
Subject: [PATCH] staging: sm750fb: rename 'hwCursor'
Date: Wed, 18 Jun 2025 23:33:42 +0900
Message-Id: <20250618143342.6517-1-kisub.choe.0x1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename 'hwCursor' to 'hw_cursor' to
conform with kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <hwCursor>

Signed-off-by: Kisub Choe <kisub.choe.0x1@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 drivers/staging/sm750fb/sm750.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index bb2ade6030c2..612c982bacd7 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -598,7 +598,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		crtc->vidmem_size >>= 1;
 
 	/* setup crtc and output member */
-	sm750_dev->hwCursor = g_hwcursor;
+	sm750_dev->hw_cursor = g_hwcursor;
 
 	crtc->line_pad = 16;
 	crtc->xpanstep = 8;
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 40051798efbf..d7e02ff3d6c6 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -113,7 +113,7 @@ struct sm750_dev {
 	 * 2: secondary crtc hw cursor enabled
 	 * 3: both ctrc hw cursor enabled
 	 */
-	int hwCursor;
+	int hw_cursor;
 };
 
 struct lynx_cursor {
-- 
2.34.1

