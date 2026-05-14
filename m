Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4841FD4
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754653; cv=none; b=pOKnGFHhxA9DdEouw0C4XYpENg78FJCY9rT87XD7Ksyw6koC86HHAvEhS2ZeWNC5hj1/QRfZGO+XqKwCsXkvtcEP2lfAtg+FG0cmHVlpFSY9uMDjF8TyEqCWJhx9JojYYLthnC5PTWKKC8Zk/6U0+8sa8Bi6S5JBCqRPRhGbJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754653; c=relaxed/simple;
	bh=7DRUcn1z1lAVxDX2oROhlzkd/x33hcrvonRVFJgizJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xbcq+KSwJ75WuzfIu9pIk33i47c/Vsi0XYwZTH7Tht31TJEO5BFItrOJJo0pCg3We3KvT9FbLJ04TbcMbb95PCbjAfQTjarBetiAZkDWsrwrb5XtOjcqaBFfVQazfcKoyea4bUUEBrrRjChZYcgigChyCodpO5zT/WDbx9Fb5Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+Ih7++X; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+Ih7++X"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36643b96b99so5576626a91.0
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778754651; x=1779359451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fdFlkFOWt/jZ2tS4R334p9A28Ma1mptG39Xac/iq1co=;
        b=P+Ih7++XM5CwC3JagG+Ev4+HipXxK3NB6nc6IOQ+sYnio7qCOFxtpsYMmPwul2EOdC
         dg7Dpys1rp3d+Vbus5fH+Q35y4YgvoX1T/cGYzjHfCqef6TA8rySU+rJZxIb4Zuwg9oa
         Y9SjmdgqSo9+arpSv6r2IGcLXYesvTy0EOWxz2ZTWJsGVZOg7Cl+hPDD9KMNae0KADcJ
         pJ6R0uzX97Md71NJ7bG7GFSJIB4Gsl9/CQOSsEe45K3ejQ/6q6kJBrbuA+HX9Pul/Yp4
         x5DyIUOdfyvnj0o8E+Cs9iL+g5Ci5Kht3ulWE4kKugKc+Fzsd0CfbBzhNAKyTlbwTuy8
         oZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778754651; x=1779359451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdFlkFOWt/jZ2tS4R334p9A28Ma1mptG39Xac/iq1co=;
        b=HJ47pHe4nI0+sRS/8RBckWUk5cqAbe8Q0n16w66GukYSQ7su7M9Max0XhNP6UUoc3T
         QcmzPYQx56+y57bq42JMQGlmbtfFluoktfKfQ1acc4BsfBNZk/gWyoktd+nYcC18knWB
         B0DL5GAoIrt+IR86JKGVv8nycPRD89Vg/7UsqF9hNPogbAaBIZ+N44hkVLRpmK8CNcuY
         /JsV8zqUnNuZ1pJD9hE4SeCCrmTq8p1ynKaVMPKZfch31g5lv9VgXqeWCE0ae3jrm/5R
         FXyyGhscqm/717S4pRedJAFvemKSQTKvbtwPV8C2Q96uci4iYoXi203qNxkMKAMVbLQ/
         Wqfw==
X-Gm-Message-State: AOJu0Yx4j4QK1qEtM+2FItmwPhvKf8FDe8w77Hz8o7Jix90ZcLlwlrVk
	aNegdqI7cvtan9LPFhPGhb1YF9U91+7QuwZ48fpz+0U1t/GQx0wXjyMU
X-Gm-Gg: Acq92OEb5dvyVRLw97665jCDYojDarm+UEqXy9Pv8Dcte0Lt1AL6/ihUu9exZUi1hiW
	48wISog7PzIJg4rlulxL9Q/NN57L6gc6UjD42Sy0kbQpyyxo4bc65NrYve+74qFViHdywhSDjRl
	bFRzvqxeAhIM6CDoh83ij0r7rxgg93Ub4MtaUdNfrASToVZxf71S8bTPlxrSL7Hcb3LEoNg35tD
	PTB+P/Dr6O2X1x5Uwo6hJBsXn/9bbG/PnTIJRLXe+7abm1Cw7lDuJ/LapN8rKHp0AioU//15lNZ
	C9GYXaXkD6psGA/i0tkXC/LtnjGSkR27qqusAolRycLl83Ok2Dohjpwgh4U/Glhd/cSn0BghmA+
	qjpBW1cODLJv52E4YrcuPeM1VFue4a39ELNj4rlOSAahAnUeGB/0+Ve7qXtMig/YBA5NCvoiXXt
	un0lhMMklcPqgEbwgSO64+zIR3X3E92ewuSsXW3ctAqZS8LSwI/j8wcRYvsTsV
X-Received: by 2002:a17:903:46c4:b0:2bd:2de3:51ad with SMTP id d9443c01a7336-2bd3043ca95mr74387675ad.34.1778754651014;
        Thu, 14 May 2026 03:30:51 -0700 (PDT)
Received: from localhost ([2404:7c00:52:8f0e:aae2:91ff:fe57:5e15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f5d2sm20493615ad.23.2026.05.14.03.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 03:30:50 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: linux-fbdev@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH] staging: sm750fb: Add suspend checks to copyarea and imageblit
Date: Thu, 14 May 2026 16:15:42 +0545
Message-ID: <20260514103042.55313-1-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lynxfb_ops_fillrect() already checks info->state before accessing
the hardware 2D engine, but lynxfb_ops_copyarea() and
lynxfb_ops_imageblit() do not.

The suspend path calls fb_set_suspend(), which sets the framebuffer
state to FBINFO_STATE_SUSPENDED. Add matching state checks in the
remaining accelerated callbacks for consistency with fillrect().

This patch was developed with AI assistance and is compile-tested only.
---
 drivers/staging/sm750fb/sm750.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 9f3e3d37e..025ac8fe3 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -204,6 +204,9 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	struct sm750_dev *sm750_dev;
 	unsigned int base, pitch, bpp;
 
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+
 	par = info->par;
 	sm750_dev = par->dev;
 
@@ -239,6 +242,9 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	struct lynxfb_par *par;
 	struct sm750_dev *sm750_dev;
 
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+
 	par = info->par;
 	sm750_dev = par->dev;
 	/*
-- 
2.54.0

