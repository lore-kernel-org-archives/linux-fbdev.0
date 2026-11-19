Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097211;
	b=boZQyHHs/ZpcT/2KlGuxiO8+psAcHJ1FRKByqPD1SnT2H8OY5PHhOE1H2E7EMQKnLy28
	 xWKk7zNtLNavBRd+cvE7PxwZ3vHTC4ImYGdy03hW1RpCHlgbH6PaKWFyY6Df30lz6zho9
	 vU5Q8HgjnAeWdCjKpPi99mxbDIwBOPeVNz/qMfFVd6at42qI9PgIRy7IHpgPqrDpxvb7k
	 Y+/FNUsHENpzNoC4hQBvNCaqfopLt0PGVKn4Mcgb2vzy1fhEOyvDVXtaZ+AOGFCprUspo
	 yityy3P0iCOqI15mTj/y/T4oFMn7GBpS3P0qyzb6IcZT/CYErIX7SbBq0nIvJM1jkTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097211;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=sp4rvbDM8GISTutprCtHpY1FubOH5yKlYsRY2NVBflw=;
	b=rqFkN9HC9J3RGYYOWW0mkJ0oLfLnHjGfXj4btYm87tjNn/Auingqj4wkkXPSoI1VlTDf
	 3Wx7yzI9IpPU2T0fGABozfvOjvO0jXGzxskPUVot5FQaW/xTEKQAFgl+B3SmHRRBXhiGo
	 DriVR0KoannBTkSWgK/G99bxaO7fKVYsu8Hk3mjFnmfIGGwBsn1o6sCyLPiszF5QHW9mn
	 8wm/tDoagpasLNf+P8URpqu8Aybwavp4z3LN2IoFPUErRCtTzldtTOrhY4EOej0g2ESg9
	 8mu6F8rqbwgoc4JGnOY7DTqxrJYSli2GkFHff8koGTWTTaAsQk33/Sqoiiz2kTbQ4/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UeT1tk7M;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824F606A32A;
	Thu, 19 Nov 2026 14:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6824F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UeT1tk7M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sp
	4rvbDM8GISTutprCtHpY1FubOH5yKlYsRY2NVBflw=; b=UeT1tk7MLiS3d2L2nk
	8A+cvM4gZLWGGtVZpFm0i0QG8OnnRpvbYTZFQ9kYxfyjDkulA1FLT+ZMvjyJrigl
	+mT7HD91I7U+ziIOZWBOAcqmSCINdRA43JQnR6QWlIPCq+4GwV0r1qzsQ36c44cS
	sLCzUAMIWzyYeJkvfNHJx7BjY=
Received: from Ubuntu26.04LTS (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnb6hdAv9qLxZ+Gw--.50288S3;
	Thu, 19 Nov 2026 22:06:22 +0800 (CST)
From: Jiaqi Shi <shijiaqi_develop@163.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiaqi Shi <shijiaqi_develop@163.com>
Subject: [PATCH 1/3] staging: sm750fb: remove unused MHZ macro
Date: Thu, 19 Nov 2026 22:06:18 +0800
Message-ID: <20261119140620.169368-2-shijiaqi_develop@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119140620.169368-1-shijiaqi_develop@163.com>
References: <20261119140620.169368-1-shijiaqi_develop@163.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDnb6hdAv9qLxZ+Gw--.50288S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTR-BMAUUUUU
X-CM-SenderInfo: xvklyxpdtlsvxhyhz0rs6rljoofrz/xtbCzh4yhWr-Al44eQAA3v

The MHZ(x) macro has no users in the driver. Remove it.

Signed-off-by: Jiaqi Shi <shijiaqi_develop@163.com>
---
 drivers/staging/sm750fb/sm750.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index fd1cf9eb5797..7511fab2e0e3 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -5,8 +5,6 @@
 
 #define FB_ACCEL_SMI 0xab
 
-#define MHZ(x) ((x) * 1000000)
-
 #define DEFAULT_SM750_CHIP_CLOCK	290
 #define DEFAULT_SM750LE_CHIP_CLOCK	333
 #ifndef SM750LE_REVISION_ID
-- 
2.53.0

