Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456B47A0C2
	for <linux-fbdev@vger.kernel.org>; Tue, 12 May 2026 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567728; cv=none; b=XByrOE1xS6vm5tXKUx6jiQToJGbDRBGkKNNIiviW0vxkJNY4jxaSs7LjLfM3lGebPOoAKGEyFD8MMGzqpeOib/8r/4A5giDLfRy8guzO3l862W8hRuOGKx48RDr2x9MZ52ir6wnO01egAD6PpxM91ahKPbze4qlSuXtBMqIUbLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567728; c=relaxed/simple;
	bh=RfXyqAbEpc/Ebt1Tm5FG0xI5sYAI0W45gTZdDXhdGQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIFKCManz4TbrRORA14ItOkGwhRaFgVZ82zET2Ixo7dqaOTdNlAz+j/5cFtQQ+fDQi4WBgeKzhB/kDqE3oPV+W035RUaZYKdZO7xLiUwSvq3Kh4Je5dXH47j0xurhBYwXiTpzikOneBiBS/lq2IT1gG2Jxcd0zIrxUeqsWMoLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NN+a/XU6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN+a/XU6"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-367c2a39fcfso1657006a91.3
        for <linux-fbdev@vger.kernel.org>; Mon, 11 May 2026 23:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778567716; x=1779172516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE3c15q44/WMPZ4E65RvxWCHOUX7Li7yDwaf8XQdnfo=;
        b=NN+a/XU6F6YwxjkwImBqFKzlaoN6xcRbhdAzweHX5FhpZ7ZkWEKC39fgBrZ1yjHipk
         fMoLVH+tNPYaFN56RipWd593dvuI4sCfIQzYs4fPGfzNNU3bxI5NnZILghIvxFyLFvxp
         Vm/ahiufYXZ2XC94XdDfUAKed55vip9WBLHbpczphhofqDm86RjmT9zK2NT8NY3vB5NJ
         kEp2SltjZfUtrHj8yQlk9KNUVMPnanEJuRvxyg8qIF3kiwkiDspMV/HroqFHdre30N79
         S8x7oGQT0gtvx8JeZ5boQQ73L33BplQ8+LabUvgNBPnZu6gWwZMDhvaRg1AyLBnkM4fB
         1Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778567716; x=1779172516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GE3c15q44/WMPZ4E65RvxWCHOUX7Li7yDwaf8XQdnfo=;
        b=EUPepGtXk1/k4zgrMzTNjYrP1PRXYXpHxb/MOK6uQzDK3PeJq+Qx92xmCVaE0K7kpw
         reraxu/ch4g7w2lghgrxqbMNvfEstofUcM1/V6eEur5sStX89lxx8QmT1ZZd5vbjAUhg
         I5SX8j+gc7QIW1puLFLJ4YCCUK6u81jdQAWomA9GzhBkvJsJqL8HwtacN80S3wIVFIG9
         OzfXhQAz30fauWP/cst2uvchNNOt/8LD3df5zJnRsvZ3MRXMdRYxXWBwvV2FErC7Azzs
         yTcnOu6jPN6Zpj19QwvyRRctqgFILzToBCbDEMVitTeuwFVUseWQcmO1SXMw8xRjB0py
         NyqQ==
X-Gm-Message-State: AOJu0Yz/8vk5XUqm5NwWpIV0W50Rm5ZgpPe0D7CpZVjdFySe9yv1jk3R
	RbUPEvDF/pE8mbOTs2XSpluDZvp594WyFpRhgIFxAXflZHmCnrrML/sR
X-Gm-Gg: Acq92OF/An7xK3Rw8ON9j393JiwrPqHuJuIlLdbLA6rMMx71HXRIIz0NQQqsDA9r5+O
	JvjXqjBMH/99I0d5cqBFU2uXLVuQNv05I3pz2EVkHHjyI5vieSf+/Xd4fkfozdy9r7qOqVtoE1K
	cF6MYSO7BvYLn7ywAN/DTxhpxZp7F7LdqsVZ9E+2LBF+xr/j5IaDlZXzwnyhTW4uAw3GiL3TXNI
	Kswjx1zvTmV9vSglMDAkto/hymvY4sEuxNBymeXsc6yMHsfNc3ohQx+W2HGjfai3rkGNImxZsYW
	msktzCoXrjHBI6Jyto1OmpIdiT4rmhaj6dIdtjja2SuCvwZIs5/YPWHdMofP7kod6Jg47JhdrB/
	lcVEQ7+6kLWyLPS18XLcGeBCYmUQb6BDeHOxWLOwnJMQLuN6V7aAb1RgGBrMREdBkQ+A3FmRX+H
	hg2BNVnvqtchEBA2gb6Ql/APkjZSOkFK7pZnjmIn2vGhbljzTxbTQmnR9MoYniF0ItgFiBxEA=
X-Received: by 2002:a17:90b:4b02:b0:368:6ff3:6675 with SMTP id 98e67ed59e1d1-3686ff36c68mr6533453a91.3.1778567716567;
        Mon, 11 May 2026 23:35:16 -0700 (PDT)
Received: from localhost ([2404:7c00:52:d485:aae2:91ff:fe57:5e15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368b01ef884sm620845a91.5.2026.05.11.23.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 23:35:16 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH v3 3/3] staging: sm750fb: remove unused functions
Date: Tue, 12 May 2026 12:19:57 +0545
Message-ID: <20260512063457.80882-3-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512063457.80882-1-yogeshdangal66@gmail.com>
References: <20260512063457.80882-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sm750_hw_cursor_set_data2() in sm750_cursor.c and sm750_enable_i2c()
in ddk750_power.c are defined and declared but never called.

Remove both dead functions and their declarations.

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

