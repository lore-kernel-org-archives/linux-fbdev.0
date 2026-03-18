Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400C7303A35
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855315; cv=none; b=MmuUgG6kztxzanAO+DYcRQBfFawDS4oSur9pJjXl30pVxzXwbMZjz/VQWc35OuFs5CN6PW6JwbGPM0Fg2ee/iZ6X7nvvEX5L2ufHecOzvEkxuxjfCyAzvjmBOdkUn0Hk8IJjX8+zqf5nz6IE+Qqp24nfqk/XMNKKkS7oJCJBYxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855315; c=relaxed/simple;
	bh=rR07kCb2PuO0EImE0YyhNwV6UOCHJ3Di8C3LXOSRM04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfSwg4VHzohofPq18Hy+6rSJ8E+lGEX3D/QrIQ4CX2YUSyOV9v570tEt2ve6aNSiGLEgKPBODRrSJE4kOH7AhPlWwf3wed07tNqFcpwCSOFmKFuW5uuGke0JtHQKUEXBah0mPB8tEIH6td7by7OMXkvTS+fij9h0NOO+HAc/ZwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYdPK2JO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYdPK2JO"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-356337f058aso151994a91.2
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773855312; x=1774460112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5kGIt5RghCPjudSHSFgmLJ/qLunO5CFRngRci7V01I=;
        b=WYdPK2JOdJxzCLq8XqnFL2Q+DMfjf+5/V7WZ7JphnCBK34MaC62RJrhCZJNn8iVqYN
         G1VSb7V/aKXSiKeFCtB4xKScjp2OA5G2lVNhepiZUukZI6cciWIPC+lbvAVdM67Gv6+d
         rqhe1PkRhvXsmzAeGba3znNX2UglQoGgZ0txhaUXm8kZJSJqJDXSQHA7UAjAKFCS0s39
         3e3qK7Qt+eEi9yFeciajxKgXDaLxWdPFA7vBQUWEYT/nKf+inKPZXXtWM1WAMm4wHQqp
         XvSHx7ocpWdJagkwfiSmZN1/5p36GH9gUAORclgo7Vc+qhnCm1KHqUJS+Ja/pHZeHDZx
         jvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773855312; x=1774460112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c5kGIt5RghCPjudSHSFgmLJ/qLunO5CFRngRci7V01I=;
        b=cGbyF+KXN58vgcuqdGEm9Uz95W/yqwdlkBwrmyWKD+eRbu6xBL338qNJRyz86CXIt+
         QjGkjOPo96dbbnEuDXyUnhV+RDmzJGgORabxU1tbBZc6bJhx9gmlnhxn/q48LdPnhthq
         M8DsPP99LaQO6PY5WakXkw/0cYGD6Ed9wXcBaT/BnQFkO4cyOFU1gwyNV+Mbtq+uxKxU
         Gj4/kXL+XR6V07/f+1+lUdsFRFTkGNPnM2Ipf7+QtP3O0mn9ALs5r6upn7OczrXzoAi0
         d7LEuQ3nOQFHQISKjvCegGSE9hWvOYU3LnAQWV4WW2OrRpxnxaAK5huGpwiR6kXwIhO9
         5JAw==
X-Gm-Message-State: AOJu0Yw4yWZfanpxy0cNtGgyPiy1eUD4MgR7yjA/p3p2Xgdu3hv8wg7C
	jRXOe/yMfT0uvj8w5VyQzJ2HImrOar9gP1W3vrd+Kg2zO3mzolhzml8L
