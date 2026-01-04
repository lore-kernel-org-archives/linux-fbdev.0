Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0B27FB0E
	for <linux-fbdev@vger.kernel.org>; Sun,  4 Jan 2026 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767524831; cv=none; b=NdUhb/72cF0RYdIwMh99I4Qu8Oq6iYR2gAytcCWl56V4MJc8BfrQZmxNFUPeS0T+NSQfb0wvnrFdbePaV7Kp7Jbrs+5h6EdIhOEzw9qa0ov2tANS/eBpEgCeSAbBn5AOkV053sSSdrAQoNWXSX5X97FgRfb9u/haDXrOlvBLjgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767524831; c=relaxed/simple;
	bh=F7lcVy2i7sDLuzA2SLiPSPOtp3uhQu1dRJE1zJ3lmwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inVgmaVGvW0QkVYvIiFmuXTKfcYH+K4lH1ESfX7xjL1iKLDMfamqrQRJZRDNwktcYWn63QPphxMC3yrkQJ5rQWP5rGYBjp7Jl6yjKcHVZoAx18KBwRMtP+oTtDrmoSnaVGysMDhLJTYppIjUXYmwSmHyKEtgEXf6xO4loQxBt84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R15BUCXt; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R15BUCXt"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bde0f62464cso13055273a12.2
        for <linux-fbdev@vger.kernel.org>; Sun, 04 Jan 2026 03:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767524829; x=1768129629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ+bmRezJcYlWiXwjZzWnf7vKwJcfmfzRPaQmAd80kQ=;
        b=R15BUCXtXNzq/YJUdZ9CKZGUv+ovOfT+9hG2pblzc2j28N348KFNBoPQErmyz2PSqL
         0MSvM5vH5FvI8Fx2frj+s4LUqS5MVp9Bi7XE6AUsyrvxCFZUrnY//2hds1RjxspAoT9k
         5cTOqbihMS94qGBHPo4ERqnen2xbq8Eb1F6pKi5aII9S63S+3+p7XqEo9LrP/InNmUrv
         tEjbIhhjKjv0/he1IjJY4MO0kMTGhoHhlptskdlP9KCfsqeKH20fKxOS6QdsfQCOltZV
         YNBAJ2nWDO9k6Bpf3gbTS3k4GuxdfjdgGCB5yiLwWI41xvTyH4z75KqjjEpuZtJMGa4L
         6J8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767524829; x=1768129629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQ+bmRezJcYlWiXwjZzWnf7vKwJcfmfzRPaQmAd80kQ=;
        b=fMZvxmh8Nw0mcCSFtMojmM4XlIe5n6yMwUdDSMExpIpcd3iYTAF5jnDsVKUvPVo1O/
         xkJQ5Hor587HXANB2bhWFUO0S7SP3g1FsFbCRHXp6PI19qc7FmKtTAibRQpbZS6cJP2W
         hFsklq1NpedPJfng8w7S/o+scClV2rq2UaaYru+2KdjpV/vfpPyBSadoRWviPndvVYMc
         QoMvlxKOZd0kroPYaE4T9/E1x0kFvcee95bMSmY/geqmw5h+oR3c2PpYwfTcD2UMx+6T
         CbSIlxWYYGB1HgjVBF40t7nbLqB1POw+mEf8h5yG+tFykXwbGP8bdxQpgcJQdeoTnLaG
         QbZA==
X-Forwarded-Encrypted: i=1; AJvYcCW1MEm+MGedm3+lc2LZ3vdZq47/fiOeeKdDZWly8Q8f98duSQHL7nh0MQCcsPDUplYm2WXH+cu/UtMurw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8OGxTBZ3eafy3kJ1wZKXuLIQw+gqqvPZYjrirQMx/qY0hJueT
	y7eu5rV8dnPIyttXYecuTPqCg6cMx5XsyL2Sohll6AkeyMJ0EwbobA/G
