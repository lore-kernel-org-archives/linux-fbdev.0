Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048D3E0758
	for <linux-fbdev@vger.kernel.org>; Thu, 28 May 2026 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975420; cv=none; b=USBercasY44y83UtuQ8MePdwG6fJn9KZ0YhkqP2i6Hexow8TihIc98jNIh8nPRw/4pA5zmtICu9S/NDINJVKgTDmWpQ+CJnfZCdRl+YNUNIrf/MfVDSEoSYIvCgjLb4RbA/98R1E/o4wbfncOavqWatgL7S7NkWRzCVgpYHN1xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975420; c=relaxed/simple;
	bh=1+sJkp3JF70DVYP25P+ln6YCeKtna0Et4kJeHhu8DTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjEihAqt8aUqt8qfh9HUfB5FmhCJ9wFzXV+ZAiKlVyrT9f/lPilD3haGQcCY4mpwPvfEAefB9iriijfBo6pezp40kSpZPRGcSzIgLo/osILLhskAvmZpsCOH80nkB9xg5DI5bsISGv+04vsCoD07Lh/+ZhKDMwN+00cqez2+yOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mluafbiE; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mluafbiE"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c796163fac5so9833343a12.1
        for <linux-fbdev@vger.kernel.org>; Thu, 28 May 2026 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779975418; x=1780580218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t48DyodwJlxPQheligpryTlIvAFX3VKtkm/H9IvDGZU=;
        b=mluafbiEb/4m+/voIYiMgRv9ED2PQx8TXXW1nIzlrXgkowyvzh0WbPjMUQkN5US803
         fawlZVitzlSFAK6Fqdas3GZS+w5WuKPCVnwkoM9QS5YGhIJx9sNIpwZd7iE3E8pJ8vLe
         FzPaZY5EkFcEnqRnlrDStA5LijFcpkQcKONfRZfjDIQIrkZGns9tuW+XAXLHyKQurDAK
         Hk68YIePY8dFwZWyIGnUWTF+iagLdH02+FJ5VdG/TsThmrRn1YC5MRRqpfiKYRUBIUvQ
         yJmo1qHDVvG14iSKy5WTqHcloYgd3ivvFmlJGYY9zjtLsloy0Z/ouqVqMbIuz1fh7l9y
         wBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779975418; x=1780580218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t48DyodwJlxPQheligpryTlIvAFX3VKtkm/H9IvDGZU=;
        b=T4+/tY9ubuT1VBB3/8OnVzkyyus2EwaIm1Naoiy9lFzZoXACLfOZvUcS3+2jhl8LTE
         Uf/VxsLFVx5I8m0LtUrWuzXE9bLnsV/3ouq4fe/jGcFoKJZxpSXHi2duTDsYd7+4Kzu5
         yCjWezBWHNvJoxRvBXgOUMKKoyhllP2o3FWjvNXVkETu80zlOkTjlYBUlMcBaiSmO6Rz
         EL6s2V8LFUrKJn4RyFfzN/Ae9oDPE3Wdxl8SbDL+flLrrw0l9VTxWTWSsSYZybWjZycX
         ID/U1a3vwI93TVx/k7WB1wAMUAX/qgwuord+rL4gh1UzaP+2Z5ip/xnlAAFUMfRhH6Ub
         wLJA==
X-Forwarded-Encrypted: i=1; AFNElJ9v2YlpikfcDwNPCdV3qh17dgjTigmzY3dyKsjF+lzeNjmK0u8s+YlzQsskzzE+Ix6f/8QucgDUmtTFgw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3nZDEnlXBtJ6W65bnRXwvBfEqRdqhyKfqeBHFPH88MyfyZJm4
	UygkOCAl4SPiIhlnybIs+ClqNAOq+VRdMh7iWdneA0ChOgZQJd/48fMF
X-Gm-Gg: Acq92OEM3Jr2125PRWd9Gms6HXRrhnhhdEX+sTfkhJHGIZMLISfixS1WSDTo0jmx6Co
	0uPxyqGPC0BE7GHbUtQk3Hrf9dy/LtNjhwVzWhwbgRJZl8gq5bbfMvuUPjMAq7QfqRyZuw47zI3
	cOgx+uJ5n69TzB2/PV3PLKPv+UtEYWeqNYBDJb+tyEXhiKk9W4nquyIJCHM6dZsgpgZPldeJqGZ
	GpoVgXM/YnVMptJKOXuWE3E24nIY26mCvBRwCVdtYQFA4Jd30s0wsdGZmcMioPfKoKqGO5cJ0iZ
	MdcbEePFa1PAxblFF4gBhkqu/fGBTgyyui+y3z+VWbjZAc+n3megpYlG9vmDehpjmtpfIi2UYWQ
	3VyPSGVwq8tYw3A42ZqBlo1jS7gbsjalJx1BTRBg6P2+9eiXOd8ppUZrK9fsUhGK7aLIviff9vH
	9+5wJolQjjsuks9yHJb8GSvHS2Wg7SATrk
X-Received: by 2002:a17:903:f90:b0:2bc:dca9:f0ef with SMTP id d9443c01a7336-2beb0770a09mr321444295ad.36.1779975418531;
        Thu, 28 May 2026 06:36:58 -0700 (PDT)
Received: from onish ([2404:7c80:75:55f3:d423:9757:6acf:6ef9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf13d83264sm8696405ad.17.2026.05.28.06.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:36:57 -0700 (PDT)
From: Onish Sharma <neharora23587@gmail.com>
To: sudipm.mukherjee@gmail.com,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Onish Sharma <neharora23587@gmail.com>
Subject: [PATCH 2/2] staging: sm750fb: rename setAllEngOff
Date: Thu, 28 May 2026 19:06:27 +0530
Message-ID: <20260528133627.10850-2-neharora23587@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528133627.10850-1-neharora23587@gmail.com>
References: <20260528133627.10850-1-neharora23587@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename setAllEngOff to set_all_eng_off to comply with kernel coding style
and improve readability.

Signed-off-by: Onish Sharma <neharora23587@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 drivers/staging/sm750fb/sm750.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8f01b3c63fe8..716a8935f58d 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -848,7 +848,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	sm750_dev->init_parm.mem_clk = 0;
 	sm750_dev->init_parm.master_clk = 0;
 	sm750_dev->init_parm.power_mode = 0;
-	sm750_dev->init_parm.setAllEngOff = 0;
+	sm750_dev->init_parm.set_all_eng_off = 0;
 	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 0492b1afbb11..e8885133da2e 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -44,7 +44,7 @@ struct init_status {
 	ushort chip_clk;
 	ushort mem_clk;
 	ushort master_clk;
-	ushort setAllEngOff;
+	ushort set_all_eng_off;
 	ushort reset_memory;
 };
 
-- 
2.54.0