X-Gm-Gg: ATEYQzyfRlmvzToqD7OcFyGgD4Tfrj0lVTa9rq4BtzO61/mP+ifnh/2Lg+D1VEGlh+q
	+YBHG5LavR5XNXBORyMgLzw8K71et+gnxXBXGy3m4DhgVk8yHTq4RO72uZeiUsRkYbW7m8aRute
	facpuQiAp46EYyzKkDNorBTzBHq2F5gfWfM+goBzOdGZ/Jw5Fquq0X8odEmf69N5qpbh8AYPiLQ
	uAu1v58vjtubc3No7rrRMbF2oLkSoCnSJzky+yFtrFHyRLgZyubTf+ScIxA5UHQh/Rn6pl979MH
	qRh1rdKlZLpgPBpGSFggVpRHhf6c0dyKNrhdtwQIwZ6sknAF5YPHBObX0KhDoE4IuZTd8zmRM/t
	VF5XzB5q8FyLduxUmkB7rzSydHe1E5/aXOudCmC8w+Y1ndwBhDvK0T+epptOswktH9j3NuFre6q
	hSbun63SWCCDKj0z7nWOiKrYnEA74qFR/+XRNjtJytrh3Rtg==
X-Received: by 2002:a17:90a:d604:b0:35a:24f3:2c88 with SMTP id 98e67ed59e1d1-35bb9e579c5mr3945996a91.8.1773855312376;
        Wed, 18 Mar 2026 10:35:12 -0700 (PDT)
Received: from fedora ([2409:40e5:1052:9a56:3b6f:933a:89fd:e530])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc5ff704bsm247103a91.2.2026.03.18.10.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 10:35:11 -0700 (PDT)
From: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
To: gregkh@linuxfoundation.org,
	sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Subject: [PATCH v2 1/3] staging: sm750fb: Rename enum sm750_pnltype values to snake_case
Date: Wed, 18 Mar 2026 23:04:38 +0530
Message-ID: <20260318173440.9457-2-chakrabortyshubham66@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318173440.9457-1-chakrabortyshubham66@gmail.com>
References: <20260318173440.9457-1-chakrabortyshubham66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch renames the CamelCase enum values in sm750_pnltype to
follow the Linux kernel coding style.

Signed-off-by: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 6 +++---
 drivers/staging/sm750fb/sm750.h    | 6 +++---
 drivers/staging/sm750fb/sm750_hw.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index dec1f6b88a7d..729c34372a1e 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -942,11 +942,11 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
 			sm750_dev->nocrt = 1;
 		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
-			sm750_dev->pnltype = sm750_doubleTFT;
+			sm750_dev->pnltype = SM750_DOUBLE_TFT;
 		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
-			sm750_dev->pnltype = sm750_dualTFT;
+			sm750_dev->pnltype = SM750_DUAL_TFT;
 		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
-			sm750_dev->pnltype = sm750_24TFT;
+			sm750_dev->pnltype = SM750_24TFT;
 		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
 			g_hwcursor &= ~0x1;
 		} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 67b9bfa23f41..49a79d0a8a2e 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -13,9 +13,9 @@
 #endif
 
 enum sm750_pnltype {
-	sm750_24TFT = 0,	/* 24bit tft */
-	sm750_dualTFT = 2,	/* dual 18 bit tft */
-	sm750_doubleTFT = 1,	/* 36 bit double pixel tft */
+	SM750_24TFT = 0,	/* 24bit tft */
+	SM750_DUAL_TFT = 2,	/* dual 18 bit tft */
+	SM750_DOUBLE_TFT = 1,	/* 36 bit double pixel tft */
 };
 
 /* vga channel is not concerned  */
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index a29faee91c78..0e594734a8b9 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -134,12 +134,12 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		      ~(PANEL_DISPLAY_CTRL_DUAL_DISPLAY |
 			PANEL_DISPLAY_CTRL_DOUBLE_PIXEL);
 		switch (sm750_dev->pnltype) {
-		case sm750_24TFT:
+		case SM750_24TFT:
 			break;
-		case sm750_doubleTFT:
+		case SM750_DOUBLE_TFT:
 			val |= PANEL_DISPLAY_CTRL_DOUBLE_PIXEL;
 			break;
-		case sm750_dualTFT:
+		case SM750_DUAL_TFT:
 			val |= PANEL_DISPLAY_CTRL_DUAL_DISPLAY;
 			break;
 		}
-- 
2.53.0

