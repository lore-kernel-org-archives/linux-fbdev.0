Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB342303A09
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Sep 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537401; cv=none; b=ZNcyE1cQP48WvjbBggqe201pJFf3Kbesbxn5YOfnc1GqFTub1DKVOlW/+4RnGlUbbbd1Ypx6Fb7RYIn73VJWh+wa97CHPVSznq7tzKncCgbMfVwjYefNHgEeB3H8pjn50nashFHTQDXqEGqaUi3/Rzk3yO8T0R87uWZCGAc6Yl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537401; c=relaxed/simple;
	bh=VekAVktQARbqymlhO6wwZZmB2sjuhPKVv7aIjYWH0zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2lGVyxbGRatbxaO+hmQpXGegQrXAnVK1yVBKs5qtMr0Dgln4kMqk862+5aBOe0FU1WOQDYTYeuhFDBO0D175K8vyKIFqKmnFQVe5/ZdZtPEDZa+17qoR+AhItAgxjJJLMu4ZR8hH515Xg9ffA9Dvz6Z5dZc0GiKRc44JUlyisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lru7tpuL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lru7tpuL"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f1f29a551so1631588b3a.3
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Sep 2025 03:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758537398; x=1759142198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUsWM/yu7Jel0zw1CX63zsJor2DdbZT5LSBHT64S5Mk=;
        b=lru7tpuL6X0JAqu97rueSZ/deGGNnifPdmEaO84/8st6kRrAhH6d0LeefSEDW65N11
         +hTrFGvbuD/MMKd7opJi4Q8q+aDoBXt2GOH2Mf/tbAYFa2R2O+PVfX0/79RsDz9iaWg+
         plU/p+SRkTld5X0mYRX6jM6NMaLQO+2ojhjEkPYiEifN5LfuIeuuHC8SWdNG6frF7sJj
         O6z1A7va9dIsezvXxGWxTlmeYRBMcs0K89WlZhT1ZYxtPRbQ83KXQ47xozoSQEe64xF6
         r6gprAqPjevOavGdlF775dxdDP7GtsC9wUWG90MlXCN6cUhSgQ0Uypcz91WfYEDVvuyN
         jC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758537398; x=1759142198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUsWM/yu7Jel0zw1CX63zsJor2DdbZT5LSBHT64S5Mk=;
        b=FeDq7fEl5qUubTmU1yV8XzmBe1UC4Wb2LtYPxeVM6tTb6zRsvhIj8rwVzYwnAzug4W
         EDVOIN7YEI+wxyUNWFygZb+T5DHKF5IBiRoUCIdw2w9ph1hIUhojlVKGvlmroVQulne0
         vt63Z9jYuj2l6ll6ESbcODOc6QRS+cYNuygkYPY4tPhWxtWnPiWBUVMJdNyIlX7CPnkt
         EhMADxuROGs1b2ldqI/ClcPdm4TCPGZr3kdYy9ht7GgkCzs7XwwHInZLBilMJJXrv0Of
         eXgeQJegWcEeHTwx1QlsYwI53X87MREfT2Vlfs3mKp1P7UwxTzHtNb/aYtAO8JaV2Ae9
         noSg==
X-Forwarded-Encrypted: i=1; AJvYcCVf8INMaMdaiKh+BObQVtxAhMH7gel/GDInmCdo+Hmot7LQ3S+XpxpJVKyheTz81FIWV6YVhBU7K8I+/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoF8ol1oJsZq4gMO9pJW2cJoiJICf0E8bE48ub8oKsQOL56qwT
	Y6OTSjpmPlDt9nS3z9vqNsCzvMTP9eQGuXRvL6ZZwPBf+d5rlqLY7cIi
X-Gm-Gg: ASbGnctLMNszjr9pdGzsIfwB/w0cJniF7X4E5T4H7/X/QiJKJttDaohxDbCcT2Jv2Lm
	Y9eiJw/909ywJ1ILgD303Zx69x9p5kDF/2meF/JX6DCH5fbdc3N+LHDtmsWUwtjiYQngSjgtcpj
	phUTv2WVV6AX5LacawAQrDe/X3yTpf12PXYgXtMTBSw0fukI5KFcoPfnxdx6X68pChIZSekaERd
	4MEanNwXPrDin9oUygsaTBL462frCFgQv7HFIHlhOtcNAEGIz5ZGPXU1IRPZs5/8OfhZnMbiFuP
	i0Akj10koK7+Q4xA6S3JFBZb4x5EmXRx5ASlH/g033geMXnmlk0uQLzp2A2zYLmSLFkuRQLqlwq
	OKNlJ9dcFvUbc3ePPs+DHRg==
