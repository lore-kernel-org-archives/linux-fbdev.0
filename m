Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA6346E7A
	for <linux-fbdev@vger.kernel.org>; Thu,  6 Aug 2026 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785977028; cv=none; b=Gut26RotANpZMiWRwnnVKUb1ziaqSnxL6rGDZIbaZtdUx2GruzcklMXQvGoCGQZg1mEQ3CN+nOrL5cFAYgiCPSI1uvWGVgNwghEeQTAtwTcATJX6gprSYXvzPKvP2Wt0xegAiBO5kc7+yClgp8LbimxaicQxyxRkGpJkwfosgbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785977028; c=relaxed/simple;
	bh=f/C38F7jfyhiNamhgj+2J3Uarv9zAZn+JoHs8l44B5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fLWNl7YUrMdUpt/qjEhMqK5WtUdf5Z8ej5matPzli8VW9T5Ci1e6pdykhRwzXbTxmaVHemMcrwxGIlU3zsLytpfG1K5z76YjN6wtZKlPysQocu+7tdqdbSOo408+0mQZaZg2+Q/GouOu5HuXEIRNXBc2Jl5Bu0rrQ5ondfUl7lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMYa/p4+; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMYa/p4+"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-529a1ee0e62so10674481cf.2
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Aug 2026 17:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785977024; x=1786581824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=64E9cSA7smKn17NrMcFh/iNHZ8v+Am6PSKOl3YRRdE8=;
        b=tMYa/p4+YmOOHIZp9CtmIYZbLF/fAfM/l+pkunD3N6NwvrWUWIkhMhKyYLYB69ryX+
         owYgHbYhrdZTt1WlOwRQPney+EB+qkYLhVogjWjYe/NpKb+ewxMTC+1S9pKa7xwQXQkj
         b3wv1p/ETnGz7p1C/lJWu7e7YalGT4GkOZq/o3yAdeQxjJIyG1EW6G+v2STF3Qjb8KU1
         3g14kD9TkI37MvJwgqH6ey17zuFg1fATm+fvbRx3o0Fz2PB7h8/o70p7KMnAIf2uiUDe
         h1TrMgNnXxdvUWnRX8SL78LWQitfzX3atRfM2S6anLgcvR7ghfczzdeZ7NXTrmvOMJLq
         Gkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785977024; x=1786581824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=64E9cSA7smKn17NrMcFh/iNHZ8v+Am6PSKOl3YRRdE8=;
        b=WyENIYZMK/IQTnfqehPFALX4VWd5aGZlYRly72A9wrBED7X+ANfiZDBngSD6IQH5wQ
         a8oY7Zo30zETJ9+pLoXTO95WGwj1OFa4HzOmESOVRv5YPmIsQixOmhzbgZJCQWSO9oSe
         C3xhlikfDvKjpyAfAjtKVUBdQ0MR8thjZCB0Z1xnHGA+RnHFD5NvBwDB3AAiDmsnkjt1
         nOIi9yIuuA1KlRYOaFm4InSKiQow9zk1LCSPFZ1zB8+vfzFCwOnizB7yoaCVT8ERzaHm
         r3ZTI7SlmYRma6ODN5tXt7sUp3LwAO38mfQgy5XcAIErlr4VE/CQhw6JfTSo292OXqlD
         0hSg==
X-Gm-Message-State: AOJu0YyHCd3rIcxWqHHvApN5INiY0y1H3pkbeLDpANbw3g+Gk41UzZ+F
	TBcUNszDHYvFb0FpnPAdOHI8Exf/IQOW9GcudblQ/aGmN3xlGyHUSVfK/FiWuIWCoh/gQA==
X-Gm-Gg: AR+sD12dAjhffymjv1TUylTNxP8Tx+tUnxe3TfuObS+WcWQ9bgZNhSxnRmySE7ske3j
	Av4CFIhcjijaaUzHbETiluSIAMKhott369b4dUc8ocY40zQURyh4nIppnuJznZWO9zs6RNzcnPx
	lprgi48uVJV+KYEZ8KigHwev84ihSwCDjIDdEiViECVl9vnRqgFNCT+WL6Wba8EM1vLywnVKJLC
	ngSNT6cXfehrsDS8u1+8n7L1n1FPKWhs8W+p4Kh0dF6lZtyr9ByybG92n5HkhN3tT0axMfCmoCz
	phUAS/ldnKIhBhvvsi7l2uSMTaZBfFEGI2nEh7uf7aB6YmI1vIBuKbQi1GXWTLqkOpqJamxh0Ik
	AbHFGlSZs+Z9v3E5UMcg2DdnFOBOR024jg84Ap2Ok2b4HJAy8Nv1Z0F6GfcPj05kzrIRgZsly0D
	39wN3whGj9yWlJhyjbxZ2jnM/umMd/V3KfzxgvyCRGRdyUy7b1OtLD8ql0uVAj2WIFmRYeAQrfb
	uIxp1jmXq38F1EnqtjHAVCeigu+eyEZGPGWv3lHeNy1tysj6I53w6TOR4eh0E+mg1+IknM+XVXV
	VY6twu/1WERv2GDsW4AdBRTXPkSOQOrM4f6bJxUZOKYWehOQpDpwiAN3xdVZ6nKNyg==
X-Received: by 2002:ac8:6f08:0:b0:51c:1e46:711a with SMTP id d75a77b69052e-52ce614523emr127663011cf.24.1785977024279;
        Wed, 05 Aug 2026 17:43:44 -0700 (PDT)
Received: from alex ([143.244.44.172])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce892a695sm30989811cf.14.2026.08.05.17.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 17:43:43 -0700 (PDT)
From: Alexandros Xanthakis <xanthakis.alexandre@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexandros Xanthakis <xanthakis.alexandre@gmail.com>
Subject: [PATCH] staging: sm750fb: make g_fbmode array pointers const;prevent accidental modification of entries.
Date: Thu,  6 Aug 2026 03:43:25 +0300
Message-ID: <20260806004325.3253-1-xanthakis.alexandre@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alexandros Xanthakis <xanthakis.alexandre@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c..8f533f3b1b42 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -21,7 +21,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel __ro_after_init;
 static int g_nomtrr __ro_after_init;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview __ro_after_init;
-- 
2.55.0

