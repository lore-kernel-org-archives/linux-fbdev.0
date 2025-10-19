Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F513595D
	for <linux-fbdev@vger.kernel.org>; Sun, 19 Oct 2025 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760898930; cv=none; b=BxnnChPcCzsKr6WWvxJymPpVATuBEjNkreuvqOF4XOKmkkBUFDUXBzVIbx2rCasisLOaMWTNEiV5ZpvLV85hYJSqNOPNwbAIArgJO9HfzyGosUZeYyS/Bo8nAv8zBJbCxyBvlcx0OIsl+FO190G/yIAgZ/OS+k1bV4R9ozXDpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760898930; c=relaxed/simple;
	bh=xqB47To3mQeORWIHCfp6oFWavgkGL2Yi/RMlz/BiE9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGxFVRl2qIbZNWhz9MQs25m9QovIPYwpzUX7eFVTX1n3TSy3MeUp2jablp63zj3VEmuHMtreeMd5lamIldTSNhZkSVQJtfZwiHr8b5RkYZFiP1pdWeFv4XI9FuiKu8ikFNIoR7I8nt+OWELbySkKAZicd/fgVVD4i8VfzCPxcFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQBMYkwm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQBMYkwm"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2699ef1b4e3so6110255ad.0
        for <linux-fbdev@vger.kernel.org>; Sun, 19 Oct 2025 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760898928; x=1761503728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rRfOoLkKKIZ1P08u43a+VdAcQJSYKDXjEt4i3GhWSy8=;
        b=EQBMYkwm0/iMQXUmb3yphsH6690OV/3a95qLVnF4GkuqPED1xGYEwIL41GQVSzDtUn
         piHNH7c8rh3g8BtXFndfhkYo2mC3BwO+dwACg60Op2unqcG55aw+IkNq6SsvhTa+mQG2
         Sz0dO0GSa5hQFW3g1z8nQvN97XwP7IRk17fjQvUkZnfeNZvkmKlqP87PgTyvazi8x1j6
         ULz4zpxiDXIMvd7xsDt+l7u0TK63E9Gvs9MCVNnqZ04lNQVKfZe/ida3/5E1s2p+RqfO
         nq3l5ygSBDqYoC8jku6TZ6Po0TI9XVlWgcvbRFuYozCijWLc/+TO9EThj32dDBxFQzXD
         jyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760898928; x=1761503728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRfOoLkKKIZ1P08u43a+VdAcQJSYKDXjEt4i3GhWSy8=;
        b=sCxc/vmFNrVmYKhyaHz/qURnMQCSunBvW0XXYqdUIXv4AmQLjXAuikvh4lvYGYkDMP
         EA/Mihq9vWTYYgCB6Dc2VMg5BfGcConmd4tm/+YUGv5KG1kIsDJKUKKNw7GGl27eRaoL
         W21O7qTcPKVMn7eEd/ZcwfcCYdOxDitEfuYV0x26VkABhfON3XwLw2dl6vDPijirIGNI
         klxOW1NXIB0AaPynkQlAM8gThJVDch5ukF2PxL5yPnoNvNUEw4dGCs+lbsWsptBr4WqW
         7Aa7boYPUAuICREH3BGd/TES4msiXemVHj07OQJc78wo7BY4LyJ8ZMNF5mlV+5vZZfae
         OYsg==
X-Gm-Message-State: AOJu0YyR0Gv6mjX9184+oaCsDSNY2lyQc4/3GVXiKRICNPG0DmvNSnYx
	brOIt/Z0nWwrlMtdeDDWE987xdzEcWId8mrRQit6r3V2A8cvmVDySwbm
X-Gm-Gg: ASbGncuGrgKVuaTeFtE0Oy55pmP9iPeLCqqv+PdYkV0yzxd4Dsb0JNDXfJHjgE7eNRh
	1oLhqRBfCsLafeQjB5bqBI1b83Fm8CEmpsvMuYABmXQIlO/HLKEaa01+nocsc3H9ySIGf1MKoQI
	dk7mmBPLmh21KLn/NEoIpe9gIcO741/cK6qEpSITiU5/fN6MUOLjYCtOg5E02gAh1muTHFRxViZ
	3bhyZhE4im7qzJ7kwqMp3pTSUZ8oCka3uCKi9Vf/AlcImZrAU3A8Ym+hDOzOzgsQnwM/uRiTXUi
	zy0prGr2nGPn4y6/pmgvipwIQBwnjcm0CLl7z62833ONLjk9yj8Gx+lf8zQMJZgy6WbjJ+2gPpH
	nlw6c81UE6td9+o965JVHl8QjDQcFhsmwof9nsJUHCP4K2iDh/jZH4n7BI4whhkluTAe4ro6yGc
	rKS2DcO1fy4g==
X-Google-Smtp-Source: AGHT+IEBr/+KS4HtviMuGoC1wIJRCMADPtQbZ3CNlH5yqb2pJ0Un5KgzQq3dwYcp0NYpYolDK9OUyw==
X-Received: by 2002:a17:903:8c3:b0:25a:4437:dbb7 with SMTP id d9443c01a7336-290c9d2debcmr73367365ad.4.1760898928335;
        Sun, 19 Oct 2025 11:35:28 -0700 (PDT)
Received: from sulfur-sorcerer.. ([2409:40d4:154:dd90:39bc:ea42:d3d:15d6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fde15sm58785055ad.84.2025.10.19.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 11:35:27 -0700 (PDT)
From: PIYUSH CHOUDHARY <mercmerc961@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	PIYUSH CHOUDHARY <mercmerc961@gmail.com>
Subject: [PATCH] video: fb: Fix typo in comment
Date: Mon, 20 Oct 2025 00:05:08 +0530
Message-ID: <20251019183508.20804-1-mercmerc961@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo: "verical" -> "vertical" in macro description

Signed-off-by: PIYUSH CHOUDHARY <mercmerc961@gmail.com>
---
 include/uapi/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
index cde8f173f566..22acaaec7b1c 100644
--- a/include/uapi/linux/fb.h
+++ b/include/uapi/linux/fb.h
@@ -319,7 +319,7 @@ enum {
 #define FB_VBLANK_HAVE_VCOUNT	0x020	/* the vcount field is valid */
 #define FB_VBLANK_HAVE_HCOUNT	0x040	/* the hcount field is valid */
 #define FB_VBLANK_VSYNCING	0x080	/* currently in a vsync */
-#define FB_VBLANK_HAVE_VSYNC	0x100	/* verical syncs can be detected */
+#define FB_VBLANK_HAVE_VSYNC	0x100	/* vertical syncs can be detected */
 
 struct fb_vblank {
 	__u32 flags;			/* FB_VBLANK flags */
-- 
2.43.0

