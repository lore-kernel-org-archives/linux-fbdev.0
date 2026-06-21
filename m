Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED7817B505
	for <linux-fbdev@vger.kernel.org>; Sun, 21 Jun 2026 04:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782017061; cv=none; b=NxqmeCxjskE74mkOzwSznUMCTuj6Wqe64GeEADuKNJXSJQAOW91NCYlejYN9YSWUHSBJRkhQCVrRbtig2Zwk1G1J1qGgonFatwilOBQem3oRAuLGzAAaxWKn9CTXmvve89dVHls/DspmwKEGchg1Hw/4235JJdNb31Ozvm30kyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782017061; c=relaxed/simple;
	bh=7nGutUcq2VrKigcc39HyZQ+8PAOqGMQFi4USpUy1Gyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGjGck4NYvWy+emsgEVKmuO/KKq8MSFY69KhoybAgc9AjgbHtEcofbdb2+zJHBk+lzE0jJjrVJDDeTRO3k9lNgnUkgFhaId7eLRIEXW6H3IMjajhK6bR1m0NGMemC9O17KfXhXtkb5q28+Kw6LJ3K2zJ3eQjXRMqf/I2HU27KSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaNVqP+r; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaNVqP+r"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c89636920a3so1101934a12.1
        for <linux-fbdev@vger.kernel.org>; Sat, 20 Jun 2026 21:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782017059; x=1782621859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JfmyrTP4wLvqMTAPFh7dYzDX+Rx+a8MkxKB88LU4IMY=;
        b=QaNVqP+rN7Nv0u/bNZZguHyX27BHJvzb38R3zIk6J7haPBHkSWBMASQYl2dhjrfyNT
         AYVxGAtsW61O7JApLaIJyLxV/kYovW3gXX2BKVLOn9jVYDLzUwKBooxN79iqZteqAuQF
         d3yOMjctvXjMYNXcFyzID8kRyL1CmxLcImb/JIH/x/mjslSNFSZnm2Z035OLnee9CR8y
         eJYKI7S5rzWGQ5rMHPEpiImpMDC5nARo2fhO+QyHNhRjcTUHjxZpHaM2VVCZ7rB3dOH3
         2NKiIYaI12kthTHf8wzAQAAf+usph+mE0Un20DaZ08WeFSGxGrGXn1MbTPtdRZDLV3KD
         oF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782017059; x=1782621859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfmyrTP4wLvqMTAPFh7dYzDX+Rx+a8MkxKB88LU4IMY=;
        b=hvsIITX7iccyRVfYCaJsW2m/93bT7Nz9qU15aOJCjHznIlvetbR2jXPvpbjAXo0UN2
         3jvZ7ZtSkeQqFI6dHpO6OI02IPvAf2XI0Hy1t6Lgx/RDrzhD4Wix5Fo9i6NYRTgkVpiI
         5lScgwmBOyxVR5doWvaEPiSgn2wwBkUfdRhJtXdnhKdXmAtd+IlWKo0bFOlHePmor6j1
         8A2b0j7leeO18M/Uadoff2dhkBhAmWaRCwXFkfKpYn+iOn2haOlf4PXiive/ztrg+WyT
         uspUO8ymv4D38+NdVjRVcvhpjiR9+PnrPAqzYnzWz8qmYSXbRAwfqMazT3kGDYjDIZVY
         WuXg==
X-Forwarded-Encrypted: i=1; AFNElJ9blLGDe+LeCIU6ponqZrhASyL9K+JecJlRtHS3bbzna6IxZtPt7rnsdQtQL47r40gyKAUKgjux0gCSZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZv9GJTHVwf4DXRmM1HJjZDy9K7yxeQ0ABmLb8AYdOONwbYLaK
	uZeBN54a6SNmAfn8Gdq/fjaIPcoAY9y1cDxMJQp+qQt2QXu8vzSdPQJm
X-Gm-Gg: AfdE7cn9xe9zQlO/HituQvX6UwtUNS0SONQDgMMV5ut0oPFdBJghElhhmYee20q0qRV
	4kkT/PH+1lJMw4O85Q7YWPL8weJmnpfjEoCMU7QppdVWAZB3/3sDSZoPOUySh63GtHiToHU1RkH
	LC51CF+An+hbNiOC42AeMAQnNf3hKULvz2G0rUxiHINE8pbvCLTWAB3de8csw6cgCSWcvTbCcmR
	znhMschppWGrX78j0ai38fsjP7qatZ8tfHgjjXAOcgfJ7YHJzO/gOd2S6mg7FkitIlWvly8hAn9
	OmfYq70AG0W71mvs9/H1ROPx2niIZcPjWzw3qXbT+Tlrb/WX40SlZXN+ts56LCATMlbR/GyXZtu
	2wqb3kCD9nxtBB0b7KpEgScaHDLihqptDcSykSwX9Xv1cJR0YFQNegzF/rNZ6P/s6tULigXYIn+
	lz1w61ZvBtk/0F0PbXn1EENoGkEUuHc2ibs8gW2y7mNQ8OSO/JEk3xosnpTD/K7m6mW+aK8M6cJ
	LN81Ym8C51uNun9hpRwciQeOcxwTlvKt8NJrmuozmu0Gjdk+VegCv3nLA==
X-Received: by 2002:a05:6a21:e098:b0:3b5:489c:7bb5 with SMTP id adf61e73a8af0-3bb34456674mr10131242637.28.1782017059185;
        Sat, 20 Jun 2026 21:44:19 -0700 (PDT)
Received: from kapoor.mahindrauniversity.edu.in ([122.184.65.229])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc3172827sm3545116a12.9.2026.06.20.21.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 21:44:18 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org (open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER),
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	linux-fbdev@vger.kernel.org (open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER),
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] staging: sm750fb: make g_fbmode array const
Date: Sun, 21 Jun 2026 10:14:09 +0530
Message-ID: <20260621044410.57823-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: arnavk23 <kapoorarnav43@gmail.com>

checkpatch complains that a static const char * array should
probably be static const char * const.

Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Signed-off-by: arnavk23 <kapoorarnav43@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 9f3e3d37e..19c3da654 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
-- 
2.53.0

