Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315EAD531
	for <linux-fbdev@vger.kernel.org>; Sun,  3 May 2026 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777768902; cv=none; b=beY7Wr1OgcY71tZu2XNx2zSE1Eh7Xm8Zk+Bziy9qUvUZ3aB0HVvMHxE63wZiDgb8MOA0wjA1XsbF43qJk3fsUoHRmpUao1vpEje2deTu4QO+Fg2iHVFjD1gDlc3CGOs6xDsXJEPuRS5Yh0E6wsRKxHekqXjzvEVEunM0ICGiGNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777768902; c=relaxed/simple;
	bh=3dtDkPvXcEobzFH0LktvTQE3OVk24kNitpzpzy7IVNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4mWb93Igq05dUvuHeGwhj2Z7m4nBYBOL+ykSm/MTI78BSTK24XVsZe+wsd2M8o03lljTjxCeosArSLdL0youFTSZmwxV99mjY1oZrusUeZmm0V0zjFgDvqs0Va/GXUL4wi8zwE1BdONpb15/R4mkap1d2+Po2NNPBxLYXAm/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maestretorreblanca.com; spf=pass smtp.mailfrom=maestretorreblanca.com; dkim=pass (2048-bit key) header.d=maestretorreblanca.com header.i=@maestretorreblanca.com header.b=Hu1pzQ0O; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maestretorreblanca.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maestretorreblanca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maestretorreblanca.com header.i=@maestretorreblanca.com header.b="Hu1pzQ0O"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-573a81abef0so1965123e0c.2
        for <linux-fbdev@vger.kernel.org>; Sat, 02 May 2026 17:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maestretorreblanca.com; s=google; t=1777768899; x=1778373699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ3Ea4r3M7K4WkR4phD4I50DLVzuYSAOvgGlIvX72M0=;
        b=Hu1pzQ0OzFhX//Qor9bmNOhJgzkC4R0XWzxEQdSansIt1ddNFHO9+jV2Jg0TrVtUVW
         f7NppYFfWrj9iHcvzIsDMt2157c3ZxZ93gNoNX1rxXswELoyZjMBS2KMd1w4wC7/4WTB
         E/LVjZzsLCW4bP5aiPr15unHoto47ugYnKf2/vboSf5fx5Q3wdAMiFbio0iY57wdZp4L
         Evv2QheSYaAbGWLeENpyPJR5OwI4DJnzk5pGda5GfKfbiRmhvxha2GZxbzoX+71Apesc
         gLKTYrIn91Gz66hDGSdy6ONvcZVaHFN95m7xElSlcHaE7K86C9N/rdJMsAV5pSA9oow5
         6W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777768899; x=1778373699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZ3Ea4r3M7K4WkR4phD4I50DLVzuYSAOvgGlIvX72M0=;
        b=hk2+ho+OAVvdpc+zK05xzDMe81zGc9Umdyj5YvEPWGluIRVjNry45ekB8rdx2nQtdZ
         eJ44OrS1/j3i5C/K8HqSSchqF5jAyESC1RkZutW4ArlV3FLgV9Ltdh1W4DRTx9Ky76qH
         KylRSu6vc646Admw4ix4+Zlz6lccxo061BL5kQcMvbC83WAwOfReDcmHp6eJcN4JQ5jM
         djpgaoIX2z+pBFIfclAuKWKxCv9fXNjnZZbsQQGa4TvLAW8yZfO7CF/ugKvJSsZN5WYb
         c6X7ZNpuNdJyTRJMU732Rw6/33A8MoJNxSC1tUAKy43rdL2fcbq4G7Hgh/rw9EzELIKH
         UjvA==
X-Gm-Message-State: AOJu0YwB7de3kgMncSLPy5m3YvvsIPkHM85bqhZjqxWYKQ7l0srR2kDw
	4oNF8uk6csE0Grhysh722CwiVJfZXWOYABeBPKJ5RiGRbmLQt9wLWNqeHDmOKt03r0Q=
X-Gm-Gg: AeBDietOGPn0YVNdmn5EMTjX91FRgc5v08MyMihQhoEoqywPSfOFNwkFzQardZGiUaJ
	PVMOdeTnITsNUycrB4LaWnYVDF1ZIUfdfhbofA9A4mJG9bTHgE3fBD3dOfLgZAFdTrF0zfg8TGi
	rLRWya4btTJ2Dt2Qb149DAh8RK2ozCV4IPcXmxiix+ku5jAQU3Buo0GSqv2Flw723uYK0Po+yyU
	G4uNMyyvDV/i3QFvjjoYYpdANNWW5QbI9B9EHUj6pz507sPMDLVQwP6WYeooi4F+oX/KTumuNI0
	E2unyMT9N4Zfh+1KNJu71bZ2LTtcbtXc96f8Qw7kEzU1xikMeUQUcGqu5kIGflOUFJIFX4uAVP7
	C1287opJ008Tf1nFc+LBTSj0zFQQdYJkIMUJybpKRAz3EOzrDy/09i3OOerPbi5KcJLrm3JGCdH
	/bNqjLniZPNJ1XkjJM5oo1YxJ0mI2f6X7OHbIqmDo+LfF/eMvGHCHqcMmiVD7Pz8LjPGuBC/SE5
	/j5eKERkO73i/YVvD/q58aUzFN6mHq5kJqA3g==
X-Received: by 2002:a05:6122:1307:b0:56d:31e1:2c9c with SMTP id 71dfb90a1353d-5750c466fe8mr2089860e0c.3.1777768899150;
        Sat, 02 May 2026 17:41:39 -0700 (PDT)
Received: from localhost.localdomain ([95.214.114.12])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6ef15e0sm3815389e0c.17.2026.05.02.17.41.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 02 May 2026 17:41:38 -0700 (PDT)
From: Francisco Maestre <francisco@maestretorreblanca.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Francisco Maestre <francisco@maestretorreblanca.com>
Subject: [PATCH 1/3] staging: sm750fb: add const qualifier to string pointer arrays
Date: Sat,  2 May 2026 19:41:34 -0500
Message-ID: <20260503004134.66693-1-francisco@maestretorreblanca.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'const' qualifier to 'g_fbmode' and 'g_def_fbmode' pointer
declarations to make them 'static const char * const', as the
pointers themselves are not modified after initialization.

This fixes the following checkpatch.pl warning:
  WARNING: static const char * array should probably be
  static const char * const

Signed-off-by: Francisco Maestre <francisco@maestretorreblanca.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 62f6e0cdff4d..dc9653ed2108 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,8 +33,8 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
-static const char *g_def_fbmode = "1024x768-32@60";
+static const char * const g_fbmode[] = {NULL, NULL};
+static const char * const g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
 static char *g_option;
-- 
2.50.1 (Apple Git-155)

