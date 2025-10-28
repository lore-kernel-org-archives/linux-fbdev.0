Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABA27A907
	for <linux-fbdev@vger.kernel.org>; Tue, 28 Oct 2025 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678981; cv=none; b=dZL0jhGmSEE07NFgUS9B1m39qB4YwAxZ5p0V7vVCwQCKPFNs42SqpNjQu84RBwzSKchzw67/QmFl7E3b84StsG66wMUFdbhyhl1+LQiM4Sh3dUyNhMFukojoi/D+NFkXRtHbzzo8pWcu05r+NpM5GJaCUskYem5DoRWWzdW9jsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678981; c=relaxed/simple;
	bh=5Hw2kN2SLLyRcmeugDO6vvlDEM9OCK18JiF5H2jgHe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSIUgaj/0eJl35Fvli6pr7MEzw7t+16QMX521L7CvgWY/V/tWkncOvaFX7yLpE1/A5VYIyzfaNNgZ9ITxR5cvimlvTgG0gq2NErF2PI7kQJFs2ScYBYRYxI/6fCOHitCguIBmX2x8U9Eudzs98Ss3S+goMGFS4QHXOv3XkiD/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gjs155XQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjs155XQ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4283be7df63so3104148f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Oct 2025 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761678978; x=1762283778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Nm3E4MKpYHM3eDwwralpb5B+mems99sHN7CXPQYlpw=;
        b=Gjs155XQ07W1x0DVTqydDHSRffx8Z7yJk9uqv6t4E3Q1u9PKiMIB0nc/6+OOnsfrvD
         FfSJojczAqFD+5q4zCkkHvwWaynBxtdcxTIohzl1Zk13XYn/uq/9lav3NqkEWU9pp6B9
         2gzuL/i1OW70mm0JXxa+5Yc21HnLbKyMUIlmuQPzYFsdezjlKsOBessJolEgBE6k/k+L
         jfXiq+p5Q4uKEl+G4uBtap8md8VlvCSXxWD4L7X54SeggMNnOluKEgd7eYLatNZXKo6h
         F3KAIGp5QWEuCw2GvBEl+sENmnLwX6nygVglQQNTcBUUcNbb2om/mAZ98L4tfsYYrYM3
         96wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761678978; x=1762283778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Nm3E4MKpYHM3eDwwralpb5B+mems99sHN7CXPQYlpw=;
        b=n80/AZnO2vXKzNHkwMUr7nGmq4oBI13cfDEZQHISYYfFMddryjTvuWquM0Sz9t0H/L
         FggdZwL1dUJrUDnXK2keLqjglbnnltcv5nhM62pWAF65K1JVr4IF2AOPBTRK5lGdoojC
         o+H/SLb17tDJubkcjI7ViFmzam+HH4YjcDsSG5W8MAsL50qhU3WmqVkjNhLZ5SriQ8Zg
         pgHFaUTJR1d0fxi/RhG6uKsPfnF0BCIjXlBM/F3dK6efJypD6sfQ2/tp7adqZISzcwFv
         S+wZZaB0wFuBtcp8ChQcQgTzQym+quiqyLJijNudsKjXisVwgEBZqitO8WDfA2fBGv6s
         8rnA==
X-Gm-Message-State: AOJu0YxWnA98TQIZvVewmQxxZ38yhw6C6WiMIFtXOxPJUbuMztVK16Hh
	e862wcCkSl5Sat3mnPqidBMKV8xy6WBBjmPBD4j30c5XDZRhezwuSk6K+idKPJXP
X-Gm-Gg: ASbGncu2yiL9y8OKQeESrQHF9eSvv5pV35qh4NbOI9OvEP23DeWn5KBcdml0KLPPc6o
	ZspbnAA4wcPn0oVWvnNG1sx1XPJMZAgSmlx+lpbyMKmzSRK3F4649wx6pa7V6cC+zxzUoMjBKwB
	PkQ57O1LbgFKP2kSmtUNYa/Q+ERS74QDGhtSjMoQSgWx4wiUV7NHUAzbSmmZEBc5k9nz08Vseho
	YcyrXG6aEg0g+bIc5DDvv9zVX1n11L39blUQ0N+9zOOnMrKyh5aP0ujTYX/hIeXY4tIHefkvQ5/
	xTiPxB71KEcvnofrN+8CpUf45vdNftUpORfZY5+tSBvMLRLbfxtxAMYEqxL3SjAxpo8vDF1sstd
	nbxEjlSqx0W18xikIdRXe1sC+JmQAqwcRFf90mpI0V6qSxO/3kMQmqFPg+LIzIKUND0HkQW/qWc
	9404JShmkmiMnebWpsuIgJCAOd+LUEjYZHjE0wAO3+cNIgcuOVvv1f46cxYr8=
X-Google-Smtp-Source: AGHT+IHffoMv5k0CgidXAMVyKRHrRcXi4iDRyKmMUzXSwiqt2PVTWsko8mfU0XNy6JLFIyM8tRxTSQ==
X-Received: by 2002:a05:6000:26d0:b0:3e9:2fea:6795 with SMTP id ffacd0b85a97d-429aefcaa41mr153239f8f.53.1761678977999;
        Tue, 28 Oct 2025 12:16:17 -0700 (PDT)
Received: from dell (229.red-88-1-12.dynamicip.rima-tde.net. [88.1.12.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbb2bsm22256326f8f.13.2025.10.28.12.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 12:16:17 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH v2] fbdev: vga16fb: Request memory region.
Date: Tue, 28 Oct 2025 20:16:15 +0100
Message-ID: <20251028191615.2765711-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <6c565f4c-ef05-45f2-9a82-cbba4a11cc07@gmx.de>
References: <6c565f4c-ef05-45f2-9a82-cbba4a11cc07@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch reserve and release VGA memory region.

This align with Documentation/drm/todo.rst
"Request memory regions in all fbdev drivers"

I've tested with 32bits kernel and qemu.

Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
v1 -> v2:
      * Add release in vga16fb_remove , thanks Helge Deller.
      * v1 https://lore.kernel.org/lkml/20251016171845.1397153-1-rampxxxx@gmail.com/

 drivers/video/fbdev/vga16fb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index eedab14c7d51..208e3eefb3ff 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1319,6 +1319,11 @@ static int vga16fb_probe(struct platform_device *dev)
 	if (ret)
 		return ret;
 
+	if (!request_mem_region(vga16fb_fix.smem_start, vga16fb_fix.smem_len,
+				"vga16b")) {
+		dev_err(&dev->dev,"vga16b: cannot reserve video memory at 0x%lx\n",
+		       vga16fb_fix.smem_start);
+	}
 	printk(KERN_DEBUG "vga16fb: initializing\n");
 	info = framebuffer_alloc(sizeof(struct vga16fb_par), &dev->dev);
 
@@ -1398,6 +1403,8 @@ static int vga16fb_probe(struct platform_device *dev)
  err_ioremap:
 	framebuffer_release(info);
  err_fb_alloc:
+	release_mem_region(vga16fb_fix.smem_start,
+		    vga16fb_fix.smem_len);
 	return ret;
 }
 
@@ -1407,6 +1414,8 @@ static void vga16fb_remove(struct platform_device *dev)
 
 	if (info)
 		unregister_framebuffer(info);
+	release_mem_region(vga16fb_fix.smem_start,
+		    vga16fb_fix.smem_len);
 }
 
 static const struct platform_device_id vga16fb_driver_id_table[] = {
-- 
2.50.1

