Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C7B27E04C
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855300; cv=none; b=H0M2DFRqH7FEiI+pPdh+I6lxG9QuNTsoA2swec0YtD6yNyEveP2blyE041iQDB94NK/iHSS+O7NViZgk+eB5spveH6XJOVlGoBX1et30UGz1KTBg1IJwmgIZ1Xt2Cz9vk/1K0MmYeQp/O/XPIhXgnGEU9G/7JAJajtMwRtdTGQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855300; c=relaxed/simple;
	bh=HVL9JcuJJwe/eCTwUdao1yOahP99oeFx4kBMvT+jP1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOG3PS+3APXDHGsIwUFXupUlwTs1G9SMzdglzu64TrIavo69gN2cBS29yRLprNpiORCipa9R9acwhTxiPqw8DwDScp09Sh4IBx/P9FQ/VU6sTkOx5tjmQz7Ii4yIbQBBDvOvXocYaFRK+Dg3lu2TbgtG+Zg25inC/81Ibsh2xcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcJx+YwN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcJx+YwN"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3591cc98871so103597a91.3
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Mar 2026 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773855299; x=1774460099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=49tSaoOy3FsaSDvjZTaErELVAoylTB6lCBPKg4WidfI=;
        b=LcJx+YwNGpLau4KT2H+gvcgU98UDGANlqYneQdVAqgrEKSrKB/SLf677Vng6gYYI1N
         qY7Lm8nFkecv4KUMacYSrd3wkMSpcXNe4vhnygZSRzLNql1nHwkQRQXp2A2B4TK0kOy/
         tXRhIkuW5w0eU5Gf+XMIQou2da3lauhdYHUcvoyS34wX6jQViRFB+v0NbCxgsTbxS39m
         TMbXuT9IUb6/5YDZUVxBIbPfX+LzUCkkOv+AhryLFT7PGmhLX/lbHMUE4YWL8O4I/yve
         ONVKaGZc2//tqoFbFFiC1SQuhYsAZYI/G0AWHPY67J22PIRRr7J0juGB8Ln6xipRj0SB
         RlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773855299; x=1774460099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49tSaoOy3FsaSDvjZTaErELVAoylTB6lCBPKg4WidfI=;
        b=JWUWQZTinKCeS9uow6UqNYnqXnlK3aiH8M3TRX+LOfUZ22/dlcYirWace46mDYEVAW
         3uS+REKKg18qT8juvx7i12BRg6iUrIbsyroCDgZjkILuKLgau6AZKbZxR3FBgX0EYz5k
         JnXnLR/3fZTL5fG6i/RZ1iJ5OP4mel9uxTgTUVsLa8sNm9WLTxdztZlqCAWdEyjvwQoY
         yUT5vucQrG2quFNpXi4uAcFlD9nJGSRt3z8mcblNFmoK5FEJfedfoDcOEcd5JVAVfngj
         QDVqPRdSvrX0fHPUrEoa6XCTQ4iPpNGRroD0pKS0kv5+ArVwlCbWcbSm5yxozgkmbfjw
         dhaQ==
X-Gm-Message-State: AOJu0YymhyoAL23l5W+d2X4fmPYYzzKgOD3tOVkOJfWWglSFQ8vGBmMt
	DigY+mrtQlOWkF6CwuGIiouxjvsHJrjp40TLJCObGFYgLwYcpYvJLjzE
X-Gm-Gg: ATEYQzy5u32/8DRrOojOsGQORjpqlwaGDQSV22naV7rLYwshEXjRxUDvaOxVMvZsM/r
	n9ZpX/TJXI+fbHpVXV9ssPTSk13AHCH9pZhKrUrCQiSHNuOFQaAYNyPcPf9CMDAt8E1VwDjX+uf
	vyCjYP2QGr8hUiwzu3joQdBgZfaSkSNkifXNWRW2O7HXLUPdxSy1R6aJQr+hYAYo63kSRjl4KvH
	g04IFMKasQLoo7EsJZW/GV8ymZ2O6iOTq/RehIWU69A4lh9jVTmhnW1oZTitR56g9M1XH98l3ni
	4/a4U/z+5xU5yDCKdE8AhHD28cG/5twotXEMvxsBQDdY3EdlAfpgFrj/4fdRfnwjzy7PqPdcqLW
	rwqavZFoFstHiSliLwVlGS4yiLgpr/TV2HHkGGpKjP84hV9MixmYCjQKkrtm1hBGrEsnu/GjRCh
	SgEctRhFTBMIoSolcc/35FrA35L+1DS+4Sr30=
X-Received: by 2002:a17:90b:184e:b0:354:c593:b1a8 with SMTP id 98e67ed59e1d1-35bb9e7d24dmr3884224a91.13.1773855298811;
        Wed, 18 Mar 2026 10:34:58 -0700 (PDT)
Received: from fedora ([2409:40e5:1052:9a56:3b6f:933a:89fd:e530])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc5ff704bsm247103a91.2.2026.03.18.10.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 10:34:58 -0700 (PDT)
From: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
To: gregkh@linuxfoundation.org,
	sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Subject: [PATCH v2 0/3] staging: sm750fb: Clean up CamelCase names
Date: Wed, 18 Mar 2026 23:04:37 +0530
Message-ID: <20260318173440.9457-1-chakrabortyshubham66@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series renames various CamelCase enums and struct members in
the sm750fb driver to standard snake_case to comply with the Linux
kernel coding style.

Changes in v2:
- Wrapped all commit message changelogs to 72 columns to fix 
  formatting as requested by Greg K-H.
- No changes to the actual code.

Shubham Chakraborty (3):
  staging: sm750fb: Rename enum sm750_pnltype values to snake_case
  staging: sm750fb: Rename struct init_status members to snake_case
  staging: sm750fb: Rename struct sm750_dev members to snake_case

 drivers/staging/sm750fb/sm750.c    | 34 +++++++++++++++---------------
 drivers/staging/sm750fb/sm750.h    | 16 +++++++-------
 drivers/staging/sm750fb/sm750_hw.c | 26 +++++++++++------------
 3 files changed, 38 insertions(+), 38 deletions(-)

-- 
2.53.0

