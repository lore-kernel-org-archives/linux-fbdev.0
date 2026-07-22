Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B7530C160
	for <linux-fbdev@vger.kernel.org>; Wed, 22 Jul 2026 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757630; cv=none; b=bWvn55s3MvFWDmZA/e0BcFwyaEuHj0UvarA8NaPffotLENbBkFcdJ0uYlJhpGDWsHbmSOJkbc+m9E/6CeIKZ+5U8RDH1nOpvu2k+9sVdpZUdYRDD5VpJZgH0bUmeXNfpDR5xumygmOL3wDgToMfWf2iEqBcTIF8n3YfEjj9iFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757630; c=relaxed/simple;
	bh=5/ZJZ8wFV6lwD9S37d19WLl3Lp+Qb8sMnjslMXqDyJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9kbKZ/2YwcYp1wePOd+Vb+y2reGQd7wybhxWR5w2wQ0XMNQf7pSNBR5GnNzaSWTLwwzOfKaQq9ggkPG6AnJe+O5t8BVSspw7IW092J1ltsUiPUEq6FbAGZ+rh6NAF3hO3JOUSFcedxVy/slZYyYvBAjjhIGfjs7YmLLhKHlbBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNe5VXWr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNe5VXWr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49546c690ffso44324985e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 22 Jul 2026 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784757627; x=1785362427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hAmg9kvDp6fcRhAWqYJmRWgkw3aQP6ISOL7nDMeVy7Y=;
        b=sNe5VXWrFC+WnSNrN8D7+bs5HU+n1uoV66wnKFz/T/iH5SjqOeVhI/eJW3+VuUUDBi
         hyKT1r/t5FsDS5tRycTSjVFR/U9BZYS19A/hKAxYGO2MEn0crF/dRobhzCWNJK8RD3IR
         ZBcWYjgur195OTV0wVgojeh5/oScNQzV8OcTVBAjRVo0Vwb8+s7aUisT/xqXm6a6eE1D
         iTI3XOL7YIauPRc2RDhbRjkt4ClOp8cnRCvTKEnq6wm7RNNPUn1zW7BZfw3PnjTlWbcm
         FyclUr6tD2SL3f7X9fnlfdhF/ej7qylhIFk+Zvqfhirocntjx3KNkZGhvW8xMTROxCes
         3SKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784757627; x=1785362427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hAmg9kvDp6fcRhAWqYJmRWgkw3aQP6ISOL7nDMeVy7Y=;
        b=ThxxxxQHcBisASHOh3mHynQ1fdb9Y8w9Ew7hRkIjxZpccYdlabZwQUuRSSKtxi4YzD
         HPZQHcwUyhrDuisSXpSwgCVwsHn0njftWyOx9tJzEdwBO/SLYiMsviC0LXTiwWfTrUlF
         TXcCuXSJCa4S7M4kJD0B9XFAXHaDJ23uanlmJ2vLTbNsULnQnqLi/47/qoZN1x8NUfBG
         V4bQ5KOFd6SMCB4j/hWu9tLgJo/qYZe93XPrvBgFcqeWGJHKaYNur7FL56xzzdBs8zIG
         zlazMDvW+Zt0uElmmhwDypUR/pUtIvUchrIREmxGLn6EVf9a9LKIa0LmJGOLU/CL4hCk
         EpPA==
X-Forwarded-Encrypted: i=1; AHgh+RpRvyJti4xFHJQJv6O8AWwKry/yUM0SmVTSdn8/7K0f7APuJqLIaPTeFzsFThXnVG9ep7/B1gD26UnT5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjr3IHh19HjeSZJnDQPVSz3Q0WC/RpKaM3YyuNrZVFLtlteAPa
	FgwYSRrW1osDDmjgwWlYXIqC9XSycCenstBMvSV4wafHMKhwmkeOdLAJ
X-Gm-Gg: AR+sD11u9RPlpV9muC8AIeNxoM6xI45TtyM9plehUYAhfv1i6CAYg7QWBx7dUREdKYN
	zvqBz9f0vmT5cZNERZcHduBf3WvgQnFtUsTcfz+4cljSwbuPykPIPJoebtV+aFpMvigIo3WeazQ
	7QK3of3hWIuk53lmmm767lFdpHsl3hri2pmZhdZIlaaK47AuQ3xLaUyjETATcrDX1X1txJOGeZR
	Yt27k92TnMTnIGVeKtfgxZDQApnoaL8iY11cA3CKGXzfup8bhFXvnmy8RnElHVM0G2n8LzWk+Kq
	zGR8z3z6eMNl1YSTei8MjEovXsjT8/aTj++C9YpyVT07HchNBoYcQnj1Rft+rkT31e7e76D9Ccx
	MybzKkLBJt8MerZyd9nAyt+cZ549E+p7n7Xg2YybihS0gfkJV7+n928hMZARCFkPvytJDtbzFlw
	z5YpRcm+jxJiBgcx1PfNgbAy32hChL467RzG6Fd0Bknm/38D2cPzzaFVvY0VNT/lOOYw==
X-Received: by 2002:a05:600c:818f:b0:495:4f62:c9f5 with SMTP id 5b1f17b1804b1-49573cf6daamr3388225e9.24.1784757627049;
        Wed, 22 Jul 2026 15:00:27 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b0395f7sm62532245e9.3.2026.07.22.15.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 15:00:26 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: deller@gmx.de
Cc: tzimmermann@suse.de,
	wei.liu@kernel.org,
	ptsm@linux.microsoft.com,
	arnd@arndb.de,
	u.kleine-koenig@baylibre.com,
	hsukrut3@gmail.com,
	rob.github@jumpstation.co.uk,
	enelsonmoore@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] fbdev: replace dead select with dependency
Date: Wed, 22 Jul 2026 23:00:23 +0100
Message-ID: <20260722220023.196029-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'select' does not work on config options in a 'choice', so currently it is
possible to enable FB_MB862XX_LIME without FB_LITTLE_ENDIAN.

We cannot replace the 'select FB_LITTLE_ENDIAN' without also changing
FB_FOREIGN_ENDIAN from 'select' to 'depends on', otherwise we will get
a recursive dependency.

Note that, if we remove the select / dependency, the kernel will compile
with FB_MB862XX_LIME=y and FB_LITTLE_ENDIAN=n so if it would be
better to remove the select, please advise as I do not have the hardware
to runtime test this.

This dead select was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/video/fbdev/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 085d3a202148..1ed4506c0cb2 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1717,8 +1717,8 @@ config FB_MB862XX_PCI_GDC
 config FB_MB862XX_LIME
 	bool "Lime GDC"
 	depends on OF && PPC
-	select FB_FOREIGN_ENDIAN
-	select FB_LITTLE_ENDIAN
+	depends on FB_FOREIGN_ENDIAN
+	depends on FB_LITTLE_ENDIAN
 	help
 	  Framebuffer support for Fujitsu Lime GDC on host CPU bus.
 
-- 
2.54.0

