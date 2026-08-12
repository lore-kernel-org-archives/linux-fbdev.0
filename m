Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B6342BC3A
	for <linux-fbdev@vger.kernel.org>; Wed, 12 Aug 2026 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535074; cv=none; b=OZ319zP7vBzAVBKxOkQEBUQaKrcH8IvGChzx5jAjlsQqROpH1hUx/2WQkRSnLJqLicbyy5ls2hHWRr4MxWcyFXj5T1+nS2dEh0lYqh8ctnGRyuMdiYxNYyTnDz9hYuIi4DPyz4Y8u/9U6l6WkUZ6LkDy9IcJhzUszVnyoW4Ngd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535074; c=relaxed/simple;
	bh=6bDgppw1upMRRhV0yGcXzCvzM2E7ZuS4xeKKgk2RLKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a23izeu4GSjNwHgb+i2N4QTklkHr/oh28QeVp4JvfkjcArPGbdigaxTh7mWkn2wLpFATJQ9l/03LYf90ubIE3gKYCQXyQLOW7zcR/ISeFj+Hz8xcffczLUnwgDX0/fbmCAilwr+hATJKCbkcTesrB0NbKWGhKCA5UB8MuFwCl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM+OI0wl; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM+OI0wl"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b021916bd3so1183129e87.3
        for <linux-fbdev@vger.kernel.org>; Wed, 12 Aug 2026 04:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786535070; x=1787139870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHDNFQ36fyaG0ir08tDXiNr3M+QaNM3vkw/XZ55Hif0=;
        b=VM+OI0wlyJet9WNJ/8bNpvw2j4KrnTTtJ8vQvGGgwgfNo5znH/nNX1PprCkOZ2NRtJ
         Ot16yW27a+JfB2+pzbkAaOFsCX6am03ITbvYV8rlvjwabJeZraoz/92slkuJkzQsiHBX
         HYngYCoaiAXuSKzxAmNYoGOwxRXzWV2OQSDZ4jRRB5zLgWJnE7/g+s8VZDuDXpfrXR5e
         i8inQfzIsqR6hRRAo1bTDnJXWBfQLegK3X4hm40y8+9/Wm+7Dv1LlL28Oynx/1OBv/Fk
         SSdWeQNRzF0D2R5EGe2yCAYeL0CWJtKkwXGTCjoQSjTC9LFYPAmjxlDGGkXcg7gc0UKR
         DzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786535070; x=1787139870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FHDNFQ36fyaG0ir08tDXiNr3M+QaNM3vkw/XZ55Hif0=;
        b=T1KIYdE6HAG8q++ilW2q3xhlQUELwoPQ4HaUght/il5fIByEhMDxCNaxoAew8BCjHU
         PkbUyk1aDa+oiSPuMv8qRrn1FJ7BtxDCHdnM/T9cc4nbgkhMRbOQQM8TUS7fmkfMPSjN
         Uu1FmLINgS2Kf6WtS8mG/eYJExN2egU2WLt/K0RsQaQNBD3AebnPvT06owHfYB3zQ/0R
         Ona8uS3Eu6x14ovl8t71LV3B65j2ZBSFkU3BOLJ32K6LICZyYwxY5vQRFalzUGn7jFgC
         qtOpNbJ2QCBSvufeGLLcs7mGeeKZST2rYY79Eqa6fNDaOUpQnrHYC2BmRfchJbem3DBx
         Nglw==
X-Gm-Message-State: AOJu0YxKnjA5hz3qmR6r2FyG4l1P1JzJ3HjqLAg46SA0Rwccl4+8/S3E
	4zBmccT+OThtkOqU7yu/JS9Sd1mOdQeC+lJREkb+HEjSBAWMsEUQmKEA
X-Gm-Gg: AR+sD106Bgj7jWAfyyAqeRKjCcWe5h439F5TZ7BuJLGJhpYgKBbbeHHWjnfEnfUa5Ts
	xtyDeMrZOISA3ep+vZJVFVsT1WkUsU1amneT6wwsx50/eaV0ZghI7j/d04ayBXbVfpPYcKPfFT9
	TME8ZNemQIBWmZ1u07xClh9o2+nGSi6sYrhgbsMYDkT4aF/QhMC7rofkKoy9ONIO6YJZ/QbuQzw
	Z5Oo4Yozw7SHLpojn+sai3ENZIvA8oAT1cZPE30A8JYh4azgNxj+CIowd6vXwer/vut2z0T7DvQ
	C4lqxnemO8ANjdoTZfMrJ12cK7+EjvutgngkscRHyLDIlDkS8dMgqAGXlDw05PJSw9R7uDin6Lj
	Uhnl0H3oPCkYyJDczBLK3oKw78d6oj5DB1/2zkn+PN0U+sF+8i9I1buFLL4yO2zgRlAntSRPqxS
	H5B7J1WmIiJEblUuB05DuP1JZo0f25BYwNlR5mYrlQqgxjdLZ7Zwdscagov/4UCWNbF87G
X-Received: by 2002:a05:6512:130c:b0:5aa:8822:c945 with SMTP id 2adb3069b0e04-5b44e336717mr679286e87.47.1786535070291;
        Wed, 12 Aug 2026 04:44:30 -0700 (PDT)
Received: from gentoo.home ([2001:2042:2a39:500:8a2b:6241:6d4c:773f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b44cfb2810sm442736e87.7.2026.08.12.04.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:44:29 -0700 (PDT)
From: Maxim Codita <maxkoditsa7c@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Maxim Codita <maxkoditsa7c@gmail.com>
Subject: [PATCH v2] staging: sm750fb/sm750.c: mark g_def_fbmode as const pointer
Date: Wed, 12 Aug 2026 13:44:21 +0200
Message-ID: <20260812114421.24860-1-maxkoditsa7c@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081233-simmering-exerciser-4ab2@gregkh>
References: <2026081233-simmering-exerciser-4ab2@gregkh>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a checkpatch.pl warning for g_def_fbmode by marking the pointer
as const. Ensures it is stored as read-only.

Note: g_fbmode[] is left as non-const as its elements are modified at
runtime by lynxfb_set_fbinfo() and sm750fb_setup().

Signed-off-by: Maxim Codita <maxkoditsa7c@gmail.com>
---
v2:
Fixed extra spacing between char and *
Compile tested with make drivers/staging/sm750fb/ (no hardware to check
runtime)
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c..b2f5f49e447a 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -22,7 +22,7 @@ static int g_hwcursor = 1;
 static int g_noaccel __ro_after_init;
 static int g_nomtrr __ro_after_init;
 static const char *g_fbmode[] = {NULL, NULL};
-static const char *g_def_fbmode = "1024x768-32@60";
+static const char * const g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview __ro_after_init;
 static char *g_option;
-- 
2.53.0

