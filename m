Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4D19E96D
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Feb 2026 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893933; cv=none; b=Te2YtPrgXzOn8cZASqlCteETPe5ZUjTszLMcSPdGhW3wJprfVNMXHPCfl2bNm+yypgS52EoCcqO+2BK9qOEuBdc3VP9U5Ex6ID+q3QHNy9kGCjKKw9kiezrSYf2qxu3XJIghXTmwFBsx6fLz4LyZ7V4gUmSzXUUvo6xZS7TvXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893933; c=relaxed/simple;
	bh=a1z+97/vHRcASw/OXKag7SrB2RfIJ963YDrikpkR0xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9w/miGqgT192ehDoW4LpsyToRG3RYfsrWNp+xwlmz+fzjmkgZqd0YYXMIRQiCl4B6f+dsy4Rf/TxklanEQbYIPTC7uVMBkHkiCoeD8rRi3RGXkyCMExebNhTg2dFJAlPwWHSi6EywLw+weNy51GE+f0MxmhJpZepkp1vdZOdp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjvGQKie; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjvGQKie"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-435a510c211so481272f8f.3
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Feb 2026 02:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770893931; x=1771498731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K80USFJkDxuG6oGVG6r4p5kSvqwQuXJSDqWSf0wkVrI=;
        b=OjvGQKiekUAFXU/1I8CczsP669RQ3TRAdLspxQiLl5STazcre1Evr0I6wIw3w3GPdR
         d6qCaSXmZsREWe//jVH4zhF6idVkeIi1gDXLeOTb/S7Srs/KMAubY07jRIjJUjlHLDx/
         UmVlqvoWc9uhjwY3wizfru5Nc+d3g83HMSZLvDzRne8KUzb61A5rfCiMTIkZ5X9f9Kum
         wRIohcs6h06NVkoFNiK8Ujg76uuVsjXaJD5fHzUNlQM04gM5VXb1hCD7LKgNd+dKJCnH
         lQR71kkJRbKeZmaW+BkanDg54ZT68DYXvVNb57NrwdHq4DP+BIegebd+7+h/Iziuk1sY
         TUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770893931; x=1771498731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K80USFJkDxuG6oGVG6r4p5kSvqwQuXJSDqWSf0wkVrI=;
        b=TWxP3N8dSPaexXgbc5/EvlXt36PCfKZ8Wd6buro/DMTuazr/WFE8e88CYrR7hels31
         DjjSE0MQv97EYLVXgOcr/Cgapwn4NjIrQLSCFnDC1tbYKGawlMuL58JQQ3BAX3GTqhbR
         4mODpLmzUYH0bLJAuGeN66TlOuF/5FoICcvrH1H8eMH2ZS1pTdCVEwD/Ch2sX4eLRk5v
         cTtYl9AAlAMGbE3WX2FANRohh/0Nt82jH4ReSXM/RUu7mHtNWJJ/RkYC7TZfKK9eoYCe
         0Z6yoJgq6tIJaw+KYg4IaiV7tH6yziwIR/q6DmdXfeehDmGyvhpR22FTYqCopDPN2GmK
         2cTw==
X-Gm-Message-State: AOJu0YzIbWHXZUlwO9BwQpfFlm0cAXF8XFnqLrXrj1scTpKXh7Y1Z7FK
	MpNCIR5tHP9fIpixes8zK8z97X1dl2xASTW8OSV4z3T1UeXl6wP0kPO+
