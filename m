Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E41B4124
	for <linux-fbdev@vger.kernel.org>; Sun, 12 Jan 2025 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736689605; cv=none; b=t+VD/9wmChrHPa+AlF+Yyrt4Bu+aha3F3A6CRqJ5P4mvYPajrurDJ+T+HYjJQtf8frv7nZFL5EjekMR1NrOGtVVmfYKzF9rX4BmKG9H0WVSI4l7TZe48ykSQcRXoALFwgbCMSMSaFsHAomkOq4RHI6MgeyGz6kezZa24eAq8s+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736689605; c=relaxed/simple;
	bh=8pRfnhU2tsCyFb8/DqJSYRFJG2u8l2yOS3mqK+F8O6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+pJhoQQAg4Tdq2U8rncW20YErxsFKVjJ452d7rSX0dYyV7OUhnz2nQkNOYaIytk8JhGWv0odzxr0mEtz0+auPNgLsckw9Ahze/9DnQZc/ePMSj3aYtCgQzvTMgOx/D3JCfzk7pwmiNrM+6/7yuuLtNH4BjyeD4b+dd0w9TSURw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onCmsdFc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onCmsdFc"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa67773ffd4so49743066b.2
        for <linux-fbdev@vger.kernel.org>; Sun, 12 Jan 2025 05:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736689600; x=1737294400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17mfEUKLFobncZ1DtZDYZ0xDKM3wSv4g9CH5hL4TNJo=;
        b=onCmsdFckaPBqaS9or/r1TG4IOqK7G5fBI6t7FnSYaLaa0HqLyGCu80Jr0tRYraUhd
         zyDRA847MMDPCDKUeaPlXOC/vGnfuMoP+1R8+Umqtai4Mg3lf/uCl0MbVr0rr7aMGW2v
         u71GV1g+1tZBjpAwDfuzLU5SNAp/qnyB6yks8mIb/PkGL/Gc3dSa9tzTYzcfuRbpXJPi
         BKK54Jblr5l1/2sz5kCkZzxpP5SJpJBqbW3Wyg+yLnd/vimpGlf2jm7uWzV4BIepw252
         mwmvydthPIr8wUAljT0Nt9xq0fcjbWxB/6YeZDA1Lc3wGLABxoRKR+TRbIkrRpbC1DUr
         4QXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736689600; x=1737294400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17mfEUKLFobncZ1DtZDYZ0xDKM3wSv4g9CH5hL4TNJo=;
        b=YdVhh12QIrANwN5vDYvsqJZDnPvk9LGQUeSEFG9GGRMe6hcCJBVGfsAerPWoXWFUeF
         wD7Aw1ggRf27IOxMGsXqOj1NmgLUgZPnnX9F6lZ5dUpe6/db+W9AmL2lSKOKwKt5mp16
         BUAlBK+uHNYsDXD9QuO/B2vA+1XYRJMvK2QkYT0/dWgitlNqDv38COTop522aE7sSnSi
         BlP9ccjGeQ0Saz1cMA6Mht/TIWFZ42mBvzH6qtsLTDSKTvvaQtAidftwfIBJ2oCWZQi8
         wIVpfJhPA1APoMbD051jbhj+tOYKvdM/Nwj+p68qTjilEG5ggMiCWqfnR/yqK7ycMssE
         QLIg==
X-Forwarded-Encrypted: i=1; AJvYcCUDvKuPhQemtX+EgjkwiAmoJYRnoVhpxYlzzz4WKJyvlY3ed2DglEeN6kQMUsdwqs2A/QZn0eQkzJ1eAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CugqROX8hehpbPiUEGKFwDRv8Nak1BsxhwLYJlHXRDQHvLNO
	9cv+x7KxJc6u6gr8NFib3LA0Z0PDntyI2q2Kk9JZGGwo7JMjAOBQw3I5R11i6sM=
X-Gm-Gg: ASbGncvVqCXH4XPsrH2TVjBV70WGYn+ROvHEG5/6M8S1zO5ltDTlKjEs9YkE12R18j2
	uOZWnyWiMF5Xc1/MIHCfjksZnY9Y6XWZ9RdoqQ02TcXJ1iD35mNd2J8cVFJs2YLr6op5ApBTIfX
	C0/+nsVM5mgPpG3Tb9wkwA96ZeKl1ZCcRczsT92VI7wIt45qJcdxAeD3g2buvY1oIiDAR3C2IiC
	+OsbG4v4k1t1zFF5lTlwBiqZ5xKHwgCHvip5FsC4kvZaWd8Tk4FGmgTsQVI7n92O2mHeDw=
X-Google-Smtp-Source: AGHT+IGek+mcaMq6Bx12/YzpJyPJOeOrjQQOfVQjcgfD7uU+pEIuD+vivjLmYHe/XC44J0Mh/I2d6g==
X-Received: by 2002:a17:907:6d20:b0:aa5:46ee:9545 with SMTP id a640c23a62f3a-ab2ab571e20mr567188866b.5.1736689600270;
        Sun, 12 Jan 2025 05:46:40 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90638acsm371051266b.20.2025.01.12.05.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 05:46:39 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Helge Deller <deller@gmx.de>,
	linux-omap@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] fbdev: omapfb: Use syscon_regmap_lookup_by_phandle_args
Date: Sun, 12 Jan 2025 14:46:34 +0100
Message-ID: <20250112134634.45991-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250112134634.45991-1-krzysztof.kozlowski@linaro.org>
References: <20250112134634.45991-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

There is also no real benefit in printing errors on missing syscon
argument, because this is done just too late: runtime check on
static/build-time data.  Dtschema and Devicetree bindings offer the
static/build-time check for this already.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index 7010544e02e1..ccb96a5be07e 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -3934,17 +3934,12 @@ static int dispc_bind(struct device *dev, struct device *master, void *data)
 	}
 
 	if (np && of_property_present(np, "syscon-pol")) {
-		dispc.syscon_pol = syscon_regmap_lookup_by_phandle(np, "syscon-pol");
+		dispc.syscon_pol = syscon_regmap_lookup_by_phandle_args(np, "syscon-pol",
+									1, &dispc.syscon_pol_offset);
 		if (IS_ERR(dispc.syscon_pol)) {
 			dev_err(&pdev->dev, "failed to get syscon-pol regmap\n");
 			return PTR_ERR(dispc.syscon_pol);
 		}
-
-		if (of_property_read_u32_index(np, "syscon-pol", 1,
-				&dispc.syscon_pol_offset)) {
-			dev_err(&pdev->dev, "failed to get syscon-pol offset\n");
-			return -EINVAL;
-		}
 	}
 
 	pm_runtime_enable(&pdev->dev);
-- 
2.43.0

