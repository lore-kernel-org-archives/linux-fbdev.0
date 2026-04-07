Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771B13A257B
	for <linux-fbdev@vger.kernel.org>; Tue,  7 Apr 2026 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548113; cv=none; b=N0RTnvht3TTqTZUTSYnuG1gdB90ZnFk2uFxPGVXMWnffMFMnMutxz6EWIRPsUfrw+v9scXRtxpkZzT739UjZkv26g3/sByWFA7SS+tum4KcWVOP3yPQmuYuLznWGg4m4nSaosnkwQFW3KF5C1P9Y3Jz+IYjXxiT/zfoJH/w53vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548113; c=relaxed/simple;
	bh=LaVf6I0Z4sCpUNfHj+Kfa+v3TghHjud/ieOByvrHuKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVyozU/rg72NAyBaGT4vBwB8tjZskarL3nLq0p0Bqa+rQo/NhmULIuceBCLHQN9IYugUpqfi4SlBJKoyJC2+sblWTlU5d/cQhZXB3H7M1RYM4KdxCsL8CtdD62s7fc6Jn0bK6NYCo2/PApBFd1flBFdN2D6I2VgwvB1R7CxqE0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ib7Yu5zs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib7Yu5zs"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8296dabef74so4530199b3a.1
        for <linux-fbdev@vger.kernel.org>; Tue, 07 Apr 2026 00:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775548112; x=1776152912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mjGuRE9W84vdHsCFtU27kxqr4TOAhO6rLoevI3eA3w=;
        b=ib7Yu5zsidAJa1MS8kPsITs5YdzoIgQmgfOXmLTCS1P8d4rhMMqdq/EplC35cyo7Tm
         wwKbXVgWIlmn/+UpMgz9Ilkuj/sl1xppFs6d9AY1tBfA4HEvM7oBGPxivwEhwB/mCxPj
         osD4rB1iYiMCe5gHEHfttPg/gNwVui50IGmyznKkSuw/NnIDAYG8J8lUhPl6fluKKGNs
         0+DpR7zy/GF6tjXyfoC+SMNHsZfpEP56lf2c3vwLI9fpQnTh0P//Ap5alJ79kdqqqlbU
         SfYk13+Fo6S5I1I+F/0iELqDUzQErOnrYyb2JshyCmoPBS1T0YuXZKhFqf9spSDA0s4+
         To9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775548112; x=1776152912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0mjGuRE9W84vdHsCFtU27kxqr4TOAhO6rLoevI3eA3w=;
        b=K6zxFF60AcjlnXgRS1wW4J1H+p+L9hzqhvgXChFbqSqiKnBpUQwDAuxT27bKcvhr6y
         5XLTgBQiFBh/buKjU/4MEJSy+4BjE/e8NPyoMfAp9/X3hNRAB+TqYbw5P17Oltdu+VjK
         skYg5v98hRaCBPORmbTP6f18hZkt+J3MpcEmekfbrPY0DZaMTDfVICmUY/c+lXiEFVUm
         Ak/ZRjI+3XjebQqOUTDCTWSn3yHvUCl1+4e3ppvE8IwV12wgKIAZ6yE9ojgkiJzrnl7i
         JM4Q2f2sPZsVzqwkacKRILjmeZoVwYp46Ods4Mx/rKafD+Jxg5CyI9XESayMmXeikh0B
         9Cww==
X-Forwarded-Encrypted: i=1; AJvYcCU6nvRUcHySQGQlcWxX976xgZCncrNUjrxXhRlNyKm0j85D56z77g4ADsbYhvdXp3nfzTmkcGgLIX8Dgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGg7GZo+890TO0yr7VzpX4J+apCJ1vmMrde8ZOwUTtbscaAaMy
	Ym1L7eU95ZKzQNePEpf9IWhyb3us6VFXtDi4TifbDCOnJ0waTkLp0PR/Vjjp5bZQXAaYUQ==
X-Gm-Gg: AeBDieuRCWmddE7cd3LH1NymMllyqBI8EM+JvdCDH10divYg+dJcEs+tmpSXfHORApJ
	GznzNK8frkJ1YEyYKvD+t5dKCkI8mbDN32WlWI6531GTq2jWXf0CPzPaw5yeEof5eJqS7Pl9rOl
	9QxmX/AS/Q4+QDgjpJeo8r6UXL72w0J2JtZHbfCmeDwJfMZ60/rd4JfK1JU4P3rZuxxoSWlkNz9
	vvOZElu6mxBFhrGHou2HVg6sajdsPLlVptxNvTeh8150fchYcYsb/YELlRe0yCncK87nK2Y0q56
	Iblpu64FdKYO5Bg7TOrZg+aufXR8VvTb0G7iWODSGyVdzLn5oN5ztYoQBlP/zsid+GwXgW2JM5V
	y4cnGBbrooBLvvXF/gDFSV8BVTMhzwINE+iafvtThN1hXAJ0EuqfoH0X/8jzOn2aleAJG2RUkyE
	ptZCfeku3y+jFF6MB2dgFi41uG0iUoP/zGNlNXKLrCgWzbDg==
X-Received: by 2002:a05:6a00:2393:b0:827:447f:7dbd with SMTP id d2e1a72fcca58-82d0dba1332mr15910357b3a.46.1775548111785;
        Tue, 07 Apr 2026 00:48:31 -0700 (PDT)
Received: from fedora ([2409:40e5:1126:477b:379d:30fd:d3e2:3b3c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9ba21sm22093716b3a.51.2026.04.07.00.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 00:48:31 -0700 (PDT)
From: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Subject: [PATCH v3 2/3] staging: sm750fb: Rename init_status members to snake_case
Date: Tue,  7 Apr 2026 13:18:04 +0530
Message-ID: <20260407074805.14505-3-chakrabortyshubham66@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407074805.14505-1-chakrabortyshubham66@gmail.com>
References: <20260407074805.14505-1-chakrabortyshubham66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the init_status structure members powerMode, setAllEngOff, and
resetMemory to snake_case to follow the kernel coding style.

Signed-off-by: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 6 +++---
 drivers/staging/sm750fb/sm750.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 729c34372a1e..c30ffab8a5f3 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -921,9 +921,9 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	sm750_dev->init_parm.chip_clk = 0;
 	sm750_dev->init_parm.mem_clk = 0;
 	sm750_dev->init_parm.master_clk = 0;
-	sm750_dev->init_parm.powerMode = 0;
-	sm750_dev->init_parm.setAllEngOff = 0;
-	sm750_dev->init_parm.resetMemory = 1;
+	sm750_dev->init_parm.power_mode = 0;
+	sm750_dev->init_parm.set_all_eng_off = 0;
+	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
 	g_hwcursor = 3;
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 49a79d0a8a2e..b683a82af349 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -39,13 +39,13 @@ enum sm750_path {
 };
 
 struct init_status {
-	ushort powerMode;
+	ushort power_mode;
 	/* below three clocks are in unit of MHZ*/
 	ushort chip_clk;
 	ushort mem_clk;
 	ushort master_clk;
-	ushort setAllEngOff;
-	ushort resetMemory;
+	ushort set_all_eng_off;
+	ushort reset_memory;
 };
 
 struct lynx_accel {
-- 
2.53.0