X-Gm-Gg: AZuq6aKsm01kJRpN+fZX4lHJDafxSay4JF1OhmGZlMRiuvPMfdKr89cmGSG0aGfb5qA
	McH45pE4rqD/xAGFIYbbqLXvqUOgLOBdqXpA4T42YryMdYGZr0Re0DvMTmueYqLVu1efAONkfXT
	OJASULVkNLZGRVY9NtaMjXqp5ZndgOc4fcHiG1dKKrESP9W2pA9zg4aGvZtUpyLjEON1dFjePSG
	8p1ImAt4m796BaOlU3EuoEIrRKRmYIQ0Yupba49fti3sXuYy/snxcrg+JSnlWcblaea8Irrbrgq
	Fou9k+rnIvFmzFGgc6ubu4LoEaYovBVWkBHcQCXArBUO4ihM1ChfggVmAoZFLTcdEjKwLZPMk3e
	d2ZSKX2TCS5qWIs9c2ZCY399vggKeYfYOdB6ssHFPR9gBcbSF4rHDEvladnMuC5TZSeUgUv75yx
	QftJhTrXdtgZE0fJi3LjyVMp2zb2pMz5ciH7GvLm3Ev4GMWHxNZard5v2XAHp0nc4TzWRB5dT66
	la28AeoBWWZjcvihKMkn8t+
X-Received: by 2002:a05:6000:1445:b0:437:76fe:abfc with SMTP id ffacd0b85a97d-4378ac71805mr2181903f8f.4.1770893930749;
        Thu, 12 Feb 2026 02:58:50 -0800 (PST)
Received: from rachel-VM.. ([31.44.137.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e5c550sm12089778f8f.36.2026.02.12.02.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 02:58:50 -0800 (PST)
From: RachelOvrani <rachel.ovrani@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	RachelOvrani <rachel.ovrani@gmail.com>
Subject: [PATCH v3] staging: sm750fb: Rename nDirection to new_direction
Date: Thu, 12 Feb 2026 12:58:42 +0200
Message-ID: <20260212105842.36431-1-rachel.ovrani@gmail.com>
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
 v2 -> v3 : Change the commit message more appropriately 
 v1 -> v2 : Renaming n_direction to new_direction

 drivers/staging/sm750fb/sm750_accel.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index e1877e5d0..c796d410c 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -153,9 +153,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2)
 {
-	unsigned int n_direction, de_ctrl;
+	unsigned int new_direction, de_ctrl;
 
-	n_direction = LEFT_TO_RIGHT;
+	new_direction = LEFT_TO_RIGHT;
 	/* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
 	de_ctrl = 0;
 
@@ -173,7 +173,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 			 *	+----------+
 			 */
 
-			n_direction = BOTTOM_TO_TOP;
+			new_direction = BOTTOM_TO_TOP;
 		} else if (sy > dy) {
 			/*  +----------+
 			 *  |D         |
@@ -185,7 +185,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 			 *	+----------+
 			 */
 
-			n_direction = TOP_TO_BOTTOM;
+			new_direction = TOP_TO_BOTTOM;
 		} else {
 			/* sy == dy */
 
@@ -198,7 +198,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 				 * +------+---+------+
 				 */
 
-				n_direction = RIGHT_TO_LEFT;
+				new_direction = RIGHT_TO_LEFT;
 			} else {
 			/* sx > dx */
 
@@ -210,12 +210,12 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 				 * +------+---+------+
 				 */
 
-				n_direction = LEFT_TO_RIGHT;
+				new_direction = LEFT_TO_RIGHT;
 			}
 		}
 	}
 
-	if ((n_direction == BOTTOM_TO_TOP) || (n_direction == RIGHT_TO_LEFT)) {
+	if ((new_direction == BOTTOM_TO_TOP) || (new_direction == RIGHT_TO_LEFT)) {
 		sx += width - 1;
 		sy += height - 1;
 		dx += width - 1;
@@ -277,7 +277,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr08 */
 
 	de_ctrl = (rop2 & DE_CONTROL_ROP_MASK) | DE_CONTROL_ROP_SELECT |
-		((n_direction == RIGHT_TO_LEFT) ? DE_CONTROL_DIRECTION : 0) |
+		((new_direction == RIGHT_TO_LEFT) ? DE_CONTROL_DIRECTION : 0) |
 		DE_CONTROL_COMMAND_BITBLT | DE_CONTROL_STATUS;
 	write_dpr(accel, DE_CONTROL, de_ctrl); /* dpr0c */
 
-- 
2.43.0

