Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27A4466B0D
	for <linux-fbdev@vger.kernel.org>; Wed, 22 Jul 2026 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743127; cv=none; b=KYHic2x0pl9RJBVzzEA53Guiu5sutuSN6o/+xsUNKo/D0eww9NrEQ9trwDiuzOdzcdLZNopYochy8oplruG5dHbGH6JiHutUk5fICEEZczoZ2pnhJNi/SAATbHikOv97uNRJQ6Cow0p+I+3olDCqhYb0yjuthALT9BEC9mA58lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743127; c=relaxed/simple;
	bh=R06kvHlvgUDZ3CXREJt2cqJ8NWU6FxD95kENY/ljqxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSUmLeDI4BBz19T26lWV86h1fdxN9Y6m2eWNh/Rn+oViqux2Ed1jpSH3vYRJJFyyj9n7tONwu/fErF6aQRweoKoCWe9a+PVa222IHgfUMlBWdA1viqm3hIQSxQ8KbwaVd38V8HpviHxkrpcgNP+VsStJ4Gncuw2WdbekBIhbvS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWub5ihc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWub5ihc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caced6038eso87132135ad.0
        for <linux-fbdev@vger.kernel.org>; Wed, 22 Jul 2026 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784743125; x=1785347925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jy637cVMzFAwnK0MmpodqX8DixFGXdPFgpFLohFzHo8=;
        b=IWub5ihcuuc3M2OVO4A0Ix/j2lNV4/e8dndZMAqojLPUh3p/L1cDuRPDhFRAb5lShF
         bxwsg6dUEiMywO+ZPoCWfUaFcgvyKnm/LLCUngKDCWqIVezl7gNmp5MAprgo/i+/IKXo
         /oYCiQ3vtCgs42KXc2B78osbycymKBpCH8+ADprytwt5m6tMBcp3DJYoeQlCkQSkf7VE
         3SHOWISA++L4Osxz6hlQbBEEI/xoCknxGG+Yf/d9XFYwdWPmZKnSCH+FMJ8rduqFU7xE
         DImfB7ztbSFtcRrrZzRdRzXVW90Yf+PVnw/cqadlWuF40AelRGd9I36lDmGlxkhAckRU
         dmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784743125; x=1785347925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jy637cVMzFAwnK0MmpodqX8DixFGXdPFgpFLohFzHo8=;
        b=pUzOLqGG9G8AtMGemlK04MqtlFdXtW5lsMbUAUoQv66uUXA4a8U00GYqbvBaWy3gqb
         9oXwttbQneElovr5Qh9PYQ9qfrWpnWWhzdjtghm3I7XcSUuv7z1UDq1nxnvJB8lVYkPO
         XoYwy/8Qy30UDVpw+DV25DtLs/+V6Kss1OCZskm0073UxlWGuEb1fcv4UgkrcLodG2IM
         lHWvMQF8b9AZbuTiLb02QAY54V7jIjzMciP3Ul3HHkTIyY+YGzriPyABMoW7Vo6M51lh
         oZM+1y3gnwL2Zj6saj1al9uAM1tqf3V3TXWG6RW4uZRae9DLt3syBBS4xL18tCu/DulG
         FBjA==
X-Gm-Message-State: AOJu0YyeXiUZz6NuFvIVo2QUsGdP6QISlNlizXhzz2qQli1atPdbM76Q
	KPgAD/fqqnibGSMKK6aVBl+HP4oBRSzlndd+j5PVKnCXwbbcdXWMzJFP
X-Gm-Gg: AR+sD10CGnDnS2zWvxwyf/tw6ZjSin3e8fq+LAjDyU28Qpt52N07PUBpIMdBYbmqzcr
	idIAnvtc475CgK/NWMjhv2lx3lFE0CgvTltTY47jLw82gjk+VZw3k+PFSnp7WhFKBzqsHUFYNSk
	uguCVYEj4lPdJolUN7ZFrApft1M06mxjXVFPri4Gqm2tZGyFRgYJAMO9CoTjZMcMG8U4Ux8Nk6B
	DswQaYhbm2oIEthVetGWGWjR+L4nlvU+Yq7PlyM3ab1AH1ALUNHTRSdEmnQ3Ztx+u7QZA/zel13
	4RWbg2YbkLLIOh9ZMMW7QH3vBxglGvHtpzQdBEKM/kixcBXkwKnTV+Ip+p3PITQH+AjNDesyv/s
	hTr2WVaowH6FmQRYaA/oqi7s/bc0hc0GepoGhJEte1V36gufsecoxqcorgMafVZQ5qQ7P18/0ZE
	6+6BqaYvZS3/8u
