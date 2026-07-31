Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DCB401A37
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497847; cv=none; b=I2OjhBHM4O7hYceUPFZ9aPBuFDaF52dYXP1ZPYRJ821kgKjAczg80oUWTu1ELo3JyMw7KXDxqtnicgUr/IA8aTlHJGoEAbMhOh699bvvYe9yJ13mL1YluFFqAnq4UgryrTDCp+Jx+vAWnHsrHq1xq6TNUDDDIs3ikUD8TnyeSa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497847; c=relaxed/simple;
	bh=jzKL0N3YlVllgP+B/U9c8TNN1MATVwvNIY+TMDc6s/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iofEW6Fzinvd5uwwFv2XhaCidbUpfM/SV8XSODyVjy+0UE1gSVxMlyHxCitFzrYi89KWDGFc02q/L5c50BW+BY0JSagkNuLhWZtG90vSKVOaNOR91ybyKwygfMaidwKW/iU/rbTj0VPw6jxZWbRHZrduck60yTgn3EqWeJ+iPmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5Ow2v32; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5Ow2v32"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso436626f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 04:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497840; x=1786102640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h0eE6D17SL5fIygwG8Kw0xWT8mg9cqKbwl7rsTtSWgs=;
        b=q5Ow2v32jfbPPxDG0mXmP+CTBT2dGUH9jlwpUt7BufPhHC8Sx2h392TWzN//pybhJF
         R5ovHcdivFq7NfpfBbaqoYKpuTKwYVQqR464ghAymNN1Ppvd5BJ7Ksc8gp/60xchEs8W
         mMprOEEFx9iv8ppnB9uBfDc7OemiLBPDH6x4QRgDpmaA0yzsmUViff8XgxhWLMkF+3t3
         VLF6/0A6H6Z6CIHe/hrUKFraY02d2uGO5JWdK+cdYkVRNzzF23l7iaYegfSaYsKVf+Qs
         7tEhx1BFzB3CN0NfzazbbiaxtwrY10wVy7Jj4R2qDeHVg2aFOrAy3sPRQu5XUkXbTRKv
         irXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497840; x=1786102640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h0eE6D17SL5fIygwG8Kw0xWT8mg9cqKbwl7rsTtSWgs=;
        b=kkNL7u6OCQt+QlD4W5MhScZp+/eNcGxih0TJc/AYNAGkXL4ee5vbWkbcAjEkFdeRqu
         PVaREbSLVOoefIvIgdCAbS6Tq2FJvyyvYwDMF1ZyEFCAKILn7jk78DCJv9TzCG/S6Ihw
         GBS7iEB7rwUn72n1eel/8t9PLJyvsjlXpJpa4geLhBhjevBI0eVKcM5GbGstPRqKoAij
         s9tP6Ti9sdCNFgH2PZ6N1zN56epyrbtBAXXyexZj6YI+zZMcfzZHwnhLuQ4/8cZ4yl3t
         O0ln975oNmosMbTRKCFdOnhoubgrJsOv0kZhZM3oO8RiBDEKfwDfPgkTIyrUWryY2NNZ
         inNg==
X-Forwarded-Encrypted: i=1; AHgh+RoWQAdLQZF8XxFhz7XXvn8NsJ2optNa7ExnTlv09J0lQCEdG7ZyPrvPg3Naz5dCpZfgi72ueFKI6E5Dyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBeFWAZQlEquKgoF5fp9rp1vhU9z5fm8MMipGZJfxOQdg+quIw
	+3GCGz9zZfuvwS/3PsHLfUvPH6BWfo04O8WMwpGrzRYWVhugSbnyx+eY
X-Gm-Gg: AR+sD11aAbC7vJiCwp35NfvyLvQyqua6wHI2vPfmahdttQ5VG5pDa25dz9xac/SgVvi
	+GeRshxC6dJf+eX9JZjp75UQJ9KFU1nTmj40Ep1UUTsvPFqnwij9fbNalZJ+pnvgReU/PXiJ2gI
	BLRs0guKSBFTTS/Hg/svyWstbmznpJOcLpD3dQcdhkYgXi1k+vCqPWnHoxqNxjTtTsTf4HbM5/K
	mQq7reMdkmuBOMQY71yDNDyph5mWROVgru15DwAn8uQ7aCHTmA2qAxmy834D2wPPmVc5mDi+Kxa
	I0b+2Lj4obOOlPPvUh8pB6hW0OhDVr3nNAIgmXTr4INT1HA74tL8akR/GrKUomHlV26R8XXfuTj
	Ou4jzDNc+T/dpjVCtIKUEL29cSZrGq2670gMzG0MPplulsCxRw4v7CbhZJYKI1T/8mD6VxYolHG
	Hmdi3/kWqhKs0EoNJunA2S2hC7Sj8d5c1EZmMDtFsG5/q9kpH6CUEYQJ1rCdeejK75WSiFR2c7w
	ATgdZNa0Q==
X-Received: by 2002:a05:6000:184f:b0:47f:9760:4d25 with SMTP id ffacd0b85a97d-47fd2ac97a4mr4103846f8f.14.1785497839657;
        Fri, 31 Jul 2026 04:37:19 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:37:18 -0700 (PDT)
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
Subject: [PATCH v6 12/14] video: backlight: lm3533_bl: Set initial mapping mode from DT
Date: Fri, 31 Jul 2026 14:36:30 +0300
Message-ID: <20260731113632.158440-13-clamor95@gmail.com>
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

Add support to obtain the initial mapping mode from DT instead of leaving
it unconfigured.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 2e31a79628d6b..666213cab667a 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -36,6 +36,7 @@ struct lm3533_bl {
 	u32 pwm;
 
 	bool have_als;
+	bool linear;
 };
 
 
@@ -230,8 +231,14 @@ static const struct attribute_group *lm3533_bl_attribute_groups[] = {
 
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
+	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+				 CTRLBANK_AB_BCONF_MODE(ctrlbank), bl->linear);
+	if (ret)
+		return ret;
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -285,6 +292,9 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	props.max_brightness = LM3533_BL_MAX_BRIGHTNESS;
 	props.brightness = default_brightness;
 
+	bl->linear = device_property_read_bool(&pdev->dev,
+					       "ti,linear-mapping-mode");
+
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
 	if (IS_ERR(bd)) {
-- 
2.53.0

