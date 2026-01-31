Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789B4A02
	for <linux-fbdev@vger.kernel.org>; Sat, 31 Jan 2026 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769863722; cv=none; b=nZaIjCi4scn99WU0ucXHDa+S85jz6HRBw+kV4A7fWS7dG7y/gxwNX4TR0gGdFYnJGvSBqzipmBupxqSK32NR+oVysfJyvfCY7aSyN1MB2fP2VmA0TbN1t1PhStxYQtIoXUEJqmK/ele5SVSJywrbn1cuTDiD2YPbtPCV1+qsj3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769863722; c=relaxed/simple;
	bh=qWjHqlgo4XNYoiM3y62z5BQIp1iGOLohTtFGm8bt+wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cruWy6K72iospOa8ysbACeDWS1VKrVkFdgKd+gzR3NVI7e8azLg/R92APHOjaL1vzoqq9k7QzJHUJf0FB1iqIdbWT3SeEWaplkeWyHVj8esPok7TAYaZKS5is6fHHxNN3vGoNsG9q2CLqpk0tkYkM+NWNGCZdKpov65QbCsRhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfMjave+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfMjave+"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35456fcb79cso62725a91.3
        for <linux-fbdev@vger.kernel.org>; Sat, 31 Jan 2026 04:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769863720; x=1770468520; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg8/gpgU9m1/xq48pahp4plD2I6M9C2S++w+H4nQDDw=;
        b=SfMjave+2+599UW84227RvcPM3CyZuTV6CyVtMLy93hfBneljVlEYnHNEh+/suZj7+
         ySReFWIHtq7YlwnLKLlcmmynWDo3QLa/XdwI41hqamFdlG+FiCV2OFf9ffjYRoyN/TFp
         bs1PXcBaTCuOiMz5Jbz3bFjriOspl0uliYOTgMSUuu2sIGABPw936dkEiWlnmbsC8Cf0
         z9UXc9EkF/T/70VsvAt39ppYj+SSv8tmI5AZum0MJWpvLmcANoHy2wuFh09MGjD83mR2
         oalcszoqDGofDlxalx2nEtlDmW3Ut42FcfkdBFunTudN8ia27zYReoyD5j7bDcj02Gzj
         W7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769863720; x=1770468520;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg8/gpgU9m1/xq48pahp4plD2I6M9C2S++w+H4nQDDw=;
        b=iWzG5Cr8sKkuKpaxF8AkDLfbXXrsm3Jy75oM82UlbLkDIVr6Qx6hnKar7mrnnGXbGF
         ao/G6fdaXFSW21NxJToVSARcMV3kmHhQ/7Ws3jgM3Xe847ZpJSVxZt6xc0gwEtxDzOm1
         mTlf6ZXFdSEIId9oTqJvyOfUaES6+D6mgXoNRZf1hxRJfgM6IkURXWKTXfyv69zc1W/M
         XrtXbiY0kDWVdSbIZrbF+05MxZut2wKSFHPnW2+b53JQAijam/DXRgxVkjaBicdK8HsT
         riIFTDcYkWq456U1urM+Yef6zRBJQ/8WXgSWwk0vwFKUvvfYcJdJ50E/w9T3W7rIHZm3
         FbhA==
X-Gm-Message-State: AOJu0YyTR8NSQeTUmx71hdIjt9921H8nHKaOambDWMO8sChgl4JDOdJl
	hB6x2YtwZbutqlef2uE8pwVCVdlBF4Ug9uvhRtohJqOCJJQ5KqpHkb2/t1kPk3al
X-Gm-Gg: AZuq6aK3atryr6pkTLu+wRNNhxQTsjIEnzoUmkk3lS2dvoM9eYc2Jy4jbe+/HnC1Yau
	sWgTHxktvnQ/WBh+IEYsB0SPt7TRg6OJ+NRnqK8r2GU3jy88ZuRwkn1A3+Vcas301DEfgqIUKKK
	cf0v5PQuNHP6zPKo54j8lSjH5Qh0f23vKNB9OconUW540k1rogdd9QY0SvPe5kNChjMh6khuIpX
	CckPv6z2rVMzuPIkvvlKUozsvh1TilNhaN1k/zsjXWxUpouoSJj4WMZE0P9r6abomlI80jG21v4
	bGqd7TMUbl3/CU77hn30MSqibb6aQy5AOFoxODe1rj00fr6I52KQwVu7AY77ek7pqAWkLtNq5Uh
	B0fkQ8ImZeadyTHucV27gVGm8bJ6HqEQXJ+0RMoZjDrszkKFsoHPVmYEmZbfVF6DWT2H+RdhX8/
	EejQOLYRU=
X-Received: by 2002:a17:90b:1348:b0:352:d1a4:19cb with SMTP id 98e67ed59e1d1-3543b323becmr5352601a91.11.1769863720158;
        Sat, 31 Jan 2026 04:48:40 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9008:ba52::3a87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6103e9fsm13107396a91.2.2026.01.31.04.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 04:48:39 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 31 Jan 2026 20:48:33 +0800
Subject: [PATCH] video: of_display_timing: Fix device node reference leak
 in of_get_display_timings()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260131-of_display_timging-v1-1-f4f8d9f87c3c@gmail.com>
X-B4-Tracking: v=1; b=H4sIACD6fWkC/x3MTQqAIBBA4avErBPUor+rRIjlaANloRFFdPek5
 bd474GIgTBClz0Q8KRIm08QeQbTrL1DRiYZJJcVF4Vgm1WG4r7oWx20OvKOoW3qUkvDy3aEFO4
 BLV3/tB/e9wNMm2F6ZAAAAA==
X-Change-ID: 20260131-of_display_timging-ef874a2d049b
To: Helge Deller <deller@gmx.de>, 
 Thierry Reding <thierry.reding@avionic-design.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@nvidia.com>, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769863715; l=1640;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=qWjHqlgo4XNYoiM3y62z5BQIp1iGOLohTtFGm8bt+wc=;
 b=XM0629h8r42xPVOhCm2SBDvW3BUSZvjh6PxB+Kv0KYTj9yiq/letlXyOHcVyaxOXrdVMsqn6j
 xWztwcLXPhaBifQPNdGT7mFMXXzUpP1ni9wqvSz0sfxt8L1iI4TXaXh
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Use for_each_child_of_node_scoped instead of for_each_child_of_node
to ensure automatic of_node_put on early exit paths, preventing
device node reference leak.

Fixes: cc3f414cf2e4 ("video: add of helper for display timings/videomode")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/video/of_display_timing.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index 1940c9505dd3..a6ec392253c3 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -195,7 +195,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 	disp->num_timings = 0;
 	disp->native_mode = 0;
 
-	for_each_child_of_node(timings_np, entry) {
+	for_each_child_of_node_scoped(timings_np, child) {
 		struct display_timing *dt;
 		int r;
 
@@ -206,7 +206,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 			goto timingfail;
 		}
 
-		r = of_parse_display_timing(entry, dt);
+		r = of_parse_display_timing(child, dt);
 		if (r) {
 			/*
 			 * to not encourage wrong devicetrees, fail in case of
@@ -218,7 +218,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 			goto timingfail;
 		}
 
-		if (native_mode == entry)
+		if (native_mode == child)
 			disp->native_mode = disp->num_timings;
 
 		disp->timings[disp->num_timings] = dt;

---
base-commit: 33a647c659ffa5bdb94abc345c8c86768ff96215
change-id: 20260131-of_display_timging-ef874a2d049b

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

