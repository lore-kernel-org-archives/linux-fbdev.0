Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080434A794
	for <linux-fbdev@vger.kernel.org>; Wed,  8 Jul 2026 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490674; cv=none; b=r6Gc/0idqeCo2T+kqs474skA3V9U4AyvdRdlLoCfpxZSB4tSf9PicfoijYYFMpnb/8yU1fVZc8U7EmuBEeHpPobHBgaTLz4Bf9+V+cWOMes7a7fE6fWUQfAkfEUHLLpJE5Jh2y8oHGgqiabDd5JDD3eTH3PZzi0YU2gh5INrA7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490674; c=relaxed/simple;
	bh=cVqHhZReA2fXAlrREfgN40nDiihFftFmc/keShq8z6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mahu14BZmIy9ofjlBHcvtm+rJpL/C1oOrlVhuJ/78PrHaQIF+QZThpXHehawDg59ADRcoEXq6/QG3lJgOFXOOsbbnZgy6VoHC7gtzGwJV0a6n2phZV4hSlkxbWwTQMb8INiM4DGEmpZYV6dZ/67DAQfnRR8mGWb1m5gARYxJ1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gwehp9Du; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gwehp9Du"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so332476b3a.1
        for <linux-fbdev@vger.kernel.org>; Tue, 07 Jul 2026 23:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783490673; x=1784095473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpzBKe/Z1YBswSZZupc0hFrJmi6kmBaWyF6zI7yuDcY=;
        b=Gwehp9DudGraqjIzwE0zASTWzTYbuwzpXNK1BLA4YyuvxAEBeKJ17mSrInQqxKUVrn
         UEUC1xB7ofbHtKkxZuB3su6LZT9XQQ672oPXud0t1+D4/ApH/0TWi2MkvHGAN9Z4MTgw
         4fmeQ1CVGLifwdI3sEXQ4ZGGaHp1QNhy/e3PYZ1XjDc4txrEpJPbKYMhy5NmrrpXQ8bz
         22FIFmfxntma9mRy6VTWwx7idni7T2iKfGqDA/rAeEBUFFy8t45qXUlDNOkDU2aERxJY
         XrZLi1h+wKBKzgnnjhAeaRSepGZ563PRMbei2uZ24qqGN9WX0zay3DcHj7r0THaLIbu+
         DR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783490673; x=1784095473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpzBKe/Z1YBswSZZupc0hFrJmi6kmBaWyF6zI7yuDcY=;
        b=p2+oMBVd3ZkUQRNDnRbeqPPIxHUdWmeM0FuiPQxLBgnfbzpdztZ/3lQ+ZJlj5saQNu
         6l1k7bFhkHpOSXzjkbjj9Yxvd7Dya+YMhLMhC1UhSNCYj+IYKfpzeKKo08F644qEiW23
         i4MBN0/XMWzFpsKMxn0iOWfqK6z6VFsaCvGfu60ueBGv6kH5wDnPBCG/ZiQGzfu5iFbV
         gppwS1FWhAyohD34dNetMKjZzsVtLTXL6TY6s0ULtCxz3Y8EenwamD1ZnYkwBSwJKcBf
         92HwBFf+5n51BI85OYxScB0935yGB1iVHmfeDJGJwcD+Jc7peaTm1U9n6ek6CGYR+Q4D
         3qmQ==
X-Forwarded-Encrypted: i=1; AHgh+RqX9zM8gOSyP67mPNA3CSBkK5LCgqPEgUJnsiXWtM9VVaH1gY7fQLh2iILWCVqw84ZHbH8JG7K07mURWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyP6n1af7IcNqUeLE8m+tVqkmiICX8Y+H6h0BmNOvDSqTQCN58c
	Y0rfpMorhqOv7hNy+OMrsdLLH7RxtIxdkP/oPcBfQ3inQcOyitjQojvE
X-Gm-Gg: AfdE7cmbJ4s04FZSb7Rmz+6idvpp3YT9xpRhKB7v7oDlrXlu3hC2gyiv7ONY0pRs+8o
	G+Zs3vfDf5A3/hdbWGT9JNCfuu346xgrLIFF1FmBxcaJ0mbmcubA+LPwl13z5UtrGw4b+b33bqf
	ZJW9hH9NqMzaN0sYPg49Kmfp9rZoEd6ipNTCBGwmyzay2GCLgCvUWKrQAJ5vUAobMDiGl5jIm+D
	LCQYX0Ga+iWZ1Je77vAHXCEuSIBOOonVI2MIDCR6mT4X9XYldlvtaNuf1BpninIJE6b64bKvpOs
	3/Owha6vR4UbqC6+Laxvg03K37+HAWC44DF8NqwI0OMjcbadOi7QpRBmRFbiV5Zs0IdstJU+tgK
	Cphg9Uc1/+snv2ZbUHuTzqDnNVYcidQivoHPBVRBGgh/ACWcXd+FCaUTwvRkodpo2O80hxlHmf0
	aJLzz23Q==
X-Received: by 2002:a05:6a00:3e23:b0:847:8250:2b31 with SMTP id d2e1a72fcca58-8484342518dmr1118351b3a.38.1783490672638;
        Tue, 07 Jul 2026 23:04:32 -0700 (PDT)
Received: from adr.. ([149.88.23.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d76e0esm6421930b3a.41.2026.07.07.23.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:04:32 -0700 (PDT)
From: =?UTF-8?q?Andr=C3=A9=20Moreira?= <andrem.33333@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Moreira?= <andrem.33333@gmail.com>
Subject: [PATCH v6] staging: sm750fb: Remove unused variable 'setAllEngOff'
Date: Wed,  8 Jul 2026 03:03:07 -0300
Message-ID: <20260708060307.12237-1-andrem.33333@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026070710-exact-unveiling-e321@gregkh>
References: <2026070710-exact-unveiling-e321@gregkh>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The variable 'setAllEngOff' within the 'init_status' struct is only
set to zero during setup but its value is never read anywhere else
in the driver. Remove it entirely to clean up the code.

Signed-off-by: André Moreira <andrem.33333@gmail.com>
---
v6:
  - Change patch approach from renaming CamelCase to entirely removing
    the unused 'setAllEngOff' variable, based on Greg KH's feedback.

v5:
  - Fix broken diff from v4 that was accidentally recreating the entire struct.
  - Update the variable usage inside drivers/staging/sm750fb/sm750.c to
    prevent compilation errors.

v4:
  - Drop register renames 'pvReg' to 'regs' as they were merged via another upstream patch.
  - Keep only the 'init_status' CamelCase cleanup.

v3:
  - Added changelog history to satisfy the bot.

v2:
  - Renamed 'pv_reg' to 'regs' to completely remove Hungarian notation, based on Greg KH's feedback.

 drivers/staging/sm750fb/sm750.c | 1 -
 drivers/staging/sm750fb/sm750.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c4..f676f1716cf89 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -848,7 +848,6 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	sm750_dev->init_parm.mem_clk = 0;
 	sm750_dev->init_parm.master_clk = 0;
 	sm750_dev->init_parm.power_mode = 0;
-	sm750_dev->init_parm.setAllEngOff = 0;
 	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d2c522e67f26a..e7b8626cb876e 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -44,7 +44,6 @@ struct init_status {
 	ushort chip_clk;
 	ushort mem_clk;
 	ushort master_clk;
-	ushort setAllEngOff;
 	ushort reset_memory;
 };
 
-- 
2.43.0

