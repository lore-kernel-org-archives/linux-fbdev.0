Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B0F1AB523;
	Thu,  3 Oct 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971992; cv=none; b=Qfrg/l0VR9FTBwFXFbYRWTD0DrHgGOVEnhAOQP3/gkZnTqk4oHSYDZgsqaL6yk1xsadYrrKUqEgZrma1yY/CIJ8fbmbj0RU3vXP3CQ/6xAT+o5JIZ6fc4kwCphrrHuWZxE0Jrq9D5sHAnK4skPWtB2JRQE36VBAPt9mV2eRt78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971992; c=relaxed/simple;
	bh=04BCdpvXPzFjT3EJdEScRcro1Poxt5zFjYde50kRkrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O+9SNKQ+6br2Q0G4hHRtidb24v+W8f/VM7zFRDl7c4KNb2wHG5Qx13jl/6qkT4/K8vCKSujv65Bx37kwCFYQ12522nUyLLF3Q/cxRVf0uMzWM8u5f5C27xhaDvoYRogrr4PaRvo/iT2vvSoHRFWV+XGDDyWBvOwRXyto5yfvQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQP6qK7Q; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQP6qK7Q"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2e0a47fda44so145313a91.1;
        Thu, 03 Oct 2024 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727971991; x=1728576791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3WiMbAhFsbgFsMbymS9SFj9ZdJkNGNlqWJ97chhwH4=;
        b=JQP6qK7Qy88NpAZuJGTKSqm/evpF5xJ7GxQlrdey3RlfNf9AnYVSJc9I9dkb41urW2
         kjVT8/SG4LNio9OpdR1tWUeW8mK58SoaGxN/qmN/nhDm2PDI4nPFdFh8iMo+T1QVgB2X
         mBfejwzXtxd90RPRsKv4fDBce7Cgm3MUSIoiw3Wof0iWVuc7Ow9eiDWQDNesTYcbid/N
         ua++NB/KfhG9lygmCsCqppu0m5w+K/UdeiJ7/CVSOPUWlcRKOISXaEKzlWaUcVyRPBJ1
         gO8ejQHFKrwr7Y7Dq+m+DbZ/anGjKsYhejUbO3dpmA0pmpgosjPLlujRLPfTxDrkeG2J
         YqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971991; x=1728576791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3WiMbAhFsbgFsMbymS9SFj9ZdJkNGNlqWJ97chhwH4=;
        b=X2TBrL/pFXW8TFWfVI2g36GnpBA3tTnupkZZb277z2/34Iq29Oh7YVJFi1h11T6MNq
         6sfXB/wOZds6tBbpZDYXWyyZOPGbtvtfKN6v4Q4pWc4ao5jkCREwlY2B5fv65BM2/emk
         pC+jkkdZqEnBhNg/vhKdtCkvw+NmmOLv33wwjCFVmqP2CVm69275LXkyfmT6ZnU8lizF
         x3I7kjjuz8EJjtrMh5H6gMjveq+jGvBvLvN3SHLgDGErqWRLMroZp+h3KVmh9QBbxigl
         hHPRBZCpXjOgH7Bkuecd1FUxYMKzj09pfDL9o9SY0qfSl4w0BFluN5fZRdMGbknLwElV
         y+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXdJpnP/sormZVA3ayQyOv0FRwn45+5dKUiugmebt5ebGVlKCXZK8lS8mwhjGTar7WKs/f+V4BuzSQtUyYV@vger.kernel.org, AJvYcCXy2MTF8JCvpVpaa2M94AoYGVDIijgaNoSxcvc1IrZ2TMuYcfVrHKljEopLF+rHREXHUyk5pQFgdHuJdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTq3zST5F9K3Kg23GhCywdyyqKJ3q6oya2NtUW5Pa3SMJoAAfA
	6u69sT0s5MzZNPkU5E5x0E5gyjypM0yu4y91fMGAryF6YU+zkKWr
X-Google-Smtp-Source: AGHT+IECRTHvTd6P+YA/9SXtKlU5SkB5oDthZt0x/R2Qd3F/NleiAE4FG9DI3RlVuzOcBMfQ4d15Fw==
X-Received: by 2002:a17:90a:d50f:b0:2e0:7adb:6380 with SMTP id 98e67ed59e1d1-2e1849be000mr3540656a91.9.1727971990582;
        Thu, 03 Oct 2024 09:13:10 -0700 (PDT)
Received: from user.. ([206.237.119.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1bff53444sm1836316a91.52.2024.10.03.09.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:13:10 -0700 (PDT)
From: clingfei <clf700383@gmail.com>
To: deller@gmx.de
Cc: shc_work@mail.ru,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	clf700383@gmail.com
Subject: [PATCH] fbdev: clps711x-fb: unregister fb when clps711x_fb_probe register failed
Date: Fri,  4 Oct 2024 00:12:36 +0800
Message-Id: <20241003161236.3527733-1-clf700383@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When register_framebuffer failed, it jumps out_fb_dealloc_cmap without
calling unregister_framebuffer, which may cause potential memory leak.

Signed-off-by: clingfei <clf700383@gmail.com>
---
 drivers/video/fbdev/clps711x-fb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index 9e3df1df5ac4..69db40a7a361 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -328,10 +328,11 @@ static int clps711x_fb_probe(struct platform_device *pdev)
 
 	ret = register_framebuffer(info);
 	if (ret)
-		goto out_fb_dealloc_cmap;
+		goto out_fb_unregister;
 
 	return 0;
 
+out_fb_unregister:
 	unregister_framebuffer(info);
 
 out_fb_dealloc_cmap:
-- 
2.34.1

