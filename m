Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFFC1957FF
	for <linux-fbdev@vger.kernel.org>; Sun, 12 Jan 2025 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736689602; cv=none; b=fsF1dDuYbK0v+hBPxSbiZ2bsBBhTQWesYxO4YiiPJassOVpl54UZ6z75Q+uOa0mrn6nZfJAKBo0kUV49uAj0d8w3J+Pe2rd+qJzwTf8E7nxrkd2xrJQf417J8uKpdU+rnDrXvz0J4Eh8iOs2jbe1NJSDK1O9dwf+0IHgP9U3u50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736689602; c=relaxed/simple;
	bh=e/bFAP1b+US7EIx5pCvXpBa7AB0HDN63nHuUpToIvz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BSh9tljpM24X6nFO2Cwjzs9flCwdHQzQ289X4EKitIaYw+xJDumMt7IJUwLi7o+T0gnzsGukMCfwi0dGUug+eMAWapj1RDxzIyAytouGCe8x4K94w5PUnMQciG7QaLIazyHPOOUavhfn7AF0wdWYiw3i2I+pVuEYzMJBpQxLBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vw1H9StP; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vw1H9StP"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3ce64e7e5so497263a12.0
        for <linux-fbdev@vger.kernel.org>; Sun, 12 Jan 2025 05:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736689599; x=1737294399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdPpMH3EB/gIvZxidNjtZ/XKsVJM/FqerzgsImOH6b0=;
        b=vw1H9StP2dZC0Un1CFlBTEKUUhhzpwRaXDsl7a1epd2AOzCgsQO7nPkoT++YNAGtHO
         OOQaUMAgZJwqbj5IxTJhH4Z8u+KtLyXW9IWa7nBDTQq0hx/hldQobpA5VuzVUoJ9f1HP
         3S/p2QQ78Sx2L1CsP5vJuJebdHEOsVT3GPUdl6CAe5V7Ae3cDAMv0uzapU3bPmmGq5xM
         AfdsaPQoOhbA7Mgci24Il3+FXA98oOFlm+ehIB3C2D98LujnS09Qq4GtupwKOCXe9r73
         uo7ey5bQAjdRD3xf6nUN7/CONYdqXl2qlrJBXiEZUMEKwn/rTtGkavQ1BV3pOCm9r7GD
         Rx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736689599; x=1737294399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdPpMH3EB/gIvZxidNjtZ/XKsVJM/FqerzgsImOH6b0=;
        b=ibBeQ0Ob7kNbVrfCd+Uk4nggrea1RR4DHH4t/CjasO1hwH7zz+hEKsK3iTDypHHloA
         akUHv3yeBVmza0MWn5XmxbJFyOeLNN3Pr1A/kZMs6lLrSQ1excwSflEtkErl6tz33ErJ
         rh938WoNqkW9C8WZ61hxa6RZyKdzg5sLsBV/GEte09lTJmfTEm6g9QvHt7DHYEZ+BBtJ
         JUprFqFJPab1h5VPf/8/p/XV5YBZWB/QiqfSfb6Q4Bbbxf6T5JIvr9iZGC5CiILa2nAq
         Lk5Th83DcHyWaLLEquDmXd7jKMsejCD8yVgeHbCWUHfzVwyIEtpxcsGUsdZwatLv7Zci
         tYXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwb1+AyDfXybtTNDxHHM6SVvR+4GTZqZDHiV/a82uipaZwYx36SPeesfUIneeGIc7G3o+jzO0vDoyZ0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDR63b9BW7maTRUSspY9k1x+koI0JDhjvcNWa1hAuYXTQyTMV
	+sp7DCDO571s6QhfrfRU2G0DWaEL0AHZ9esAlYI9OsNzi5Ir/JkPCj65hfwoE80=
X-Gm-Gg: ASbGncuP4yIrOGtFTencXgyG/8WWTj+EweWgD+e4nd9P6ioFH+Mh5OCpP2mGNkUVtv3
	Wp1o2ft7uprhUs+fDm3qVp4E5JTTzAP6k8704Ru8H6psaVkKaTNKrGIgB+8WJNeTHxPA1b+rtJM
	YZ119L/EXz0qOS8Z2mRQCqhp6C8EqG5RqOZtI1h60pFjnZ2WOFypZ8KWoujH9jkuEgk58YSXCEC
	8QfyKoFpUwXYlvy0VIbszui48PfrBMJP/rJSev7eeYI8999h9uuSa10Ny1n6kjK4WaOdig=
X-Google-Smtp-Source: AGHT+IGMaMySK+AzczYWaado8bQXerWOI16nG+e9W1R3XECS4GCbYRudIN5tZNNHFbXoJHhLI8HzVg==
X-Received: by 2002:a17:907:1b05:b0:aa5:3e81:5abc with SMTP id a640c23a62f3a-ab2ab643defmr680650766b.1.1736689598955;
        Sun, 12 Jan 2025 05:46:38 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90638acsm371051266b.20.2025.01.12.05.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 05:46:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Helge Deller <deller@gmx.de>,
	linux-omap@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] fbdev: omapfb: Use of_property_present() to test existence of DT property
Date: Sun, 12 Jan 2025 14:46:33 +0100
Message-ID: <20250112134634.45991-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_property_read_bool() should be used only on boolean properties.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index c3329c8b4c16..7010544e02e1 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -3933,7 +3933,7 @@ static int dispc_bind(struct device *dev, struct device *master, void *data)
 		return -ENODEV;
 	}
 
-	if (np && of_property_read_bool(np, "syscon-pol")) {
+	if (np && of_property_present(np, "syscon-pol")) {
 		dispc.syscon_pol = syscon_regmap_lookup_by_phandle(np, "syscon-pol");
 		if (IS_ERR(dispc.syscon_pol)) {
 			dev_err(&pdev->dev, "failed to get syscon-pol regmap\n");
-- 
2.43.0

