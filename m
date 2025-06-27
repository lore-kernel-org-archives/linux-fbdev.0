Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295BE35957;
	Fri, 27 Jun 2025 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751045494; cv=none; b=hijTASbkWQ4SDZHa06h00u0JVGGqRI85zmxJq+yontCyvNlkH6pffKD6d0oP5LS8h2jYXE8+AtdjCsg7gQayQq6SzG/BeEIWRuAIBJBgqk8xL33hIxaYf1StzVS87QQ+jVC9p5wK3aLLypbwqSlEP3384ptbNbZrhdZg5G9Y4hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751045494; c=relaxed/simple;
	bh=JkQJjF0Qec5T4iobN1AOTeyQ5w/nJDrM5+viPyB3/E0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBA2lPKciR8nhCh/6zT6ZzodAHplTR5hIyl0ucbBgp0xJjlu9BpECdNiEjS9TiiLbuCePz9CIpbMabtCAni1Ek6CvVMIP/16QfUcQ5+8dLYFoc+xL4BPrEYKIYROX2O3bDuvUDgMAg63vW97pBiNlHRMyf9KqX/UjlRvfHpdwbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB1NgpfF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB1NgpfF"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747ef5996edso149345b3a.0;
        Fri, 27 Jun 2025 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751045490; x=1751650290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oTfVgFtzOFOfg6vIGvu1wxSN1SyeGW/viyLGmJ6OnNo=;
        b=OB1NgpfFxdCIdbRj1kFd2qqIUpo1cQePUMCXbwRyAX8fpTXPRsiTLIzsoDIu+rVt4H
         xCEyGkkwvVZqOvzU7gd0XvfEzebSst4M4cU/Awtr/KL0KyRz6ipqiniSoFJvgUNX+cXM
         6xuE+153b9dnOIfhe5zTGHkq2t9a5ENqIt+7h+mGdit1CUEOWPK3H2WeSbBsJqeoVDHi
         KvOTnOC/FW/xTOLdOykPJV4hI1yHF38CK9P9WlelBpPcRNdqmpbo0fam8g1TtYSF3XQV
         kuNVH7xj8kqnnyhPRKZaEWtTImIgK/weWezLtW7Wh7cSePh12w/gxQYN/HmSaUqBm0KZ
         R53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751045490; x=1751650290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTfVgFtzOFOfg6vIGvu1wxSN1SyeGW/viyLGmJ6OnNo=;
        b=tjV7ESbC3+uDZBBG2O6xXc/HPLpAZVqUtvmbKMl2YipIop47LigDqQI3exVfCZdKsM
         Gb0mEFevSCO5wuo1qgZ2anRvnvtBkUjwQOQumO5BoSNFCb70DzJjtT9A/tYHxpwPdurq
         1eanl0vAaGZ8v3oopwRFnfSz9mk3n3IAZ1yERo23kGWcY+5ghgArluvytl7O9RUOmsnb
         +WxVTnJZnTmhgPh9chb1G4FaqbzKKmMC0RKKx/6J6ng8TqWKcT0szM86O1dVJjLOnM+G
         XKm0b7XHJLBBQFKGQLHv/VJDxmPYpyjND8AU74Ygu3eBbkKCo8VWhtEaBjSLpHjO5bDj
         F1+g==
X-Forwarded-Encrypted: i=1; AJvYcCWZcWIevbyKe/Wku6gpri/DSdZ7++EzXmtdIOACtlJ9KDlCr4xVew7Xuu8JJ2477O/9bpByQKcdI2ZRpa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgYuHKj9X/FxAg1GQsy1i7Dc5WWrMDawfyesOOoOBboqFAnbO
	ucZ/g0z65E35RqJeNsm4ULvf5zrW93uPtjravWvw+hH/LxMA9NVtxFPL
X-Gm-Gg: ASbGnct7NOLzYcUNImDxML5cMEqBsWzboXxVu9kMjd4njawmtyyZDDDYbeSnEMaIyoq
	HV6eCeta8eiYgGGn38I14Q6d1MrGOkUNTWu4pHmiMn5mJ5Sit0WkCNvO+vr1j4g4Yj+VZgHI52c
	WlXnFPIPD/mng3WSWURyzPkc3+pm5wCVf0n3LRaMUQQtktPrCjmFIIKnToJniWYGNW8Gnlm8WOq
	rnsHjR5Evo/DXU2OTikczfLgMxZ4fN9/hteUnAjGd1tcDjPXzJ7o53hDrXNIYfwiAQr1D94iI9o
	5b3W21bqL52BKni4H4nvbRP4tZ2vVE/xHG9R8FeewfRjUg9k9Eu2cQiP2zqExIE=
X-Google-Smtp-Source: AGHT+IEhIMepfK9nCZUOQR8wWahLBJNCF+QFm2OXbbyiVTTKrfuS1lKZ88tt5z5/UNXFlfl4cLUdMQ==
X-Received: by 2002:a05:6a00:9094:b0:748:ed51:1300 with SMTP id d2e1a72fcca58-74af6e61c70mr5347132b3a.9.1751045490378;
        Fri, 27 Jun 2025 10:31:30 -0700 (PDT)
Received: from muxbit.. ([2401:4900:1cb8:b350:f061:66f3:baf1:5b2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af557440fsm2907764b3a.74.2025.06.27.10.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:31:30 -0700 (PDT)
From: Manish Kumar <manish1588@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Manish Kumar <manish1588@gmail.com>
Subject: [PATCH] staging: sm750fb: make g_fbmode[] a read-only pointer array
Date: Fri, 27 Jun 2025 23:01:20 +0530
Message-ID: <20250627173120.7639-1-manish1588@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a checkpatch warning by changing the declaration of g_fbmode[]
from 'static const char *' to 'static const char * const', making both the
string contents and the array elements read-only.

Signed-off-by: Manish Kumar <manish1588@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 1d929aca399c..e77ad73f0db1 100644
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

