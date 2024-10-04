Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E6F1C75E0
	for <linux-fbdev@vger.kernel.org>; Fri,  4 Oct 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055478; cv=none; b=BQRPRlEXskiyAupxZVNtGF/das6GMFPiZk3ULHhqPHYA6IB01/wBsxeOIAIWbDJQmTAZ6BXnW7mP3MlLTWP86TYhViNvWi6DIIy9f7f5ATrJW1SUAikV6ohZkwWWsLePy2Sg5MBspJcZ1rLHTXLaRLGAOMXdzKB8p/yb07VO0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055478; c=relaxed/simple;
	bh=T7IRw1AKNUwr5QIrdOkZhvYlhMJLiSS7agj0Ncqc278=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pl+HqDLHq4Gml9qB9sR9lWVS1THbk64BgwbPAFvmbvQO7ixmz0zZS+zl8NMNvBrTOKU+dBTOLxuGspY/rp9we08+2PJSj/Ovh+4jJJr2QdNXmD1oaR8/peQDNYC00oRtpfM6xvjpIdb6SVXkexoXmuSpZJVVAuzo3cq0NC3IvNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kbbb3Izl; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kbbb3Izl"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-37ccc597b96so1521870f8f.3
        for <linux-fbdev@vger.kernel.org>; Fri, 04 Oct 2024 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728055474; x=1728660274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBEcrk99pLwxmiJHtfJfKgyMHG/gC+Hf5TZACV40Dqc=;
        b=Kbbb3IzlbhI5YtubfwN3Oqfdwejd3Vyy/U/pY3ckIV8FKsKD2+zlfa8wTmov18m/qP
         8uR74kV7J11D0jhyK4tHw0g22zc0VK2YcFlCsMbgFBKTurPypkMqsnLF+Jk5fJiSMwKr
         C+oWluqOg/f0MqcL9shSbW9NUVY+XDfL6JwmaLAxy9X30i9VM6eycsvDJDdee1sminzv
         1IJrXxYViBsJBpHZcK6Ii3PTrMpBTuqT1zDHS7q9UJ0JfYPAtw4fJPOoiQNiuo33xFXD
         mgz9szCfoYEBN+LScLCpqbeBar12Yrls+DXKSTIw6MGuakHADel00Vr2lsgS7vGB4pIO
         /Xpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728055474; x=1728660274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBEcrk99pLwxmiJHtfJfKgyMHG/gC+Hf5TZACV40Dqc=;
        b=uNVPLc28Gzk/BbmltuAHwaE2IqYoM2dfRWKAQO9LVg8kr/lO9RrMIAJD483BHgEmRd
         PONisyPsJcj/dfrwF79dlmULOiWehHr5AH2YXHB4ixtJ3rQf6RQ2/QvqG9z0Cz+bBrex
         7S7dYQltB1IK/Q/9qk2Tj8qb2gqhNohOXr8tuOAr5Cv57+9CHtadIgeWO4WDKCz4c7X4
         VZRe/lTuTZfdEv7moDelevspzPP41Jzz4LN80HlkUWtm8bdHRlLFs98N/y4U0FH1vXa0
         ct4Pp5c4229flrukQUkWwoVP0Gx9YANhW8KvTcFwA3B6sS8vqw5i7lrUyWzZxfCWzFIt
         G63w==
X-Gm-Message-State: AOJu0YxrAbqbtiWZRvQ7+W5PSeSAUQ9KVvu9szInKwC+OWGlF/8U4w5L
	id1FtTvvbpfFPzKwxdyHx0zrJBjLFZZCy01M3jOX6di79uDZbZVD9/mOSgcK17c=
X-Google-Smtp-Source: AGHT+IGNZoBBCwh9bvJvyw0BHHpRZMKCQqvyxWnYs3vbrVfla9eIZqQ6Oj9nLBMCnSg/iAmXYFRlHg==
X-Received: by 2002:a5d:64e7:0:b0:371:c51a:3b2a with SMTP id ffacd0b85a97d-37d0e6d31edmr3034859f8f.4.1728055474346;
        Fri, 04 Oct 2024 08:24:34 -0700 (PDT)
Received: from localhost.localdomain ([83.165.96.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d081f7103sm3466317f8f.1.2024.10.04.08.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 08:24:33 -0700 (PDT)
From: Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	thomas.zimmermann@suse.de,
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>
Subject: [PATCH v2] fbdev: sstfb: Make CONFIG_FB_DEVICE optional
Date: Fri,  4 Oct 2024 17:24:29 +0200
Message-Id: <20241004152429.4329-1-gonzalo.silvalde@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <1db0e2db-97e0-492f-ba89-0a1f49ca4498@suse.de>
References: <1db0e2db-97e0-492f-ba89-0a1f49ca4498@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sstfb driver currently depends on CONFIG_FB_DEVICE to create sysfs
entries and access info->dev. This patch wraps the relevant code blocks
with #ifdef CONFIG_FB_DEVICE, allowing the driver to be built and used
even if CONFIG_FB_DEVICE is not selected.

The sysfs setting only controls the VGA pass-through state and is not
required for the display to work correctly.
(See: http://vogonswiki.com/index.php/VGA_passthrough_cable
for more information.)

Tested by building with and without CONFIG_FB_DEVICE, both of which
compiled without issues.

Signed-off-by: Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>
---
 drivers/video/fbdev/sstfb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index f8ae54ca0cc3..8d2e9d1f8d80 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -716,6 +716,7 @@ static void sstfb_setvgapass( struct fb_info *info, int enable )
 	pci_write_config_dword(sst_dev, PCI_INIT_ENABLE, tmp);
 }
 
+#ifdef CONFIG_FB_DEVICE
 static ssize_t store_vgapass(struct device *device, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
@@ -736,10 +737,10 @@ static ssize_t show_vgapass(struct device *device, struct device_attribute *attr
 	struct sstfb_par *par = info->par;
 	return sprintf(buf, "%d\n", par->vgapass);
 }
-
 static struct device_attribute device_attrs[] = {
 	__ATTR(vgapass, S_IRUGO|S_IWUSR, show_vgapass, store_vgapass)
 	};
+#endif
 
 static int sstfb_ioctl(struct fb_info *info, unsigned int cmd,
 			unsigned long arg)
@@ -1435,10 +1436,10 @@ static int sstfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	sstfb_clear_screen(info);
-
+#fdef CONFIG_FB_DEVICE
 	if (device_create_file(info->dev, &device_attrs[0]))
 		printk(KERN_WARNING "sstfb: can't create sysfs entry.\n");
-
+#endif
 
 	fb_info(info, "%s frame buffer device at 0x%p\n",
 		fix->id, info->screen_base);
@@ -1467,8 +1468,9 @@ static void sstfb_remove(struct pci_dev *pdev)
 
 	info = pci_get_drvdata(pdev);
 	par = info->par;
-
+#ifdef CONFIG_FB_DEVICE
 	device_remove_file(info->dev, &device_attrs[0]);
+#endif
 	sst_shutdown(info);
 	iounmap(info->screen_base);
 	iounmap(par->mmio_vbase);
-- 
2.39.5

