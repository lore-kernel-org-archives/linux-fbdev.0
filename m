Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFE03F23AF
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209744; cv=none; b=dF7GNPTfOfKlnJl6Up44WdWxpE+aXE5+AyIZAmKso84pr8WHvYcExpjrNAE1jcG8X2w2Ubbh12x3YSqAH/r5ybVkhPMAyPKLSbB5xkvVHbSnuXOhSdDr+/y4zefSyEFD++UagBPr/Fb0MioS1mQMaGSBRkFa1oIFjz+skPCEEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209744; c=relaxed/simple;
	bh=vnSqf6Q6+jykaOkTPY6+JdqtPH2h+eJqb9PmvzMyeNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Km3fDLPKN57iUAI8b+R4xch/wouG2wAvTMnXbLeBw/lXMQciTBIfHTAP+ZDikIq6an/Nc7hqv0zBGch6ZnjrJ25ONsWQLpOklVHk6jlcjK5WKBxdMiOpNunM2o1uOSGhQ+XyvkbOhgwTluEzLQmTGmt/XUCcDtKo1QEtydmLwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YC3t7OGR; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC3t7OGR"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso4119849b3a.2
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 04:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770209744; x=1770814544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PlsqnjjagAEsGQw5SlDMIqzia0vvHEg+g1ssaAuOLLg=;
        b=YC3t7OGRJ33Qo01/SbNn881D6I5EE36xjDFFQr23RmRtt3DBfNQSZWRa6+uaIg76ST
         XysouBT1Iz5IqIn8T+Av2d0VYI/j97pKrNlmrLUmyB0zLNY/WZCX0RODfjb41Rut7PES
         bm/kdsBWFu5BFMmmApSIvSeSRclzF74kX26Z2dtUHtkn4+uUxsuoUVIrnNg8cjP+f/Ld
         SzDBDxUllQ5mOIgcyBfZv+ogtWcG/ZsgyqJW5eURC1oiIfnOiQbjTSKLXYksP8adPz4Q
         nS8KlPuMy+sYRnNuHI8P/Iw4f/320FhAFyTsRJCepuGh5HzN3J+pkoIFftWRFyJFNY79
         1Bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770209744; x=1770814544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlsqnjjagAEsGQw5SlDMIqzia0vvHEg+g1ssaAuOLLg=;
        b=Kx6SZ48f001mSYO4VKso87T4JMJBuzZ14IptAkkFNQTHxM8NbFghVPOvt3HjyU6As3
         CeVAsiTglOwyVx5PAISCpLGpX3A0B7FwvjBO6qQn3Ep8I4fnXkLL1C/EPi6iWyvH9tIf
         AGns9FZF+Nd2vSSPGGWJNsxLphmydCGnp0QDofrHQ/x4Igx9nbb48dnyIECN7olIyWzI
         v8NC+3DD/F9gXnto8gb5asnwr9vxBVUhn8zOqDE9guc+D6VJgnhinngAie93T/KBuuiK
         2Nizs4yYzRpN7D/MR1w59JKrHyoYn+AojY+E3cWGHrtuhj6gbxVJb2ZE7auuwAz1LXqz
         xIrA==
X-Forwarded-Encrypted: i=1; AJvYcCXIVz2rDA/Uf81EnH+eE/6lDpcExBIhcRleFfnmNdK9dXA/CPr5maQNnQmsNxvPCPOx9HBMN5LgbT3mrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTBseEa4LiSFeucCzgC85ztC9fEsUYSAEKXCHAp9NhcvSVTCCD
	lWrg/r8Y5+kGSi0qTCM+3u1JtYNsqHH1rhzI4xUoqk1x7hKCCXIde0+J
X-Gm-Gg: AZuq6aK1bzcuH/PtUAI55k5mffyDsqr6NtffO9QR3jPgYr2Yr0E1c54LICQyM/2vqum
	1yVE55FxD4pEiaVRYeu2bke3W8SFt1VeRMJy4CG9K02nVdxmjTOzMBHpJSoxIWDi1i1H75lO1zW
	s5Y+ipWHUdKtVptJmvv2ESGcNVLdfCSvPUtCWDwZBs2DU0h5hkxB9DVPJdmY6qHDTbietp5z/qv
	eAdahiF+yHlPhoD2IAdkAd7oYE8x1BJG+WggXH47bANbSQzFoNcA9tvnOJ9k4pJoA8GNJ76fcUS
	aSOfmqldbLVfjV8UOEQgMy4pVw1tSHiRzk9lbGJnG0P5h3YLtuNOYMmRcUMhTyI38bs4uQaCA0a
	Ua3XCrSJpsa9tmWdW4vymMtaPqPmId+M/GGLSq3XsaLOkp+CjIzM/DfcOiUtGcg/zUW4asRhWAn
	E7DnAzeDEEjJS/w4ObGS2a8EtUtRo8TpF1nJT9OQhzRoiUvYv9lvhWiQJE
X-Received: by 2002:a05:6a20:ce4b:b0:350:fa56:3f45 with SMTP id adf61e73a8af0-3937211e956mr3301077637.35.1770209743878;
        Wed, 04 Feb 2026 04:55:43 -0800 (PST)
Received: from zeeshan-Standard-PC-Q35-ICH9-2009.. ([110.93.227.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c84c70b79sm2360353a12.18.2026.02.04.04.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:55:43 -0800 (PST)
From: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
Subject: [PATCH] staging: sm750fb: remove unnecessary parentheses in ddk750_swi2c.c
Date: Wed,  4 Feb 2026 17:55:25 +0500
Message-ID: <20260204125525.5498-1-zeeshanahmad022019@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checkpatch reported "Unnecessary parentheses around 'clk_gpio > 31'"
and 'data_gpio > 31'.

Remove the extra parentheses to clean up the code and satisfy the
coding style guidelines.

Signed-off-by: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 0ef8d4ff2ef9..50e51d730d86 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -393,7 +393,7 @@ long sm750_sw_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
 	 * Return 0 if the GPIO pins to be used is out of range. The
 	 * range is only from [0..63]
 	 */
-	if ((clk_gpio > 31) || (data_gpio > 31))
+	if (clk_gpio > 31 || data_gpio > 31)
 		return -1;
 
 	if (sm750_get_chip_type() == SM750LE)
-- 
2.43.0

