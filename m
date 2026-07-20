Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2A3DD870
	for <linux-fbdev@vger.kernel.org>; Mon, 20 Jul 2026 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557602; cv=none; b=HdPcyPsJ9m2nRhUvZFiPzd3J1Jql0DItfp7Bam75lzlgNlRWccdHNZ5oe2BT+mpByxxDN6ThzBC+sqhlTd9pT7JGFIG7CqxQrsktAevdXavHRM0vDdShYahq7ZtqOUEadrupsjFnX7c55a+lk+vi6tW6+AsyTqTX+4xoxAPHj3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557602; c=relaxed/simple;
	bh=p/jPcTmkeeX77iSaCsL7N9400sQYSGpluXtQkUOG47c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRB4UTw4ibvjJ2HSjzN4BxJODCFXdNnYGafBgNOJT7ibcL19LIA9kI+KD+XdA7wzDbBs9qHvEtEAu5UdaUgnl6KGVg75XbDoCB5yIJ+Mv2DfzBm5wEG0D0Y7FwMF3D9KV69bCgI+UIPFONMJZPOkELbEcSSHaYxGMNm3akECdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbPYsl1n; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbPYsl1n"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c95d0a54ea5so7460461a12.0
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Jul 2026 07:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784557601; x=1785162401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QpEdeGGLeSN9RZd1dNw8hRrHTwjmNFcu+OQpMNS+88Y=;
        b=LbPYsl1n63Jr6qhgMWoR5B3Z6O0UgO3MeYuiFXJ+zeE4Hl4L1rjoY4HTQYMRJn6364
         ZBue+uqmPzHj82c5EuLaNRLu99eXFmpjbUYxNgzld7rp79xY32QzmpM571B/9R/57XIi
         nrkL8983Bp0wp6VwDholNtlLF0DoEFS+1LGpNfIhFXi2kf53gmeDfz3JMVYxCelsZVAD
         425zmJCqpRYEcHZj43JGK2RRi6EaIOZt6Ur/kSb3CTyyIlD89JafqRWimPJifgtMe6av
         5+6p53ziy/MAn0EsPlqdaryUmR23qR8YHxbTCYrqyasrCoiuLalnS/otPoS43eSvHKb5
         myDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784557601; x=1785162401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QpEdeGGLeSN9RZd1dNw8hRrHTwjmNFcu+OQpMNS+88Y=;
        b=Ie8ekb/DWC8mhxh6R8+XGfsXUmg1tp8q9TXs9rclEuGW+aGX2zhah1sc0VsBE94LLr
         YKAPaP62DU0s2h9fEOz4dU3VC3YEfSQCQwll/LkmShTqD+B4grt8IRdfZgNRHph8KjyE
         D+WkVttEi+nL5/j/lp/wkHRdYrHSuf62PkQmTCauHpvkO9qsbtF5uuuLDxSosap7SMgt
         VZn9SnQdeC5DJkWw4g8ZG2dHdkm0ZotZeLLMQXwEn5RIb5wkPc4WWemtPp2H8FbIW6xX
         HX+BXhlm6yhLTqXPHhRrlJ4dYKPTtbDX5Y6PjJ9oSl79QokZ0RAEXM0jeY1JdOVpPiaz
         vPmA==
X-Gm-Message-State: AOJu0YwL3BbT3sGuD2pqQtyuTRZ6licJBD8u4oS5gfnvuphdRfYOURhQ
	LlvjU0xdHygYwkmR6pL+TEqJEU4YJcfKqiU7tQ2gO6oR9TgwQheNNGQY
