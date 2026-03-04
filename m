Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B763CB2EC
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645752; cv=none; b=T08JT2HCR4qT6I2UJMFM1TwOkBXsUSp/q3u0tLEtIkNmlXY90gVmH2ERyku0LqCzcpJUqhAsi78pvEBeBs0VakkFkuUfuaMz2b34eJJIFXEDh8qj9QLxfDT5Eeo4GeRdzw9LHMIzcCEF7/CbX+nQePXxL159L7hl3vUmTxS/M/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645752; c=relaxed/simple;
	bh=ZPfxzik31T03EgSdWiRyC5YG5TXWyYF8Ds6MnhvfdYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PDU0htoKQM5L83vcP2bNFbn8WqfITBpUBszpZGPVHOsX0tP5LUx1NAlZG4evYpiy4TmoD1DEYXeN2/73dWWSf+2uOD2LHwSXQ9g01FlQ3w4wYwfZGiL6cp98Op4fXeMLD2VgPC70/pLie/lH2wBSLY+eRN6zmjnfJhsjXYJBohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeIV7yg1; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeIV7yg1"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c70c38515d3so832075a12.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 09:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772645750; x=1773250550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FKWt4Ue46a5Jtl3J8WxKsJ5o7nZVt2UhiVFWoT7/Ts=;
        b=aeIV7yg1QefRSo3KRn2DKFLPwT15f/0qP3iM7Rvb+P2qGVL+EZ+yhLLNtebG/kjzxd
         qUW3bKJIP3jRMt/IWTbXeMhwoCnEOAtVW/lGysFnwgfH4z+1FvWrQfBzXiQQcAjan5vf
         61Iewl55EXNSjKvjUolr6tQc2XGb1DHZ20y3SjvNuR7eOIWnAd1fuvyKVfLQisnA/J6w
         FIAYvSH/TXFIKV26lLHgSS3bEok9v0SNm12V5O4oxoCm54yIFQjk8OV0JTN3O+Y+bebt
         PJt6tkOQz+FONX/nR49eXSDlX2ROj36f54HfLZ8fZOeAXFZNVMmMcPrvmYJWmm2PGYx3
         3fHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772645750; x=1773250550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9FKWt4Ue46a5Jtl3J8WxKsJ5o7nZVt2UhiVFWoT7/Ts=;
        b=J0mDa87bLgJOXvWOcvT5XxAxsAPzac+T+ynOOp7VqEJ122gNxRjAH9fVIRAI5Zpuqm
         YywUFMGHVA2jDgqDRNVc22mQOwnFdIs6RR/6glknqPL3Paka42jHtcQTMWwFazkvHl+e
         mRMVaV95SDHM6YtIJr8cgmxN2HW5/NC2iHz1VXsm/QX72hiesnkBmfyWcj5SXU7qv6iu
         Oq/KbRTD4GvH7Glm7wuhIqAyYJLKSV/BQNR9mTdHAXjuntWVuvyKVZ+aolBflixTWZpa
         TZw6ZQ7s2C6oEglV0rf2+EHRs2XvIDCqFTUP9AMHkkjdVx4BnQzGf05LaGzeZhX+f3Yh
         vrYw==
X-Forwarded-Encrypted: i=1; AJvYcCWJM+AtrlOiyK7FY0kOmbxvSf0bKnsXNFW4hWRBIzCg4SenAg4V8qmKuq/qpaHuAWaFD5Q4KsUDsEoVvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9KDvoj3p0/Lz7nZE1sB3PG/CqRyMU/P6idf40u7H+mXqyRvL
	H9wlipx9Dc2BOdTW9hlktUdEael12yRN/e1fcvkm5NayTpeX7+7Rf95U
X-Gm-Gg: ATEYQzwsSwPZGjKgkyc8KekHvbKlhh6LClzrUh3KJ4Y7QX4GVuDMAGi6HglfAZBLJXu
	nw2fvoVUlBrnAjOYY7z8LMLnyCw8giOP/nAHqxtM1lrqARa4RVaNOQ5HqaYGmLaMmixsZDBf4wV
	XPiOYeb9QaRMecG75tYggYS/0hYTB4nC0KKEfVSQY/r/vcErKvyEycXIk0kuaLbQBQ2y+PklA7B
	wJtu6reBska3gI2xfODvgaNT6aN8x6ZKoM40H2pML4kaovzlvSOAKZdoT0HaNDVjps4LJ6lN4Rf
	dYlI/95UKz14lt0dJQyraZEy+UZkeDTv+cP+UB4vClTRNg2yqmeP0FRMRRjTRDJEIEMx1KoTWl0
	eYP7bRdtJKJr3wr6fekhUVm+Mg8FJgijozQLgN6PDofWnzEO4BGhCJvuZdhw0jVGdlaYrVCbb+n
	27kI29iDu1mz5kBdM2FS4RCc5A6gkj6EKnRnrlGXBb99GFYDtKlTyZ9vHDVmNMVRlOYjHBDBfCl
	qG2Sqgys0uCtz4=
X-Received: by 2002:a17:903:38c8:b0:2ae:4cfa:7e3 with SMTP id d9443c01a7336-2ae6a9ed66bmr22732905ad.1.1772645749686;
        Wed, 04 Mar 2026 09:35:49 -0800 (PST)
Received: from cute.. ([2405:201:31:d01f:950d:ab7d:5e5c:5244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4bbdec99sm136901955ad.64.2026.03.04.09.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:35:49 -0800 (PST)
From: Soham Kute <officialsohamkute@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	Soham Kute <officialsohamkute@gmail.com>
Subject: [PATCH 4/6] staging: sm750fb: sm750_hw_imageblit: propagate de_wait() error
Date: Wed,  4 Mar 2026 23:05:27 +0530
Message-Id: <20260304173529.192067-4-officialsohamkute@gmail.com>
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

Propagate the error from accel->de_wait() instead of returning -1.
The caller ignores the return value.

Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index f2fde011e7ca..7d11810864ae 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -325,15 +325,16 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 	unsigned int ulBytesRemain;
 	unsigned int de_ctrl = 0;
 	unsigned char ajRemain[4];
-	int i, j;
+	int i, j, ret;
 
 	startBit &= 7; /* Just make sure the start bit is within legal range */
 	ulBytesPerScan = (width + startBit + 7) / 8;
 	ul4BytesPerScan = ulBytesPerScan & ~3;
 	ulBytesRemain = ulBytesPerScan & 3;
 
-	if (accel->de_wait() != 0)
-		return -1;
+	ret = accel->de_wait();
+	if (ret)
+		return ret;
 
 	/*
 	 * 2D Source Base.
-- 
2.34.1

