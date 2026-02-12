Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9771519AC
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Feb 2026 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919455; cv=none; b=hGes6u5tvUh54P7bNUd5Y8nkjdR4a6O5YQ+RACeNdfr4sh9UCnRmrAKzDDePXp2m+goad518v1iWTe2i0JD9pEI7waDNpFwrcOH0RJK1mtw+5CkdiOb+QeKVf6vMidWzKH5DlXYx/Ed4rOY/43roE3vXFDC0p+Gt96i59PfwppA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919455; c=relaxed/simple;
	bh=TEU5ACtBivSpOWfnK6Sn/cIxkKLzyBH/+2XoKUoppMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kYuGplaDt3VzLQvCdSR+91jbNSh/dlCnGS+bbv0fNWthtsrfkMjmMQs142wz8Qm3znHb7M30wA4Mfy6plBkcMzBbBpIhE8X7YXE/luRzXpd6s0Zf74j6SiQJ8WSD0mZPW+BeesljwEu/M2rMql7hdoatx3LKc0/tzmGvOGK7VKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCe8G9Zg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCe8G9Zg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483708b697cso37635e9.3
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Feb 2026 10:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770919452; x=1771524252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h0wk2xsCrS3DaAr/gCoCsMedTcrkDGhrxiWMWwsv91w=;
        b=HCe8G9ZghgKQtNsUaRD3cd+vu3/ew9aGclsewE4AkGAgRXqdu0+WN2ZQLHg0nEc3Y4
         +weHumGz8PLDsw2f+cZo+ZDopUhvWHM1viIdsxbyBVbvVTZq4+N+wbDL45L7FW/0ft1I
         I97qZR3/z6LW3J+pk7VG+7CgF87XK9a3c7uv8W7i5XF8umWmTOMXgAi/QPyYHCPxdSpI
         mcGG1X7gKeXi7q1vCzGOABJNIIJSsOEHCLnxYLC5vM6Lahx8v/fabw1FCoYQmahoqGzl
         y+uA492htLYUP5Gelwx/wM6qJJzyPmz5yIh12yC8r24ao0GMsYwbMArLEbXEWyuhQKYr
         mKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770919452; x=1771524252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0wk2xsCrS3DaAr/gCoCsMedTcrkDGhrxiWMWwsv91w=;
        b=Bi1Fi70OUJvATDZXZPYeY3Kgty5iujxg0GJ9TUtuW2ERL9z3jhMXzhOe88t/YYlQ38
         WyM94OpsnVOkXwfR4F9Fa0JVSjSvUjJsvic6FkwNxIPGmIp99Wtk7402SanUEl66NVuX
         NtcdknJUcGxxS34F2vbHh5ZBblyismZNc4ymuX4srW0BOWmF3W6NZqVS1/Tc+LUx6N9E
         PA4EQ8AEHUgtJ/3YIhb4Yl0cZMSC9hAm0lbTXStwGfosE4YdoD40OhUjUiI6jtdkoy+v
         gAD/E8C9EZE8QO5KSb+hGUYHV+oF+vwXH5IlgUf/siB5h9cUH6cRx3TxTQ5v3uyT9aVA
         srgw==
X-Gm-Message-State: AOJu0YxBeW3qC5ttuGQPjwitUiqwvpDWHfsnwcg6h1WjleMJZqkDbZDS
	Q3gVAObTFHOOZtD9OMUrE/1LnLwapUzpw71s/stQeIvpm5DOkxlWPSnM
