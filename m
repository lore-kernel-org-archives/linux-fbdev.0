Received: from mail-pz2-f20.google.com (mail-pz2-f20.google.com [74.125.228.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF26283CAF
	for <linux-fbdev@vger.kernel.org>; Tue, 15 Sep 2026 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467077; cv=none; b=bkROxrJXNVJA0eiFDutg5z/WQokUd09TfR6hS4Kem8lxgKcHIHriki+VuHRc/tS4JON6EwWDdlDS/bFwdxv81UNi/S/cg6EhLW8MSpL/AymIZQEk+OJ9DXWqnlKlw+6HM7E4lvSc/WVjBkljDVnd0jA7wAvTcx9UAvhvFrbgNDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467077; c=relaxed/simple;
	bh=CWjz01IGEO4DhBFkusR7Nz1l/h2qMp9orMij3MJtNgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhbbjFt9AFGeq9eo4n/oSed8zB0SZqATxP9sjqkPdHWElsz/wOWAZkT4QCylf16TPRBET56C3p35fOi4necJIM6Xh+N1uqwQFPfBHV463QQ7GKXDKLbVbRiqv2/dVal+1hiAIp1JpNfnT3H2VWVhN2HOLyvfqxXh9oISYWZWeCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGYJtpXC; arc=none smtp.client-ip=74.125.228.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGYJtpXC"
Received: by mail-pz2-f20.google.com with SMTP id 41be03b00d2f7-cc4ae61629fso2189602a12.2
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Sep 2026 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789467075; x=1790071875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sq/lagHSdcuwlRE6xG/AIJTxTk05xbO2fOWH3pVtZM8=;
        b=BGYJtpXCrsWN/e/mq+OABG7PBOLXl24r8H8eX1X4Fz85vy1o0AX6o7lH5BlTLBnmMl
         kYOxMh0vWreohTCFTJimJW1VfP62OHGWj6MRRpC3Bc0409HO94pRnYra751b32LDKM7d
         KpM4DDX/toCxzyzZMy2dyVlYGjRcjK189EhxQ+qUZtnwDJ3NY23IEO/s6o2Iu3OCSDlQ
         enJokB3aXI9TbyCx7KgjFvL/laQt5c0d9M8BdGh8afOhNFGEkUJE90dJ8KhyVDNr8LDV
         Y9rRDjtMHVTGLLR6v6b2Gn5D41o0p6+612tn5hgBbKe3UAYCmwdN+RMXaj2Y1h8lgFyE
         +AkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467075; x=1790071875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sq/lagHSdcuwlRE6xG/AIJTxTk05xbO2fOWH3pVtZM8=;
        b=rvUn5ODbUTs7W9jlR9Avd1GWp/XFu4d/HNEeEscpsfTjmhXgepY1Itx52nvjU/i1Tf
         8HaU3LDKCId+qOMQHkOXyMz/GG8DmofNyfjjOtlFebnF9QoMdWy3hqwbomtwIfi8O/Xd
         0kCu9YL3zIFSMC0cHPD80KCwxNWAdziJ3zrsjM90yK+yfQ4l6hvNalXZTSuM7mCYrong
         GwgZvwxUXJmnCjNfss1kiAoD3vDJow1YngDxEqmt49u9SNrkpWAle3pzt7MKp7prk88C
         Ix7u/JAdeIUJfWJYbklDCyyPk/kdranOHfze0S8dFQ9//DWZeCd53fW/7dWsycn2MC6u
         tbjQ==
X-Gm-Message-State: AFuF++lXLWgpq/Vq0IDvZAXMhSVKOjMCaHfkqUy0sa70v6weOg1aLyiO
	Bu7gQEo2D7ULaY/ba6mPg5CU3oozOPrO2vHYysg6Vt+Arv3Nl0ME/N72dj32Pw==
X-Gm-Gg: AYBFou1jlVw+atyp5b0Zwz581CJPAhtmXJPsDVn6vXclY9fhy2InT9F1Nb0Nq/e9GYT
	WDNwjAUKgRRcLfsjab0aF8v6y15SaZzte2vFgB6y3qxdjGysyreCwULRhsPfYAywvCqLMpm3nX2
	SD9rR54Dto26WZ8ScJDzMQIIuDiYVGXHtVLH3oDrX9084A6GnAGKOhpmTxFQXN2PU/GF6xjVsMx
	Kl0tDtKJhUSQDwIYkUo4rJkyhlU/5msk0IqoceS7SXPOARNaQcg0o/Xp9DHWAY8xad+RqUQzLSt
	TaI+CvMYu5h+LJF2a6kp7uO2fCE9NnhOkqRQmCKL/En/ZrsaXKUWqZ7pp2IP6knXIPmahO6J+kS
	cfoK+z11LjTTbgXKttk3b0bR7OW62kauIjgrVCn2l1+ffldcCsgnhh9LeuKgIZf8ld+JHz3YKt8
	XJS0VOR6yoWn/IReBqDfmjf5d1L44nAAJonT7bMoLl7Biw1EDPGnOoBM8oYuORHakvLmgDyL/9d
	Ldg24YQXimJB3SqvOM8niycus0e+fjmyDxd8zXNuYCPL+I6MMAXkEnk/nIiDAOgROf1H6HQwaeg
	+EqJ6f1P0qrfSByxhdJlm6tB8Eub8jjbYazzmNHnYdJP948=
X-Received: by 2002:a17:90b:3b85:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-39debdd9c94mr13483292a91.0.1789467074668;
        Tue, 15 Sep 2026 03:11:14 -0700 (PDT)
Received: from my-oracle-VirtualBox ([106.192.128.255])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f06423sm38610336eec.20.2026.09.15.03.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 03:11:13 -0700 (PDT)
From: Manish Shah <mshah3409@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: linux-staging@lists.linux.dev,
	Manish Shah <mshah3409@gmail.com>
Subject: [PATCH] staging: fbtft: remove prohibited spaces before closing parentheses
Date: Tue, 15 Sep 2026 15:40:56 +0530
Message-ID: <20260915101056.66210-1-mshah3409@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove space before closing parentheses in define_fbtft_write_reg
macro invocations to fix checkpatch errors.

Signed-off-by: Manish Shah <mshah3409@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..409770891c54 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.53.0

