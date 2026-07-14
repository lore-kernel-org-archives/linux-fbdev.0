Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6433557D
	for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056272; cv=none; b=UiRlZ9GgOpVQDgowZzeYtjAYWE9YB094Y/gUrZIhG0+cZW1yUGYihkQ+AsPKP17YS885CfCEMfW7Zyn2AxER6Oux61/cIMFyti19oxGJ5aIt7RUbAz9fCKxxNYzLKl/zEeoJEgwPm8SrdstK5MEDxzbsfPYEmJwfISP8Mhtayvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056272; c=relaxed/simple;
	bh=dL6AZe8iK0ixK2a7le+Esh6ltnlPeThUu0kyhVtloNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvBQpKkc4ch+wTgDUd/LlF/Y+ROHWud96lWvTfs35OrXcaUGaVv9WFlJyBTHRU0K8iem+4CiRIxsYQtEDOw/6R8M3qRqslqj6h/WGbgWvYZ5lrZN8CQUOBfntC1/P3duDC1YDMiQxVDIjCGPxdy57lztek2BQm36DCyZNn30pms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkLq2RDP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkLq2RDP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b27c7451so15691985e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 12:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056266; x=1784661066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V8cflk1NhiWz6I9y7ZdfFj/dVqPOluavFLdFslOwS/8=;
        b=FkLq2RDPUxWanNEL1MpKsr7bwRtYYBHcNxcumLK+Pmjbxgef//lp4jnWnRwp+XjMSk
         h8U7Xd+fCjns1WTaL8ahEZMw80IVqnaBelP6lSIhRJPDuekpIq0xl0GSYcSPumSCIG6A
         gqkLHOnheTNe5dM+8Ul4ZrbqACmlAQSND2iE5OBNtzgEdgxPAbbpDA90spRprgPlgwsb
         qlHIhV+HObFz0z6Zns8hs685p29i0ZNvwhpLwbXbsikktXY6EcxQGgbRhjbJ9vMGlLKc
         sHHqQTMbKUrL50Js4HJfi465wAQ3U9S2/Dkp8V3hnmiEMCjbaAjj4kv9oWDAa0AYXtOt
         QaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056266; x=1784661066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V8cflk1NhiWz6I9y7ZdfFj/dVqPOluavFLdFslOwS/8=;
        b=HhnUQvH/FH5Btf95gzsUyX+FxC7TkHY2RnKmZZ+AFKsz1DIecP4tBJQ1fqYsTBfgEB
         bIRLFvzbKxxIxGxaTJfZeZkUDJQbNqufWCDJzUm6qB9Q12RR4ngCF03PfXaT7yhTIO19
         0u9Pl/6f241K2HZ+2vD2f1o85r4NlI7EAh9pgxiShAwg+PSLDxURfdT76a7F+P3Xg+j2
         d5d1mIPgcMXt+1Dn/FDQfXgILox7UFFTOm9QC3b/wuLRG3eaKOi7wl2qR5535O7eTzSx
         H6PTyGdn6vMdwNLh76MwyJij5CxcDst8aAXOLTg7V8GFeeO4d3t8w9yHIaqfntrJRt8y
         IB8w==
X-Forwarded-Encrypted: i=1; AHgh+RqZz9oRFFYVJif9gXROTR/redc1CaYwshBvBvdXL3SkpzS2YEeZCey11qRO+Gnr50XlCY0h10byGpKQYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1g6IDKvRbjhdGRxn1fPO/O+67NRnfrueRLK6iml4C6T36EajB
	Hv6KCRFUTEGJrNcL86uIFv5OWOyE0l7eAbv8qN8SQ2Lwi3E9f+ryyoakGxosZ74vXH4=
X-Gm-Gg: AfdE7cmnaVlD8SlYdh0Ozxsp9vBJA0FiIs+y0NzBKCp/u3ehcvBsH2lv8R0+pkOLTUV
	dZOgcD2MhntY1BCepluft1gcs+xBWrHCr/9JCrdx6i9jJ3ITfoTlAZ4xxXWJ+aKie7tPNDOKMvW
	NAE+opyJoHhTFEL+vRDdqk4ZOR8JazAJ1kC/4eJUR4c4acL1f/h9t5c9XtvEzWt1i+/exQcHFas
	7iQlmt/RHr/e7+L5BC9JpcrtgVtTCaP3vjJ+QpfOFWcOeRNCn2hog7AtnNfdy182a5hH4N7r/Fx
	FyAA1LeUMfW28l5L70IV6F55oHsnO7W9qpH1qrddqOS2fZKxpCgl+eKgC6oFjYlNk07hO24nIpi
	0p0o3XXVE+eq3imHGNlYNBoBnaUi1nlZc3tx4m10XdP8hkr5WHXWp0vRi4G+wAekG1rYoLz68rZ
	GLhpDfJHEpMI6X4Kxcrp+ZTgDVklrlTkxZakWEXR5wyDYUNm1PG5ECsbb3uTHhzzKtdi8H7NEkS
	vQ3Vukw4fkxNTEA1FUvVA==
X-Received: by 2002:a05:600d:8444:20b0:493:e2c3:af25 with SMTP id 5b1f17b1804b1-493f88bd90emr119328685e9.12.1784056266292;
        Tue, 14 Jul 2026 12:11:06 -0700 (PDT)
Received: from evil-archie.tail5479a9.ts.net ([2a02:1388:23c0:16c0:aa41:f4ff:fec6:26e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f951asm100677815e9.14.2026.07.14.12.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:11:05 -0700 (PDT)
From: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: namcao@linutronix.de,
	tomasz.unger@yahoo.pl,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Subject: [PATCH 0/3] staging/fbtft: Minor cleanups.
Date: Tue, 14 Jul 2026 22:09:38 +0300
Message-ID: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Solved some style errors,
parenthesis spacing, aligning arguments, replacing udelay() with
usleep_range().

I hope this makes future checks with the style script cleaner and more
helpfull.

Panagiotis Gravias (3):
  staging/fbtft: Remove prohibited space before close parenthesis
  staging/fbtft: Align arguments to match open parenthesis
  staging: fbtft: Replace udelay with usleep_range

 drivers/staging/fbtft/fb_ra8875.c    |  4 ++--
 drivers/staging/fbtft/fb_tinylcd.c   |  2 +-
 drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
 drivers/staging/fbtft/fbtft-bus.c    |  4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.55.0