X-Gm-Gg: AZuq6aLrAkDp/WLl7OyWj3U4secAh4Q4gqgMhQLlqwl/AsaYD1/Ol+IFyXpDd3tkdQ1
	hKkrVp8arlVEdFzgYt1WRnl3U/o7TE6GpjdwiPN1cjik6KtLSYB8apoTxUYUbFByTS1mpOx8fhX
	Mrmp4O18B8dY0bTWWXH3CRX506SY73weSw/re1uvM5nnfE3TzPFXQF8Rif8qpjnsqqWaisB9RLl
	LywNFMPJdtfeaRNkmLopeykQJTRDJtisaYvc9rFVvtOtmllRDL+KXglDge20kNNWxDek+BSeqW5
	CJ6EldGD48JZRbXqFumKm1jpPvedaXrtSbmNITKfe7PXHkxQep48j6Y5XvaRuS50SfHCrMfJcUX
	uf1BMLN0jXdk6fVKIq6UIz+hOb2kGdS7SqoINtngAR9F7G1OCmKMmI3X+3QAacplnexNeoLSbgY
	hb1GrNP3AriCqKpGXgBvMOmaxL7F9YINAgE8ID2I8tcMRWun4qM2+Rsyq5v6Q8sVZvxwzmIq23B
	T6ZIWZiHqStcA==
X-Received: by 2002:a05:600c:474a:b0:477:7b16:5f97 with SMTP id 5b1f17b1804b1-48370cce47cmr111215e9.0.1770919452101;
        Thu, 12 Feb 2026 10:04:12 -0800 (PST)
Received: from rachel-VM.. ([31.44.137.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d34657sm15932004f8f.6.2026.02.12.10.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 10:04:11 -0800 (PST)
From: RachelOvrani <rachel.ovrani@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	RachelOvrani <rachel.ovrani@gmail.com>
Subject: [PATCH v4] staging: sm750fb: Rename nDirection to new_direction
Date: Thu, 12 Feb 2026 20:04:02 +0200
Message-ID: <20260212180402.69356-1-rachel.ovrani@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the variable 'nDirection' to 'new_direction'
to fix the warning reported by checkpatch.pl

Signed-off-by: RachelOvrani <rachel.ovrani@gmail.com>
---
 v3 -> v4 : Directly rename from nDirection to new_direction
 v2 -> v3 : Change the commit message more appropriately
 v1 -> v2 : Renaming n_direction to new_direction 

 drivers/staging/sm750fb/sm750_accel.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 046b9282b..c796d410c 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -153,9 +153,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2)
 {
-	unsigned int nDirection, de_ctrl;
+	unsigned int new_direction, de_ctrl;
 
-	nDirection = LEFT_TO_RIGHT;
+	new_direction = LEFT_TO_RIGHT;
 	/* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
 	de_ctrl = 0;
 
@@ -173,7 +173,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 			 *	+----------+
 			 */
 
-			nDirection = BOTTOM_TO_TOP;
+			new_direction = BOTTOM_TO_TOP;
 		} else if (sy > dy) {
 			/*  +----------+
 			 *  |D         |
@@ -185,7 +185,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 			 *	+----------+
 			 */
 
-			nDirection = TOP_TO_BOTTOM;
+			new_direction = TOP_TO_BOTTOM;
 		} else {
 			/* sy == dy */
 
@@ -198,7 +198,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 				 * +------+---+------+
 				 */
 
-				nDirection = RIGHT_TO_LEFT;
+				new_direction = RIGHT_TO_LEFT;
 			} else {
 			/* sx > dx */
 
@@ -210,12 +210,12 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 				 * +------+---+------+
 				 */
 
-				nDirection = LEFT_TO_RIGHT;
+				new_direction = LEFT_TO_RIGHT;
 			}
 		}
 	}
 
-	if ((nDirection == BOTTOM_TO_TOP) || (nDirection == RIGHT_TO_LEFT)) {
+	if ((new_direction == BOTTOM_TO_TOP) || (new_direction == RIGHT_TO_LEFT)) {
 		sx += width - 1;
 		sy += height - 1;
 		dx += width - 1;
@@ -277,7 +277,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr08 */
 
 	de_ctrl = (rop2 & DE_CONTROL_ROP_MASK) | DE_CONTROL_ROP_SELECT |
-		((nDirection == RIGHT_TO_LEFT) ? DE_CONTROL_DIRECTION : 0) |
+		((new_direction == RIGHT_TO_LEFT) ? DE_CONTROL_DIRECTION : 0) |
 		DE_CONTROL_COMMAND_BITBLT | DE_CONTROL_STATUS;
 	write_dpr(accel, DE_CONTROL, de_ctrl); /* dpr0c */
 
-- 
2.43.0

