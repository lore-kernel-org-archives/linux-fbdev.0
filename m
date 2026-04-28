Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E740FD94
	for <linux-fbdev@vger.kernel.org>; Tue, 28 Apr 2026 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777379153; cv=none; b=I+98z52tVNBEmojPL2JlmbB6o2q4hVAEexc+aeJXwE5Ot9+a6PaEre3Q0OHISO3HTyqDqQSMH4OHWXukJ4ym8fG8ZOtUx8QydI3Z2zLNAHcTFT1IJp36P902FxzMnk9Xq7hO/TZNEYyb1pS2OuEUh3t35rytO90bkYArnQoTVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777379153; c=relaxed/simple;
	bh=994kbwGbzpDI84gth2ZWFQ/DUkneewtg68w15z/+1pQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L/tievu31/QGeRNOzk2APZ462ALzaOPsVcVHsFMBDWIwwOzMb9iRe4fsDq3J93p9o8FfWmh0sWTExvfho9uIpocfCoK24jGRM9Y+KTpcYmzbBmhh94V/aH1zIiUHFR8wvmyj0oj++3D6IzKWp/NWvtIgn4Z+YN8dycfWtcDH4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtAQVlre; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtAQVlre"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cfce3a195so6466143f8f.2
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Apr 2026 05:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777379145; x=1777983945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ub97SYxvfTtcUCthywwbD21zacNvXcOjmgIC6pDl4ug=;
        b=ZtAQVlreMIa1orkVYdaMkqHMoW0nz9/rQMmwN4np9iRaOzGOk20Eve+yGl/kt6pmXk
         vvpCgamETJ9GsfUgBUSuBMjrACFKMLt5GCE6Xlq2t7g3UugmwDFgh5vYdHyw1dJxyLDZ
         vV8oYNreWIkIZppEhqwWYwWhERix+e0w81Swoc3nwpdnbILOOGzanvKCzaX+WcLc8d2y
         KgGw4ek45x5LhBrV61T6790JXVq4BASQZyGvHe7HXJUXT74GFEpHjXHILLUKiVlZYitk
         sTaOKIz59SvTnH7PIHQB57qkbabFwABZSPCi9Eu5vHagV6dwbniCrvX0kf4CICerdHnq
         WIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777379145; x=1777983945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ub97SYxvfTtcUCthywwbD21zacNvXcOjmgIC6pDl4ug=;
        b=k3C95bsYiu9zoaIIkwqQ03nlapJeEXfvMrMLyXipqRp+XC8itBA9w3X3MrA/WKwfX8
         P8etxBIZAMUqaAuQn4opQ/6IDQo76mocIzYnzD53Yzug6a8apMG1eFqEfXc+HQAp+yUR
         PiiWcNxX3JKvs6K6oWVrbYS9EhfBt9ITLzUiaQl84RBNShtl9qc2CGCMA0iAItpD6W8/
         eQ5560ELWYhyCkS2mPjEEk3BesmScOykfOsgp38rHbLVL6pnbSkHUnbPvDlLXKoIPFDY
         tUbu1P3L0+/SKrCbxj02M35DWGBqNwpkONUQdE13pshiGlyn4kWa14/T3nNNoRaSc1QZ
         pSlw==
X-Forwarded-Encrypted: i=1; AFNElJ+L0CHiqHhi6pv/vBvLqj+qPTNh+1NZcw/fOS3vWnveYtqWjSX5UbeMV+g/UTdqlunaVPPyUP0qvN2xPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnofeIhUn7KkXyQ8DeubpfblQ88VVGNxCrNncoo6kpEUJeri/0
	y+phebni1QuABI+zGl9+CtUio7+IN/G6YYeA4YGMFeHK8+4FrWc9LkNV
X-Gm-Gg: AeBDiet884l6/M5vhRrltJHS1dEKbpdnml8XeyPb6XvyREf50O1NjpuFwhZJeu5v+f9
	Wlhv+vgdGeQJiRQd5j4T+P83PtUyT3cwPPlMp97fdeXDQ7D6qBg68MBG3DZt65LRwEQO6EeGLsY
	p7bYiQ3cmYAUOr2e9xcBq7/kcQxXQ6w0u4OTZOk9ZRpIGsgCWPtSMzOxcl5rxCFpzgf1owAi6NK
	qG05bhS6e1H840ZemucluHsHoVTiIMJ0dzwapFKjQ4wldr8hOoq34cL3ccpJpPEncURkXMzaa3F
	lBCdYVOAmOeBzSw4xU2w0umEIOE5iXmdQpntL/OCi7BaO1ukApNdXaDM2/gU4KEXIi5CxDCe9qV
	Z1zTY4ipiBocsU9d1Doz4xlMF3ILZhSelqUOkapjoRfvjzEfEcvKx4pyh+K0ZYfWZ5mSr4Off72
	HY4nSJcbndl+nE2DLWneqZL0yJ2qhe+OpBg/opD1GmMb+asVC0H508SihJePrjZ1phOecJitb+U
	OinxUjpdA9ZrqJ85YYGklu7MqaAgzkdh4s2pA==
X-Received: by 2002:adf:ffd0:0:b0:43d:7d24:b506 with SMTP id ffacd0b85a97d-44649ba19d0mr3593290f8f.38.1777379145171;
        Tue, 28 Apr 2026 05:25:45 -0700 (PDT)
Received: from ubuntu.nomadic.bris.ac.uk (eduroam-wireless-pat4.nomadic.bris.ac.uk. [137.222.229.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f6a1sm6140083f8f.13.2026.04.28.05.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:25:44 -0700 (PDT)
From: Ilai Levin <levinilai972@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ilai Levin <levinilai972@gmail.com>
Subject: [PATCH] staging: sm750fb: fix const pointer array declaration
Date: Tue, 28 Apr 2026 12:25:01 +0000
Message-Id: <20260428122501.100696-1-levinilai972@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

g_fbmode should be declared as 'static const char * const' to prevent
the pointer array itself from being modified.

Signed-off-by: Ilai Levin <levinilai972@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 9f3e3d37e..a618b4a69 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char *  const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
-- 
2.34.1

