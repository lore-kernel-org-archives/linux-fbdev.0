Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1953FD960
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497847; cv=none; b=Y5owPfafBfEd0WoG1VSzfqcwVwa9S4qd+GPRscZA22PjGuo0d4Wf6jpspe091WpLEX7F46urXNPLgWiNpiQqU286PGBbo0MLomAEYL8LRG02FshtgyDHk8wW0NYfeSDGlF0RHabFjzZXStR7MS+Yl45k4hL847BSF41m9ESpOb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497847; c=relaxed/simple;
	bh=XJPW9wWVGIYK13Jj227Wper/L2IcVnCSHBbetNAUY0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxCaz5hCrgutqoBP9XJVOoUBDMCs2zn6MgNuvLGA+FuTX0xwMbk+5H1VHxONEpazvi9CTJMRaEYT9PX2OQer0xA0gZMVC6iKz0Ug0A9COWRT5hzSkYFk9eKdT4ODZQvMSrvjZcRTSHN+FoHzwUOP0qTIzkrGpTA4BZ6+b14Fmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbucWX2v; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbucWX2v"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso176280f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 04:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497842; x=1786102642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PPCwNXXQzUx5SzGc5RGFQWtwM4MIgHKgBLvTAnTdtiI=;
        b=QbucWX2vUkkVvgFOpAgNC9g4ykz22qPanhiYrqlinSt8/GfMk+dld9sTzfSoMBtCGq
         OHsoc5dxVD1Zp6yyObFQ1d1RtCGnKlKYyhGmvtBDQ6CsPFvL3zBk/NAOFSV9+65LbXBs
         Qz+ozBtWfMjzk3+BjbLbRN2fud6uSo7VEtIW6+iKXyDadQfUB/fZJgXK8sGC8DMzzBg7
         9erfpBa2w8qQ561kHoBrCyPl4iVO0ILzy+IbJrJXSYdRSWhNCTt+UOfR0/t74p9INGeC
         yxU8x2GmI9uRiyjzIxrjCcjcrrbGju1zjDGQnbAUAH+3OiRVlcvuCePM+/qYQFXKzmXi
         eZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497842; x=1786102642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PPCwNXXQzUx5SzGc5RGFQWtwM4MIgHKgBLvTAnTdtiI=;
        b=OFXTT9/9IZ2gnwUv+6nVlhtRKS0Wf1QvpU46JCpk0he82tLdxUPn8+9oMrnd4YlJBB
         hfvzZmxi789LSH1ihYW/a1tU1WpVLKgang0yWIxVU7ID8j9QIjPJi18ZKedNrzWq8QW3
         bz7QKJ+kM68UxW7GFBZCzBHFcOWTfR8h0axTZAgKx2KSRag3iEbtR0VucGjA56awHLjB
         51oMvhXwmn+CfvByUVTEIeqZjq1YJbKMjY4EgEOgIXgoI1iJjUHuEfc1JLCQME7cswO+
         5Nv6VJ5oaxUc+KyPGqeZAikyaVbyuFkpI09CjZQFORowq1NdtJfNRZLNQFHzxkufWATc
         /krg==
X-Forwarded-Encrypted: i=1; AHgh+RpDT8CRvwlQeiKB55pa8jw0qQ2EbGvIBbMm3pjLzcgCdGfDNWv/a7ntKuXv+sWjUh0lxCWAzNp62XQ0EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2tqSmH6jhWD/F9KF/aIKuwer1/dpbXkf/0LuXb8xwBrHbKS7/
	dlBG1/KXK9f7F1VYmvHHnCzI3DHKnnOxB08jBeIbdms7BVls6i1LzVoH
X-Gm-Gg: AR+sD10aZTMvOogxF2hGZWon22dJwrThIooVZv4RAGLWFuU7J3p1yWAgZnqNfKqiGze
	LqjiXyLb80V1kArViU/FDHBB0AAJVnCeNLEc0NHrQl8szLIJI222WRD0SXscu1P0KDdn4orylXQ
	hzVvHKL0T2tnH+VSNYB/vlABQmcRW6aiFnB6LL/mMRzDOSHejVsMLKsfz8s/iwKefVmLHrOBNnE
	1P5+8JxjoMrcSZ6KNSY9mV4cFIcSAL5Zy+0oii+RMY0bw/moEpZRwhHkDNZdH+U6lV6GWbk2S0A
	+/pcbaLbpWbdIrG0iQVRXR1rcpPQb+4MrQA1+d6gEdnRZ+dRtDoasCEErTXRXN4HCYfEQoj9ytc
	fIsFPIkB/iTKjm1/maYThICNbl4pt9thqi+uxinxGBINn6GrpVz3krq0HZx+5v9qg9uX8hb+Sgo
	c02SO+CHTn/mz2BrVf5A6SlfetBYQnaPR6aiedju5+p3ildyZX+Ap/jDBPWaUXRqJa/ZUIgVSCG
	9OG3nqNaQ==
X-Received: by 2002:a05:6000:29c2:b0:478:4de8:9b91 with SMTP id ffacd0b85a97d-47fd2b55e06mr2408925f8f.41.1785497841644;
        Fri, 31 Jul 2026 04:37:21 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:37:20 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v6 13/14] video: backlight: lm3533_bl: Implement backlight_scale property
Date: Fri, 31 Jul 2026 14:36:31 +0300
Message-ID: <20260731113632.158440-14-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the device supports linear and non-linear modes, implement the
backlight_scale property to describe this state.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 666213cab667a..adcd6ac7cf229 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -141,6 +141,7 @@ static ssize_t store_linear(struct device *dev, struct device_attribute *attr,
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
+	struct backlight_device *bd = bl->bd;
 	unsigned long linear;
 	int ret;
 
@@ -152,6 +153,9 @@ static ssize_t store_linear(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
+	bd->props.scale = linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
+
 	return len;
 }
 
@@ -294,6 +298,8 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	bl->linear = device_property_read_bool(&pdev->dev,
 					       "ti,linear-mapping-mode");
+	props.scale = bl->linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
 
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
-- 
2.53.0

