Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90876FC3
	for <linux-fbdev@vger.kernel.org>; Wed, 29 Apr 2026 00:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777421796; cv=none; b=KL82pwV1ejk0Ti+DE7V3cSAxKoQMsdCKHiMRkKDSLnY+FqlvQqW878uEHBauFyotDhPLzfzWtPltn2YjJqmmwVa6aazFf+G49cZ8SPvSW6Dn9uJjK3CCiCLTQBJ/zxAZ/EPkH7VHoKouN0iUXlkwpeZTg7eWTPya8fOuLzP9nys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777421796; c=relaxed/simple;
	bh=MYkC1lGgmyF61CGHkzTO951DZUc25ipo5CaYXUYB1s4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0Ea9DpkyuU2gQ0inHJZpBCRpo5K7K8cSqeXIbHDKjGOG0thtl1x3Z2kkyBC+Ndr3kFpcxexfn4pMpwLsb24WwMRDzfyzl38VaLhy9mJiYLEWfjdtTWE7jASq/XC7an5e1DD+5XioWR98k21HI7hm6SVHuHGYNlr/MG9l1Cybbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQsh0w2/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQsh0w2/"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35691a231a7so7993860a91.3
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Apr 2026 17:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777421794; x=1778026594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IxLGKHb8A2XfyprIdpvTidPgjGnBvN3bS6Ed5BUmYws=;
        b=fQsh0w2/AwXmNhXeLICtXQbbYOhpDrxuDqJ+VkehxrcTvBLTsgYEzlk3p7rUrf4e6N
         XhFuGPpZxpCkkq1am1GjUSBpfAm2nCZjXqM+2C/DTPDaX3RD+04Psj3Lp/TX2f4QmKOn
         uO5YxK7m4bTITYLwCt0m1NmWTzyhFYLuGnV7pvvvjjPcMcDgd6kHdlg2uqFStchPtpSH
         bRTv/O7GKJvfs6Mz4uh3Yuy2zlAzW0yQHpgdnLamZVKG+88D9kciufnmnUrUvMJco3HO
         8kv22MpEsjN7snknvWuHrMoaHoOJQ+feDpVPfFbB5djk249JoCJoeY5FNp6BGrZvBxum
         Zdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777421794; x=1778026594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxLGKHb8A2XfyprIdpvTidPgjGnBvN3bS6Ed5BUmYws=;
        b=U4/q82Uzc7bLSggsgRl621NLjmYZ3PkwzkwHEdiHpwHSWH9Haaz7wynpLCOdgc6KiL
         YTfiWhsfzaZN1FN8SFRwfnza0HlmEhS4RUT9IgNFKfYrIJTPkHnbQExI1Py/AbZ0YN30
         2nPbagM+exCqFuO0dwOtZoYTjLg5x+ILBV+WIwA9bXKWPSM0/TTuXjrtVCc9UvaRJF/e
         vquwifnY8o5ectBS+bpQnwe2MKamqxmYH1Gtbk+AlvV9wnYXnd5aJCKy5fTVhRMaNeOo
         wdOukvULzGiPZYu0qHw3bAq95d+e9oOacfU/V0WHaIdpjzyNKidNKC+GmfmJyKGtefuQ
         6Yag==
X-Forwarded-Encrypted: i=1; AFNElJ/653MlkQdQu9AYwvtG/URmlHMBaILHS7H9zXg/l+pNEX+jQsSV3FQrrFZbDW6vIEsxzReBV7qSnENUuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvfWip4dD0cUgHU0/wNI7CQA1qW10jOTIXCphn5caS46ZXxM5M
	TflVDDgci88cKk6Z93udnPwaSg7ItqEDsQw2NkhzSn48OVpuutJtgKUK
X-Gm-Gg: AeBDieuxca7AWvYHnDbR7MfhqCaZx3qMs7X5bomCuslXwB5lLdpGgBaxd3ZVpn3ic1F
	+I5p4czykgtd3isV2x+kKyIy+98+GxjBq2wtZq9VqTRnQJDxnuu8W93ehzTZ10fXOR0bI1yX+Xx
	+1CUvavcAQ37M92eeRltBLK20khO0lZ7gT46PkXcHnD/XGYcLU8kSWd7eivMbhChXGda3j77Hbb
	kwz9VoLCF3l0VCsw+aI2h5aE4Ep5QC7UDacp9I8mIll6S7aJgG1Ufan7YvqYE3b4fGaQJH2xg7b
	DE/S3PGv9v9Tn0oru/+Y4LnV7aX6gyZ8QOShT50tSIiOOMMbsD+TgfIsDcUqb0bkjSES6AQZ8rI
	+fRfHNQNDfBGAd9f+kEFQ9tYOnmKRaK1d7WxJdtVkOfcpLt3yrXDS30bKYkmczbGjtJFRm9JXxx
	9lw4Lx3k6my4AV9nCnEtqWO3dcQ6KDDwUdNraJm0whLgcaDYgOCqcoTuW0XH411idPMSJjptc2Q
	E2AtFHopC8cchK0ifNlYGvMDLU=
X-Received: by 2002:a17:903:1b30:b0:2b0:708f:4dc7 with SMTP id d9443c01a7336-2b98742796emr14684505ad.29.1777421794116;
        Tue, 28 Apr 2026 17:16:34 -0700 (PDT)
Received: from archlinux (S010680dac2bce256.cg.shawcable.net. [174.0.186.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98897edefsm3493465ad.74.2026.04.28.17.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 17:16:33 -0700 (PDT)
From: auth <skunkolee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org (open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER),
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: auth <skunkolee@gmail.com>
Subject: [PATCH] sm750fb: fix spelling typo in comment
Date: Tue, 28 Apr 2026 18:15:56 -0600
Message-ID: <20260429001557.71737-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed suspected typo in comment ("programe" -> "program").

Signed-off-by: auth <skunkolee@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 7163232c0701..6363a66d5570 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -82,7 +82,7 @@ static void program_mode_registers(struct mode_parameter *mode_param,
 	unsigned int tmp, reg;
 
 	if (pll->clock_type == SECONDARY_PLL) {
-		/* programe secondary pixel clock */
+		/* program secondary pixel clock */
 		poke32(CRT_PLL_CTRL, sm750_format_pll_reg(pll));
 
 		tmp = ((mode_param->horizontal_total - 1) <<
-- 
2.54.0

