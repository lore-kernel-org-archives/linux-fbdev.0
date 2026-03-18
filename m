Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C77311C2A
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855326; cv=none; b=hgglM4JefceWGfYq9bBpPS+4cuWMVEqxK2ky+iYeB+cuxf4qe2nNF1zldRCWjBawxSd8iJc0U4vCstbhPF7Bb5WIEG3ILfAvQLQPQeGXuZKnzSHoHJ53trHnFjyAa5Jox/8S6ykn1qSRenTa6kUGQ/Djq330ccK8nWWRUnSx6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855326; c=relaxed/simple;
	bh=bff1sGeOPrpdwKjWuXZN6sUx+wfEDM7j81uWD3fIsZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJtXtBxBSr+LBIB9Z0h/k7vSjkHULHzsIuwtgHX+wOK0C96M3JOcpONGB8UCbASvz6OKsNaoAJbcEzF5vXqbmlxzpxJ7xVyrCBadrMgwiGF18drEER0VDBdelQN3tCMT88g2tK46Q7EO6I3NYgzwzJ+1w8zzYfeWMRT3bEggfJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1Ll4RIX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1Ll4RIX"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso154371a91.1
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773855323; x=1774460123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=717hwjvUKeRFJ/nK/O9VF6bm2edjepMJ7kzNrqjLgno=;
        b=N1Ll4RIXs+dKL/738HOu9uy+D4iY9h668oZ49hYFQBY7GQ/HphXTpOqTOMx7qnJfS/
         V6SjUaupjHK0ndo9+X1ofvZNJVuzyxriLHmj5Aum6udkeFLo8Xu5To1X6uznOmCv6iXV
         AuOuOp1ch6/1j4Wg4/9wj7ZcC9ZVlxfGmhbJh9uvUPtWRgDG3u87nVDYmSLYSXD2BvCN
         n9AS/zHS7HR1r2o6ebwZs8AeqwPghCnAfgH6UTOolyu7oQObQDEzymyZFj75o0LZRSaQ
         sX/omg6Gyj22KNX63+yMxRXTmFWf/CtxCMMk+R86N+v05Xg4xH5SAdXUwpNQLDZQbiL4
         /RSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773855323; x=1774460123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=717hwjvUKeRFJ/nK/O9VF6bm2edjepMJ7kzNrqjLgno=;
        b=b+CGHY+MD5+H1Vm+GTMpvzsU+K0YPyhgfJvPGMlaUN/Q4SHcjgWMTqkhF5xFbz5yK1
         51YOjKUh6KHXdmR+mhJV2nmcM8864tq6hWqDvyL98ClaUHS4IUFoJePZJkoWTJHAUu+c
         kdXJjMW6IvxsgVnBdFYaKNIjnU+MzDGZHwdzTD9JHlZcsYAMFCXCvwE/KPf9i3eXL0wR
         FpnPejCzzYCSvIoru3GdYdk9GNpVe2xlmXAuwNxaIOW8zhjjKIDG0Uwd4KtfowMNhDLT
         zrhHZlRLEk7+rIakHXk1nr8OZGCLIWLHDvYTjlYdt6f2/Og2eZX4wOXbgAW2a5eWlsZl
         0M4g==
X-Gm-Message-State: AOJu0YyQeKKLw9YGGynh2BhY4wXGo685CnFAN0Dr+5a+xmYEg9is7HAo
	tRE4iF9ec6kccRNvUhDWKcIql3YkLXBig2WatDt9sPkSfUlV1/VKCHSG
X-Gm-Gg: ATEYQzx0NnirZTs2wxp6mYIk530eQl1Z++j5UXAtwq0QulhA7VutJsEMTbfoa35iOmb
	fKiCoGo2Rrw2CMgowqGSrzigk+bwuiWDTwiuSLK8f8ug1Pj31FKGRsStVBRKDdNQcGceykLBz7E
	OESJHkXZAKv1HTSSd7QK4d/XgKdmfwiCzsJmAEjDR/yVvA7W/NfJ+dIHugafFSH7z9TkCJKFZbU
	PgULJdCE0mfsLH9Sj/YLPZmC8eQNGooY3M/xwG7LXbo7ObB+zC+4LYfkPqg8c48BvVrfc3hh0id
	wowDDg7MQkk/nCeEsUTcp55W1w3/CG2w0idA8Hgkj2fyy51D2QOsE7ceRRXD24ZcoFbfhi1iVO4
	pB3YAr53zNRtn6xZPa1q8lqLZ/RM/f3faZ8EG3nIT10CbElXg5uJzJYRdoXDR+zuyyuifjGRW4T
	ssF+N1J4oI3qc4uJQUm8wrFJqUq8ueB67LYaQ=
X-Received: by 2002:a17:90b:394b:b0:359:f88d:1e2e with SMTP id 98e67ed59e1d1-35bb9f90248mr3765947a91.31.1773855322714;
        Wed, 18 Mar 2026 10:35:22 -0700 (PDT)
Received: from fedora ([2409:40e5:1052:9a56:3b6f:933a:89fd:e530])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc5ff704bsm247103a91.2.2026.03.18.10.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 10:35:22 -0700 (PDT)
From: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
To: gregkh@linuxfoundation.org,
	sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Subject: [PATCH v2 2/3] staging: sm750fb: Rename struct init_status members to snake_case
Date: Wed, 18 Mar 2026 23:04:39 +0530
Message-ID: <20260318173440.9457-3-chakrabortyshubham66@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318173440.9457-1-chakrabortyshubham66@gmail.com>
References: <20260318173440.9457-1-chakrabortyshubham66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename CamelCase members powerMode, setAllEngOff, and resetMemory
to follow the Linux kernel coding style.

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

