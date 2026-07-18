Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C591DF25C
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784370699; cv=none; b=meuJGReN/4saInX4SFxrRFRRmMlfzLkqKLVHRlcoU+t/sRZ5G98g5834Wp/3iArVLVOjBulfd8/4RrarWuiHBZLB2G7JXOHc4Vp5bXamjaoi6yZeUBc38KmXzVDl9R9hHmXrQ9ICYDoUr5auifhoh26TjpzubFWqMlXGpKpqag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784370699; c=relaxed/simple;
	bh=//RX4WkXlQC6pYWjnZffoQCrCvtvt+jpXoPoMY8XutA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MR/F8TAjECM5CTWUZFOOl0bxG1FhW+KuMUsg8MaxtRDilttK1WdtOXFcxbvKrxQg5Lru+qlES7K3RT2Mfq+JKLg2eZxumFlI6oO/y1lzu1CJzksS1AvxGCqpzCSSSCrjPyqwoeHdYCWPUs4iC10St4DsWqwxY0cCYA/1uSumbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/eoUE4q; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/eoUE4q"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69c7c8accffso12743143a12.2
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 03:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784370695; x=1784975495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MnN8DFBWo+ZvzL83jibfwGEyO0GPb5UkEb4CK2Q5G2Q=;
        b=j/eoUE4qbEnJANYSthfIVI4he+kxIMUXRW5hs8cVgi3BkA3lDtEF/3zSe4B+sxUVsw
         FMvggYSBqjM/auKKZ3YNTQsdg4Xrj3liD4wKx+Z9QXjyrne2RJBxprf18hlzPntgqtvw
         01vI4F72oSafff37XeXKaFV5a0HKr31nQ9T5kuO7UaXHWpL09WkSrsC1u/9tOaKG5jHG
         1Y9cnYQ72huLHLzlzEDo4Jd5Xmy0YDHzlnxqDa3ilSWWZMdvPAJ6PYbep7w+n2hCCSeC
         klKnKL7LSVEJ7k9sXJV7LKYkIAauykotAzVHOKgre2sMd7k5QkMIjgvbEYhTfB15+IKW
         GZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784370695; x=1784975495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MnN8DFBWo+ZvzL83jibfwGEyO0GPb5UkEb4CK2Q5G2Q=;
        b=P2apilQ1kAJTE3ISAjp4jtaD+KwxZgR+CNt8PUSLG5DOSU7mi6KeH7BP5EXIEb8esj
         afn1GFhVcC6r5YVkt2lx3TeXLI33AQE4Aq9hVCakuVMDudScHhOq4mWTfY0JXJ2j7dTY
         jRyAD5859rpeJT6BOya+SkJe5jOJ//CKqpIvp0/Neb3NYqn6/p1DPnxiOB1e4XIS5Gnp
         sdcFTscPNJHv8H8dQeRKFx0TfR+4akLt7MsRwRGTj/7ohYdcXpheQ91UTZ+GyxMIpWXS
         KFXP/pce7+pUUCSESlcic0cAmKsOoW+01E2KsjBASK04FBMdsMYxwXdIVmiuQk6ozsWV
         3QXQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbLd4EtakO/Cx0A7SZFGV281e8ksil9FYckTGkw5KcVg7VmbDn5D1OEgdK4nKDCisybcHa+f+nxus6Iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLih47clSdk3kP0Dz0ApxBb/8XvTKOzVJTR1F8F1YHi0+W+O/a
	Wp94nuzFYewmgOvierqu/arCXZbl3lrUBMAz1FVMu1ezoEI+dr0Helia
X-Gm-Gg: AfdE7cly9Y6zYYqloXiwx+bgMq4qG4dQrrL6HJhZxxVpcZ/pBked9YIfvZn/o8wdAeh
	bB8pgVWB3l+8vlvjeQSb75CxxSkXifnPwF97y9lcn3b5iS+1D3Jof1mBFFAMvFnhpcn6TfLw8re
	Twm8U99x+BBhWTjFTqFZWuxzrQBEI0CrT6zRGo/Q1tkAZTCk1Oy2ori8/g5lOeL2TZMMf0TbSgd
	Uq0NnrZamDZezh02szvHhqN3sIRAACcRRv4/lv2GEptYGhWM5A/MVbU+B9mMBaVlzpOfq2h408m
	0A2jDdQ5ltO0RAx8iswBTh3ONQVpTw57JV2roe8mv0zypMTjvlN/fhTFUuJ4E4nHSNxpLJGhWAI
	xd1QZGTsQCxKsGrBaqi8UQSU3QFBN7QEfbJNINg/mxVcnNWE8bfMpJ7AxIgHNzSl7bsvUuacxaa
	e5n5tPjid8cfotsjuGQ7aytZVigDP8+2q0+iPkSd1bJVwAKhcc1q+SSuAa1uopY3Jf5A==
