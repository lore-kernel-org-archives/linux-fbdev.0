Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B51B87C9
	for <linux-fbdev@vger.kernel.org>; Tue, 12 May 2026 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778562486; cv=none; b=qfWjAL4qzSJK8gmnQ+DpNAmm+q2d2DjceBZg4miZope0Y7lJPSoSEC4kJQHIVEi2jYc9f0PGgOl8jd6fFc0XQQ61OXLXMipLYn9BNFGnoifqfBk5WoVdTQdWyUjQ5yKxmTLl7/v1oHU11MIgpTy3gP27SloB0iGPQheb6wMelm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778562486; c=relaxed/simple;
	bh=BAuthF2Z16WH+zfDEHk3KKdJ2eXOVPk1jSTNkvFdwRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bxv3FWr31xjMuvHYpc14UZE3jkHDK/uF66HPOgBaLMQ4PpDbWEZrrSDjBSAEz6IoxO5c5EiPqNfdl1/P09AIPs452DT0EzQXgatbN0/v+FrqGwqZWhXBy05qlAQ9qV2e6x0Zds0wwr89Dg/BzwhYtMrOh/gRrqdKCYhw/dAJ8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1eFl37/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1eFl37/"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-83945063f70so2719272b3a.0
        for <linux-fbdev@vger.kernel.org>; Mon, 11 May 2026 22:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778562485; x=1779167285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=upF+QNLvJv5Mrb2znPY+HkCjKz2u/xiqje/4qNyRhbA=;
        b=D1eFl37/xQBJMgrXHEcTK0g6LC+BzwhyqLqu5Pdglj5ZSXK+q+9luZ0EctU8sQFDIr
         VhkPUZJMtHDcCR/EJ5Y5CTPBRLF2NmocXKmMHOQJ44eLgODSX6n9FAEFkseotTwyJ+s6
         qrvTZEsa1MB2UF7uN80bOPTQYvyn/g7Ae7UyQcFrNNmxqpEsAKQNsE50RtYkGTIMNAvG
         0DJM/xV0OO/yeZyub7iMLaByauvNaRcc2o40qHfI6sY2x1jQlr1fEDrq9xay/xOsBbKg
         dumZGaGmopKy9HBJ+rIV+WypnJi+y4DrMGfw192WP4kVJ9q0Y+TLa2HIpvTecLJE81Fe
         RDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778562485; x=1779167285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upF+QNLvJv5Mrb2znPY+HkCjKz2u/xiqje/4qNyRhbA=;
        b=frvybZQoF/5zuIuqQBFevKhiv157VnBbEclel5mCZm0n0lpG+9DHM2RxpA68jBjmDG
         0JTNEWSnjAmy9gCRD6gGzV7BjMyKZPH/gXG2oU+d7CXasIIF2kfDkS8YgufRfhJvxF99
         v0uZiEkdsPRjTX40WVLDhf/oy/0jt4oqeul2Gq1WXqqYNu/ecZMsHivlZs/L6GY7zahA
         Kky+aNGpUbnA37/pnj/mps7LGHXiW/imTlJ9bX5X+Oq/3OOZO83887KPj1n/N4QIe5wv
         11ZPcavIJHSjoA1hXSuOuaotU39wrEFnV2FLge1XBiOuA80/SUsisnLDniWkg/VJRlWk
         iaRQ==
X-Gm-Message-State: AOJu0Yw5Y7MsI7XKNpvLdkvfaz10MuromuYBv5g2BCw1nsjEx29SKFAj
	KDKbjkdhKhZaqnHk1eO9Lp0BQM0fKMJjvm4cacFW9ip06kvQ5xC2xnbo
X-Gm-Gg: Acq92OF4KBMH38ZADC1DiGjoKL8JYU/ZrI56mpvjHpJanMzd9rDl/iqeeWgucMrUw0K
	W8KDV7XguDD4xLk4hPfK1SropkvJN3rB9MUCSywhKl/enstxbYnGTS/TSH9k/oVx55n2wH6i4k/
	hzTjL19p0s1/0zfl6jlPawW1OCFpX2EEknDLS6mTfZPgA6gP9mAG+hYH7W1iGjAgWaFr+DG7Trl
	oMx4HRzbf2ci6cj6UmND7zTjBm2JBt5iFVJn02zANZCY7LapR7OBE11mCHUAc5KnIjRmzZCLIFd
	Ih1lN7xgfDYPvpbnclbrXh0tilINwnKfKK9FOlRzvh1UBUolJAXSXN2a6MVmdTCzQ/3hSUhwk3O
	0kKUXY48dEZMYGdVjdVlCGK2SiwJHFy0NBEhOQP3n44RjPmSWeCjy/mzagvXQmbFr9mJRuToUOQ
	I2Wap1BGJkCbtFUmXMtzU2lu7QzKf6bYjNTb5YWGcazl/OV++9cWDYcWcy0WJRNnlZKtF9jvmMv
	hZgO0G0iQlBnnk=
X-Received: by 2002:a05:6a00:3981:b0:82f:39df:dd54 with SMTP id d2e1a72fcca58-83ee83021e3mr2137334b3a.8.1778562484707;
        Mon, 11 May 2026 22:08:04 -0700 (PDT)
Received: from localhost.localdomain ([2404:7c00:52:d485:aae2:91ff:fe57:5e15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c7b92sm21645449b3a.29.2026.05.11.22.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 22:08:04 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH v1 2/2] staging: sm750fb: remove unused functions
Date: Tue, 12 May 2026 10:52:25 +0545
Message-ID: <20260512050725.58408-1-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sm750_hw_cursor_set_data2() in sm750_cursor.c is defined and declared
but never called anywhere in the driver.

sm750_enable_i2c() in ddk750_power.c is similarly defined and declared
but has no callers. The software I2C implementation (ddk750_swi2c.c)
uses GPIO directly rather than the I2C gate.

Remove both dead functions and their declarations per the TODO item
to refine the code and remove unused code.

Tested by building the full kernel and module with CONFIG_FB_SM750=m
on x86_64:
  make -j$(nproc)
  make M=drivers/staging/sm750fb modules
Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
---
 drivers/staging/sm750fb/ddk750_power.c | 16 ----------------
 drivers/staging/sm750fb/ddk750_power.h |  5 -----
 drivers/staging/sm750fb/sm750_cursor.h |  2 --
 3 files changed, 23 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index 12834f78eef7..1f7e0ec1d02b 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -127,19 +127,3 @@ void sm750_enable_gpio(unsigned int enable)
 	sm750_set_current_gate(gate);
 }
 
-/*
- * This function enable/disable the I2C Engine
- */
-void sm750_enable_i2c(unsigned int enable)
-{
-	u32 gate;
-
-	/* Enable I2C Gate */
-	gate = peek32(CURRENT_GATE);
-	if (enable)
-		gate |= CURRENT_GATE_I2C;
-	else
-		gate &= ~CURRENT_GATE_I2C;
-
-	sm750_set_current_gate(gate);
-}
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index 5cbb11986bb8..1c4f054d7276 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -33,9 +33,4 @@ void sm750_enable_dma(unsigned int enable);
  */
 void sm750_enable_gpio(unsigned int enable);
 
-/*
- * This function enable/disable the I2C Engine
- */
-void sm750_enable_i2c(unsigned int enable);
-
 #endif
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index 88fa02f6377a..51ba0da0270c 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -10,6 +10,4 @@ void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y);
 void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg);
 void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
 			      const u8 *data, const u8 *mask);
-void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
-			       const u8 *data, const u8 *mask);
 #endif
-- 
2.54.0

