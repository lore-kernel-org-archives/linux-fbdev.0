Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B367313E3B
	for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779003826; cv=none; b=YUI2Uw40nsoH66dHpcKBkACFvf0HhypaHn/GpnovtQZMzSb9a5Ref1FQCIrpphQAEYlHKe7xXaruzdiIiVGvt6pXPy7hozpkczn0/2QgAPDbGO+fo8WKJLkQeCDN5HQmHYSLGkBDV0j0zbux1Fege7X6K1dO3b8V1RpN0naeqRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779003826; c=relaxed/simple;
	bh=YDvzhtpKlF4YyG+3rcF4wl/f1z7vrexwv/RtY92FvxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOKwGX7sn3r1fDdE9g2/e3gljPDP/RhF4Dfy2bz6O2zb/gP1uGY/KFLWF3K0plSz3iCSb/E6t0LtE+fBrEcC9v0d5jWjhVLo70yv9h5Sy7h/mPRWlGYvJ0YuSHXbMFJYRIK6PUgbnBZ7l2rDJdCAgwT7BYeRg2l9vcLE2uWMNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vwer9Jlt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vwer9Jlt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44b330c5cc6so787005f8f.1
        for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 00:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779003819; x=1779608619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LzbpjsuKPCXdtxH83s9qoUUdpBAxIBv3nnvj0Qfzzw=;
        b=Vwer9JltXQOWgcvgTjf2dSCnv7RIw5v1yF4JR02LuTu6WcQbmJyNODS9iKnIXJYCq7
         8cZ0Q+qKM5jgfaoWeCDGEsAk+7UnwWvJUfmvQkJMe4KCNR2B5unVLJ0gmbvLmLUWzSbj
         Weswr4xAkLH8DqLvjxPCU+EJMetfboFl0qvCFxB7dPIMR9RzrgVS7M7mArDWzcIiuNvN
         0N4BOL3s8Lu93bIq1t835Q54RnbNIr1Bsrl3yMX7uJ7ZWAn8/nXUv1nkeVfzLZgbcLLd
         liLOUroMTrMbjVdV4mbge5R94uskFopQatOCMGn74eOs8MHi0wWlnMFon2Bg7xOIYB2g
         pGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779003819; x=1779608619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0LzbpjsuKPCXdtxH83s9qoUUdpBAxIBv3nnvj0Qfzzw=;
        b=LmOlIa4ubwHD7vHnNmNgf3BBAAs9AdWG9lVbRMms3/Tfu2fGE39PB35RBnldBlTdNv
         JHsdfvpf5tLgSQWnpfHdIh/9Zxba/ZBq6wckfwlraY+6GeGz5dTtHdDihjen3K+Oh4AT
         wLS9Wcvp3F+DbnocXxgRUDSMiaWPRc8DnT1uE207iPK+7KqUBoJz4Tu43CHpTyvf+CEf
         0anOPYL68UqV4OVH/kU6sNLyc6OQGfT65kaEHFOn3iwvyDmgAo9jRMSQ8fTMyojEMEOm
         yYDCrt9DRssstaCe36Gqs9e3sMbTZgr5C4/Sggu8kZlP5xo4lhhbMp+IpMt1Er9Ofcfb
         aZcw==
X-Forwarded-Encrypted: i=1; AFNElJ/2L/dA0LQAWeYP3+IuYwlMpkvQZO9CdcFt+97AdcpVQhz2tF7MwGQZYdCJ4eqqhzFDYhKl/EbQwCHwLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf7sBxEymD19TogjeoML9/jiTnZrS9qF8lIgYhrtehj8DeFEvN
	q9C10O+4I3gS3GEMWgcXHpcPWygYSu8Ylt4bhHg8ZSuoaQOoeA3Ti5xw
