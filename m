Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20653126A9
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Feb 2026 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160084; cv=none; b=AFr0ZFef4x7lnvPabI2x11PPWWTMaIJ6XT66PM/wjV/WWKyiqJcydcS1WQSWnXXOmjqaoFmb7k99FhkC1YBQI/SWgOy6yGyh1wZfdvfNKRJttb+Iaf4fDEaYZd8vz1U4/8Jutr8kzNTv+cBavlEitPdbLJHH+dDEWja3D8frZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160084; c=relaxed/simple;
	bh=B7JjV3GFU7Uh5QssvSt50BbkBYppkGhl3wSBvqUdL1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adSRCXyAtxBNUnvM3YqrLa0FwhPxGevYLGDjPmFyZV6bw0FmvXDsFrYtbT2mxOzfmpEzJ0rx4eCFC9h1/g4MWdyICKuGowA/ogC4wnHwMxwoJUQeI85uApnrNsvhZgWqqnymLKNBXV8jzUQVT45dLeY43Ohupuua3z4M9gdRAak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPGBuMjD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPGBuMjD"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b87677a8abeso32023466b.1
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Feb 2026 15:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770160081; x=1770764881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hyuu5DQHN0kM/6Ii1doCyC/+2p0/fE93hPD6MhvTzyo=;
        b=CPGBuMjDoNMpknzAiX02SO//NgOc5o+4hHzjEK7qmfXndjSJL/d/lbmXFbkgv2GCSm
         /aGdit/bNPzE/F6W1pzgs6NA+IvRRoy4hbQRNoY++k1T55mzNNhbcRGHGcbA1Od7tw9F
         /E7zJcZ+06u9eYPeRvXrOQIPSEbPpHVF10lBj5kyhOB0bGZFZREr2HNhWokscrk09AjF
         K8vGTIUKVivGhIdOgUOAZ64xO5g3CAqoINXs4PEabk7+NJ9OsYYazpnq0nmQhW1E6E4V
         kFu2xyUS8Ikx4/99xI/17caskYvnS+HI94yYBgr1u3R4gSjuzymVcATMQu8Ma+fqMeXW
         M7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770160081; x=1770764881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hyuu5DQHN0kM/6Ii1doCyC/+2p0/fE93hPD6MhvTzyo=;
        b=tkt3bpPw390MvLLj0wtwqHD9/4qpxddqIXigcX7+J8sFQ113UoM9IEJtXQ8IJ+buRm
         bhoXhB/CCqnlNHOwhL9Q87q7knLihXO63SvyZADMiJfXJf+LbjE12LFycODaO4rSuUTA
         JJkH6DKKQPayWWOQLPfCn3c1tbDxLpuOOde5ElQ7b3wET6/ucHQndf/WGgvQHw0jDtn2
         bWDjy9ldAyEw6jD6bWDvvnqkz0o2JaW5K1MyzOuqLuVDCMxLTMOwCKUczQlr4L7j/ep8
         ZLj71uJegSNKudrmv4IkZKGopHUamxI3onMYJQDJ8Oc5tV/YE5OOvSq99iB35KFzzRQD
         eHgw==
X-Gm-Message-State: AOJu0YwUM3phgWNLO9s/PwNb9i4E2EncEFmfvt/xtqzjUPAl6Jx+PRrd
	hmeHy0dgq9NOGfgqmclo0T18CgGMsG5J10yLuwYgVz1ixd1VUJCcP559
X-Gm-Gg: AZuq6aL44ST6/AXROJIdTvsaIvdOave92GJgRXmh2f9EI6AFsIxtkw4GgLt1/K7A1DU
	n6SAj4zyxH2IEe9KYp0sXy/LHVOQGEWvKpGYFWqwprvosisXa4yObMaAo0B3Xri2MdYnF7hkmP0
	cSmKjATkvaH1QOzGT1vkTE7rqZRrErhmYqf3X5UCPerR8LA8jZpRF7XLgKh1JJbWt8q/4nsnm9u
	Vf9zaau50qldzfQZHd/29lxaJzwL7UO6dpRtpuj1HYi76cCxQLpyRQI7JE++fg0LLxmehFv4aGq
	dYCl9qut179CyRgK42aTPUbg4kkl/CzhId3eKnxsBiG+GoVSa5tjkqLjnArVzcbezAt42HUamoc
	OKP4hAbL8vDaw2JoC0PfMHygiRFxuCX15pB3Uh3YsS+Y9fupDnSET+HZnqmG4YXdvAD4LQWY+nc
	3dzMy5JqIa6VEor8of3WfrPTImkhX6huTlnrkPqf7ieKgLS5INCdVK5FNuQSdPivWV6a5KEiZNa
	CwE5R/3RSN8F6LcPqJ53Rqm8CMby7Gy08gnFYzudhsBoMrvVnE8LXHiBS0=
