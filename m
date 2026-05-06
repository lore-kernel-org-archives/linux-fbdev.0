Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4B9463
	for <linux-fbdev@vger.kernel.org>; Wed,  6 May 2026 03:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039815; cv=none; b=Xt+1f5xMeIv0aTGo9tuo3LR6Zi5jI1yKO2FHhqsVeTc4sLv1IsPWbQgNSE1a+OTvzUbn5e2MGXvRkUDZeETfiM3NHqBd0tXjl+r+cAjC7JEK1J9qh96qQ8pfwa6Fc4DONSWAHZQSMOEQEkgJI7rr8VxNrzIpjKUIAcoUbF/Gv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039815; c=relaxed/simple;
	bh=6ko7eVhNJ/bCYiS5Qrb2pV2MACE7rarZZC/4lEmFKL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7Ymid2QRqhf5A3jYfqBzyRVV1E/BJXNcEVDZHxfmYhsZxDMzOdtko9nfOH+sFgmL9/QrV5+Vk4HsN1877x6zro3YrDVFTz1kubAloOD6VJsDB4lBbZoLX3KUGCIOYXzSZm6oDYRfVq+rCR9ETWrmOED+lgIUupCj3POHrxDKgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGLwwZn/; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGLwwZn/"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8021c8c42fso1079268a12.3
        for <linux-fbdev@vger.kernel.org>; Tue, 05 May 2026 20:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778039814; x=1778644614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=htI6+XoNqJlwt1fmMa555xnswcXaknwDFHq/WqS1Sf0=;
        b=oGLwwZn/0p7hdSSt+Ltnym+FChApMup2nh68PlHTYaYhiRNDkYLDxrMjc/BlnAg8CH
         LiCzj6lrwaWjVb2vTY8SuZRjloFyNjFtOrzoa2naMtOxE4dj0b2L0q13RHgjWudN1Cws
         kBULFtu1ay5vY2AuD+b6CbnX+pMYnfvxgQE8xMCJe6zcaT8BoDJ2Y58jd3hgVpzRMLjg
         B+fgjk6bwISclY8+rT28yw/u2mfYM3zrNlzpIUuB4MZuw650fbYEGKL943gaLfJYFnXC
         J2y4NQ6nYZZoerY2yrjMJHCltZBIc4g8OXk5p7YaYquwjhs9C5J87RNAVwk7YYtdpQNf
         9Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778039814; x=1778644614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htI6+XoNqJlwt1fmMa555xnswcXaknwDFHq/WqS1Sf0=;
        b=DhDvsGWjEpar/Wu1pOAgWamc5ijbTt8h6feKLNc6RpeemywMdsvha6KvuFYyvqa0UM
         jsafE/PUe6qrB/c/OUu21jiMmU2A04Ng3uBQlhFwtHjXe5bGvvDnYloimd82GrleGIoY
         LJKgqNFip6EQKpT/gzdDvPz9WdIXT8xV8OY89yKJ7KHSqroxT/P85g8/sCDnGFyskq5R
         qhrWsSxyfbWEp45OrStpuMY57F63V7aDsTErkep5fM5zpCQl3eQlm0aNaI5YPelMlQKb
         cDTyV4NEJccZKpKcUQjfDaaf4QeWjOC3cNFcs0E9nxWWp219nbZijbn8KZZZ3JQZrpr1
         JBnA==
X-Gm-Message-State: AOJu0Yx9amlw9aUD6+EebOuQetJtNA3tyjfXIewhDqACIU4ajeDoh8lP
	ahfokEEQOYssYZfsLaZWhOf03ON6QQaLNrEJaa30fOHbuqbJbqIjCjhI
X-Gm-Gg: AeBDietaw5OBk2+3AxfeAbgGzgoKRqR6IbZETESNrcGy0kjGGFFl+5dqujUZC72RriI
	gLJD8eJDsV+j723LPQjVhCokkaB3IaTsiCb9qXTEkFsXMsJcu0hazWW4zA3KrdsT63E3nDa/RJj
	7OvhqtfgHJ3wf2tCMFi3MG+wbiP/u0TdUCuNBqwBEOBvqJfHZpqnSBJa/CW5bzGMMHAyoV6b764
	hHiytiBUhnkrcKht6U7r8XlBw8ZGveKV3ymdruOG6fr97JVTRgpXhOCQr7hW2LN+f2VFBEM2DfJ
	rHGWvvNq6ZpiqMtBFlAyAg9h8iMYX0cz6uWWWyJx68d77MILQfcY10ohXBetinPryCUmq/H4Ist
	b4uQvo33qN8ofRtQ4OwQX3nBvAHKiOo8rEjnYbzwsMW8b+W3Pft4kpKOYQE3fFU9QjcEQ2N8P8+
	8HiYTWzucDyUlib0uY2fiB7QbR5Q9y7Ro8uW4Ede4Efe5tPRvFPEyZgryEC+7Jhru/N9JxCZmEB
	y+qXQB4fKg=
X-Received: by 2002:a05:6a21:6d88:b0:39b:e710:e2e2 with SMTP id adf61e73a8af0-3aa5ac1ae28mr1619760637.46.1778039813617;
        Tue, 05 May 2026 20:56:53 -0700 (PDT)
Received: from chaitanya-virtualbox.. ([103.249.241.52])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8242ab50bdsm698939a12.7.2026.05.05.20.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 20:56:53 -0700 (PDT)
From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Subject: [PATCH] staging: sm750fb: add const to g_fbmode array
Date: Wed,  6 May 2026 09:26:41 +0530
Message-ID: <20260506035641.5060-1-chaitanya.msabnis@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a checkpatch warning by changing the `g_fbmode` array of
pointers to be `static const char * const`. This ensures that both
the strings and the array of pointers are placed in read-only memory,
preventing unintended modifications and improving security.

Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index dec1f6b88a7d..08d4979c6755 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
-- 
2.43.0

