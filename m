Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35D2C3257
	for <linux-fbdev@vger.kernel.org>; Sun,  1 Mar 2026 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772342082; cv=none; b=qrc54OhKqjDd81DcSMDnHKP3EPYOObmD7u23eNi2KCVo6boI8wzRQNMs9bvk/eraYt1t21o5v3juF5xeABLcZ41leVf1FM7uBoMMJdZFiqMu09BKZvrXUNFJMTftGQq8z6WW1NvjA01FC95+or1YqNJHS7JDllqgYj3RMl9JPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772342082; c=relaxed/simple;
	bh=+94V9P3uZsspdMGc6KsIYWut42QqNWXwX7vEg92NR2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKHOwBM0Sm9HHm+6oxV9WvJd88UgCg/ZKwywvXZ/eo1XAluzsdpRy1x0JCyjG1z7k5fnHjV81PyRPpaVtEwD2GBrxdNYI3uvRSqPghfpexh5fxaMenSF/kZK//rugbjBN2PVUlfTaH4Akorye8dbvTise2QSHTrTVafa2v9VyLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjUomQwO; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjUomQwO"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-358ee55eafcso348363a91.1
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Feb 2026 21:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772342081; x=1772946881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5wud+qGCdJgXmWDagJPYVri7UNngm9Du3LF+naqdy0U=;
        b=hjUomQwObGoXkmQNb4ZzuWdUbr8KnDDaCelVrprCg+3a/WfPmkVTB03GVqC9u9JmKs
         2NXaIdIl5SN610e9QH9Z8H60W9+kqvatFITJoZZVY5tCiQqiftV6SgK9uBDvvm1bP+YK
         /hwlnvaTf1sPOiAMXknwbnTcVcVqEHjb+PwInJ5SkFdyVjKD/7cWrS4aYmJTOOj+fmqK
         PK2IdL/+SX7mFUReKNQhofkLgr02oM7mrAsZGphoe1dWZsBGyZdLM5AdJJfvUz5+ecvp
         rEm6Q1trk2HQstDhItWjrpOqGIfOtu89CrIwndBeN2BjfCzkf+fe64LVMo85KBXu8RM1
         blFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772342081; x=1772946881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wud+qGCdJgXmWDagJPYVri7UNngm9Du3LF+naqdy0U=;
        b=BZu1VYN50gmYhGQ6dyefj7U6w+ViPDK4q73JQjnhxtB6jGLU8cuMwMfpVnzozgTN9r
         VuTLgeoJ4TGOFAnp1pEa5Kjpa+OKvo51PcUje/A5nEYE3C2Pkrq0RDpdpRBNskWUEYw+
         ztWdyEviXc01knZGxhzKsgp1mxRdnj6tVNxSNJZN0ts9Mhjkf7YVYQaccyjCI5C+cTcR
         uCdtn7ruYfudxznYk4a6tDEQHoKKFs6yWsCuCI78iv1UgLBVGsg4DhM2bRogmOlQGnZd
         Y986d48zu9VC07NimJ7rn1lwVZ3miBBv5Vcp2p6lB7LnvwtGrXhMUAj6KbRuouGxOIWR
         Q/Pw==
X-Gm-Message-State: AOJu0YzH/wVlKUl9Agmu+nVbTOoUXPpRDdu6VSN8JdKtz5acoAaKy28Z
	FpaOubaw8T3hOYWxGXwGfyOX4TJfiTc7OoKCmV7rjITe6MlJWrI70pMa
