Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0E926868D;
	Tue,  8 Apr 2025 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107653; cv=none; b=ae+Md0e4B2h7zvfdpHPUTzAf+iWFgOaYtyJL7CVPUSG5LOWvUcxTY79iCAxoeIGiac78XMtotjAo8v3KHOhKia69R9j/NxBiMVrLeXG2imYVi1PrwoTDIfMXYTtxPl/ZGLqrsV09FduBg8X7KSAQzIiFRojfvWUnZ3ZWdtkXjHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107653; c=relaxed/simple;
	bh=ZJUu2kUTtBrtb8QIr/T5NE5Nfo4t+UHcls6R0+lYS24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m9Ro1i8TOMMt4ny2TBw+hfxCGfCuXboWRgSIT+ZPWV3cNOe4yKmiEO4ALMquX5WLq/OE12mV8YnYCE1f5E38OyE4eTyWZueoofRMRihqk5XzK1eyGmvx2540q4fGlH2UaeY82a47s2WdGs7rqZo6Uuu+hzFgi1111ocm/bt+ptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgFKwQp/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgFKwQp/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edb40f357so28124655e9.0;
        Tue, 08 Apr 2025 03:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744107650; x=1744712450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xeNglUB7597l+hXKgp8ZDR8E6Vs1eyzhEhyeNzv3D74=;
        b=PgFKwQp/j3JxTemRmTK5kskr97+kSpJfp2r0ylxV09h4jObW1foevqn7XW90aVGo4h
         Doh/4A/CgVNjngGCPVZYn8Yq5uoi+35syA3n7k2j9j56LlTwZJZ91KDDxex37FyodJ9H
         Y0UHhifFczeJS0UPb8+mu/qgnw4Uk2jb4K5lL86nno4VxbbwKSeYJB/xTRLyfk+wcb4f
         RMdaLMrq+9Sx8BdgGLTKyN1kRr/PXhtCkhxUxkRzBkdD1OElJTRE/aneoIP7pSn+oje2
         tQIOOsfr6+YssBugVdGhULKz16B5Iz3oUtwSjM9DZRw3zf144+Y+NmGoEPJjdowRoeki
         d+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107650; x=1744712450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeNglUB7597l+hXKgp8ZDR8E6Vs1eyzhEhyeNzv3D74=;
        b=GqF3JkouMdCIhjKAhFs4GksREzlkKCDHzEg12XlBPdbiLBY9oE+VNTK3txzf7cmtsK
         mNPDGf6HCBevVrRiWtifcEjsxcL+frnzfHpK/bMWw+plE66ZWrdvRxFFn6RBFtdcQQRm
         Tw1jiqRBVzC9mx3n2bGIRQg6ig10kyZFPvQCwZl5ZLyn7tcYLp/fC+LvsvkRVCSMWnXg
         e0eKtW2l0GNVP50sIGbpwjMG8W5VYbXEKtCWxxMKe3EPLgxQ/6mLu9Cao17lPhOKAHtI
         TDQrb1z+GSN1AIQh2MrH4LkWvHzvniq2XRwkUdScH92ujLoZLkcJo3lfcar/xGWz7v40
         pkJA==
X-Forwarded-Encrypted: i=1; AJvYcCUSlio1ImJMQI79uDiCQ4HFIam937mrUR2ggiKFs0XIQZkBqMRaI8fzAWk5pJTwQJFZo1hHNA6CU5SYMw==@vger.kernel.org, AJvYcCVoL1ddXtcgB/BoL3s6Qe4QgQDFge5trsgLvUqVEYHd1n+JGGe5EcER724K1l0nulwR632F+D9bDsIHSJOr@vger.kernel.org
X-Gm-Message-State: AOJu0YxgQERxd6hN7bj1WW19KW6W8mFEfEdj6ebgE78kEDMsE1sBziSz
	NKBPoCnaAyIqEPk1OkA2rsXL4OVX6/ekXCl75oqlrkOFmiIz6qw6
X-Gm-Gg: ASbGncs1GxJV+wkbp1YDU8cAjHgslqIBstFSiNwAOV1EPWIJ0HbVs1YOlAt/rzHGC7n
	oAcHnHxDLGCnl0trxD1Hii+nEhbESzKpCDeFMUeC4wMbupTDQdvr+OWcJOQjU61kkGCNN7caRNe
	6dk+KwB3oWW338fTJv7UkT5MPN90gdvN9rdWF6Ldr/IYf4f6TZGKfkhp5dKc4Tv2KzN+cR78Ee+
	3Kn1KMgaOopYa4EIUMgAb7Bb2NQwW303lKSwvIQzV9MaPuedfMwYmdFxBPTqErFxeHki4X7pvcb
	OePo+No4CV9VcRjXYlCtrr6oRj0=
X-Google-Smtp-Source: AGHT+IGoCblA8039XA2SYcRuvHR7lv77+7fyVszqPklN9pnwKU/Q7bQYVLoa8hnC3VLSBmwSoVOR5Q==
X-Received: by 2002:a05:600c:1c88:b0:43c:fe15:41d4 with SMTP id 5b1f17b1804b1-43ee06985d4mr96625295e9.18.1744107649775;
        Tue, 08 Apr 2025 03:20:49 -0700 (PDT)
Received: from parrot ([105.113.112.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1f27a55sm159367605e9.2.2025.04.08.03.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:20:49 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH v2 0/8] staging: sm750fb: change function naming style
Date: Tue,  8 Apr 2025 11:20:32 +0100
Message-Id: <cover.1744105388.git.princerichard17a@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address checkpatch's "Avoid camelCase" for sm750fb module by changing
function name to conform to kernel code style.

The patches are required to be applied in sequence.

---
changes in v2:
  - Fixed typo in the commit message for patch 1
  - Sent patches as patchset

Richard Akintola (8):
  staging: sm750fb: change sii164GetDeviceID to snake_case
  staging: sm750fb: change sii164ResetChip to snake_case
  staging: sm750fb: change sii164SetPower to snake_case
  staging: sm750fb: change sii164GetChipString to snake_case
  staging: sm750fb: change sii164EnableHotPlugDetection to snake_case
  staging: sm750fb: change sii164IsConnected to snake_case
  staging: sm750fb: change sii164CheckInterrupt to snake_case
  staging: sm750fb: change sii164ClearInterrupt to snake_case

 drivers/staging/sm750fb/ddk750_dvi.c    | 16 +++++-----
 drivers/staging/sm750fb/ddk750_sii164.c | 42 ++++++++++++-------------
 drivers/staging/sm750fb/ddk750_sii164.h | 16 +++++-----
 3 files changed, 37 insertions(+), 37 deletions(-)

-- 
2.39.5

