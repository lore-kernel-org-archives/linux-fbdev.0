Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603D330595B
	for <linux-fbdev@vger.kernel.org>; Tue,  7 Jul 2026 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455484; cv=none; b=DuUxO6GGyVQV7+EIsUIX4B4u6FJ0IspySjCZof8fUR4M6TNMvgDcDlnJV+EIXWjumGCF3HyGZprEKbulSkiwpi5/fLJF1Z3y3M1//VDSy6uA12vTFyAen9s4ym2j2AbNgko56boiQT6Ng+/tU8jHSYbOy4XUY7GK3MZ9fAsI2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455484; c=relaxed/simple;
	bh=LT84Mt9Usfp2EKOVxpbMacj1qP8vDd8wrB3bl7sGTqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cI11xaG/HhKWPSwu83lxFMYcDXzuPeBB7muf8NqqBetSuyqVKSdjF6ZtGlwovf1znxMzltzVejbW/zpXc+XCuGBaUgsL0hbKqdMWUPMWYMXouwQgP8pYo909jZfl3mmFwEFAMoMdtrTvq/Thf+86twGog9LPPJyxs9I/GtSkSaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv08t6D4; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv08t6D4"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-13b5fae0710so27004c88.0
        for <linux-fbdev@vger.kernel.org>; Tue, 07 Jul 2026 13:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783455481; x=1784060281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9aWTekv18Vz7q14Rh1vzCFo3WAspKNMWkB+3v3BTdxo=;
        b=kv08t6D4Bfakd9O8Qeed4p/mrN/3LnqAHYLJRHJ5EY1iSEhXm1Uvy87Z/Uyb+uI083
         kqKj1oW/MfPNPMBescO+zJoZquUAHPRCQwsg64e4QRc8OBL93ElPA7FG1tWMQPNJQu1e
         +r4NJtxYf4Igz2/grJvK/SGtpNgG/Cmwdu29MXwO4Jeelcvv/jTkuXSP4ll7AjOiIezY
         UVBuJijHvRG8Msb7rkR7FmaFyfTXcbBKAqRmbHtl4G0CiPbm9JX3w4TyraYG+WYrHin5
         Lnkvu86NNYXzaptNXb8aMnyruHZARGExE5gC9HzqgrBxenQ5BSUFfTbvawkLKTp6ayUH
         skqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783455481; x=1784060281;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9aWTekv18Vz7q14Rh1vzCFo3WAspKNMWkB+3v3BTdxo=;
        b=IsW8gY7ipailIOzHHd76LnRH3V4nHoAbGRcytamwZuXlWCEGXsA56LmEGAHjqF1qA2
         omvO9XndLNjnqxvLjrRhs7uwQipeRu1y6rcy1VWQV/+Mn+taGdg4pWxYf1h7No+RutWx
         xdj+V9mJsQkjizqr96bYAUdCPcOSUKtbcGggRVISGIJirvga5A2kerXyZeJGe0XOuyWr
         FngUsL1+8DoUyP2a4xZ+IE/yvJEsFs34crgyUJ533m9vGnBdAEpKwlyT0uMIFz4n251H
         EtMLYxxUta1xnI5ZNYHsB6jZUCkamBF1n9tIOBzPx2sdA7Yq4YxJqY2QhSjZHKxSyjfG
         lnKA==
X-Forwarded-Encrypted: i=1; AHgh+RrbTnt/cBX2WZhk1jGuntwV6CQYlDP7yhvwiSWCTk6AvyMDQqj7K39Lt73NFhsi2uaZoeOUIz94GZIhpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmYZmoRQ24VB6T+rNwaYZW7LZHZBlWFCO2ZLPDUG0DM3wCaik1
	gjZfqZsE1tq5UM89+vyF2bsWxytopIrKAdaZ10iBkkeZ49DVfgHK/R8n
X-Gm-Gg: AfdE7cmm45ZkrksgHpbqKajYsrU9h5zfNGX05D8aGRKTzJR5xVJRYabCznrZQ5cNn+E
	MyIN5YukOJDHoEIdUT35Dek+qVOk4pkMwVVav/9guI4HS/QuGQJykfHBmh1F+it8xZM0nCWNOz0
	PUUYvRMvQ4oiYxFmC2qqzCz4P4+V/klaEF7PFVz8BHa66dBrVermsEAsSJZCSePICsEBdLKwuq9
	7nrvyAQkLWyDcf0jA1imQ1h+0gxsC+bebflcqc/gQW6cuwI/Uny7G9Efp0xnyFPAJc7SykxiI1m
	ePuDuhjKDY37JtsnKCqtzbTa6K1D2fnD8Kq1Is70fH66CLwqghVxN9GbnQ7YevLURMJkM+JKTu6
	2vS5EwXmEuYvETcTxDvEXKqYtvdp1dP24XINzfMX5Ag3i+IYRL3LVCI37wzhPNPzDyR/S+dRw9/
	HxTmfKPw4JHTSXe2fwkg==
X-Received: by 2002:a05:7022:f10d:b0:136:959a:abf2 with SMTP id a92af1059eb24-13b625e0929mr57728c88.2.1783455481318;
        Tue, 07 Jul 2026 13:18:01 -0700 (PDT)
Received: from adr.. ([103.216.221.83])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b65960d88sm9835785c88.6.2026.07.07.13.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 13:18:01 -0700 (PDT)
From: =?UTF-8?q?Andr=C3=A9=20Moreira?= <andrem.33333@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Moreira?= <andrem.33333@gmail.com>
Subject: [PATCH v5] staging: sm750fb: rename variables to comply with kernel style
Date: Tue,  7 Jul 2026 17:15:41 -0300
Message-ID: <20260707201541.12459-1-andrem.33333@gmail.com>
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

Rename 'setAllEngOff' to 'set_all_eng_off' within the 'init_status'
struct to avoid CamelCase and comply with the Linux kernel coding style.
Also update its usage within sm750.c to prevent compilation errors.

Signed-off-by: André Moreira <andrem.33333@gmail.com>
---
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

 drivers/staging/sm750fb/sm750.c | 2 +-
 drivers/staging/sm750fb/sm750.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c4..00c293430a7d5 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -848,7 +848,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	sm750_dev->init_parm.mem_clk = 0;
 	sm750_dev->init_parm.master_clk = 0;
 	sm750_dev->init_parm.power_mode = 0;
-	sm750_dev->init_parm.setAllEngOff = 0;
+	sm750_dev->init_parm.set_all_eng_off = 0;
 	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d2c522e67f26a..589ae51444f81 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -44,7 +44,7 @@ struct init_status {
 	ushort chip_clk;
 	ushort mem_clk;
 	ushort master_clk;
-	ushort setAllEngOff;
+	ushort set_all_eng_off;
 	ushort reset_memory;
 };
 
-- 
2.43.0

