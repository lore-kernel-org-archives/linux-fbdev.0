Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417561;
	b=EM+WHvTspx9xps7tB0XM6zNJXI5I8kQWy/eNfg0mDI7OlySigI61Qfx4APTf5KLxTk7g
	 iNNlnGpkiR8IgS8mIQH0hUxowmlVLiQIOomwqQXuI+7hCdeZ6WlhDTPnTht65+2UhLlAW
	 8mW0yJ5muPsMGIdsEaaOIGRxOZ+DkUvQaQYljHp7QYSnTnMlx0yPhhZYXrK/MXe8+lWks
	 or8j609NuIJPqCYVGKHhUruqeKSJYLbd9w1EPpQDrKPXNuEqgTrfy/Z023khjroUubrTh
	 tPAMR4fOcd5XvKQAPhl/jrotv45CPwaqfR5uRmwTgx4fR4McfEDIg7DEn50YZ5G272A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mnYw2aLxaOMLunU5/NMlexxvi/OdOgAm+kgTsrY2DdI=;
	b=p1OtlKSwfnp5XXUp0YBfZBjqZepHeLD/ykwp0YXeDyof2R1DVMnSO5Cko2SVLCXdL0VZ
	 xVNAemwzzST7TDkC0aCvUBuJJvRiv37r+/ct3ERwKK0+hdtfOvkwesnFAW0L4KVwA4nNM
	 3fT6SpLRTJuKedja7pWvpeboEvs2MdthhctCd5GqWGH/eS5G86KtvL1et6Rv+s+lWgy5c
	 t3BlsckLSgiEWoQljsoG6Ocu8JORANlqYsKxbV6c2mJYy3Cd3/DUFqpbhJ/hMyPkW90uq
	 lKA5EIuhfILsIAuIy9fuNJwaFZ3pFtTRlmOjqSnNysurCfa8trrh98tVfWh0HwliOeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OrlS9rp1;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE06606A31F
	for <linux-fbdev@vger.kernel.org>; Sat, 31 Oct 2026 03:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AE06606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OrlS9rp1
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-369f33df08eso2753841eec.0
        for <linux-fbdev@vger.kernel.org>; Fri, 30 Oct 2026 20:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793417560; x=1794022360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mnYw2aLxaOMLunU5/NMlexxvi/OdOgAm+kgTsrY2DdI=;
        b=OrlS9rp1bbj0NWuz4a4wVNlomMJVhVs19LaX2EJYbQ0S9tZhodKl4FQWuIiJNuNxBj
         G/CwzXulMvG1NVMtMQ6IUjbRb7GMCUt4norsKv/2xRl1NWjNaL8BO63XwuZxlme/7LtT
         GZamJWPslc6/Kw0N9tNMMA6e7UY5FKgs0KEJ2ap9sVdnCLcl0MQAknWt+vUZLzFESDfZ
         WOs1o1mDcS0VEkVMs4sgsscnpafYAq9cnC1rwwu81FsSFThubV5uIdy/Pk68mlqkqMXv
         K+BYw/6SbwDaBheZ598lAGu7BNtVDx8Pq8mY9hFtTi/b/JRdVOnJkJlPKcAqtC2n59qE
         d37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793417560; x=1794022360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mnYw2aLxaOMLunU5/NMlexxvi/OdOgAm+kgTsrY2DdI=;
        b=vs3NgBnwIm6zcGGHIgWcP2ymfN/KS6fUtEpcVo/RUc0yi52TRnGjJARk2qhVc4zqn/
         wPtm4zw8/48cTEna/QCYNRkEaDN0vXt9JvP1ZP06VJjMQcKwR3HlobZnadAChi//x1WZ
         m0vEjRYemLr0vZ/UBZsjyVUqFbgFvCuUTi7GcZhlEbnuQ04PuFqCb7nKhhJ95S/+U05m
         vy+YiRl/jb5RK/l+UGaGjCYrLKWSnI83asRLZiq7+GfQdY+N7R3FMFOA8vbPA38RqkS2
         oSCjPLxuUDc1PUUf8MgPNu+PesLoA26lX30t7W9kbsx57t4+0+9S/mODecr5rv5pOQrE
         1VJQ==
