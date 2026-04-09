Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977E3DE42C
	for <linux-fbdev@vger.kernel.org>; Thu,  9 Apr 2026 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775745720; cv=none; b=n8t1JLsGRmwM/bd7S/j+0UzVUIPQNXWnhJIgboF2YtiPdKJDYyWp/85b8JmyupnhuFKjk3pvltP0YPgDbWsyMtmnD79W7L4xNDvekabQdzJ4gQhbrsc1CBe1ACoz4vZl0mreJhB+2MMWlLR5dx5n3hKNKdCzAvtMdTWGaz2mP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775745720; c=relaxed/simple;
	bh=/3dzbTa2yCGGWKMPTi/jtaZM33hFKM0i5biBd97LBEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gn65xqF5DEVuLzLR8tiXSvBOSGMiVzRl1HJ+WKTF+fxEGU5dQaSOhJuZBCbF1HMS9TJJQyC1dmZ5h/GT4tmi/n4pMlZ334QmJAJvg7BZ4Cp9fni0DX+AByxVSXjht64iegaObHmg3ShsvUL7nZ0lNICATiYzANnQChmWyUp0M2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENgVUY9C; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENgVUY9C"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12c20010f10so2252166c88.0
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Apr 2026 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775745716; x=1776350516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIq2KvgyVuLp71772xYiI9sgjjf9n0iRtxnyZ0QmOTY=;
        b=ENgVUY9CEoAPdkN+nq3QQUs+YzFel32dEk9a56UX7Yjlb+8teBdDzZgZ1/hf4yuouK
         hnJ0n99URewNJIxdBKd6zwZtKJ5CXgow/R+Ey8OKulIdwCreKZj4YNs77ZMHJFzhfsI7
         ebXLFt0bDbZdII6XsCQV/oGRWHIcef9l70GG9JS9LVMp/cKAqmbKrJGcCHM8HSpct9fE
         pfpg70pJiBTtbjWQvrznTezQAk18L0eh0GNJlRGK5YLFnTqNJtR3pRupSDzYA5CBEXMg
         zUQLBTgHk2ajGwDVCnc7RjVOQzGMW0er944p5LOFN9bd5YP8ckxK7jw6z1fK82LZSkq4
         Rexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775745716; x=1776350516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cIq2KvgyVuLp71772xYiI9sgjjf9n0iRtxnyZ0QmOTY=;
        b=O27oE2GpDw0bq7v978FwWZtmT8NjUlwZBqnYCHV88N9xg+WCcy4jWIYpWH03n2M2iX
         MFrbSJPGG7ZjbQJmE7ENzbHTwKoOiclEKj8g/kF8NJmxWJ8cy1mC/9fbuAHoVCv2ptP8
         GlMbyuqKP7VWsHNgOyiytIFvOChMbwvP6RujSsaxc2mjcMqOYEEEJuvxYrA5FwMNPAhy
         UPsjgXGPhnRfRx3YouOy9QuarJCWjrAMbar+9fFtgfOWWdlgSvqCPsdBTH2NoGQ/iRas
         YuW18GVdGPotzRWmDpeUHfkSTLkXFXPOIskXGQoWw7l/lLDmqWR8MJYdiyRUY/SKfq4/
         GEKA==
X-Gm-Message-State: AOJu0YybHi/WvUmrY5htR7soAOYrAu0bEzQFUO6TakaiCBrm/N2yaT/A
	7/MxF6aj3nXlQH7SfGhuhD4lTIK8AdHmVLhd2Vn+mPav0PWfnmc1ib4X
X-Gm-Gg: AeBDieuve6pzctHTcPKDIWUr5DKLpu2lD3v3Q7LCQTR+YYvc7juCyxOiAkE8hwCzA85
	2FxRZi6eGUhMbS++yC7wpEQrLpZvNbN0NO8yRam9mjvmixT0OLc7i15kGcBNxCXfMGaqIz4Ke0P
	Wu0UI5QhGkBWGYpWwg3Aet49KRr0yePlNL8PgAsVB6vWotapCil7zxMoPHMzO7r2nFyzWQZ8Zjo
	ZXYTprlo2xJm+La+IL9OEw4fXTNGAO9aThw69Hhp5VmZ0T00luvf8n9ePP8ggbyZ0vn2MVvUFMd
	VJQak1R9bueLdL579E1dSKve+GIe/5nBBlIREHmtd6Jijjx/S6wFTMbH/L/LtC+Ogcjjw0rSs1G
	Hd1nqi6LsX81D3qw8wWqcfW0Bby/gUqc2oTvZ6wy8ZvrFLDmqOBE9KDPKZq8Qn4UZGJsNkSAIj5
	rjEuJdAFeJgmc1eOrxbn/Ur9+vLY8NCiaJ/W4SkTE6kcmUgJuxASk/rSCHCx64STmzFg==
X-Received: by 2002:a05:7022:ec14:b0:128:bae0:e03c with SMTP id a92af1059eb24-12bfb765c2emr15325531c88.30.1775745715490;
        Thu, 09 Apr 2026 07:41:55 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c07a8703esm20363284c88.8.2026.04.09.07.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 07:41:54 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH 2/2] staging: sm750fb: propagate error codes from de_wait()
Date: Thu,  9 Apr 2026 14:41:19 +0000
Message-Id: <20260409144119.21500-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409144119.21500-1-dennylin0707@gmail.com>
References: <20260409144119.21500-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sm750 acceleration functions currently return -1 when
de_wait() fails, discarding the original error code.

Since de_wait() now returns proper errno values, propagate
the error code instead of returning -1.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 0f94d859e91c..891d12a5e2cc 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -90,14 +90,12 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 		      u32 color, u32 rop)
 {
 	u32 de_ctrl;
+	int ret;
 
-	if (accel->de_wait() != 0) {
-		/*
-		 * int time wait and always busy,seems hardware
-		 * got something error
-		 */
+	ret = accel->de_wait();
+	if (ret) {
 		pr_debug("De engine always busy\n");
-		return -1;
+		return ret;
 	}
 
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base); /* dpr40 */
@@ -154,6 +152,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int rop2)
 {
 	unsigned int direction, de_ctrl;
+	int ret;
 
 	direction = LEFT_TO_RIGHT;
 	/* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
@@ -263,8 +262,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		   DE_WINDOW_WIDTH_DST_MASK) |
 		  (source_pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
-	if (accel->de_wait() != 0)
-		return -1;
+	ret = accel->de_wait();
+	if (ret)
+		return ret;
 
 	write_dpr(accel, DE_SOURCE,
 		  ((sx << DE_SOURCE_X_K1_SHIFT) & DE_SOURCE_X_K1_MASK) |
@@ -326,14 +326,16 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
 	unsigned int de_ctrl = 0;
 	unsigned char remain[4];
 	int i, j;
+	int ret;
 
 	start_bit &= 7; /* Just make sure the start bit is within legal range */
 	bytes_per_scan = (width + start_bit + 7) / 8;
 	words_per_scan = bytes_per_scan & ~3;
 	bytes_remain = bytes_per_scan & 3;
 
-	if (accel->de_wait() != 0)
-		return -1;
+	ret = accel->de_wait();
+	if (ret)
+		return ret;
 
 	/*
 	 * 2D Source Base.
-- 
2.34.1