X-Received: by 2002:a17:906:9fd1:b0:b72:70ad:b8f0 with SMTP id a640c23a62f3a-b8e9f19471bmr74044066b.36.1770160080597;
        Tue, 03 Feb 2026 15:08:00 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-b.c.od237066db22328bb-tp.internal (33.242.13.34.bc.googleusercontent.com. [34.13.242.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea0021b3bsm38486566b.49.2026.02.03.15.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 15:08:00 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH 2/4] staging: sm750fb: use strcmp() for exact option matching
Date: Tue,  3 Feb 2026 23:07:56 +0000
Message-ID: <20260203230758.3056-2-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203230758.3056-1-iprintercanon@gmail.com>
References: <20260203230758.3056-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strncmp(opt, "...", strlen("...")) with strcmp() in option
parsing functions. Options from strsep() are complete null-terminated
tokens, so prefix matching via strncmp() could cause false positives
for options like "noaccelXYZ" matching "noaccel".

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 4c6e84c03..bd2d4a290 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -937,21 +937,21 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
 		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
 
-		if (!strncmp(opt, "swap", strlen("swap"))) {
+		if (!strcmp(opt, "swap")) {
 			swap = 1;
-		} else if (!strncmp(opt, "nocrt", strlen("nocrt"))) {
+		} else if (!strcmp(opt, "nocrt")) {
 			sm750_dev->nocrt = 1;
-		} else if (!strncmp(opt, "36bit", strlen("36bit"))) {
+		} else if (!strcmp(opt, "36bit")) {
 			sm750_dev->pnltype = sm750_doubleTFT;
-		} else if (!strncmp(opt, "18bit", strlen("18bit"))) {
+		} else if (!strcmp(opt, "18bit")) {
 			sm750_dev->pnltype = sm750_dualTFT;
-		} else if (!strncmp(opt, "24bit", strlen("24bit"))) {
+		} else if (!strcmp(opt, "24bit")) {
 			sm750_dev->pnltype = sm750_24TFT;
-		} else if (!strncmp(opt, "nohwc0", strlen("nohwc0"))) {
+		} else if (!strcmp(opt, "nohwc0")) {
 			g_hwcursor &= ~0x1;
-		} else if (!strncmp(opt, "nohwc1", strlen("nohwc1"))) {
+		} else if (!strcmp(opt, "nohwc1")) {
 			g_hwcursor &= ~0x2;
-		} else if (!strncmp(opt, "nohwc", strlen("nohwc"))) {
+		} else if (!strcmp(opt, "nohwc")) {
 			g_hwcursor = 0;
 		} else {
 			if (!g_fbmode[0]) {
@@ -1156,11 +1156,11 @@ static int __init lynxfb_setup(char *options)
 	 */
 	while ((opt = strsep(&options, ":")) != NULL) {
 		/* options that mean for any lynx chips are configured here */
-		if (!strncmp(opt, "noaccel", strlen("noaccel"))) {
+		if (!strcmp(opt, "noaccel")) {
 			g_noaccel = 1;
-		} else if (!strncmp(opt, "nomtrr", strlen("nomtrr"))) {
+		} else if (!strcmp(opt, "nomtrr")) {
 			g_nomtrr = 1;
-		} else if (!strncmp(opt, "dual", strlen("dual"))) {
+		} else if (!strcmp(opt, "dual")) {
 			g_dualview = 1;
 		} else {
 			memcpy(tmp, opt, strlen(opt));
-- 
2.43.0

