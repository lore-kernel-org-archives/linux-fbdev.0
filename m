Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C684D90CC
	for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056287; cv=none; b=JrQMRJB986h+Eeu3J2D7men0kwr1eFiMAXppuKCLOfiw06knf52NxxGzlv3EZsK8Sp2xT+mUXUEOGkbjUei8TR2LYSwDu6zwcR1v3eh8uGu2KgadOx1k7rCrUYmF0ve4P2Aij3Ku/zAtG3Uglu7upBL+/j5Wyk49oMvPLg/BnwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056287; c=relaxed/simple;
	bh=nOCQSFW7CSkNoMWM8fbJpg3119zaBvpzWx6xv/iqRPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baNxbzxB4Wu511Q/mgsPesVd1C1TPnliGobyPFI5xRee6GJAPw12KdrZT4w27VhByhhrH6DBAGLQ47MSx/1ycOGSs2/xW28RkbmJsKeWmwT3duu1SX6WuX+2wPEvnmOtULcJFwDOR0fVOsht+Z9uK8E8giVEHZF/6Uy3F4kfVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUH22C4a; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUH22C4a"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493e4cccd8dso6660845e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 12:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056282; x=1784661082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8SgW7Vtvc0tFBeUiDAXyhdKRnHwKhXWugDI8a8LDJqs=;
        b=NUH22C4aMM3oCrbvhPdrpOaZ13SWKojvq4gVq//O9Kh1+v0JIbVIIJbqCxnx8VsS+V
         wl2m7W8WgJ98ezwtAvNdzKB6qybzxwQl84XyD1kcSArSrIlZ7oR/gb0C/gUvDfr84Djo
         V3BkoRoY477VMv0afpzm1WUUWg0mOuQ4zZOo/Gvx82KTDfcKQ455zNPvD2EitvhMnVka
         3CXs+OI9ssYNmOFA+n84hur6oK7If9JtDxAu+X2WeCW9I0hBNrLbaiGRu41Lx5u8hj2p
         ujOTLJVirxUQ9vkyWl74qgw1Qv3qF6zdLlRqhzUtixuRgccHXZihYaWBA7sOqkLDK4sy
         2KaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056282; x=1784661082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8SgW7Vtvc0tFBeUiDAXyhdKRnHwKhXWugDI8a8LDJqs=;
        b=CvAjUmsfXc//YAgC3VZrmiBNla+SJR64m58WHvTTaav8mgHS38gTl4Ttcn5it28F4N
         b0klXgcFWm0aGamE5iM4FuEu7upBmK13dqYAvhsABCjpvOECQz8zjSKArNmc4AaqEL9u
         JaP2uidR2gyea6RGpeogOTIKjmE+DcJ86vv04LTFubQB6x4wh6F6onOoU9rMGRYlJ+at
         hS6x+7WaJo8h3tWHrfxUm8/fu5ggQ9TRezA7QAbBmSWdlh6me9WhzCL8B4k3HxRxDZ9p
         zRhsVnvRNQbaxo/9DFke3/eEedsagcYkmiC1rpEkk6mK4lg6fKbfe3SqCC7ktTbZMYTZ
         gMPw==
X-Forwarded-Encrypted: i=1; AHgh+RoEE44hWwvlFrDxRs+2o5z5fmfi+0rMvVbaR+AmK2VEF3oHHNN/wbGdYyEOOOK+Mn8DFsP1yqo4uyFVPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuu3P0lL6ZNwMyUqHt7kvwNbd3iWld5sBvGpZqnl8yGKQAhKrs
	1nxE6jwpefpgG0cFYiuZq2iouGjSTRl0/PjlwxUKfVK4xPkpIQqaos+K
X-Gm-Gg: AfdE7cmHk1RvJVfFecUd7O2kfmXuxEOUiJ2wQdkpZ20w131dy0v/WVY9P8HgbTUED7E
	JnuBj4tRkamCo1cmWKl/EttC+V6Q290W3c90n+tZgrqUDMgfwWucb/dtdrxm5eh6AP1dDaHgige
	MqfVhUCAGLVXDbzXU9ZZBH+omMmQUUAq5wANtkfXpsDWqRZrVx50UNRqAzXb1cmdk2Q8RtW7nJO
	g+e639n0BWktmqGs49cljT1ks0aWrrZEpJcD2Xf+mkAn7yOAO824Rw/C1Hprx9nJO4u8CV12H4h
	2PbPVQhP3ZAeU2QdXo2HXlxppjs5a6Z6qRrZsas3TetYsYWoHtbSZIaM8lKpVOyB2JEtHab7JXb
	K7D3+iIcRzUhf6rLLdlzWxWMB5PHv65QsanABQdEt6N0r2Ov5wR0QwK5WV3+HHbKjizwmHgFuHd
	VufDY4ZKY6dYh0+ZHofJ06M0vyYFAt8/gHdwncR/SiV+WVDteWAM3Bt7v+1I5qM9CYhAcYTfqpX
	cUHckCH5d8=
X-Received: by 2002:a05:600c:310f:b0:493:ee3a:f05b with SMTP id 5b1f17b1804b1-493f87d7fcdmr147477765e9.7.1784056281449;
        Tue, 14 Jul 2026 12:11:21 -0700 (PDT)
Received: from evil-archie.tail5479a9.ts.net ([2a02:1388:23c0:16c0:aa41:f4ff:fec6:26e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f951asm100677815e9.14.2026.07.14.12.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:11:21 -0700 (PDT)
From: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: namcao@linutronix.de,
	tomasz.unger@yahoo.pl,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Subject: [PATCH 1/3] staging/fbtft: Remove prohibited space before close parenthesis
Date: Tue, 14 Jul 2026 22:09:40 +0300
Message-ID: <20260714190958.219437-4-graviaspanagiotis1@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch error: "space prohibited before that close parenthesis"
in the define_fbtft_write_reg macro.

Signed-off-by: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..38697992f5e1 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8,)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16,)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.55.0