X-Received: by 2002:a17:902:e5c3:b0:2cc:db7a:251 with SMTP id d9443c01a7336-2cf8dc6d1c3mr51151055ad.2.1784743125072;
        Wed, 22 Jul 2026 10:58:45 -0700 (PDT)
Received: from PC.. ([103.172.209.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1a67esm12057690eec.2.2026.07.22.10.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 10:58:44 -0700 (PDT)
From: Mohit Mishra <mishraloopmohit@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mohit Mishra <mishraloopmohit@gmail.com>
Subject: [PATCH 2/2] staging: sm750fb: Clean up whitespace and comment spacing in headers
Date: Wed, 22 Jul 2026 23:28:17 +0530
Message-ID: <20260722175817.213235-2-mishraloopmohit@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722175817.213235-1-mishraloopmohit@gmail.com>
References: <20260722175817.213235-1-mishraloopmohit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up minor formatting inconsistencies in sm750.h and sm750_accel.h:
- Remove a redundant consecutive blank line in sm750.h.
- Add missing spaces in comment blocks in sm750.h and sm750_accel.h.
- Align DE_SOURCE_X_K1_MONO_MASK macro definition in sm750_accel.h with
  spaces instead of tabs to match surrounding macros.

Signed-off-by: Mohit Mishra <mishraloopmohit@gmail.com>
---
 drivers/staging/sm750fb/sm750.h       | 3 +--
 drivers/staging/sm750fb/sm750_accel.h | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index cd34d7f82c64..7a8eaef7b1fe 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -39,7 +39,6 @@ enum sm750_path {
 	sm750_pnc = 3,	/* panel and crt */
 };
 
-
 struct lynx_accel {
 	/* base virtual address of DPR registers */
 	unsigned char __iomem *dpr_base;
@@ -49,7 +48,7 @@ struct lynx_accel {
 	/* function pointers */
 	void (*de_init)(struct lynx_accel *accel);
 
-	int (*de_wait)(void);/* see if hardware ready to work */
+	int (*de_wait)(void); /* see if hardware ready to work */
 
 	int (*de_fillrect)(struct lynx_accel *accel,
 			   u32 base, u32 pitch, u32 bpp,
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index e98cf8f9fb2e..3c5c189940fa 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -5,16 +5,16 @@
 #define HW_ROP2_COPY 0xc
 #define HW_ROP2_XOR 0x6
 
-/* notes: below address are the offset value from de_base_address (0x100000)*/
+/* notes: below address are the offset value from de_base_address (0x100000) */
 
-/* for sm718/750/502 de_base is at mmreg_1mb*/
+/* for sm718/750/502 de_base is at mmreg_1mb */
 #define DE_BASE_ADDR_TYPE1 0x100000
 /* for sm712,de_base is at mmreg_32kb */
 #define DE_BASE_ADDR_TYPE2  0x8000
 /* for sm722,de_base is at mmreg_0 */
 #define DE_BASE_ADDR_TYPE3 0
 
-/* type1 data port address is at mmreg_0x110000*/
+/* type1 data port address is at mmreg_0x110000 */
 #define DE_PORT_ADDR_TYPE1 0x110000
 /* for sm712,data port address is at mmreg_0 */
 #define DE_PORT_ADDR_TYPE2 0x100000
@@ -25,7 +25,7 @@
 #define DE_SOURCE_WRAP                                  BIT(31)
 #define DE_SOURCE_X_K1_SHIFT                            16
 #define DE_SOURCE_X_K1_MASK                             (0x3fff << 16)
-#define DE_SOURCE_X_K1_MONO_MASK			(0x1f << 16)
+#define DE_SOURCE_X_K1_MONO_MASK                        (0x1f << 16)
 #define DE_SOURCE_Y_K2_MASK                             0xffff
 
 #define DE_DESTINATION                                  0x4
-- 
2.43.0

