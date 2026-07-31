Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02844192FC
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497845; cv=none; b=qi6dYObU2lTlh4yPXgKAltXWsLzTndEZxq9aZEAUgYmuSlWJYOevCFCODCeIFOVO7XMnsn0rJkWPEsMY/hQRK4kq4/mC/jLBQf47F43U/VC3aRWAs3WK5RAAfZTWjH8VIpjfxzxPGnFuSrm3ALHN+erpjK6iLDSO6EAG5qbI7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497845; c=relaxed/simple;
	bh=Fz4O9nNI+mBOWsonwfBBh3DSW/u0KKHFtWGWtm4D2KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejSFL+Y3U1635rHsQZlIroimmS8FNZm3dOXsU4GxDuBrt1mXE3DEnm5wGWuLFsEMX2REKed2LoI5kvr6he45mMeZUA+Zn7GAKyKM41Gek7vNYrA7WTkJzta1E40ebyiNKWK303mjlKwL/cqlc6b2PC12xjTsXPv+BO6Pt7cBWOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKctgs+n; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKctgs+n"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-476a130c138so1069718f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 04:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497837; x=1786102637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0PyVHQRL/Wspv3Qk4s8DBLC6Ax3FJKAvcclZCqUsci0=;
        b=VKctgs+nPvqDRdEsrjwAWnrhgFxTLSxrVPe3OkVD0iDZ7U/LvAp5X5rlDl0Jv68c00
         +Nh91hWgWXkuM+gbupI5dDQ2J9ey4kCOXO3ROEbILCO7YmAFrmfo9ofkftiB2FOdFs9f
         nzgjOaEPfHp0iEEA2C8qtp7f/eYWMhXnNm8/U219PH5Pep7GDq6lxsyMHJqjtUEAE5RZ
         D5fP/g7u0iY4zjBeP7tPELhOte2qqxQlMYAnlg+/G44Y4UAfOQzZoK0bOhHEUixMi5L5
         ROwWPOFc8yW45I8C/Ak+zgI7c9RZs5f5oFtV91wzr0Bbc0pj+y0oGRSOcHq7TNQjS0P7
         hpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497837; x=1786102637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0PyVHQRL/Wspv3Qk4s8DBLC6Ax3FJKAvcclZCqUsci0=;
        b=OjEoTYEQ7Z0EDPKQImtWHSmoB/anI8c8h0M3dROW2dV4826l+NmnHkdp8Iz4chPFyM
         cPBCHH3PE5XY8XhH0JShG5MaHsYT5xkMMz5x52BmLN/9pW3xczsSVRPMgL05rqC9SRXT
         JdzoE5LV+y4gYC7ibjjM4D3Nw1UIxGeTaitOR5BE7KcEhsXtMJOvggWlOhiQtL9ZFD++
         EzMAek0Ty78XW1/6VUy9igkpflsheWc2X9MNu9Plexj3iAli17FNzs8safIum/+6YYzo
         G8KmcnZcIw6+WZp0PRZ0wOpB6y0EgPj1+z1SZMtweP+mhhYQwVq+Wo/0BQ5i4UpQZyDZ
         8M0A==
X-Forwarded-Encrypted: i=1; AHgh+RrfhznArOiKD+oPWYdMRUyOpI+zH9KdU+8Ex09oudGyEljmV3G2mxdLKophjacU4CIFiPKC+s2NEuHRQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw313jgU9aRuhN/NVHNiwwXP76WRpmrILBT8G7tSWLR1ddVY4qL
	fV9tmapuB/FoIYPSMhW33kg7E3tT7I9RMarfakFcV9b1qbzL2bpDZLwe
