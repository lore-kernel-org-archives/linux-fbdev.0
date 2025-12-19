Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A2B2D323D
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Dec 2025 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766123027; cv=none; b=c9v+EfwhQPfw16PrzJud0ArrvitEd7Wi/tlqOwlPfNfilNtJqS4oEsrHDMjJIuaDGerEjVwyTSO0Mn6Jplm5DG6LebV36PFxVpxmVH/eSrEnhTguhXyjwidNIbdAINfz2W9cqjQJ6eynPBGfD4vlC7KTpzFDfeysw7RThfGGXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766123027; c=relaxed/simple;
	bh=/h0B2MrEIB8vw1/0qkLk8pblOQDpqw3e0E/7EdgwDz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNxBxg+ok+eqRuc3iWZp6nkhTgOUQSXGxd8oYFPmSjy6FHvv70j5QddnIOzM1zEwqRVE1fJQd6OSOk0/NIlG9pwyLJAQ2TNDxgwTax4VdPUogCPaxIRZeVE3S4HfQh481uzjswpcgETYaOpJAJHQx+WpKjuZuzgr+lOGU7qyKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEMGQLF7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEMGQLF7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a110548cdeso19131795ad.0
        for <linux-fbdev@vger.kernel.org>; Thu, 18 Dec 2025 21:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766123024; x=1766727824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLowgtUxpf7Ylc32b4gcev+kc2iAvzLFrJvCpgPdl8s=;
        b=MEMGQLF7wLCH7OpEDUVaeJDgrsjKFUWkDuTpFnx68L9JLQGVqnOKVr3h5P2gLMuyOW
         exuw/wisARzusZqbKf8LBe6QvrY/8BXg/hvpQodRQts4DHIY5VaCMkMfKHxLAA8Ns4P6
         /Ny/SY61iHs4hHSwAuURv7PQXQZR9w6VAqgq9BzlnqlbM4F6+FiDC72mVVXAf0muTirB
         +6mW1Bqqtw8vtQm7o07NdHyU3ccWcMjCVdbokwywQYw8S/sBn46uQQyT0sxHOznYPQ/M
         xunbDVL7QbCo7owcg9G/pa1yu0yyfSYmN2GaaAefjDBqQm3x9N0FjZ22vtIKazBYuZyu
         SwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766123024; x=1766727824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wLowgtUxpf7Ylc32b4gcev+kc2iAvzLFrJvCpgPdl8s=;
        b=ltHPehWFJCBqm3WnNN+u7p2nMppn/WCnPHINdk6vp109Dku1jGhKGm7fDzEPXKldi7
         p87lLPmHQ66W7etE//Dkaw2uahM+J+/JpX95BPTqeAmXJHnzo0msLGj76LPtyFgavBIZ
         OAV9Wh9cacZPcUhrbckyX0gfhZ/vVebXeQzAVl6T5y6tjnAMIDZwSL6/1U1g0jaELSwY
         9UPOqXv7vnfRpTuKPnClRUa7K7iQh1RblJIj5Md4Q1V2bs0R1RsqvXZOczfr7a5fxHje
         QGnHAWoyW2OQOosYX57O/ZVWZXKDmPqJE8LD7huYxN/wgh8GLmCZ9ZivlSnlMvTZAPe5
         VtWg==
X-Gm-Message-State: AOJu0YxntV+LukvRdxgEcAIHAIRl6zzmtZMjgThvpq9NDbqlx/eFlSii
	XBzMudHssaArK66DupcBhIzOfVw53yCW7qrb0uB9KCJsRscaRNLYbdM2T+nAbaXR
X-Gm-Gg: AY/fxX69Aea+cPdXmczriDpi2vEhFjriXWGlYDvetmG9gO5ZdAAnnem8xouCZdkmheg
	mQcrX6jVTCQbsaxf9qqmw9qbLvxxu0x1KT/Y1m8edhKGOk8QP4MWW93LxUJkuexUMtrgfUGtvp1
	O1AuV70NxlJFFPDg6v/pLF5jo5MP3GtNaqe7guEbwbR1DvDkaN124+n20dj/2HD1xmHXSYBQu6/
	oNDgnMw6I8/2uGkpuf0HYPQuVEq03WN/2MepC39As6yTWu9su/ZBOXB6PlM4FZMg4rfswG2cyjU
	fZ6s7XPUHq6y/IbsgIzx645H4q1GWS9l0H0D8gRVKVJgFygHNQjgbFuok3kiUNYGP9AtyN2YgF4
	qv9Nd6avczUgw4dq+d55930J7s4bdNpsRG11cZocxEq3suszeIZaJW9biJUGM4vtyulVVFugWXe
	4XPQ1oisnjuTdgHWPB/Q6x89x/89J6voe0smqRpwMhIK0=
