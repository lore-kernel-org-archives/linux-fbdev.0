Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4678F2E;
	Fri, 14 Mar 2025 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973484; cv=none; b=H4On0P3szfNlwX4Sls6bKJ1Zh8uqsr+Hbwj51v2l3WnMgb8mmrMCkrc7j+nJaGJvgYMhTmOOi/FL5uVkXSpSRGWyHuDhJhFCeZ9MVhG6HUJ86220F1M3mER7DbCFNGlSOO576cJWlLxBKva4ye6aLLI6w4erZbr/pHjpo5E57TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973484; c=relaxed/simple;
	bh=lQHiypFcLak6lsLXoWDwnUCHVk/PPGA0FiTJLIOtutE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cYxAIxbeVswWtbU0xehY2UrmxfVIYl5S0hwCsCKiLnUsTN3Rp/2l4EdPD3DFmVuklBYjOetE4E7KneVNRnbeE7kC2L3bcu3LctJV6pzh7SE47vPETg3KS3+qls5ndwFZmvYW20kr+YJYZOUTxQbeZvNQNtvXw374VlW5dyVGxEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvwzHpMA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvwzHpMA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224191d92e4so48993065ad.3;
        Fri, 14 Mar 2025 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741973482; x=1742578282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o2H9f8fayNTLuc4RxM/hrBITullJSe5ENEpakpPOGu4=;
        b=JvwzHpMAhMzQ1nvz1Kwa2Vkw5QflYshLaAGnhSzcAuDSlOZmdqwA1F1quIv0+qWy3a
         CgEK7eD62Sr0Y3a+mUchkAln1ioxsG5/ky3ulwYIBV9FqMXhEV77fNyyya3IV4ZW7BlP
         ARNNGzw55tHOsa28x6MEzDsxBHmomNLK6AaJAIPX+1o7wcXlRQit93gQL9rCNPPG9f1q
         deOGnUuRoVCDAyR1+QlXoBCrCQj3FJ5Wue1xA9CPX1smQQ/mrueRqrJiI6yXpfXDzA16
         NG8to+yrJPDZWyIvBXbAccum2mwULXXEgR2RsEpfzbLHCISuY18OdI4VbN2DVlCIcaJd
         Bjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741973482; x=1742578282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2H9f8fayNTLuc4RxM/hrBITullJSe5ENEpakpPOGu4=;
        b=od7ElcWCBukyLSzV8GdJGuxKxis0vV6tYuZ6Ulfovnz+4Hivj+dLzDUe+a3gTs7FLw
         jTOcVQjv8CkvivDS5dFp2FZl5h8OM92BIwVyAr3giyvcxY/ummDBmg+IIw6CWapkAm8X
         bbd0QEWK97lB6QK5LHy6n2xpyQr6MK4UBFYa6U1kzo+/DmkKO1s1G7szBdwHc03fA14x
         3b9jP3nAn5QnphwgHgRFfLaNzK3NHBvKtFddu+yg0p4MW1sVrQGZNOsWs3l/PSo6pgU8
         o5QCUFgayGPw4QkMEXRVMEaiJH/y+0iF2AI3b5BEJh7KJcp4eYZoTjSjZS+DftGELpxN
         TVjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK16r2JeHmU/GnNT1iKeCtbaBMUfLn2Jtk5Oqeg1nHRzRFtnm8y6KbFv/T02bPqzJ0YE3oXgNd4xhw4hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLuMjNabnhDf0Dv7uFmN5/nIq5D4TXC+OkwcByTmxVYaXUkQco
	vUQ08enFKl3RGRd3BsHOMufvKds6J+h1Zzqsw+c+8+3Z8bhvHnO+OxfLGw==
X-Gm-Gg: ASbGncvtV+cYSUGhMJf81R5et0Pjv3+5mrOdoxEp9KKMyR6r668F1yvI6Q54pZjneXN
	7QTc1b2mVTsKbqapWW/O4HHCv7g/rTZwXVOq57YoiwuLy3jS+Ziq/nLXpXRHuDzRxUiyrhg4RO3
	F4m02iKcXrbQRnNGz9EpL1OaoEgnsPpHhOn8fgbV171y7tQTDUaU1uzeKFRfyHi29bcUnPNUndR
	lCRXRHuLDRTpgTvmSuOLGhhvP5LZJXO9cyIpM6ge2wVsAWPE0NoC3uO0q658+JFr5+BhVG23xQa
	qJVCd6fAj6UT8KonRvXK15Cs/R4eYrlDDdckbLunAeiYEupPbOo=
X-Google-Smtp-Source: AGHT+IGW1ErhGDYOgIoHp1zxSvP+OCdC+KrhrI01W0s2eDw5SYAFJ5Fu5ht9zU33PZPMd68g4r9Xfw==
X-Received: by 2002:a17:902:ec83:b0:223:3624:87b7 with SMTP id d9443c01a7336-225e0a4857dmr30165535ad.13.1741973482001;
        Fri, 14 Mar 2025 10:31:22 -0700 (PDT)
Received: from Grommit.. ([2804:7f0:3f4:18cf:4497:3613:11f3:bcd3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f38sm31160435ad.129.2025.03.14.10.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:31:21 -0700 (PDT)
From: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
To: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v2] staging: sm750fb: Remove unused enum dpms
Date: Fri, 14 Mar 2025 14:31:09 -0300
Message-ID: <20250314173114.4476-1-lima.gabriel.luz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remove unused enum and replace its usage with
a unsigned int.
add comment to ddk750_set_dpms function for
documenting state values

Signed-off-by: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
---
 drivers/staging/sm750fb/ddk750_power.c | 10 ++++++++--
 drivers/staging/sm750fb/ddk750_power.h |  9 +--------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index 12834f78eef7..547a96ccba9b 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -3,8 +3,14 @@
 #include "ddk750_reg.h"
 #include "ddk750_power.h"
 
-void ddk750_set_dpms(enum dpms state)
-{
+void ddk750_set_dpms(unsigned int state)
+{	/*
+	 *	state values documentation
+	 *	crt_DPMS_ON = 0x0,
+	 *	crt_DPMS_STANDBY = 0x1,
+	 *	crt_DPMS_SUSPEND = 0x2,
+	 *	crt_DPMS_OFF = 0x3,	unsigned int value;
+	 */
 	unsigned int value;
 
 	if (sm750_get_chip_type() == SM750LE) {
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index 63c9e8b6ffb3..93dafdde3699 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -2,19 +2,12 @@
 #ifndef DDK750_POWER_H__
 #define DDK750_POWER_H__
 
-enum dpms {
-	crtDPMS_ON = 0x0,
-	crtDPMS_STANDBY = 0x1,
-	crtDPMS_SUSPEND = 0x2,
-	crtDPMS_OFF = 0x3,
-};
-
 #define set_DAC(off) {							\
 	poke32(MISC_CTRL,						\
 	       (peek32(MISC_CTRL) & ~MISC_CTRL_DAC_POWER_OFF) | (off)); \
 }
 
-void ddk750_set_dpms(enum dpms state);
+void ddk750_set_dpms(unsigned int state);
 void sm750_set_power_mode(unsigned int mode);
 void sm750_set_current_gate(unsigned int gate);
 
-- 
2.43.0

