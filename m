Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78564311963
	for <linux-fbdev@vger.kernel.org>; Mon,  5 Jan 2026 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767579040; cv=none; b=hxiF8O07mn0m1iJx+dNKYJMFM/75v5kDP/xvCtNP1yoRwqE/oJ2wTpqEcag8pflh/r1RhSTe16xxWkgND8Bgt4nigL3OvCCk5g9w6sXNGxi++RgJaBoVlh8M44kSMEZpgyio0IO/9jZXXRusO60oJuxanl1qKZUJ6RVu2D58u6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767579040; c=relaxed/simple;
	bh=0vwCrzGD82Ry2ARhk4Xc0rYw3WMR62lsFO6Ax/l4doo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fp7qIPNWBtBMkuSwVK6mj3M8vaDvhw9w+YtNokYrNZQIy/0a20LKqreDwDpasL4Xk3hxq47r8NWSYhMe7l5VyIvgEiycVDUi1E3VgoUw37dTHfU3N7OtFBYwaNNGOzEf8b69UTFV6hEuQwHyanBUHKqrrE3lm8oerOBgfLyAZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIsIQuS2; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIsIQuS2"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78fc3572431so104464317b3.0
        for <linux-fbdev@vger.kernel.org>; Sun, 04 Jan 2026 18:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767579037; x=1768183837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hZh6OfyrjwSD0R+vDwnPJjj9xWF6XT/KbzSM5i3k5sY=;
        b=iIsIQuS20wFtazNhGMJyuQRAZLsUJ2TdlVQrJ5RCIWaKxtGPEimG/28E7D/SEsD2Yc
         vUSUlTZ4eFt9ZpIIqL3y6o9BbMh9Qx6r6UHJQNaCqPUu477QEx7ffmd15nIcjPaFBsSP
         YYKS/l84OZJuFDC4D/JwLHaD3/ENqyDBWLnsEK+pouzACRQuE6WTILWLttnKkf/TO9/I
         gYWcI1RZxxKK7PniUOwjlPapEpYSi2aNn6q1C1icSj++yg6YhAEVTCrneqfib1y9tFFS
         EbyYGvBZWRL+ZM49eSzzmA+ja99NrEqJTj8Nv+6C1qV6xNGrgVTpyEpMXKolXF5Fkm2q
         Z5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767579037; x=1768183837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZh6OfyrjwSD0R+vDwnPJjj9xWF6XT/KbzSM5i3k5sY=;
        b=dNAiTd+TeCSTNKJEpdvibABlcGvhHAIGCggSI3x7tFgQ+Bun70hSf5Q+U4eCdLE3bl
         UohKY3aX2CeZ7OiecpURXymmbnZsznyOkg5A1CLJDHyVUbxJqa4ZAJ0KNq3WFuKyRL7j
         J6VJuFNFskiJU1KsyTjRpmcIR5Zr3iuKURk+HgCLtcePZlu0WVFDdf0GMKPdxDeQmBOh
         mq7yHlW+iNGIpKvcZ2TQu9+ZiNM5Sqpr39k4q1OjH5zubUHHWTq+VO8zt3m9lpbufzNb
         ZpR6BNryB9ei1beK8TXL+Wcj2wx6qKkWxqTfkolksLdOVxej7W28IX4GChuDMNaJnbQy
         7EMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbvx7gLcxxHJRDN6OKViC8a55OWwA6Dqi+Sw6pONu08acEUgGN5VYKBevKlyQvNpytX5EFjyF0RxLEjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQnMca/go0+WxU/9fjAXHbM7aChPJdI/jgA6+fLbk/nQcXbov
	mfQAxyFp+3BnFD6fjKw5suZAeznZ/atOLwNzNa+HeI9VDezppfgsvm4BKkfnlDYA1Rwl0Q==
X-Gm-Gg: AY/fxX6f9uStwEGwreM9u2BUYMOAvabnAO+YfCzfFNmQsjBSugRdxwOK2LP9H8YSOHu
	WHGYGbyMxrjyXOKJJnwigk8H+utK6Sgp1m/hrAqxjIeBuBdy2HohFW+F9NivDBcdDhNbWvZ2b0P
	ZKVr5e4s0Fj2Qp2N8xBf/pAYSYuB2DrvBqXrpG/S4Bk5fxOOmRngy72uwfqIl76jHjH6fAK98gJ
	lDqemlB2T2iQ1ZTVax2WLmJ14ClaGfyDab0qtIe4WTAX7K+6cxegD7Mlim0jfOcuGLBT1AmEs63
	cfcaW3OAKIxcfPEghCdTneSJUvGVFmAQq0Qy/kDcWP8tOgZUKb7SRGciWzSkFpH/4G1llrW29AU
	J6Ysr/i/VdXx8ZGOpfeeM4HMaJT8hmCf0w89UnoAqFDEWhWXgY9cntlVriXSXRQKY9Y13+tEbyC
	M2H4UZJZhGkPDNb6U50lVO+oLCNQUtvMms3U3jsEqR9Q0BN6CCcqroQRo56LMptvG+llNN5rqr3
	y+9pk8=
X-Google-Smtp-Source: AGHT+IFP4cKlb7pVuGWgX0kABNLB8AddxBLEDUHDNDVXTtT+5aRajtle0ByOO5nWA/FJ+WdjF9zl9A==
X-Received: by 2002:a05:690c:6704:b0:786:5712:46c3 with SMTP id 00721157ae682-7902e6e99camr182881307b3.41.1767579037054;
        Sun, 04 Jan 2026 18:10:37 -0800 (PST)
Received: from ubuntu-linux-2404.. (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7905a24322bsm47425747b3.32.2026.01.04.18.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 18:10:36 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: linux-staging@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] staging: sm750fb: fix unused tmp in sw_i2c_wait
Date: Mon,  5 Jan 2026 10:10:26 +0800
Message-ID: <20260105021026.556244-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang W=1 warns that 'tmp' is set but not used in sw_i2c_wait().

Replace the dummy loop with cpu_relax() to keep the delay loop without
triggering -Wunused-but-set-variable.

No functional change intended.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 0ef8d4ff2ef9..279a1a10f132 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -92,12 +92,11 @@ static void sw_i2c_wait(void)
      * it's more reliable than counter loop ..
      * write 0x61 to 0x3ce and read from 0x3cf
      */
-	int i, tmp;
+	int i;
+
+	for (i = 0; i < 600; i++)
+		cpu_relax();
 
-	for (i = 0; i < 600; i++) {
-		tmp = i;
-		tmp += i;
-	}
 }
 
 /*
-- 
2.43.0