X-Google-Smtp-Source: AGHT+IHapH6OsO1AHtO1AIXlBe8ewsFWc/T53IxGs44x5WRWKW2jyFjQP7saYVlxU5+BW4fZO8YydA==
X-Received: by 2002:a17:902:e809:b0:297:cf96:45bd with SMTP id d9443c01a7336-2a2f2231b01mr17507025ad.19.1766123024262;
        Thu, 18 Dec 2025 21:43:44 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:5160:2cad:cf88:afa5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3da7dabsm9878955ad.25.2025.12.18.21.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 21:43:44 -0800 (PST)
From: Chintan Patel <chintanlike@gmail.com>
To: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	tzimmermann@suse.de,
	andy@kernel.org,
	deller@gmx.de,
	gregkh@linuxfoundation.org,
	Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH v2 2/4] staging: fbtft: Make FB_DEVICE dependency optional
Date: Thu, 18 Dec 2025 21:43:17 -0800
Message-ID: <20251219054320.447281-3-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219054320.447281-1-chintanlike@gmail.com>
References: <20251219054320.447281-1-chintanlike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbtft provides sysfs interfaces for debugging and gamma configuration,
but these are not required for the core driver.

Drop the hard dependency on CONFIG_FB_DEVICE and make sysfs support
optional by using dev_of_fbinfo() at runtime. When FB_DEVICE is disabled,
sysfs operations are skipped while the code remains buildable and
type-checked.

v2:
- Replace CONFIG_FB_DEVICE ifdefs with runtime checks
- Use dev_of_fbinfo() to guard sysfs creation and removal

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
 drivers/staging/fbtft/Kconfig       |  5 ++++-
 drivers/staging/fbtft/fbtft-sysfs.c | 18 ++++++++++++++----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
index c2655768209a..578412a2f379 100644
--- a/drivers/staging/fbtft/Kconfig
+++ b/drivers/staging/fbtft/Kconfig
@@ -2,11 +2,14 @@
 menuconfig FB_TFT
 	tristate "Support for small TFT LCD display modules"
 	depends on FB && SPI
-	depends on FB_DEVICE
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on GPIOLIB || COMPILE_TEST
 	select FB_BACKLIGHT
 	select FB_SYSMEM_HELPERS_DEFERRED
+	help
+	  Support for small TFT LCD display modules over SPI bus. FB_DEVICE
+	  is not required, but if enabled, provides sysfs interface for debugging
+	  and gamma curve configuration.
 
 if FB_TFT
 
diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
index e45c90a03a90..848702fc871a 100644
--- a/drivers/staging/fbtft/fbtft-sysfs.c
+++ b/drivers/staging/fbtft/fbtft-sysfs.c
@@ -203,14 +203,24 @@ static struct device_attribute debug_device_attr =
 
 void fbtft_sysfs_init(struct fbtft_par *par)
 {
-	device_create_file(par->info->dev, &debug_device_attr);
+	struct device *dev = dev_of_fbinfo(par->info);
+
+	if (!dev)
+		return;
+
+	device_create_file(dev, &debug_device_attr);
 	if (par->gamma.curves && par->fbtftops.set_gamma)
-		device_create_file(par->info->dev, &gamma_device_attrs[0]);
+		device_create_file(dev, &gamma_device_attrs[0]);
 }
 
 void fbtft_sysfs_exit(struct fbtft_par *par)
 {
-	device_remove_file(par->info->dev, &debug_device_attr);
+	struct device *dev = dev_of_fbinfo(par->info);
+
+	if (!dev)
+		return;
+
+	device_remove_file(dev, &debug_device_attr);
 	if (par->gamma.curves && par->fbtftops.set_gamma)
-		device_remove_file(par->info->dev, &gamma_device_attrs[0]);
+		device_remove_file(dev, &gamma_device_attrs[0]);
 }
-- 
2.43.0

