Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C709313E1D
	for <linux-fbdev@vger.kernel.org>; Wed,  1 Jul 2026 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944283; cv=none; b=GeIOLCQj8DJKz165qz71nE4e9Q5C5Dvm0ko/u28RkRyLGkTvVY5lF1VIbYaGbaHbOvcsS8pZdl19RBmjxwA3L66n1AnHcxYSzGC9fndVPrgLGTEDr5a7lg35fHVeo9QBTUIz9g4KZrmtykMypV4/iXPNh8vmRLqE1ccKXsLfnB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944283; c=relaxed/simple;
	bh=nCOVcS5Xjk1nB+bnIBUwvH0i7poNAUWnO3X659ZGnvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fb9Bon8tkZr+CQtO0SaXSC2jqneMPIJtGnNMkqSoZ9mvAa76U0g9Q6GiHxqiqJ8d8ciP6TaNkKQjX6vdO9WuhBb+QkfhWoI+sBKMNcAxOT/ZxPlXafyUx3+G9jY95OLv9RsY4SVR6XPpksYhLYhybgo7bK2W0viHC0a18+WjlvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIOw014N; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIOw014N"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aea9d606f0so1037402e87.3
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Jul 2026 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782944281; x=1783549081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iq6lRh8f1Za1oSMuyvvaFYD5RB3Lmh/p/MiUmv9wGms=;
        b=VIOw014N7J/t32H61bZ8TXV5pmvOYXG0Sd594hILZsE2zCpd0XnLiRzPn0cKPb+Sju
         zoCjUydOHW7lMJ8flk5yXMymqgBCMYXOXya9TdMAgW2qIvi6seEPdCtBdnbeycJ8Busv
         fP37/o5ckENNDNzv/Gvn+QN2g5qcv9GuoPl5mw+2qwokD213BGu3a8Tv2JRSDf8osBh5
         rfsfxOPaal7SmLzeJ4R8xyr1PWDDZsK/auRQKpfhhH1BtEAVvXDnpzPKs7p/rkIPc88R
         +oiRR9XwvJunnU/6AKOsaQuHCZqMq3gHkn/Kff8k0aJjfmAlHpjKaGie5kzZDFlvnu/0
         WZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782944281; x=1783549081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iq6lRh8f1Za1oSMuyvvaFYD5RB3Lmh/p/MiUmv9wGms=;
        b=cPvyeGy6NaRYQUxo2PVxsh6/dJWY2lm2hwyb++rEbCuIsRdzl9WaqnIUhQm+/13Fk4
         v7KKLtU8JKsG02tVj4Gx6wuZWu+4A6wqdeLQOxdb/64/VFm8cDm8EkGQEwFX6o4v+g6n
         vkPyTuu3qYdVpLoCHJ8xLM/0rZz5blNFrKgDwSiqgnrVnQrJ0r+W80jyPTe039CxWPEC
         bOBu8H9PiuZio34y+XBRv4g6LPKKcuYWRV831Bv66dYFzjNiLP9aDi4NU3YEdLAz5bCj
         1+Gr4gYxfqRbSxXafGh7bwKzKN7d0IBLzLs5zIgqF/Hf8DM2fTKAADNAyalJvf5vXSzQ
         u9ew==
X-Gm-Message-State: AOJu0YzedtkFybJilYqBQCxOzpdI9lLJUygjxCCGfz9dBPPMeGWgOeUM
	hiK6R+71xUXkOyyySpdu5GBUngU4Mr9Jj/ECjGdVonrPtQYR9pty0kssNO+om5tgLWo=
X-Gm-Gg: AfdE7cm6Y9LXE+LH4usWWubq9Fzwh0Basc83yxhsREADheIeQZjNXh0DXxeimtQw8by
	XiE/D3dZ65DCFPb1WRulJLTEMa05xi5P6XxoKIDSFveCg/0fRN+8yeX3V+zM8N8nHX8Huht4HLK
	9WcEOe0LAgi3V5Nk6YvSKOiFhRFvNXMb07krbjYlyUbISNwvqU12wHUaARjlok/iYhgeHagFM9b
	QufMqkRoEVwzJEFadbXhkr2j4Zq+Hx4zuwM8LI6aABtbaHKChuJccM2lVI9ghNkyNyU5qMaAXvk
	Zhj64FowjQ2Z+s08sG9629nAVPKhwYTh0z5HcyAEE0+aM+JLDe8KZpV21ObhXAp/v2WZru2KjLN
	/8TKH4ThEXxrb2UKy52EgD+c013LD5k4iF5SyIgxuZ60V/W0Q2P9eu1vrehtA3BlFdIZqzCznxH
	D0AgM50tKmuwk0eGo7J54p6X0hZdUUGnU=
X-Received: by 2002:a05:6512:22c5:b0:5ae:a9ec:3545 with SMTP id 2adb3069b0e04-5aec7338d31mr590751e87.54.1782944280234;
        Wed, 01 Jul 2026 15:18:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec89dc478sm267767e87.68.2026.07.01.15.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:17:58 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: protect mode sysfs reads with lock_fb_info()
Date: Thu,  2 Jul 2026 00:17:57 +0200
Message-Id: <20260701221757.231490-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

show_mode() dereferences fb_info->mode and show_modes() walks
fb_info->modelist without holding lock_fb_info(). store_modes() takes
lock_fb_info() while replacing the modelist and freeing the old one.

A concurrent reader can load a pointer to an old modelist entry before
store_modes() frees it, then dereference freed memory in mode_string().

Take lock_fb_info() in both show_mode() and show_modes() to serialize
with store_modes(). In show_mode(), copy the mode to the stack and
format the stack copy after dropping the lock.

Impact: local kernel UAF read when a privileged writer races with
sysfs readers of /sys/class/graphics/fb*/mode and modes.

Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
A userspace reproducer triggering the race is available to maintainers on request.

 drivers/video/fbdev/core/fbsysfs.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index ea196603c7..6bdb25f7be 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -82,11 +82,20 @@ static ssize_t show_mode(struct device *device, struct device_attribute *attr,
 			 char *buf)
 {
 	struct fb_info *fb_info = dev_get_drvdata(device);
+	struct fb_videomode mode;
+	bool have_mode = false;
 
-	if (!fb_info->mode)
+	lock_fb_info(fb_info);
+	if (fb_info->mode) {
+		mode = *fb_info->mode;
+		have_mode = true;
+	}
+	unlock_fb_info(fb_info);
+
+	if (!have_mode)
 		return 0;
 
-	return mode_string(buf, 0, fb_info->mode);
+	return mode_string(buf, 0, &mode);
 }
 
 static ssize_t store_modes(struct device *device,
@@ -134,10 +143,13 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
 	const struct fb_videomode *mode;
 
 	i = 0;
+	lock_fb_info(fb_info);
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
 		i += mode_string(buf, i, mode);
 	}
+	unlock_fb_info(fb_info);
+
 	return i;
 }
 
-- 
2.39.5