X-Gm-Gg: AY/fxX6xHF5L5RdEVNNvZPzYcPCfwz08xOXtpk4rllrtXrD0/bCY15XNFuj+cD8o8tH
	86WJR5O6kTlzgQ9h6WBiJ2tLZTBap9Kkj9RZX982jfJF3ZJAbr+rhXeaj9GrAxHZItQwk2/BwnX
	OTAkXGcAE8B0PRAcufwCZVxz0cBMBBanOUnhSTgTJRFZoCvVxvvrwSqW45qa5cx8ZNaAVVJpc+f
	E3Qcvi2zE8Mt5nB1CRysBHC8lxObUF43yNx/gDtYp+XiSQd2O9WeWvJ9gYUQs/4piciuPkWzE55
	dOgi/7qLIyvD9xAuZwtOelU0j248iOQ2DjAY1w9kx/ETwggh66Q9joTLi8r2E/AAPQl2+OKTZ6b
	e7ZE3DXC7biBvSeV5vfn2Osk821NESog8Q1x/a4Ko4RdKZDAAUTpGfbUt0Sw+SMC12Y3UFKEnjb
	XI6DwjYQIsZUPRW1sLmN+Zqf8kZClWA4fV0aZnZLcramzkgBNvjx2Ts7e3ZMUFOJZ1sen5n5eYl
	1Nfn9+JoDc=
X-Google-Smtp-Source: AGHT+IHIyNwefXI8MXb93W36SvT36uYIbrNX+u5iv7qHaTdpUR4A5CUQ4/hnB+XYTX2Eg+hORueIMw==
X-Received: by 2002:a05:7301:a2a:b0:2ab:f56e:bea6 with SMTP id 5a478bee46e88-2b05ecb3987mr27224194eec.39.1767524829190;
        Sun, 04 Jan 2026 03:07:09 -0800 (PST)
Received: from ubuntu-linux-2404.. (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e4esm7743509eec.15.2026.01.04.03.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 03:07:08 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v1 3/4] staging: fbtft: ssd1331: send gamma table via fbtft_write_buf_dc()
Date: Sun,  4 Jan 2026 19:06:37 +0800
Message-ID: <20260104110638.532615-4-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260104110638.532615-1-sun.jian.kdev@gmail.com>
References: <20260104110638.532615-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang reports a large stack frame in set_gamma() (-Wframe-larger-than=1024)
because write_reg() expands into a large varargs call and triggers
NUMARGS((int[]){...}) stack allocation.

Use fbtft_write_buf_dc() to send the command byte (0xB8) and the gamma
payload as a buffer.

No functional change intended.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 drivers/staging/fbtft/fb_ssd1331.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1331.c b/drivers/staging/fbtft/fb_ssd1331.c
index 06b7056d6c71..cbe10f191f5b 100644
--- a/drivers/staging/fbtft/fb_ssd1331.c
+++ b/drivers/staging/fbtft/fb_ssd1331.c
@@ -130,37 +130,38 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
  */
 static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
-	unsigned long tmp[GAMMA_NUM * GAMMA_LEN];
+	u8 data[GAMMA_LEN];
+	u8 cmd = 0xB8;
 	int i, acc = 0;
+	int ret;
 
-	for (i = 0; i < 63; i++) {
+	for (i = 0; i < GAMMA_LEN; i++) {
 		if (i > 0 && curves[i] < 2) {
 			dev_err(par->info->device,
 				"Illegal value in Grayscale Lookup Table at index %d. Must be greater than 1\n",
 				i);
 			return -EINVAL;
 		}
+
 		acc += curves[i];
-		tmp[i] = acc;
+
 		if (acc > 180) {
 			dev_err(par->info->device,
 				"Illegal value(s) in Grayscale Lookup Table. At index=%d, the accumulated value has exceeded 180\n",
 				i);
 			return -EINVAL;
 		}
+
+		data[i] = acc;
 	}
 
-	write_reg(par, 0xB8,
-		  tmp[0], tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], tmp[6],
-		  tmp[7], tmp[8], tmp[9], tmp[10], tmp[11], tmp[12], tmp[13],
-		  tmp[14], tmp[15], tmp[16], tmp[17], tmp[18], tmp[19], tmp[20],
-		  tmp[21], tmp[22], tmp[23], tmp[24], tmp[25], tmp[26],	tmp[27],
-		  tmp[28], tmp[29], tmp[30], tmp[31], tmp[32], tmp[33], tmp[34],
-		  tmp[35], tmp[36], tmp[37], tmp[38], tmp[39], tmp[40], tmp[41],
-		  tmp[42], tmp[43], tmp[44], tmp[45], tmp[46], tmp[47], tmp[48],
-		  tmp[49], tmp[50], tmp[51], tmp[52], tmp[53], tmp[54], tmp[55],
-		  tmp[56], tmp[57], tmp[58], tmp[59], tmp[60], tmp[61],
-		  tmp[62]);
+	ret = fbtft_write_buf_dc(par, &cmd, 1, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = fbtft_write_buf_dc(par, data, sizeof(data), 1);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
-- 
2.43.0

