Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FFD357722
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Jan 2026 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520488; cv=none; b=Rssxk45xFFTl/9l9brkgb2trAUOtcZFos75X0Thl36RXQEP7qsf5fE6HMlnhIXUUVfc+Ualb4CHB1XGZ4lT7FJGoVKQI75ugZ9SQ9ZHwn6nNXf7DBP+PH/lKVIx3obrUU+hIgSIl0YrZBm7Ry3AwPPgtSC/SJdIHufooK21FCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520488; c=relaxed/simple;
	bh=oFuZ/HRtloYM9iYhuq4BViSywKCjv8X7x4OXI/5MwlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qhk0JNAsEPaoJzWyQ7oBkkQ17YVKlu+z4VUeso+e+Ubn7Xn+6ibQe9TOfJMeV4GS/f88IywhDagI4dfMIQyYGaXRp9+jNhbn7iH1kxkSE4Cf+RW3cQZCegcBFngqUe8ZIn/QEZ0Lgc7lh139dyKQ1dYIvGsrHCebHU6NetdmjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaG56xM6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaG56xM6"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fed090e5fso3473701f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Jan 2026 05:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769520485; x=1770125285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vt46RssgikEJSElwuUT//rA9kswfqTzUa3QvVRbgabw=;
        b=JaG56xM6nWo7I4a9NBif4bgC4S9yhzciEPCTxyICjWGbvgQPOpErLXwF6YbneTONVe
         zRCRn88/o+pn96UdsxikXayU0eSwrPdohKA/CGAh5TopEXO+fuGGhmX8fJLpUzq65fh+
         mSpJqEGxVZH9yq7ojRs0ldAQzu0xDh5xJWbG6mwse5OQsLFzXtXIwsPe8FjebzSSNkaM
         Eoy/u4cQQ6Fi/jKjv20SzRlixyU4W+mlTddKQgfM8QMReo3nijo8Hpo4kO2eZAMFjL5h
         JSjR5Eu8+TtROL9kWyO2lMz61DHcS+ctbOuOmoXayNl4/1NZlkPBQBepgskzmZ7vvt+2
         ftnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769520486; x=1770125286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vt46RssgikEJSElwuUT//rA9kswfqTzUa3QvVRbgabw=;
        b=MSiAHd/C1zdyy/PKy9UgCEOTfemY+b7lIF2Pn+XtH1eKPpz5ZtwI8ig6LmmB8U7QKl
         VI2DfijbCVn0qAotywYpI0d8QJTOOHkhDpdCTL7WXrEEss0rg9qRtZW/rbXxQgqB4Cfh
         YUMMs26cynuM8wq6P831X4MTOaBJrIdhu+WUMOBd0hvqtWMWB4CBSsTed4W5+MqwNCmo
         Pa81lnz8Cq0U7gGRq8p58pnwR0dYQQ32OXmVgekeveeWkytJLkGvQAJ+4tPDTtZkRvve
         G4eV8F7sDzLcV4mYBoTCP9IChZ/mUhfP8xc1z7ID3xl/Ilj7l+9/gAb/f5ZwqkRyy2Qa
         5UzQ==
X-Gm-Message-State: AOJu0YxB/6vTfS2kwtvBNl0IxBB3tVxXt73SLGUkms9iLw8I3pgWlKR6
	O+Oa5tC09vcMPk6qvHWFG8d01x13V3B8MqPq3Z/t+e6sxfs4KaFnoUjo
X-Gm-Gg: AZuq6aIFXhDSmNMA7cvEQktfcu6XFv8Z306hMinOn8hfOFuu/mZlJRL+Vvry4OZxPyx
	U/fTjlm8AG2ruPKwLRTiwYLgypigqVof8kC6L0pv/Ivz8DAUEyaSqVFeeRYNm4wk0qg64yHJ0dZ
	LU2hyX0pxEqoZhnjGoGmOLY2TnPYw0JTSGG1tPMjoDsKtVe/PhPN6c9+DzXpTVMLo0YNLMDxgc7
	COsTvaKXE/VCoX9H3w792N5I/exu//9afzCekcK+V8VHeqvHDth8FOgmRSJ2OgVqXBcwB7DasL8
	vXXbFqQLLC+CIg5RP3/n7v5qES71wglLpIN4Cif0iRJVXIh6juD2jSf4leUFlinvJsotmIONbKV
	9MMBlRBkOwuYvnxz3NfArF8YObZFUYn5jdNhvXGgJsZuLyMG1m9gdB/OllwObOaKT6uEh9Bza2O
	BZs4nTzMVT325Hv7xdVkg=
X-Received: by 2002:a5d:5d0a:0:b0:42b:3131:5437 with SMTP id ffacd0b85a97d-435dd0a3e50mr2509020f8f.34.1769520485372;
        Tue, 27 Jan 2026 05:28:05 -0800 (PST)
Received: from Madhu.broadband ([83.106.123.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7ba0bsm38902304f8f.40.2026.01.27.05.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 05:28:05 -0800 (PST)
From: Madhumitha Sundar <madhuananda18@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Madhumitha Sundar <madhuananda18@gmail.com>
Subject: [PATCH] staging: sm750fb: replace magic number with defined constant
Date: Tue, 27 Jan 2026 13:27:58 +0000
Message-ID: <20260127132758.49650-1-madhuananda18@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware wait loop in hw_sm750_de_wait uses a hardcoded magic
number (0x10000000) for the timeout counter.

Define a constant SM750_MAX_LOOP in sm750.h and use it to improve
code readability and maintainability.

Signed-off-by: Madhumitha Sundar <madhuananda18@gmail.com>
---
 drivers/staging/sm750fb/sm750.h    | 2 ++
 drivers/staging/sm750fb/sm750_hw.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index fcb7d586e..ae07ceec1 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -12,6 +12,8 @@
 #define SM750LE_REVISION_ID ((unsigned char)0xfe)
 #endif
 
+#define SM750_MAX_LOOP 0x10000000
+
 enum sm750_pnltype {
 	sm750_24TFT = 0,	/* 24bit tft */
 	sm750_dualTFT = 2,	/* dual 18 bit tft */
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index ce46f240c..f051bd75f 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -523,7 +523,7 @@ int hw_sm750le_de_wait(void)
 
 int hw_sm750_de_wait(void)
 {
-	int i = 0x10000000;
+	int i = SM750_MAX_LOOP;
 	unsigned int mask = SYSTEM_CTRL_DE_STATUS_BUSY |
 			    SYSTEM_CTRL_DE_FIFO_EMPTY |
 			    SYSTEM_CTRL_DE_MEM_FIFO_EMPTY;
-- 
2.43.0

