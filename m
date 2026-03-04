Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D33CC9F0
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645756; cv=none; b=jBId8fY6djnF04gCaCC5vQWJScb2iW+uIj82PSF60fbBe5Y5IaG61s8IlgJ2Z4BgJSo8OKzqCpIVODgV4UUKBt1d9CYdEpYR+g7s0WopTNuENyS5VnVgIuwb0gG2Bh01iU3GabzT0Q4j61gbIqxdlx1GTiyeulzLTs4Jv0BHKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645756; c=relaxed/simple;
	bh=NrewVoy+CeJ4LUS2omlQWrWteEd+0dreb3Su0BiNHn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCGJTZTPPLEO1LU1eVCB1K1ywPiaIGhgLBkXT2H0SUVnYKENhWkVGT1r/0SZCJSH9OcKHP8gq//ZPKQsI4FkGxvQuSAhqfLCIRf5jnWL9e7Ob9Vd9DYfEBt6gPEVZ8fFS3GiQSrSO247u65HxI1cFM/EgaPO/JqPUTjTHs3OMwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOyLHzC8; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOyLHzC8"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-3598b3351c1so281035a91.3
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 09:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772645753; x=1773250553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kueakoTFarHtmRefKHO97IsjKUAic56lekSnI1LQXA=;
        b=cOyLHzC8JKnqPJFSc5ROSFpLI4jLKktnN8Uhd+WBrWUp1BPDp2+3UqLKb+SxhCH3RU
         O7x4r+JwCiY8o6OK0BAl/A7OhY77xW/Ju4Evley10EdeuCSV2FNwKpl9exzqbqFhNm8U
         sEMZGyIBt2IPmQ1C8abH+OdJWfO1uJVLXgnYPMvTCGfCUaIea+5yvE5oUIy5l0VrRgzp
         dUI8IMPTBUF1DWayBAasH20A/+7Pmtmi2alycu9kBwRuwCxOcmoWBv62q//VmzwvqrUT
         XsgIDevgVwgm78V4ecYHgpGggBA5HhV0VmNzXTK9OD2vvZ74fKHROPkjVu1zYfY6KZQl
         9g1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772645753; x=1773250553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5kueakoTFarHtmRefKHO97IsjKUAic56lekSnI1LQXA=;
        b=WScBPNGfOIIHAQBFGPSEl6jl8cKu3D9MtTdgh099HLjeLwQdIZB0BRnpoFD7hb8TWi
         FjUD3AFpUghnu5Uy8qcNsR4GUgnSjzw/NCnOd1BVRiYUknkXNbU4dO9KQ5fpzNLjZ56t
         oxrvwySVCQFeCKG4HqRpsZBGhpFhEwt9F3YKtoWyv6aeUux+1ns8DORAvWEcAsnT5gtN
         EcXQeScRI5y0tCtPsTyUIZaPtCp2cQyIBiqmc07Y9s4E3Ji2yfiBgv2i3G0dlMNUc6JZ
         6S1tuGv53O/1DenTBA4kNSxHcKp4e0JbpS07UWBWXF71rqxa0CXNXE5kQHCZ7G41wIbi
         znJw==
X-Forwarded-Encrypted: i=1; AJvYcCWvATsyaC1nbGKbFsbApGoOruTZf4DCZ4VgwCRzy4Z6bSOZwucMMe/EkMwDdl0P/egLhVqY/4wm8n7a4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5uUDbd2wxuJgQjLL8kFAcUmwvFnqasMo8ozfRO+XyFuVRSZ0M
	EmIherWULk+AKG+Y7QVrzEOR3fNLh82yOoaxmyz/MDoUw4LNe5FK9RCA
X-Gm-Gg: ATEYQzyhxj9KuXZ8Xhy4sD3hdJgl5Eji74HTidophtp/DApdgyVVXYII+Yv0CtUD/Hn
	uIWvbSCb/8idDJbgTN9l3I7CSLdnaZa2xQOKx6j8ptTXecAGjtR4UluVDeiVvAK8pbjtbULzSJm
	+xwQGZzDahJcJ9mWV2dkA71YJK9YxKb+3KVq/o2293zMjcLywS8/EeYSrlgRYj2SLpMEcb7n0VB
	Zxn6SGHJK9veWNKeo6Gi+blx+a3lzPyN7mnDqu3evypX6muTNRmLm0xvR5t4/YKZMPmOmwmq/9M
	cW8Cnopkl+UCy+CSQURMRkzRr8t6VvkX8C4UrGiWUpulumu23QbuUEuc3JHRFwH2ErCPTYXSVnQ
	qP+lGl0SNCvlMXZmNOnvlyGOTWJEKjqGH3j4IkYH2Y9J3X+MEfqkfWWTbNTGnq3M9FIKCTtsW2c
	tnCH0yq1vUW6RJ/6hZlSSboRXr00bvyd8257jAp4H/olvyacr5sw/la3feUbNGaolfZqQeJ2WTE
	Ad4pFJyEeSm66eCPYnemmPM+Q==
X-Received: by 2002:a17:90b:3fcd:b0:359:7b9a:2cf2 with SMTP id 98e67ed59e1d1-359a688f6femr1869151a91.0.1772645753531;
        Wed, 04 Mar 2026 09:35:53 -0800 (PST)
Received: from cute.. ([2405:201:31:d01f:950d:ab7d:5e5c:5244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4bbdec99sm136901955ad.64.2026.03.04.09.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:35:53 -0800 (PST)
From: Soham Kute <officialsohamkute@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	Soham Kute <officialsohamkute@gmail.com>
Subject: [PATCH 5/6] staging: sm750fb: sw_i2c_write_byte: return -EIO on failure
Date: Wed,  4 Mar 2026 23:05:28 +0530
Message-Id: <20260304173529.192067-5-officialsohamkute@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304173529.192067-1-officialsohamkute@gmail.com>
References: <aaVT1mSeKrSSlrha@stanley.mountain>
 <20260304173529.192067-1-officialsohamkute@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return -EIO instead of -1 when the I2C byte write fails.
The caller ignores the return value.

Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 0ef8d4ff2ef9..c73943341f66 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -239,7 +239,7 @@ static void sw_i2c_stop(void)
  *
  *  Return Value:
  *       0   - Success
- *      -1   - Fail to write byte
+ *      -EIO - Fail to write byte
  */
 static long sw_i2c_write_byte(unsigned char data)
 {
@@ -294,7 +294,7 @@ static long sw_i2c_write_byte(unsigned char data)
 	if (i < 0xff)
 		return 0;
 	else
-		return -1;
+		return -EIO;
 }
 
 /*
-- 
2.34.1

