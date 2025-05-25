Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896421EB3D;
	Sun, 25 May 2025 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748169634; cv=none; b=e6X+QsF45lGced64AbHPHO5yzT1NNe375ABp4sFMtDHtICZfW89yddtwPUBKo1CxO704ELCTZuLwHExHY/IM7dezx0mKGLXF/zjjx3BdXPbVW2plrqn52WWuHNJjhRrYE9s6RQo+t0heMaFivVodkqR3zznzO+jt9l0fJkO6SF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748169634; c=relaxed/simple;
	bh=WgACCt68qfQfxTlmxlqUkIyjawT4I/8tTVhBz4juMQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWnrr9VblSbnAMCHMBBVBdiy3a+prYZXcga86nefKYgtQs9f9ykC+BvPhJMkABkX/wutwxLCaKYXPDMT3fxmwv346fQhVFqX18Er+k8dsulQ66JpTfce9JYdEufNM5/vDZdqtOpCgtUDO00kWu1B+GLesOWMn5WudbmjQqzOKDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1ueCzT+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1ueCzT+"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73972a54919so949215b3a.3;
        Sun, 25 May 2025 03:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748169632; x=1748774432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GaYAYQTXNpM2WMYfSuIUveFo2umn4ZAMC5svAIDE8aA=;
        b=A1ueCzT+LMe/Kxtq2F71XhwDjdTT0mYryMGvrD2YUnH8JusCS4z6OPXT7GPS9MfAOb
         5Y44+6BoDK+c+4HR9KvF16liSdF8RGo28qlT5YJ2h1J51eS7ZNeqm6KxbIkKbMm3TUyW
         4AI0W75DURX9hsf/1Gawxdxcc7tFDC+ZJDQTSrJGkYpsn15IXp96gT2Otb4QB33pzIbB
         XZ5ZKz62o2rkzRp2ZFmqqPKfUiDG6eILhqzOujpTjWeA21pjlN5rZNGbeECVRfX9Vj49
         SiCCBCksMNH0Ylyfl4RZvyPY5AQqH8NdV9yUu/Ztyyl89Bk1QtDZBwRirlsZBHWeB4UY
         9xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748169632; x=1748774432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaYAYQTXNpM2WMYfSuIUveFo2umn4ZAMC5svAIDE8aA=;
        b=K77YP0DCrZ1nO4OrtlV9fVkRXJw7VPnPMuYVv4pe5AL0/W9U3COvOo9cglzQLk+KbE
         +JmBXMLsRAvBUYpRv4k7Uj2n1oHuGgk3DuVsTTztWnGoHA2dKWDTixHDtl105t3B/srk
         bnmZMYMJLzQ74sUbdmZg4yQcp1OcslVBOrFu70XssXVF9h9qOE2yGD2M97/VNt+O1VN8
         HuzG1bcr+mUrfl296sNyCHCb7xzg9S0hYc2mQxvwqsL7C60QGGIjgL2XB/8HRWHS4IMS
         sIG/5kOMqJ6K6mKF2yYkproK1Cw1m7ig31XK6SHh+evNjGp3pbWXq6gZz5+Vhgrfj1la
         pcjg==
X-Forwarded-Encrypted: i=1; AJvYcCUXWcNhmwF6Q8P7HYkbi4pXFp3aeXAuircMlnP26Ft/n1vlFv7qtS0TxiBWGehB/iUJ6tSo2rpuRUNlYw==@vger.kernel.org, AJvYcCWHk+MyoloyX/ZWASF3Cz+rcQd49bWvukSicR5nCtvcOaay/UnFx+OqK6HUJICT9W20exzcKfId2UszTtQs@vger.kernel.org
X-Gm-Message-State: AOJu0YzWjJhKC6vEh2AFuQ7pfw5edh4Q7YH0PnTPwTQYd9h4Dr7SKhAN
	GAstK+mA6cnUdJcgCRkPOA9Pj7s1rBfufozNrdn38BR+z93Q4zt677zf2pQ4TA==
