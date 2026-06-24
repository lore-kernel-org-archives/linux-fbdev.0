Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593C25B091
	for <linux-fbdev@vger.kernel.org>; Wed, 24 Jun 2026 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286719; cv=none; b=JJN3/9YlxTBaGfRni8wVWAQUhMtGiRWWI6gHqDeDitxm2Azt+MX598lYoCujuxc6eRzu0ZBlc3lRU+0RJEBTDDGV2mn0Bvhp3D7Xtd0WeeXJK8WfqFrZeqE4nv9eoSA1MKdym4m73Hm6aXmlpbEc+z3dqwvfxS5bJxQj9zgvrd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286719; c=relaxed/simple;
	bh=5Z/CZfn0CfC8QFnMep1ReEO8WH6JJMbMm3qMgD2ezDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKtxBDirGwAHjGv8P/vPDxI6paXRqTdJObvP5Ks4A1cWc5gz7IwAt4CyfDPkFhOzXwYzgDGUVdN7rgdlYf6Dj7ZGOXMnCIxkbE9JU9DrAMRuM44w6knp1SRjQWSkuZZZ3//TlMKfftARzFzMmozivtvHQQYdODBy0hJnYMoZseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rge2GwKP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rge2GwKP"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4926046fbc5so5543295e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Jun 2026 00:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782286716; x=1782891516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vk2iYqcO7LMBB/0161whJq3oPaKM69uvROOVp1OGQZM=;
        b=rge2GwKPFwGUfU0enP3jF2DEQOugFPUrW1uJnUViGCRm+evlFVAHPF0D6e0l9RkkRF
         4drDXjWRMEhOhXmSburn6vs0s3lpBWmFfbgqiNkesCW+TdV1vxRcrZ436g6F1Drz92HZ
         pK0wYxWIjis1mk8SL920NpguKv1eRmZ3nQtCzpaWKWW1ooY3yRyyC+CadE+lH57xK12z
         Jd2j5s5idQMz6h8rpRy9GOGc5vbeJwKhR71+IRQa8b1FpmkJ4bnk6dZjnyE7jeJoOaRt
         +phQw+XcH6BjhyOFmTw+ltyQN+ve2scpnDdNc3GMw/DOxJLP7EmTp0gULmWGvVpEVQu/
         1heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782286716; x=1782891516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk2iYqcO7LMBB/0161whJq3oPaKM69uvROOVp1OGQZM=;
        b=OXypV2p3A2bGZhLc6ot0UjY1Nt9r75bDNxR2eAW3VkM8psFmvW8ZNEjSKE1QGb3WD2
         /xTgGeld4YBBsHIKDNewgmfJEqb92NKAPM8n63ClYOtBCNYAaY2PvFPuV5wUr10Iiin2
         22t2xzuZW6h8se9mDdbaAwjo1uJuOJ6Nl+eCmwvXEQ3/NPI2P+2cZEiYFjKLqIGmFsUO
         JwUs0rq4yZ55IilAfeKA8KMTFEktBt7HsWmE111OO8SycZnXaloJJVgFRem3y+W0s+5P
         xopfiUJEtFs/+3USKq0BZDBKa/2bs4BBVu+6ruiD8W2F+ZLceGKGDVVNVDFaguz7t5N3
         zcpw==
X-Forwarded-Encrypted: i=1; AFNElJ+IME5khhgyKiOATrtBEGHZyjHRDY+VlNfdAGSuczz51njXn1PoTcLCvWlQha9rXPmVghF3yAvqm8PWYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXgts4bvAUFOpQ2IAlSlyLnCzH9tNlzvD23iO2ag59hhycD6FB
	ytYObcyxYOF8riexsuh3avw0VlQsm9X6z68UvHd+dNHy+p7spc0yYqwJ
X-Gm-Gg: AfdE7ckjcEU1TCsfztH6msDtKVaY7K3hOCk329xrwtQpK9W/2xUKVkR5rArSslF85gc
	ptzJrihYGYc90iqGO/PxwU1PDtkCGHaAUAc5ltY8m4LxIriuNq83j1ApFZ9+8FMDdirq7sqMVFn
	2DljMz1nJAC/fuop+GElLFe3nzMB+U4DfS0qNTLwidrH7IHt4U/t1/akCDjnAGeLpDwXUjaf3MF
	w35RfD0e0H9a8P0UZLPxZZBgv9sEg9T0vHmJL8VquaMl6aVh9c5Nns7IEBtGS0VFQwb0Q2ny5Tp
	0NU5rk9xi2masilO2YpNdG57kdeJW1qRGSo+oK4obFqMIMPey++VVCRJp0G+4tQ7h/jw5S6gDp+
	ftLi7t0tApsF/+tPq9b46S95C/+ln+SctKif5JS51B6wilpA60PcvARujKOmk7seFWEjDwu+gyi
	VIBPYFnxWs2NYO2UcffrRWRVxc6g==
X-Received: by 2002:a05:600c:348e:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-4925a0c564dmr93840065e9.16.1782286716400;
        Wed, 24 Jun 2026 00:38:36 -0700 (PDT)
Received: from localhost.localdomain ([115.187.36.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49260915286sm78796755e9.1.2026.06.24.00.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 00:38:36 -0700 (PDT)
From: Joyeta Modak <joyetamdk@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joyeta Modak <joyetamdk@gmail.com>
Subject: [PATCH] staging: fbtft: use ARRAY_SIZE() in NUMARGS macro
Date: Wed, 24 Jun 2026 13:08:04 +0530
Message-ID: <20260624073804.4391-1-joyetamdk@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NUMARGS() computes the number of arguments by dividing the size of a
temporary int array by sizeof(int). Using the standard ARRAY_SIZE()
macro is the correct way to count array elements in the kernel, and
ARRAY_SIZE() also provides a __must_be_array() compile time check. There
are no functional changes.

Found using make coccicheck (scripts/coccinelle/misc/array_size.cocci).

Signed-off-by: Joyeta Modak <joyetamdk@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index c7afb0fd3..48da1503f 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -4,6 +4,7 @@
 #ifndef __LINUX_FBTFT_H
 #define __LINUX_FBTFT_H
 
+#include <linux/array_size.h>
 #include <linux/fb.h>
 #include <linux/spinlock.h>
 #include <linux/spi/spi.h>
@@ -233,7 +234,7 @@ struct fbtft_par {
 	bool polarity;
 };
 
-#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
+#define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
 
 #define write_reg(par, ...)                                            \
 	((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
-- 
2.53.0