X-Gm-Gg: Acq92OE0IIvnq5yedPhQ1USO7NABKkgIlCEvJAiFEBphKoBPApieOZLZTArDMLv8DV5
	xG9C66lKrskWI58EbiB7A+HaKydlKWxaM1pHwJlzjvC0VQGIMvZZLBSFeyy5Ox4PV+Sntd7djLh
	Xnu7EPKLJ+IMVX+KL20Cs+EHHHRNZRGRaRQK5DOcjnpJFkCTgRbYiGSSNCByuHKzbkZkVinyXE/
	vXS/S2VPJGZnLw+KF/OFhloBn8UvhL/s/cJC3ZXuJyppo5vOU0Pr/zXw1D5h8Hi/X/eFVO5azo7
	vqyvLIQKGz2mEr9XfkqO8ylPJT0NztroKIQMsL+Pn+QpoogkGE1r1uYNhzJfy8KkdKY80xzE6ug
	IKSJJYFWk1sGOtp1r9nQyjDodoObaugi4rztbSi3zDWachWAkXPkV+y8E3YjQQaruJVB7ibtjQC
	iNW8SEdMwgyN7C
X-Received: by 2002:a05:6000:603:b0:43d:7c6c:a0dd with SMTP id ffacd0b85a97d-45e5c609a1dmr15044926f8f.35.1779003818881;
        Sun, 17 May 2026 00:43:38 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm27512864f8f.30.2026.05.17.00.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:43:38 -0700 (PDT)
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
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v1 5/6] video: backlight: lm3533_bl: Set initial mapping mode from DT
Date: Sun, 17 May 2026 10:43:05 +0300
Message-ID: <20260517074306.30937-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260517074306.30937-1-clamor95@gmail.com>
References: <20260517074306.30937-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to obtain the initial mapping mode from DT instead of leaving
it unconfigured. Additionally, update the linear sysfs code, which uses a
similar coding pattern.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/lm3533_bl.c | 32 ++++++++++++++++-------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 42da652df58d..be9114b7e0ad 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -22,6 +22,7 @@
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
+#define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
 
 struct lm3533_bl {
@@ -32,6 +33,7 @@ struct lm3533_bl {
 
 	u32 max_current;
 	u32 pwm;
+	bool linear;
 };
 
 
@@ -135,8 +137,9 @@ static ssize_t show_linear(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int id = lm3533_bl_get_ctrlbank_id(bl);
+	u8 mask = CTRLBANK_AB_BCONF_MODE(id);
 	u8 val;
-	u8 mask;
 	int linear;
 	int ret;
 
@@ -144,8 +147,6 @@ static ssize_t show_linear(struct device *dev,
 	if (ret)
 		return ret;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
 	if (val & mask)
 		linear = 1;
 	else
@@ -159,23 +160,16 @@ static ssize_t store_linear(struct device *dev,
 					const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int id = lm3533_bl_get_ctrlbank_id(bl);
 	unsigned long linear;
-	u8 mask;
-	u8 val;
 	int ret;
 
 	if (kstrtoul(buf, 0, &linear))
 		return -EINVAL;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
-	if (linear)
-		val = mask;
-	else
-		val = 0;
-
-	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF, val,
-									mask);
+	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF,
+			    linear ? CTRLBANK_AB_BCONF_MODE(id) : 0,
+			    CTRLBANK_AB_BCONF_MODE(id));
 	if (ret)
 		return ret;
 
@@ -253,8 +247,15 @@ static struct attribute_group lm3533_bl_attribute_group = {
 
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
+	int id = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
+	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF,
+			    bl->linear ? CTRLBANK_AB_BCONF_MODE(id) : 0,
+			    CTRLBANK_AB_BCONF_MODE(id));
+	if (ret)
+		return ret;
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -333,6 +334,9 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	bl->pwm = 0;
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
 
+	bl->linear = device_property_read_bool(&pdev->dev,
+					       "ti,linear-mapping-mode");
+
 	ret = lm3533_bl_setup(bl);
 	if (ret)
 		goto err_sysfs_remove;
-- 
2.51.0