X-Google-Smtp-Source: AGHT+IFUhE34CR13u3pkqJ2FQbCBkH8zk1hwNOLtzeEtwFNcYfGFUDEb6C1tE0SbXMUBVYslIX63RQ==
X-Received: by 2002:a05:6a00:39a3:b0:770:73ed:e6e8 with SMTP id d2e1a72fcca58-77e4eabb491mr13122300b3a.22.1758537397949;
        Mon, 22 Sep 2025 03:36:37 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77da1584eafsm11238858b3a.20.2025.09.22.03.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:36:36 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A2F8341A2ED4; Mon, 22 Sep 2025 17:36:34 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Framebuffer <linux-fbdev@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Helge Deller <deller@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Bernie Thompson <bernie@plugable.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arvind Sankar <nivedita@alum.mit.edu>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 2/3] Documentation: fb: Retitle driver docs
Date: Mon, 22 Sep 2025 17:36:15 +0700
Message-ID: <20250922103615.42925-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922103615.42925-2-bagasdotme@gmail.com>
References: <20250922103615.42925-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7230; i=bagasdotme@gmail.com; h=from:subject; bh=VekAVktQARbqymlhO6wwZZmB2sjuhPKVv7aIjYWH0zY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkX1QIFY4JuaLwWP8268MXcu4/Lt1XvPnmFt/rfdJPZ8 7dc3eN+taOUhUGMi0FWTJFlUiJf0+ldRiIX2tc6wsxhZQIZwsDFKQATsd3GyPDWTydwfp75sZhu I08n9lTZfWfSXFkPZLlb519dMFt5uTDDP8tjH+97pt5uEE7SZza+vF16s8K3+qitrj2v9UveiFx Q4wUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Many framebuffer driver docs are copied from vesafb docs as their
template, including "What is <driver name>" title. Such title
implies the introductory section, however, and not the whole docs.

Retitle them.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/fb/aty128fb.rst | 8 +++-----
 Documentation/fb/efifb.rst    | 6 +++---
 Documentation/fb/gxfb.rst     | 8 +++-----
 Documentation/fb/lxfb.rst     | 9 +++------
 Documentation/fb/matroxfb.rst | 9 +++------
 Documentation/fb/pvr2fb.rst   | 6 +++---
 Documentation/fb/sa1100fb.rst | 9 +++------
 Documentation/fb/sisfb.rst    | 6 +++---
 Documentation/fb/sm712fb.rst  | 6 +++---
 Documentation/fb/tgafb.rst    | 6 +++---
 Documentation/fb/udlfb.rst    | 6 +++---
 Documentation/fb/vesafb.rst   | 6 +++---
 12 files changed, 36 insertions(+), 49 deletions(-)

diff --git a/Documentation/fb/aty128fb.rst b/Documentation/fb/aty128fb.rst
index 3f107718f933fc..0da8070a552165 100644
--- a/Documentation/fb/aty128fb.rst
+++ b/Documentation/fb/aty128fb.rst
@@ -1,8 +1,6 @@
-=================
-What is aty128fb?
-=================
-
-.. [This file is cloned from VesaFB/matroxfb]
+=========================================
+aty128fb - ATI Rage128 framebuffer driver
+=========================================
 
 This is a driver for a graphic framebuffer for ATI Rage128 based devices
 on Intel and PPC boxes.
diff --git a/Documentation/fb/efifb.rst b/Documentation/fb/efifb.rst
index 6badff64756f49..3d4aab406dee0a 100644
--- a/Documentation/fb/efifb.rst
+++ b/Documentation/fb/efifb.rst
@@ -1,6 +1,6 @@
-==============
-What is efifb?
-==============
+===================================
+efifb - Generic EFI platform driver
+===================================
 
 This is a generic EFI platform driver for systems with UEFI firmware. The
 system must be booted via the EFI stub for this to be usable. efifb supports
diff --git a/Documentation/fb/gxfb.rst b/Documentation/fb/gxfb.rst
index 5738709bccbbf3..3fda485606bdc1 100644
--- a/Documentation/fb/gxfb.rst
+++ b/Documentation/fb/gxfb.rst
@@ -1,8 +1,6 @@
-=============
-What is gxfb?
-=============
-
-.. [This file is cloned from VesaFB/aty128fb]
+=======================================
+gxfb - AMD Geode GX2 framebuffer driver
+=======================================
 
 This is a graphics framebuffer driver for AMD Geode GX2 based processors.
 
diff --git a/Documentation/fb/lxfb.rst b/Documentation/fb/lxfb.rst
index 863e6b98fbae55..0a176ab376e30e 100644
--- a/Documentation/fb/lxfb.rst
+++ b/Documentation/fb/lxfb.rst
@@ -1,9 +1,6 @@
-=============
-What is lxfb?
-=============
-
-.. [This file is cloned from VesaFB/aty128fb]
-
+======================================
+lxfb - AMD Geode LX framebuffer driver
+======================================
 
 This is a graphics framebuffer driver for AMD Geode LX based processors.
 