X-Received: by 2002:a05:6402:21c4:b0:698:3fd4:47da with SMTP id 4fb4d7f45d1cf-69e652e2951mr2283610a12.26.1784370695352;
        Sat, 18 Jul 2026 03:31:35 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000688dsm2086673a12.29.2026.07.18.03.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 03:31:34 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2] staging: sm750fb: fix mono image source stride mismatch in lynxfb_ops_imageblit()
Date: Sat, 18 Jul 2026 15:31:03 +0500
Message-ID: <20260718103103.18082-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sm750_hw_imageblit() advances its monochrome source pointer by
src_delta per scanline, and computes the correct rounded-up stride
internally as:

	bytes_per_scan = (width + start_bit + 7) / 8;

Its only caller, lynxfb_ops_imageblit(), instead passed src_delta as
image->width >> 3. For widths not a multiple of 8 this under-counted
the stride, so the source pointer fell further behind the real
per-scanline layout on every line, corrupting the rendered image.

Rather than just fixing the caller's calculation, remove src_delta
as a parameter entirely and have sm750_hw_imageblit() advance by the
bytes_per_scan it already computes for itself. There has only ever
been one caller, and that caller was passing an out-of-sync
derivative of the same width/start_bit values sm750_hw_imageblit()
already has, so keeping stride as a separate parameter served no
purpose beyond letting the two calculations drift apart, which is
exactly what happened here.

Fixes: 81dee67e215b2 ("staging: sm750fb: add sm750 to staging")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/staging/sm750fb/sm750.c       | 2 +-
 drivers/staging/sm750fb/sm750.h       | 2 +-
 drivers/staging/sm750fb/sm750_accel.c | 6 ++----
 drivers/staging/sm750fb/sm750_accel.h | 4 +---
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c..da0b4979a281 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -261,7 +261,7 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	spin_lock(&sm750_dev->slock);
 
 	sm750_dev->accel.de_imageblit(&sm750_dev->accel,
-				      image->data, image->width >> 3, 0,
+				      image->data, 0,
 				      base, pitch, bpp,
 				      image->dx, image->dy,
 				      image->width, image->height,
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d2c522e67f26..83229fe155ec 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -73,7 +73,7 @@ struct lynx_accel {
 			   u32 rop2);
 
 	int (*de_imageblit)(struct lynx_accel *accel, const char *p_srcbuf,
-			    u32 src_delta, u32 start_bit, u32 d_base, u32 d_pitch,
+			    u32 start_bit, u32 d_base, u32 d_pitch,
 			    u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
 			    u32 height, u32 f_color, u32 b_color, u32 rop2);
 
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 0316ea69d009..bac9a209899c 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -288,8 +288,6 @@ static unsigned int de_get_transparency(struct lynx_accel *accel)
  * sm750_hw_imageblit
  * @accel: Acceleration device data
  * @src_buf: pointer to start of source buffer in system memory
- * @src_delta: Pitch value (in bytes) of the source buffer, +ive means top down
- *	      and -ive mean button up
  * @start_bit: Mono data can start at any bit in a byte, this value should be
  *	      0 to 7
  * @dest_base: Address of destination: offset in frame buffer
@@ -304,7 +302,7 @@ static unsigned int de_get_transparency(struct lynx_accel *accel)
  * @rop2: ROP value
  */
 int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
-		       u32 src_delta, u32 start_bit, u32 dest_base, u32 dest_pitch,
+		       u32 start_bit, u32 dest_base, u32 dest_pitch,
 		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
 		       u32 height, u32 fg_color, u32 bg_color, u32 rop2)
 {
@@ -395,7 +393,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
 			write_dp_port(accel, *(unsigned int *)remain);
 		}
 
-		src_buf += src_delta;
+		src_buf += bytes_per_scan;
 	}
 
 	return 0;
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index d15a40cacb84..4f609d6af0fa 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -220,8 +220,6 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 /**
  * sm750_hw_imageblit
  * @pSrcbuf: pointer to start of source buffer in system memory
- * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
- *>-----      and -ive mean button up
  * @startBit: Mono data can start at any bit in a byte, this value should be
  *>-----      0 to 7
  * @dBase: Address of destination: offset in frame buffer
@@ -236,7 +234,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
+		       u32 startBit, u32 dBase, u32 dPitch,
 		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
 		       u32 height, u32 fColor, u32 bColor, u32 rop2);
 
-- 
2.55.0