X-Gm-Gg: AR+sD12IBEKJpqOqWgA8Auq++oDXuWf3zKkmjn3DoPbErakfdFt7wCvaggJu8KK7CFi
	Kx9jW1bhHTNhCzuOjcWdeK/XC0jHEriCsDrPEgjB5okQjb+aa4FII6HZohhMsTSbKey9XRiOHrx
	LlonpZWHmVFDgTHnYxV7oX1aHfxT8qPkYzHnLZVE7PQ3kccBo/ItDO1lgf6qZFAoMlC+cWe8tLG
	ukGgjAO8pXV7lCDjtMuePEqkLTT3uszSp7E4mclRSvTL7CrXrLK5RgVNKozY8/qVpdesP2peM52
	KQ/9KlbV3JOZtcGpkMoJ1F/csmOhFbgxU4pVlDSxnA2zgJ/KimJ0+wGB+ApPwa92IWIGuTeeFWv
	pMqPDVJOZuCVGiEzM9dCoAyjSwkFzI04/9M7LVowL3iipsXO4I1sPxlj/1+jsSJpJVetjF2FGuW
	tetlMDIVXItp58BkLFbdTW50xy1VsZxpRBkOci//40QLho6r9Ij+srpAXmqi4qWqEEmJQw/IxjL
	bUlfYPR/g==
X-Received: by 2002:a05:6000:220d:b0:47f:93a1:1126 with SMTP id ffacd0b85a97d-47fd2b6b0cdmr3767923f8f.61.1785497837511;
        Fri, 31 Jul 2026 04:37:17 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:37:16 -0700 (PDT)
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
Subject: [PATCH v6 11/14] video: backlight: lm3533_bl: Improve logic of sysfs functions
Date: Fri, 31 Jul 2026 14:36:29 +0300
Message-ID: <20260731113632.158440-12-clamor95@gmail.com>
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

Simplify the sysfs logic of properties by switching to macros and proper
regmap helpers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 62 ++++++++++-------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 5ce237cb42190..2e31a79628d6b 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -22,6 +22,8 @@
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
+#define   CTRLBANK_AB_BCONF_ALS(n)	BIT(2 * (n))
+#define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
 
 struct lm3533_bl {
@@ -84,88 +86,68 @@ static ssize_t show_als_channel(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "%u\n", channel);
 }
 
-static ssize_t show_als_en(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t show_als_en(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
-	u32 val;
-	u8 mask;
-	bool enable;
 	int ret;
 
-	ret = regmap_read(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
-	if (ret)
+	ret = regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+			       CTRLBANK_AB_BCONF_ALS(ctrlbank));
+	if (ret < 0)
 		return ret;
 
-	mask = 1 << (2 * ctrlbank);
-	enable = val & mask;
-
-	return scnprintf(buf, PAGE_SIZE, "%d\n", enable);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
 }
 
-static ssize_t store_als_en(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
+static ssize_t store_als_en(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int enable;
-	u8 mask;
 	int ret;
 
 	if (kstrtoint(buf, 0, &enable))
 		return -EINVAL;
 
-	mask = 1 << (2 * ctrlbank);
-
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
-				 mask, enable);
+				 CTRLBANK_AB_BCONF_ALS(ctrlbank), enable);
 	if (ret)
 		return ret;
 
 	return len;
 }
 
-static ssize_t show_linear(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t show_linear(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	u32 val;
-	u8 mask;
-	int linear;
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
-	ret = regmap_read(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
-	if (ret)
+	ret = regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+			       CTRLBANK_AB_BCONF_MODE(ctrlbank));
+	if (ret < 0)
 		return ret;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
-	if (val & mask)
-		linear = 1;
-	else
-		linear = 0;
-
-	return scnprintf(buf, PAGE_SIZE, "%x\n", linear);
+	return scnprintf(buf, PAGE_SIZE, "%x\n", ret);
 }
 
-static ssize_t store_linear(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
+static ssize_t store_linear(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	unsigned long linear;
-	u8 mask;
 	int ret;
 
 	if (kstrtoul(buf, 0, &linear))
 		return -EINVAL;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
-				 mask, linear);
+				 CTRLBANK_AB_BCONF_MODE(ctrlbank), linear);
 	if (ret)
 		return ret;
 
-- 
2.53.0