X-Gm-Gg: ASbGncufuhvWEaSEveGz8i9hIHy2pjnqh5iUYZfYQe2BYNHsKfR+H7lDNO26yH5m6QK
	Na9iZMqvL8W+vMGkXeaZZ674+qtWUHDnbM90T9AfyjzMN1sey3xDwLSXeXUvmT90eo1P98p7e53
	Yd27Vesrj2DIu30x15Bb6Hujt70w6oMLGZneHolqZvPLXavddLezAdpizKaqRXO1C1Md9Og1NfR
	4EIwzwBM/0CSVqKU3lb1E2ePS9XvJbVMqJcURazVA9oHhQOjoP5XuwPh69x9bVaOGjExvMdOroi
	8ke4ikijl6B2UReHCDZLJyNrpZFeCAtxKR/QB2INHFSM8YMbkw==
X-Google-Smtp-Source: AGHT+IGlJGZJeHx8OGbctaBG1uExbLaC8Q3Ayyr+IhhjqqI6aLuKbhMEoRnhVaFAlORnkwrGEyDb6w==
X-Received: by 2002:a05:6a20:c709:b0:217:4f95:6a51 with SMTP id adf61e73a8af0-2188c362e27mr9194105637.29.1748169631662;
        Sun, 25 May 2025 03:40:31 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96defa1sm15833363b3a.12.2025.05.25.03.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 03:40:31 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [RFC PATCH 1/2] backlight: Rename duplicated devices to support dual-backlight setups
Date: Sun, 25 May 2025 18:40:21 +0800
Message-ID: <20250525104022.1326997-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When registering a backlight device, if a device with the same name
already exists, append "-secondary" to the new device's name. This is
useful for platforms with dual backlight drivers (e.g. some panels use
dual ktz8866), where both instances need to coexist.

For now, only one secondary instance is supported. If more instances
are needed, this logic can be extended with auto-increment or a more
flexible naming scheme.

Suggested-by: Daniel Thompson <danielt@kernel.org>
Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 drivers/video/backlight/backlight.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 9dc93c5e4..991702f5d 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -365,7 +365,8 @@ struct backlight_device *backlight_device_register(const char *name,
 	struct device *parent, void *devdata, const struct backlight_ops *ops,
 	const struct backlight_properties *props)
 {
-	struct backlight_device *new_bd;
+	struct backlight_device *new_bd, *prev_bd;
+	const char *new_name = NULL;
 	int rc;
 
 	pr_debug("backlight_device_register: name=%s\n", name);
@@ -377,10 +378,23 @@ struct backlight_device *backlight_device_register(const char *name,
 	mutex_init(&new_bd->update_lock);
 	mutex_init(&new_bd->ops_lock);
 
+	/*
+	 * If there is an instance with the same name already, then rename it.
+	 * We also can use an auto-increment field, but it seems that there is
+	 * no triple or quad case.
+	 */
+	prev_bd = backlight_device_get_by_name(name);
+	if (!IS_ERR_OR_NULL(prev_bd)) {
+		new_name = kasprintf(GFP_KERNEL, "%s-secondary", name);
+		if (!new_name)
+			return ERR_PTR(-ENOMEM);
+		put_device(&prev_bd->dev);
+	}
+
 	new_bd->dev.class = &backlight_class;
 	new_bd->dev.parent = parent;
 	new_bd->dev.release = bl_device_release;
-	dev_set_name(&new_bd->dev, "%s", name);
+	dev_set_name(&new_bd->dev, "%s", new_name ? new_name : name);
 	dev_set_drvdata(&new_bd->dev, devdata);
 
 	/* Set default properties */
@@ -414,6 +428,8 @@ struct backlight_device *backlight_device_register(const char *name,
 	list_add(&new_bd->entry, &backlight_dev_list);
 	mutex_unlock(&backlight_dev_list_mutex);
 
+	kfree(new_name);
+
 	return new_bd;
 }
 EXPORT_SYMBOL(backlight_device_register);
-- 
2.49.0