X-Gm-Gg: ATEYQzyYXeUowcHtt9dzb8En6jtQvxsvtSn/TJlk7ubVJrwh16CRFm6lRu7PuwqgMyT
	DMJQs5fV+JIUy9YC9teg5k/jm9Xx9pluk3Ub7dhQR6xfcHi41d/wsS+roXLmevsHb2ouj4Myl9o
	jajuVK/ZNSYyEUdXH+BEpTLjZkrfb7tSdsm0tRei7lNt/RQNV1FN73wbuhqXp9XYmuusGo0tCo1
	qFsIT+1fp+E46RJ7lBLInxTTNcpRdvNTQ6INlqs32JiC0+KHk6Zm6xOwt4UajLY91AG5gdnkW+3
	qalSlPoj1aCnhKdegVPoTkt83wl5i79psRXE/XZ5BMhi8sMkdOJ7jIlkPsv3NzUSjoLxjIcbQ5x
	ru8veUeficVH2Ik2VsT+SVJzfzY7mb3y0dD7IM8F5lhkxdDKxrKvdtp0+V0XOJ1RfShBiEy5uKw
	HNVvQPmmCe44lP7L0ryIZ7br9yZbR6HFIf2QJDtKCrKKpSA7vmIOu2AqWPd8pvkZB6H1KbQz+Hq
	lid+zOP0mjzrQ==
X-Received: by 2002:a17:90b:5104:b0:359:8988:38c2 with SMTP id 98e67ed59e1d1-35989883b9bmr288915a91.2.1772342080607;
        Sat, 28 Feb 2026 21:14:40 -0800 (PST)
Received: from cute.. ([2405:201:31:d01f:a5d:5f1a:a014:e1f5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3597b85db9asm1616298a91.8.2026.02.28.21.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 21:14:40 -0800 (PST)
From: Soham Kute <officialsohamkute@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Soham Kute <officialsohamkute@gmail.com>
Subject: [PATCH] staging: sm750fb: use proper error codes instead of -1
Date: Sun,  1 Mar 2026 10:44:34 +0530
Message-Id: <20260301051434.28187-1-officialsohamkute@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace magic return value -1 with proper kernel error
codes -EBUSY, -ETIMEDOUT and -EINVAL.

Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 4 ++--
 drivers/staging/sm750fb/sm750_accel.c  | 6 +++---
 drivers/staging/sm750fb/sm750_hw.c     | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 0ef8d4ff2ef9..d90a93ab8fdc 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -294,7 +294,7 @@ static long sw_i2c_write_byte(unsigned char data)
 	if (i < 0xff)
 		return 0;
 	else
-		return -1;
+		return -ETIMEDOUT;
 }
 
 /*
@@ -394,7 +394,7 @@ long sm750_sw_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
 	 * range is only from [0..63]
 	 */
 	if ((clk_gpio > 31) || (data_gpio > 31))
-		return -1;
+		return -EINVAL;
 
 	if (sm750_get_chip_type() == SM750LE)
 		return sm750le_i2c_init(clk_gpio, data_gpio);
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 046b9282b24a..fa593d4f31fe 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -97,7 +97,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 		 * got something error
 		 */
 		pr_debug("De engine always busy\n");
-		return -1;
+		return -EBUSY;
 	}
 
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base); /* dpr40 */
@@ -264,7 +264,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		  (sPitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
 	if (accel->de_wait() != 0)
-		return -1;
+		return -EBUSY;
 
 	write_dpr(accel, DE_SOURCE,
 		  ((sx << DE_SOURCE_X_K1_SHIFT) & DE_SOURCE_X_K1_MASK) |
@@ -333,7 +333,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 	ulBytesRemain = ulBytesPerScan & 3;
 
 	if (accel->de_wait() != 0)
-		return -1;
+		return -EBUSY;
 
 	/*
 	 * 2D Source Base.
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index ce46f240cbaf..e4b6b254335e 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -518,7 +518,7 @@ int hw_sm750le_de_wait(void)
 			return 0;
 	}
 	/* timeout error */
-	return -1;
+	return -ETIMEDOUT;
 }
 
 int hw_sm750_de_wait(void)
@@ -536,7 +536,7 @@ int hw_sm750_de_wait(void)
 			return 0;
 	}
 	/* timeout error */
-	return -1;
+	return -ETIMEDOUT;
 }
 
 int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
-- 
2.34.1

