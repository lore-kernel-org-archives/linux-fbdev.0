Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82843374E6D
	for <linux-fbdev@vger.kernel.org>; Sun, 13 Sep 2026 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789272121; cv=none; b=WyP5ZtdAJny9JHJilg5IKaWbpLdpkg4o3c18Wvq2MKS7VnamCzmWbl9ZO6lZYlmfOF/iQLXbJHQHIYULsTBzqNOUkP8893nwsZ3NGazTTeuwP6pSWLDcQPNPmMmciDFD7nfOKR5sdoGFBxms+GAfPjGniQdK4NvzjPSHiZeWjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789272121; c=relaxed/simple;
	bh=qOU4mOdJZExzY66rPx/p4PHpUpxs+QTxG3UNNWTlklo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGh8qswmvlqaLXpjM3OMa39wlMVtEzdhL2Wh4PYuIBQTaDKXqtqaLAvL6L1TZk3qK3JbkTyHET8oTDAafiK0Tm4REPLUirSuylF2INzouFkO2W/fmMqYq8K3xvkxVt/joTOppuPoyxdBFdSFk+CP5Qer0tH7ERZfG+AuZ06kwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL784V58; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL784V58"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8692a8568e9so683855b3a.3
        for <linux-fbdev@vger.kernel.org>; Sat, 12 Sep 2026 21:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789272120; x=1789876920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IUaIWeESj5beJuigMXgXrhS+tGPcUhdzld8fSkS1OKQ=;
        b=KL784V58wIuDnuXqenQLvuL5orC7rXdZDhrkOMhD3a5ZjhJ4B+UoScneZ0tdsuefrw
         Pf/ar54hPmTOfNbuxXCw+6F0imtvjjsgyPTbfftAnotrva2gj6wRZDU1n8og1pm4U5hB
         Hjsf6xVhcGaHbN2lf+QTFGr5CXfh5O8CZWzE75Ku3LZ7j/TTdliwIV2rS+P9bjiAmKog
         kmIz6jg1S4qQAxppQ3yjfnLBbtjlj6Pu+EwjMlQZgk0ucAdEVrNf9sXPqLekn1/cmKgj
         L2+Xf39HUUewqb4ZXTqRsIvWOBZdyjQ6Yx1lacE/pgfkIjeVmtcKqYvf3hXp+mTfAZvE
         EGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789272120; x=1789876920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IUaIWeESj5beJuigMXgXrhS+tGPcUhdzld8fSkS1OKQ=;
        b=ZjdXaaq/zG5qbuV4iPPmVPHX9Wwgcd+uz+94PXb0nbOBfeIwcIB/j2OJMrIwRJY36x
         2YVMkTgXsfiNk2wkbzO64o+UjlLI2ECpaoI1VdoJ6/ir7HT9wR4xMUhO7qNFDC+ZWXYK
         0zNIbmOk6pkDl0MuvLx0p+RuRMaM4F5aR3EX5freAsV/U3dDsXxYqR87DoRo5uiWsSjk
         xKqICRppiq6ekNgsyEcN3hDu4i+HkuEcELyx98N6Nfx+hc+bGXDMPJlDuYixewLR6gW7
         bnT+h2mrAvyfTBKD2PWKp9BUQWkQ/ugDrdgBxA2O1QVQ3EsGQHbc0YHXiAL+LYFZwP4k
         z/OA==
X-Gm-Message-State: AFuF++mkd3pwejgT8bXZuL9kDZGY5EMBhP++wRBZvx+ogWaUc4kiPjw8
	3yTTjpYmZpyLNL+qvPVFGSdfbNB/WYaw67sm8+jwKqpwJqLYDLZFEEja
X-Gm-Gg: AYBFou05+mIUsm6KPOgxjc9Z6eQojiFd/6PWmLGn0MzFu34M+2kqy3ktcb2loPCu6oh
	wPEaaSOYm5Gl7YR8oBhlzy07+C6GZDQ1GBP+lEnyZvvJmIC1veN9jCCJkFGDthFbwnPAWVlTVw8
	PwaHf8HSHMi37g+wpm9XDeuycn/zDXrtsGbxMlGMpS+6JgJKnC6xHkHkX6nRf5FlMUfMKfHPKPK
	g3Ld/pGw00uP/8cYYvkdjrvHabusLqX9nQxh0xcv9edkiWXSP+JnodZ5uIcGtmvtW5fQB2cV7R3
	LueHZ0rSS+fQn6m96e4CsDS/zNPpPa8YVIW3RYMr9hhZsqDZ2DZXjCJtVkCwgagwXh2fhz1RPhv
	HtnJ+v2yj4UPc8YqL0HO8fVk01SnS6H9eJJb0RcjeWAstsyAQ6XA4JT6ONaiFrUkkP4HoF3ZEuJ
	d6X12dCsiBNN2DkS8PtWiltxmwgUhsTl5Ov/FwiDZvgiB5nKKNY8Lc76YZ+f3m9XlE5DovVvO/r
	8RumYNU3ydJQnva5oGJcmomYTzLIzqgUOXZfXf+8XFCTqkvD6oKg7IHmKAVaqKcPdLrNwoJ+8Jp
	s2EwFM5dl9az9CeejarQFQ75+wKKsUJilSskkHpV6dx3h+Bfbw==
X-Received: by 2002:a05:6a00:3d01:b0:85c:2d83:bbf1 with SMTP id d2e1a72fcca58-86ccb44e113mr8738679b3a.20.1789272119714;
        Sat, 12 Sep 2026 21:01:59 -0700 (PDT)
Received: from localhost.localdomain (c-67-170-60-64.hsd1.wa.comcast.net. [67.170.60.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c659b9a3sm2957890a12.29.2026.09.12.21.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 21:01:59 -0700 (PDT)
From: Gabriel Changamire <gaberashawn@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gabriel Changamire <gaberashawn@gmail.com>
Subject: [PATCH 1/2] staging: sm750fb: clean up sm750_hw_imageblit() kernel-doc comment
Date: Sun, 13 Sep 2026 04:01:39 +0000
Message-ID: <20260913040140.4517-1-gaberashawn@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The @start_bit description contains a stray ">-----" artifact -- a
literal copy of an editor tab marker -- that leaves the continuation
line "0 to 7" garbled. The @fg_color and @bg_color descriptions are
also missing their closing parentheses.

Replace the artifact with a plain indented continuation line and close
the parentheses. Comment change only; no functional change.

Signed-off-by: Gabriel Changamire <gaberashawn@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 6db54c6526dc..a0fda56d955e 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -223,7 +223,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
  * @accel: Acceleration device data
  * @src_buf: pointer to start of source buffer in system memory
  * @start_bit: Mono data can start at any bit in a byte, this value should be
- *>-----      0 to 7
+ *             0 to 7
  * @dest_base: Address of destination: offset in frame buffer
  * @dest_pitch: Pitch value of destination surface in BYTE
  * @byte_per_pixel: Color depth of destination surface
@@ -231,8 +231,8 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
  * @height: height of rectangle in pixel value
- * @fg_color: Foreground color (corresponding to a 1 in the monochrome data
- * @bg_color: Background color (corresponding to a 0 in the monochrome data
+ * @fg_color: Foreground color (corresponding to a 1 in the monochrome data)
+ * @bg_color: Background color (corresponding to a 0 in the monochrome data)
  * @rop2: ROP value
  */
 int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
-- 
2.47.3