X-Gm-Gg: AfdE7cnbWYBkzk9/5keJ86ncmqDGI+jBHZGHA7MfYs9EUezq1doOBU7xwkG5DQHxiFc
	iZUZBBFnwqdYpG5kQEFysF11hyqaUyDQn2a+KasWSPBVlATPyXqgNGqCvyyIciFZ/K1i15YmP9/
	qxcp4L++YdSo2sIR3+79xvIXq0sRJXXYk3SFCH1E3X9QZqQtsOrTr2bww+Y18GhGRfyAoFVos7n
	4TJZ3BJdgK7vocMmLDGvSU83ORA1lR5OK5NI2pSNKcKzK7AV2VtiDipNF38pdKBOG5cqO+kQqsF
	y+bYAQov6QKTOXHHlhFsUw8wvWGKYmlfbe+ZkYO0h83q10GtNWhQ2dGHfjwOnmaZhdyg0LIPMPg
	pEu/TX6d1kZYtihLka/sPjuD53zUI1UfkauoZEwDi7x7ImvySZgmyWz+p2H4lTVV8qdXCE9hyuZ
	IgvA==
X-Received: by 2002:a05:6a21:484:b0:398:6ea8:21d2 with SMTP id adf61e73a8af0-3c3ad7a2ebamr16040253637.19.1784557600692;
        Mon, 20 Jul 2026 07:26:40 -0700 (PDT)
Received: from PC.. ([103.172.209.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9d444sm43228050eec.6.2026.07.20.07.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:26:39 -0700 (PDT)
From: Mohit Mishra <mishraloopmohit@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mohit Mishra <mishraloopmohit@gmail.com>
Subject: [PATCH] staging: sm750fb: Align prototype parameter names to implementation
Date: Mon, 20 Jul 2026 19:56:05 +0530
Message-ID: <20260720142605.63454-1-mishraloopmohit@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The declarations for sm750_hw_copyarea and sm750_hw_imageblit in sm750_accel.h
use legacy CamelCase parameters, which do not match the snake_case names
in the actual implementation in sm750_accel.c. The de_copyarea and
de_imageblit function pointers in struct lynx_accel (sm750.h) also use
outdated parameter names.

Rename these prototype parameters to match their implementation names.

Signed-off-by: Mohit Mishra <mishraloopmohit@gmail.com>
---
 drivers/staging/sm750fb/sm750.h       | 10 +++++-----
 drivers/staging/sm750fb/sm750_accel.h | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 0324778768cb..cd34d7f82c64 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -57,17 +57,17 @@ struct lynx_accel {
 			   u32 color, u32 rop);
 
 	int (*de_copyarea)(struct lynx_accel *accel,
-			   u32 s_base, u32 s_pitch,
+			   u32 source_base, u32 source_pitch,
 			   u32 sx, u32 sy,
-			   u32 d_base, u32 d_pitch,
+			   u32 dest_base, u32 dest_pitch,
 			   u32 bpp, u32 dx, u32 dy,
 			   u32 width, u32 height,
 			   u32 rop2);
 
-	int (*de_imageblit)(struct lynx_accel *accel, const char *p_srcbuf,
-			    u32 src_delta, u32 start_bit, u32 d_base, u32 d_pitch,
+	int (*de_imageblit)(struct lynx_accel *accel, const char *src_buf,
+			    u32 src_delta, u32 start_bit, u32 dest_base, u32 dest_pitch,
 			    u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
-			    u32 height, u32 f_color, u32 b_color, u32 rop2);
+			    u32 height, u32 fg_color, u32 bg_color, u32 rop2);
 
 };
 
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index d15a40cacb84..25e5703b6774 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -210,9 +210,9 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_copyarea(struct lynx_accel *accel,
-		      unsigned int sBase, unsigned int sPitch,
+		      unsigned int source_base, unsigned int source_pitch,
 		      unsigned int sx, unsigned int sy,
-		      unsigned int dBase, unsigned int dPitch,
+		      unsigned int dest_base, unsigned int dest_pitch,
 		      unsigned int bpp, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2);
@@ -235,9 +235,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
  * @bColor: Background color (corresponding to a 0 in the monochrome data
  * @rop2: ROP value
  */
-int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
-		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
-		       u32 height, u32 fColor, u32 bColor, u32 rop2);
+int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
+		       u32 src_delta, u32 start_bit, u32 dest_base, u32 dest_pitch,
+		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
+		       u32 height, u32 fg_color, u32 bg_color, u32 rop2);
 
 #endif
-- 
2.43.0

