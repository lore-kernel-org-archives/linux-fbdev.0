Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A363D75BA
	for <linux-fbdev@vger.kernel.org>; Thu,  9 Apr 2026 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750331; cv=none; b=jaEAqfUJPkUg1UEm+gq+Rf3/MJXl/dRKLmLzbwPeVPVdlpCC7ObFsMz7wjSZ8zGt+m+W5VA/pwA7uXPhBluThP3RblKi4Ko/V/c0i+z6/sJxZhJj80BSLDsK2FLyW0yRhN3qXM0mj3wKrcc+yI+WINaPtQi75D6MLXtMhi2i1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750331; c=relaxed/simple;
	bh=4RJcvPMyl5PqcgPXvQ4VGCjMXYk/SloNlz3pAdCeCTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kskLZirMRo0vy6qYO1mqywpLlCAkhMcUulNu41RGww7bAyfe8x7+jPPPpJsK5qyInNNNqqVl7Nqp7MF7Y1NO8sTxWkg5+fn+EGp8W/0y4GkmuEHk+25OLiN5MN5tFnlCQXTnWKu6LqX1CAU4Y8UOS9yW9i2ksAeD+uD2ku5liZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asxpOu5V; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asxpOu5V"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2c56aa62931so1542147eec.0
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Apr 2026 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775750329; x=1776355129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XM2RE5mSvaPlHGre9Lf8kPtJSxgysytky2N//YtXII=;
        b=asxpOu5VXcDxRN439sXTJlxy+j1jgih0hzyit/iWfZuuDxiraSnyalO97M2C6NGenO
         y8ltdxFTQwmt0jtcSggm/CBtVif9FEpdc2CmWovDV7RD5W+X18+YhbC4RuaRKk6amvsM
         KuQadEGgCVV0HF7XnN/L1xHbr1MOCpQd1ozL4PvXz33QB8Rh6FWs4cCrQu62ZKs3TFi3
         2e7mIUkffqlzI+0tptZDdA7ltMyO7bk6YUfAbEEosroowYjghtT3DFLKS0OV1vLf3fgY
         OyUGvNWPfkkzRDBX3hcQF3NIWdSVEEY5HbSlp/nkaqcvBtdwSTvNgSenrir5OK3YxqTg
         7hgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775750329; x=1776355129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1XM2RE5mSvaPlHGre9Lf8kPtJSxgysytky2N//YtXII=;
        b=d3HiwDB9D7yFDQPjEVWoPKlyJ5PYF9tj/r9qbwR7aAJkfPyBjDhbdynQobSswNZGLB
         Q6L1wbeQAxoRjEIvPMnVdHtqwuWha1cLbX93fQ7BUiSOFbyqPIfTDuzHCXWABmeWGYmr
         ARvUqmh9tuToNARlQEF4Gwe3x5sHxAfJRWe13YIMkJRwDXKQhEyMgvFZzU07s/laqSYD
         GQYV8UcIUkgwmg6KjmuPHLx2JodX2+TAV6H1iSeJbgY/fNLVSH44T/tCDA9IXYDwBb2Y
         /yZNTjdLLRQ6thXmQkiKyUD3orlypPvrLnNVPueBd7al5bjPCc3Qg0delnh7h5n25ioI
         MvHg==
X-Gm-Message-State: AOJu0YwdLpE0Zvor8NoNSq9HPMVt69C6PABe3MVTDxHufOflaXLOn/DO
	8+VlPhc/TL5rP8djDBkA6IRNUhBNwnvDBuwOMbycKoDXhtw3CIVqMnTr
X-Gm-Gg: AeBDieuX9HSPfGd9eX8wwez6Rx+RU4zQp4YfyeKUa+IFazgJFEL9Rt2K0qhdZJ3zZMY
	b1drUSe4DRtMwdhhJL0NCi3N+pDL0S9UunCE1UgspRCNrXdUlRuAVMTLRGxn4gDIEjuBn/fuy0H
	Ay/zmOV/cg2xNyfBggpbcThHisqHTBgVolrh8jE7aKfHpeFT56CI3/WhVNSrtTw4I1WPn2b1WrB
	3PoRnwiWmSSaDEbhj9CNT08MK6f15zRDQGwTE1d17fGEni+cbmbAL3OrxfbgJCsdBiPj7mTB3nT
	0QVcQA9mJrO3XdyPtBH43SPOrNs0J7LHKO3ncxvXrG8BoonKDnE0CiWy9VL9w89Ujznlo78MH2M
	JKrrniBc8DpYxlDSUtVWXjcikkV9pDdNjKstCYl0BJKPa9EGvwIk5EVcah1CNdVikWo9FFEUIjn
	0i3eoaw4Xdeh+r33Hchfm+sKZkJaLX+NvbyMFKBbIGe3nJCYDcgL3RPQY=
X-Received: by 2002:a05:7300:bc86:b0:2c5:a6ce:e534 with SMTP id 5a478bee46e88-2cbf9fe1d45mr14374181eec.8.1775750329282;
        Thu, 09 Apr 2026 08:58:49 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5621d5e43sm153746eec.21.2026.04.09.08.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:58:48 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2 2/2] staging: sm750fb: propagate error codes from de_wait()
Date: Thu,  9 Apr 2026 15:58:21 +0000
Message-Id: <20260409155821.23375-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409155821.23375-1-dennylin0707@gmail.com>
References: <20260409155821.23375-1-dennylin0707@gmail.com>
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
 drivers/staging/sm750fb/sm750_accel.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 0f94d859e91c..688ec262a8ed 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -90,14 +90,16 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 		      u32 color, u32 rop)
 {
 	u32 de_ctrl;
+	int ret;
 
-	if (accel->de_wait() != 0) {
+	ret = accel->de_wait();
+	if (ret) {
 		/*
-		 * int time wait and always busy,seems hardware
+		 * int time wait and always busy, seems hardware
 		 * got something error
 		 */
 		pr_debug("De engine always busy\n");
-		return -1;
+		return ret;
 	}
 
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base); /* dpr40 */
@@ -154,6 +156,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int rop2)
 {
 	unsigned int direction, de_ctrl;
+	int ret;
 
 	direction = LEFT_TO_RIGHT;
 	/* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
@@ -263,8 +266,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		   DE_WINDOW_WIDTH_DST_MASK) |
 		  (source_pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
-	if (accel->de_wait() != 0)
-		return -1;
+	ret = accel->de_wait();
+	if (ret)
+		return ret;
 
 	write_dpr(accel, DE_SOURCE,
 		  ((sx << DE_SOURCE_X_K1_SHIFT) & DE_SOURCE_X_K1_MASK) |
@@ -326,14 +330,16 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
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

