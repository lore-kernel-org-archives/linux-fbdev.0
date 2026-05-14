Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC33A8741
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778745806; cv=none; b=M8GRVfXGAiAC810l6YospEjDsAtFcYX+eOmXToiNt6k1GPV4SYvS8gcdRsRBRjAtcZFzF5ocI1+OZiUfGJiTqPdDrYxBsjcWlJR+iPI4aKiWPTXSvaIX6l7ajUcAbyv/wHdC+g/52jSg7SjzLL5BDEBb/1ejO8Q95Xc2Vjq6cHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778745806; c=relaxed/simple;
	bh=r31U3mmNfI2l91+C7Oi83eBww+uDGQFp8X9UzhipXl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCqxh0nASwFA7uqvuTWab4Jy5q00kWrR6HlBTw9GpTwRBswcxw+2THmiunnDxwulQ5dk/tzYMWVymBhpu87tS3jebAiZBVMhI2z4U8dOUSbC90C8GTf2z1ghJQB+vMps1wcJYFlA4GVLCYCWfFSIEzOdDTNksGKXdimXo0pzB5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pN3ZSxu/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pN3ZSxu/"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c795f441ff7so5637843a12.2
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778745804; x=1779350604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u7GNIvyzCgZi0OvfLvXfLsDC6btZO2C2Y4XrgU5NUV0=;
        b=pN3ZSxu/gj2+gqm5e7Ha1KeeUA2bLbZxFk+E8/2T+qijOla/TkohmbVRhUQEGXE6Qw
         cRPfn3jy037CtPRD2+KAWSM8k1RNlbIzdxymdwOaaBHQE6yzKLDmd+Qrw44AJk+OKLoz
         Q3SJSjBiAE0EhPUUkwNE/tBoEn9trvFSXExNBNlYbOui4b9rA2FQk6QqQ2tiyrPEtV2l
         b6zFLkUBiDulexfUOBetbX2vZ8zb43Dqfi/wop5Zul6jD3QIrh7odx+39oXSdd1Y892Y
         T1Bs3dsTczPsWs4Rg2omPImCRssb4UnS+91VjLSk4I4+s4Fu14jHe3b0siHiiN4yg5k9
         MygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778745804; x=1779350604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7GNIvyzCgZi0OvfLvXfLsDC6btZO2C2Y4XrgU5NUV0=;
        b=JMoh42aeIsr5sLhI8hYKG6UgdkgAb3Z5wG9Ig5qsyvhEuz/Hgi/6/266jrJjCQPcNN
         tkeY59STMu1MXEDsSncKsynemARZJK93jgoSwFRMirtr+M1h/aZHg65o6MS6f7Bbm4J3
         Y3pUNpeS3/294xAjUa/5YwQuiLea57wcOZskgK/AdCmeWGrGIk3YC9Snt9rqIiUH67hm
         ZYkZIvhAATc0XUCGLujZPusORXctF01EfonKPuBzbKHKtoywUsTjqUwqRVHrZS1o8/2R
         Phe9kuFAUgCYWmWnP5k0gWc9E/QXqt3vI/H5ixAROKX8qgyIh6T5TsSBcgRu0Z3LU8Xm
         r5+A==
X-Gm-Message-State: AOJu0Ywy6WxcsaMA7ttcc4UIntiizAM/n4mGHpA+zRb+baTgpWIztEBM
	S8CgeUVz2DaKh4LFTxiX0F6N6dxpnIU2S1QE3SbJ1vFgJqj8umYqBSRb
X-Gm-Gg: Acq92OFg11jlAt4W0VanNGay1cCbgonnkjcsPDqcMf+WSbQg0aUDmNDXB/+XRi+Wq22
	YjrmKkn6ND4VnUiBpKbCxQ5bb7RiNvH5SO+PIQuMhBVQBDzK5km8dTL3VEHDaECNiD32hwBpGMA
	6KE6IOP7GZhyEDO3RfBh0hQmLhUbFiiCDRcQanHCZOQwnIDoznBZFekevsZOtPH3DjnFma5W8bA
	pbScYflDOmr3ekKItipRYEe08XnLH7OCMssjcRzF38V3B0H5I5/fyrXMm4CyTwZbbMGlNoxMht2
	KivJqBOJE6II3LoavVsiY0J2oQyBwkthlg1pmWSVFieuT6rpLST/BE3AHrI0RbWWBFHTNC6S0/n
	RLuho2v2McVOSX4OEM3ObNFvdoFQd9QK1TMsE7NqT1+KN9wrtPZfroaUbuCUWOcocxqrrlL4sDC
	oDNNJulWLYPzUaiLw8AYE542gf61p1PHN72I45EBgrnPWhdTLAGdw/TnbphRowQKf+f7D/VXg=
X-Received: by 2002:a17:902:fac3:b0:2ba:6ffa:bde0 with SMTP id d9443c01a7336-2bd30210e76mr47839485ad.19.1778745803654;
        Thu, 14 May 2026 01:03:23 -0700 (PDT)
Received: from localhost ([2404:7c00:52:8f0e:aae2:91ff:fe57:5e15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c16ac4asm15236865ad.33.2026.05.14.01.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:03:23 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH] staging: sm750fb: add missing FBINFO_STATE_RUNNING checks in copyarea and imageblit
Date: Thu, 14 May 2026 13:48:18 +0545
Message-ID: <20260514080318.39332-1-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lynxfb_ops_fillrect() correctly checks info->state before accessing the hardware 2D accelerator, returning early if the framebuffer is not in FBINFO_STATE_RUNNING state. However, lynxfb_ops_copyarea() and lynxfb_ops_imageblit() omit this guard despite using the same hardware accelerator through identical code paths.

Without this check, the 2D engine could be accessed while the device is suspended (state set to FBINFO_STATE_SUSPENDED via fb_set_suspend()), potentially causing bus errors or system hangs.

Add the missing state checks to both functions, matching the existing pattern in lynxfb_ops_fillrect().

Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
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

