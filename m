Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02AB21D3F4
	for <linux-fbdev@vger.kernel.org>; Sun,  3 May 2026 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777769871; cv=none; b=CNYYn4WrZkR8AK9rXM9/Fa7aNZSFqrANUdexF5Sd/Fp6MXfnHDYhlMxYg2Bp79KCxNxSKF0L3VwDoiQ/CbTKGMqmqQ9T8wlEeUH3NqRP4aQFAeKNJAlf/cMRCY5NLIMOZowFmLzqhPQK+Uoust0c583j8ITSy+LYdvQWBzXEW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777769871; c=relaxed/simple;
	bh=oepVN3zzq6064BKTaXpgnxq4JLHdTznAxFO05g1KGXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRc45nbUDZR2WP+/RshsugEdAT2vYo+Ssc3BlYgLsue5DhVOH/OnqmqdL/hE6pyENhqkxUvkrEaUiaHnRJ5kD2OGcP9tFQcPku9HFQpmHtHZi7+bCfd44ci/7T0usqtED10YzhcyV6T2jlViqFYSIma2kSgLwFF4hlBjhgWAUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maestretorreblanca.com; spf=pass smtp.mailfrom=maestretorreblanca.com; dkim=pass (2048-bit key) header.d=maestretorreblanca.com header.i=@maestretorreblanca.com header.b=LM+Nbfee; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maestretorreblanca.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maestretorreblanca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maestretorreblanca.com header.i=@maestretorreblanca.com header.b="LM+Nbfee"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-62dd2fa4a16so472162137.0
        for <linux-fbdev@vger.kernel.org>; Sat, 02 May 2026 17:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maestretorreblanca.com; s=google; t=1777769869; x=1778374669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ABDR/q/xwxYuiRgUF7t5Dck8wiIS5ZmruvsZbkbl+Po=;
        b=LM+NbfeesBDPnrvwpdkMJXWTbcZl5W8QF8nhJS8vhb1gSNXxgahqwMLjzA8R2ZlAE9
         H5Y0MlZely+6w29qYXOGZ3TtT8OB8NgtOSt6tL5n9Pmi7GzwqDdFu0YBLOoTUhZ4aK/V
         Zt9U066+7+RZCTHAa02jjxXfLxsWXsWv/qhHHbsvltyj0vvXtpCZmdoZa+/VIzMgbYEB
         csTZibsAxjhgxxiLPFX94r4o5LHDHyjikIJtYZiwLkVTbDocrlsDZi648nd+XJzCreWC
         p1y5NFz5j+4JPcAkyu68KdvSTXlias82Egi5xKHOTRNJxUFUJP4gjjEyv1p1QDTZ/232
         CGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777769869; x=1778374669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABDR/q/xwxYuiRgUF7t5Dck8wiIS5ZmruvsZbkbl+Po=;
        b=Oj8oMLgpAMmXkIWQhdKEXbqeqbx2g4xNxk8mWNepekM6CGrdkzYhFcJykPztN2noYz
         mZfkwHp4hclQshzwquplLRc3fYNhdyaJ1saAFFKGRjodqkA3dxg6m778qL++wPT5bAQa
         DjSu+VP7kf5fbKso46PhfYzN5/lkchv5OGSN4LmSOx7FnhjShD9Ft1+KjqymxMq6QZtS
         feB9r6SGyWyJBStfPvLBK68eBN6s1On2ZqY6Ny/0RBoBfh/nQIB/elr3tciJZLR2cdQ2
         3V/l3DcqLpSeZg8sFrfv9pAHDwl3KuEVU21pE0VUyGuqbkP2o6TWWKm47aoNtz6Txm5b
         G62A==
X-Gm-Message-State: AOJu0YwBoRpodP4YxTko23KUIMrI0BNax0W4osastbDVrBB44l+bKT2l
	ZydVhzJgYoYpFa7l69wEL9pFBdnLvSffhgIAH2rq5V6RcoqIJW9jE1gEcT6l1FQCNLo=
X-Gm-Gg: AeBDiesduwPQ1wkLo6oO4QehO3Tlco50Co+zAQmn7eHjDXmAJSlkT/T8rxO/JLchzOH
	I4dZkZsrk1DFAtl0CtY2sUOje0vCWg+aLrcIV+BE/6QjSRJo7vp5Av8z6i811q7wAkB9By+wHab
	V7Gqzv6bpb85KvGiVXabhoXOLpm+3vyjsolhJkdxF3mcIHtJtCI5jtyN5yH4ZbBgpHJ0SFJUOCk
	yH06DHTQL0Dlcf3b3bjpSGkdPITBxlwunXnnvr+a+ZJvgC5YBuNuQW+5SJuy7U2aLAqvhy4j4D+
	3YZs0ehadUmOXONXOXRd1iEdAZUIsbh+/X63HeOww07jQbfZolydjR81zEfysMGM9j5vAGlfxNq
	uRNCquoMBEPejKnZQeJon9byu9aVTpH3KAx0b5e+grGXgS649WufJVqBAh/P/XHeyrqgycz1boD
	FhgzzYeq83CWMMqm/sCrP18wJRbDsLSbnB1bJwYCEXbhRaHk1sLi/MlEaIWlm1eK3A1tpn1ZbGF
	KxQoo3MdGzO/aNMKHl/BveTQ4rxWBOPP/LKg1o1B3AeN4Ib
X-Received: by 2002:a05:6102:3353:b0:5ff:b8d8:b40d with SMTP id ada2fe7eead31-62d8725a5abmr2002245137.21.1777769868994;
        Sat, 02 May 2026 17:57:48 -0700 (PDT)
Received: from localhost.localdomain ([95.214.114.12])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62ef2b9720asm452862137.6.2026.05.02.17.57.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 02 May 2026 17:57:48 -0700 (PDT)
From: Francisco Maestre <francisco@maestretorreblanca.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Francisco Maestre <francisco@maestretorreblanca.com>
Subject: [PATCH v2] staging: sm750fb: add const qualifier to string pointer arrays
Date: Sat,  2 May 2026 19:57:44 -0500
Message-ID: <20260503005744.68974-1-francisco@maestretorreblanca.com>
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
v2: Resend as individual patch, not part of an unrelated series.
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