diff --git a/Documentation/fb/matroxfb.rst b/Documentation/fb/matroxfb.rst
index 6158c49c857148..8ac7534a2e6168 100644
--- a/Documentation/fb/matroxfb.rst
+++ b/Documentation/fb/matroxfb.rst
@@ -1,9 +1,6 @@
-=================
-What is matroxfb?
-=================
-
-.. [This file is cloned from VesaFB. Thanks go to Gerd Knorr]
-
+================================================
+matroxfb - Framebuffer driver for Matrox devices
+================================================
 
 This is a driver for a graphic framebuffer for Matrox devices on
 Alpha, Intel and PPC boxes.
diff --git a/Documentation/fb/pvr2fb.rst b/Documentation/fb/pvr2fb.rst
index fcf2c21c8fcfeb..315ce085a5855b 100644
--- a/Documentation/fb/pvr2fb.rst
+++ b/Documentation/fb/pvr2fb.rst
@@ -1,6 +1,6 @@
-===============
-What is pvr2fb?
-===============
+===============================================
+pvr2fb - PowerVR 2 graphics frame buffer driver
+===============================================
 
 This is a driver for PowerVR 2 based graphics frame buffers, such as the
 one found in the Dreamcast.
diff --git a/Documentation/fb/sa1100fb.rst b/Documentation/fb/sa1100fb.rst
index 67e2650e017d12..c5ca019b361a94 100644
--- a/Documentation/fb/sa1100fb.rst
+++ b/Documentation/fb/sa1100fb.rst
@@ -1,9 +1,6 @@
-=================
-What is sa1100fb?
-=================
-
-.. [This file is cloned from VesaFB/matroxfb]
-
+=================================================
+sa1100fb - SA-1100 LCD graphic framebuffer driver
+=================================================
 
 This is a driver for a graphic framebuffer for the SA-1100 LCD
 controller.
diff --git a/Documentation/fb/sisfb.rst b/Documentation/fb/sisfb.rst
index 8f4e502ea12ea7..9982f5ee05601b 100644
--- a/Documentation/fb/sisfb.rst
+++ b/Documentation/fb/sisfb.rst
@@ -1,6 +1,6 @@
-==============
-What is sisfb?
-==============
+=====================================
+sisfb - SiS framebuffer device driver
+=====================================
 
 sisfb is a framebuffer device driver for SiS (Silicon Integrated Systems)
 graphics chips. Supported are:
diff --git a/Documentation/fb/sm712fb.rst b/Documentation/fb/sm712fb.rst
index 8e000f80b5bc6d..abbc6efae25f46 100644
--- a/Documentation/fb/sm712fb.rst
+++ b/Documentation/fb/sm712fb.rst
@@ -1,6 +1,6 @@
-================
-What is sm712fb?
-================
+==========================================================
+sm712fb - Silicon Motion SM712 graphics framebuffer driver
+==========================================================
 
 This is a graphics framebuffer driver for Silicon Motion SM712 based processors.
 
diff --git a/Documentation/fb/tgafb.rst b/Documentation/fb/tgafb.rst
index 0c50d2134aa433..f0944da1ea5ef1 100644
--- a/Documentation/fb/tgafb.rst
+++ b/Documentation/fb/tgafb.rst
@@ -1,6 +1,6 @@
-==============
-What is tgafb?
-==============
+=======================================
+tgafb - TGA graphics framebuffer driver
+=======================================
 
 This is a driver for DECChip 21030 based graphics framebuffers, a.k.a. TGA
 cards, which are usually found in older Digital Alpha systems. The
diff --git a/Documentation/fb/udlfb.rst b/Documentation/fb/udlfb.rst
index 99cfbb7a192238..9e75ac6b07c36a 100644
--- a/Documentation/fb/udlfb.rst
+++ b/Documentation/fb/udlfb.rst
@@ -1,6 +1,6 @@
-==============
-What is udlfb?
-==============
+==================================
+udlfb - DisplayLink USB 2.0 driver
+==================================
 
 This is a driver for DisplayLink USB 2.0 era graphics chips.
 
diff --git a/Documentation/fb/vesafb.rst b/Documentation/fb/vesafb.rst
index f890a4f5623b45..d8241e38bb28d6 100644
--- a/Documentation/fb/vesafb.rst
+++ b/Documentation/fb/vesafb.rst
@@ -1,6 +1,6 @@
-===============
-What is vesafb?
-===============
+===========================================
+vesafb - Generic graphic framebuffer driver
+===========================================
 
 This is a generic driver for a graphic framebuffer on intel boxes.
 
-- 
An old man doll... just what I always wanted! - Clara

