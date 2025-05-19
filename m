Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F121A0B08
	for <linux-fbdev@vger.kernel.org>; Mon, 19 May 2025 02:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747620331; cv=none; b=dPiTtvH1H0CLm+ugmAFNzIJ9A+BTkOX8zKQkrZEbM/MopH5uKcqs3RPKRPQxE0J3x6sgVmzfAzdJyKC/mXIbWDwtPndzlxRbyJJ1K0W8G7zS5DETchv5L/93RDHuMnyoUwPXdqI8TkqQcRBu+lZFQbfcz/42c1Ri6+xLToBO58M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747620331; c=relaxed/simple;
	bh=P6YhGfwpTWjH4RxelIMCi1nT/wtCrRVWtOdmcF4kceE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HXoREITxQj/KYYhKsK8KTmzlTOj/Ev876p+JT+sqJEapDhMpQwqpHjL96sRiIZzHMfgOfQcBEaCUdKUNGl61rL1dJGdyUGtmBsg1Gf3PIA5w1qgUOSDTfrfyeyUcHxbdh6xA4xBlPYHGT7HkcpxjUxRUmz+JbmDhPXLLGErbB+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KUxQjmTN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KUxQjmTN"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742cede1473so833071b3a.3
        for <linux-fbdev@vger.kernel.org>; Sun, 18 May 2025 19:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747620328; x=1748225128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4WNeHNuQ/4XktBWCvVGZ2j9OjX/jX7Q26i4sZzFTDLM=;
        b=KUxQjmTNePJDLIkVX+MvTyT9BJn3nuq1fTzjhK7XhIO+JCAP3aR/KiT+ndnGndtUcW
         fJKx8KtbTsIaLG8uC70ZGCdII3/TizGVYE7ySvt2sIL5vzkd5/02ZqL8igWbzfNxFfPc
         bByL/MGPm7bfIj+ZokviBRZwjmj5g0jqyDHHHxO/YOk5+oXZZ2QUDeuyjPfa6eXpN7lu
         4y6hPnJrZrgL/Oeoxq/qDUWC5Z2DuOwxhiCtHEKYT2aa64w9s9OLeyewm3J2EZ0oY25x
         X3w13cd+XSvzIqa63MCQb7GenbqAg2Lrl3CBbWp4q2S5i2YnVq8eNv09iqNtDmJeObjt
         eywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747620328; x=1748225128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4WNeHNuQ/4XktBWCvVGZ2j9OjX/jX7Q26i4sZzFTDLM=;
        b=FCXRuXhUoriMpYd07lKbA2j5cHOrrbvR1Ng0z9KMHjyOyBMrVcmlHw1D5eFqaxZGVO
         ywke7qORZ9eeHxtubiXWgB54I/853rAJ+aZns9XPp1vjqc4WYeJDjx3nkDUs3vyd0a4+
         qwAye3q+aXIiOvyJGfe4KwKpsxQ6Flh7NWKVd6swpaWeajl8FHmutFMuotRatreRobrT
         cnkr8ltAHLDLKfV1CE2jiTf8d3aW59VeexHe6fhMmE2NShLuOSerYfu7coTcDcO+/LCW
         sTxOlZgUr8agno0udfgmgqeeDnPIZ3scfzYkLdD5+9y32hNq+YU6CTqPvjSMh6oWobN7
         YWjA==
X-Forwarded-Encrypted: i=1; AJvYcCWKQVx23wo3mqv8bY1c+cggdML4Bat39r9MFM2pYuF6tyP9fzIeZMSBe3VrTodAVp9xE+DAZSTrDBXEXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YygrvVHo89Y0eAwtVl5tFpRIpqsKbmm3LkjL82Jb6zqSX7Zbd8V
	gNi9IrfPf2FN8f02pbTLwoVhg0gunUOURwDFYbDjVSZ6nmhU0bFoN47Mk9m6BGMFp8JeKbNAR4p
	ecuFIKwrtfKfIRjoN8pXAGQ==
X-Google-Smtp-Source: AGHT+IGJ1y2LMgtkB4KN/mhUl2Kk6KWp4viAq1pbxiTlJMAogrAQ3rkz6/z6rHDzqvrWuq/M/ufamRUOrLWsXoK5
X-Received: from pgre17.prod.google.com ([2002:a65:6791:0:b0:b14:9a53:2226])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d1c:b0:1ee:d418:f764 with SMTP id adf61e73a8af0-2170ce33ad3mr16521363637.38.1747620327781;
 Sun, 18 May 2025 19:05:27 -0700 (PDT)
Date: Sun, 18 May 2025 19:04:44 -0700
In-Reply-To: <cover.1747619816.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747619816.git.ericflorin@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <3c84dccaf38161d6de6ff560d4f10bb3d344cc51.1747619816.git.ericflorin@google.com>
Subject: [PATCH 1/9] staging: sm750fb: rename `hw_sm750_initAccel`
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename `hw_sm750_initAccel` to `hw_sm750_init_accel` to conform with
kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <hw_sm750_initAccel>

Signed-off-by: Eric Florin <ericflorin@google.com>
---
 drivers/staging/sm750fb/sm750.h    | 2 +-
 drivers/staging/sm750fb/sm750_hw.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index aff69661c8e6..a797985a4df7 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -193,7 +193,7 @@ static inline unsigned long ps_to_hz(unsigned int psvalue)
 
 int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
 int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev);
-void hw_sm750_initAccel(struct sm750_dev *sm750_dev);
+void hw_sm750_init_accel(struct sm750_dev *sm750_dev);
 int hw_sm750_deWait(void);
 int hw_sm750le_deWait(void);
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 64b199061d14..a5bb067b30cc 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -173,7 +173,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 
 	/* init 2d engine */
 	if (!sm750_dev->accel_off)
-		hw_sm750_initAccel(sm750_dev);
+		hw_sm750_init_accel(sm750_dev);
 
 	return 0;
 }
@@ -474,7 +474,7 @@ int hw_sm750_setBLANK(struct lynxfb_output *output, int blank)
 	return 0;
 }
 
-void hw_sm750_initAccel(struct sm750_dev *sm750_dev)
+void hw_sm750_init_accel(struct sm750_dev *sm750_dev)
 {
 	u32 reg;
 
-- 
2.49.0.1112.g889b7c5bd8-goog