X-Gm-Message-State: AFq9FYKUhtaJ6WY/GlLmOEaLb/4Flq1m7PhUsB/k6Gxr2fe3B4zOsFbj
	2j4bsNk9uMhOyDwS9Vd7gJAzHjreqQPIYZcAZ3aQmq/Vk91z7wD4S4qExocHOM7hNew=
X-Gm-Gg: AYBFou2QC268QGHFB6U0Nbymx55Vr/K0+42KtPszMQEFuDQsWyFEjHcKP22RXTNRUh8
	zh4dE++InS+AYL1HJv28fmdjKOtbPqapHFPQMccBORfuGqW3mwzD28UYaAEbYSuqZchX4y0razz
	NBMXYwikrFbb3J5WWNBnXmTZ73aWLhf33eXsIYP25zWx6wn7sOBzlr6Jg79aKnsBx7E/7rADdEy
	xj80/og3+T2pIU5V4+y/Re8v7YaF7UC8xAWA77QjIyzjSOp5SpkQGn3n6cSSaOqvwpDoB7uhnOV
	ToDWGWjYz40tfVwUzYmCaLTHM8lER+N2APdGaPGrRXdNr4UsT/Z/8p1XYthmz5CZ2MjbkC0ScMq
	GDLggLr3UHrjm83DXpwRIkhOUjOssH5+Kn2StyNYupEnx78RCKpCUXe+ZAmHG6JvBED82Gy++mZ
	VgRe6+eSLd0VZ/pBxRoAzxM82uBacQ3TOqSUVNM6Gu28bjm+f/ttCPZtRXBcIHVpvTCabPwdpSl
	snwRQunzqD0Nn4IVTN0Ps+uHnQhAB0O0fmnwbJCqA9H6YUpFQWiRrOS47pfLq8jjD6Poe7bw39N
	KbsebFbdWU6bGqXLDreh57CIH2Y0yrAAxEya7sSFalqzJg+nNh8400Kk6XF06rGhn4RclU1SUXn
	gYDkKbESKsJLX6d8qmR7GnDCagR8H+9+izhQxt5hSrBcMy9xUQ/rEVV/6HL4JuqHBmlOrCJCbWp
	mjmVICXKy8P+jr9w==
X-Received: by 2002:a05:7301:fa4:b0:36a:713:a76b with SMTP id 5a478bee46e88-36a4236a5c5mr6199404eec.6.1793417560169;
        Fri, 30 Oct 2026 20:32:40 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429000f8sm11634639eec.13.2026.10.30.20.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:32:39 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: pxafb: preserve IRQ probe errors
Date: Sat, 31 Oct 2026 11:32:36 +0800
Message-ID: <20261031033236.2490968-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preserve platform_get_irq() and devm_request_irq() errors, including
-EPROBE_DEFER, instead of replacing them with -ENODEV and -EBUSY.

Found by Sashiko AI review.

Link: https://lore.kernel.org/dri-devel/20260722075803.570532-1-panchuang@vivo.com
---
 drivers/video/fbdev/pxafb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 1682345fb9b0..1912cfce28d6 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2306,15 +2306,13 @@ static int pxafb_probe(struct platform_device *dev)
 
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0) {
-		ret = -ENODEV;
+		ret = irq;
 		goto failed_free_mem;
 	}
 
 	ret = devm_request_irq(&dev->dev, irq, pxafb_handle_irq, 0, "LCD", fbi);
-	if (ret) {
-		ret = -EBUSY;
+	if (ret)
 		goto failed_free_mem;
-	}
 
 	ret = pxafb_smart_init(fbi);
 	if (ret) {

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
prerequisite-patch-id: 44b1c2680cb029871e123eb11eab7764a807ef24
-- 
2.56.0

