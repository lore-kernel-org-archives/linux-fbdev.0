Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1882F22
	for <linux-fbdev@vger.kernel.org>; Wed,  2 Oct 2024 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905552; cv=none; b=gkcRRNdej5oYlrXw2dumolPMUeKUjVjmOd5TbUqLxmGiPQVGBifnMstB566gNkjg+reDukSZMmTaLDFwWT9glmDtLXNlSRxVf3MtCsnFuWFeBKIoW4tkrU9qbM2OD5buRwbYuApnzRzcfIvSFYMS2/Klcuw6I47pBuw99NKkuYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905552; c=relaxed/simple;
	bh=G7u5uyJiWXxt82J7ILiQXPkWX0vQS4S1XjneoPKvQXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z0wgpzgMLKir0cf1asuRx0sA+Id4PxofGYhPMNfLRi6J4ivlrNXh8c8/MuYnwu7H3MJmqimX5lj+T3w5gZMIC4y1IBHJBAFag+38GL4+Bphl6Hsr/+aFTrwjEkFSJWSIBI7GhakuWYSRVGuolV0KLydDViBMhx8yvmwFzXXxPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yz0AZpmL; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz0AZpmL"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso221189a12.1
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Oct 2024 14:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727905549; x=1728510349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TpAVWbf3/lT0CKVerCtL5WEmBdJkY5+gMWEwEveY7JI=;
        b=Yz0AZpmLRcdqirMBJ5ZZNUkXhpmyW3fgMo+cElsg/IF3dR6reP1pc2EulLKSas+4M4
         GzHLla7fnzC3UR847XXd/TxrG7p8SlHLMVfTWZF1tTZ9nNL2JhCZFrz/7uL1XLKdTHdK
         kguTZeVDEJ9hAYhrQvg0ONazON62L/h+s2ZOMdzfnP1DojbxZDQpKejZcbTlAmL8LDVu
         NegFau6+26ogYk96a3VaydazA1P2o8QHM9uGWNv3uRLs/ZXzhMOvZsia4YMxMNkc/U7r
         F+yIqI+zrNJNVC84NmVjAJmq87Bru21e2a30U7LqZpWa+N+5WpTrXdi9kbLyJ6BNrlRO
         VecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727905549; x=1728510349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpAVWbf3/lT0CKVerCtL5WEmBdJkY5+gMWEwEveY7JI=;
        b=QBkOc45WeFs11OVz/s665z59rU2hDUE8S6gqEjYvSSvYoQ1K+KRH/Rq09d2YdOdpr9
         Gv1EWwv6ASRdXL9CnHhdY1Z9TMtFdAGoGwhB6GJFWT2q/WI3pgpYpSSsNAKbJHNGmQlU
         Rbv8AlfHK4KE9KLKBhTlf/CHHijcH6O8vB8HS6uE7I/0KScTe9TpqxQefCiX+VxMdYVs
         QDf4KN9Q7tIKJT+pH/tkPIQOTzAF5HL99tuUzlFye6sUFiCkvBvaDWlLgU9HQrucQocU
         63Ub7Fkb62zfRVtIW9GxaIibnMI2BfuiAeyZSEooqOlzesPk5cRbRSRzUdew/M10KanE
         KwPA==
X-Gm-Message-State: AOJu0YypzNeM/cnHD+HjX8jQoFPEqMW4Y7x4X+3IPdWnf2+pBXUMvGOh
	qiFhsuKSUU4759rKIMPfpLs0oUKsw6PsJM+bgi96ZZplw799nvaYRwB5WID02HE=
X-Google-Smtp-Source: AGHT+IEW4do9mEryEFFcJLi2oiNfrekou4nnddOfqmVNu1oFKsPf/Ce6bVcEm9stBqwE+CF+wPk0Iw==
X-Received: by 2002:a05:6402:2691:b0:5c8:a0b1:b60 with SMTP id 4fb4d7f45d1cf-5c8b18e4467mr3091612a12.4.1727905548536;
        Wed, 02 Oct 2024 14:45:48 -0700 (PDT)
Received: from localhost.localdomain ([83.165.96.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88b189878sm6548101a12.93.2024.10.02.14.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 14:45:46 -0700 (PDT)
From: Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	thomas.zimmermann@suse.de,
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>
Subject: [PATCH] Subject: fbdev: sstfb: Make CONFIG_FB_DEVICE optional
Date: Wed,  2 Oct 2024 23:45:16 +0200
Message-Id: <20241002214517.206657-1-gonzalo.silvalde@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Tested by building with and without CONFIG_FB_DEVICE, both of which
compile without issues
Signed-off-by: Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>
---
 drivers/video/fbdev/sstfb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index f8ae54ca0cc3..17f39cc721aa 100644
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
+	#ifdef CONFIG_FB_DEVICE
 	if (device_create_file(info->dev, &device_attrs[0]))
 		printk(KERN_WARNING "sstfb: can't create sysfs entry.\n");
-
+	#endif
 
 	fb_info(info, "%s frame buffer device at 0x%p\n",
 		fix->id, info->screen_base);
@@ -1467,8 +1468,9 @@ static void sstfb_remove(struct pci_dev *pdev)
 
 	info = pci_get_drvdata(pdev);
 	par = info->par;
-
+	#ifdef CONFIG_FB_DEVICE
 	device_remove_file(info->dev, &device_attrs[0]);
+	#endif
 	sst_shutdown(info);
 	iounmap(info->screen_base);
 	iounmap(par->mmio_vbase);
-- 
2.39.5

