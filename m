Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A527F4CE;
	Wed, 18 Jun 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256204; cv=none; b=k86PzPoibfVAkhN/9LFpQ46ZB2jz2BaYqybPv7Kqj22VCwaIbyrn+tZSxDtdYbTSfu1lgATR0TAfSNAdKyajH+AO78B/IDANSGC4kYARYDe4Ik+gNBwntr4tgj5tvifuuP6o/XEhXqy7VGU146gOg/aRrYmJYAp+16orAYgxEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256204; c=relaxed/simple;
	bh=vpumWvZEKWirBkxBr6SXpGBrKl0PGlgMdEwZMBbkXvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IrJpYrhMVjEs9wQ/+kvs7URpIs0ovtiYQiZmfZuD72SAhBKlC5OpgaRj+rGya1kdzhv8nKsbQVYQML4jfEL6f84CRAgSx2NsOn2dPY5iPN6RrbxW4kKpt2tgWa8pO7r3ZAuZAj8ehcyTgDiwX6QtObKNRMM+LQm/huiUjyyieQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv1JLcuM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv1JLcuM"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-747c2cc3419so5479576b3a.2;
        Wed, 18 Jun 2025 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750256202; x=1750861002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dN6A+dCRQCTewVwE+vKtlp25E+5/ls+WyGlXJF8/QJI=;
        b=Dv1JLcuMd8v4ekw7zGZfti0arU8kkwPSSjGAZ0K2lNy5skfGqGZPw0DX+Q3S8+sdqz
         lJ8eT9bSoazc/FPu8lXGvB81yBEdGr8MDsyLDxdGT885h03cxwaKiHQ3geXdmIMF1JNU
         cX3BP8Sx1z9onKwphJSXTE0bvs9bvPObebhNqO9OeDhNZjWDYreSZ0qAEc84a8O3SeNv
         Pt1WIUB7TFcr+J25y5CWhYnnGx8B7qpKy9BCSh8BmlEZEuoBDSzDRt9qF8WGAg6w01lm
         bnzXLoVttVYAuxcBpgHDhpYhrkpaUxYR1KVScj+SS4ySM2kklxnV30/nS+R3d6pMTePZ
         VIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750256202; x=1750861002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dN6A+dCRQCTewVwE+vKtlp25E+5/ls+WyGlXJF8/QJI=;
        b=nmWK6vouRPhSkgFXdMIIKWTlXKYSrN746ep7eUSUiJc++BCIwTDxRt1FgObDQ8ErA4
         9mBnCgBd3a4IAI/6YM//EQV1cu65EQcY0VFw42Mx0m8NYfiGl069yqoDo75hDn1jbkri
         UY8JnqWxZyQih9BuVYUioGxgsFD937cAwSJAmQKifHYSjwIsTmZDGa7x8NsJz8MfMABQ
         mQ1uARQkF6I29/LWgX5bDLRdg3QCequnRhVQYlx0+Xf8ll1U6+dRt7q5H2Z5+DAh0jVG
         DTOFkioR6PwDyh99Sw4vMgWyRQbIt66ZyKjhRJ/cM8nc/Vjxj6BuZpYihcjEZnmn3UN0
         OTOw==
X-Forwarded-Encrypted: i=1; AJvYcCVckpdfDhGp/THTLyPpAJUuY+spjqjCG4b6A6ocXtFLIjFTTqZFOe16rIQj1AAOyLJgoVmlHZZrhGSnrzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGWx7Sun1rBoyHPiqjK114+3DsvY676nAM4Tv2sJWURM007NGY
	W8VjlbOUlWbmUmqQ/FxZVZJru60eu12lKOuy4BV5YagEa71mi3jwcDbv
X-Gm-Gg: ASbGnctTQ/dj9aPgzg1cZFEoDom8Np5CcgpkjWAOF+9PX7FuNH5a+FwlYmfTZVvdUnL
	ZZ0mv8FKXm4JXbxt/X8HqBlSPFSuoKexvOvFf78IYbRdnUBJzY5HoBEwuFcnPy3Xo601px9cdgf
	AtE6qiamz5O6/awlm4oyv6TqdBQy5Tgl7CO/4WGbeYRl2AKCo1ZpNHRLcxGjyoIiSdvURmycIMK
	7Wx+mheKGoN9S8Fs+wh+Px8oNuRbk8C/4ziGjFgmSWPwiKgLTpMtTi84FclbQDjLpNhnejAFgPk
	5Opqm7wAzCFQAUfe9a0iKHVHixsj64/R+qgNm8NbDPc3SFrcYm9XNNui6AoT
X-Google-Smtp-Source: AGHT+IGYEQHH8nI/GaHcGYoU54mp6byytA9Jxq+tLdc8SYm9ueq6KZ56WHIsiHaYQB3yd+AYvGKopg==
X-Received: by 2002:a05:6a00:14cc:b0:740:4fd8:a2bc with SMTP id d2e1a72fcca58-7489cf5c8e8mr20629514b3a.5.1750256201994;
        Wed, 18 Jun 2025 07:16:41 -0700 (PDT)
Received: from zinc.. ([182.216.63.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b2c1asm11360866b3a.143.2025.06.18.07.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 07:16:41 -0700 (PDT)
From: Kisub Choe <kisub.choe.0x1@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kisub.choe.0x1@gmail.com
Subject: [PATCH] staging: sm750fb: rename 'proc_setBLANK'
Date: Wed, 18 Jun 2025 23:15:55 +0900
Message-Id: <20250618141555.5434-1-kisub.choe.0x1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename 'proc_setBLANK' to 'proc_setBLANK' to
conform with kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <proc_setBLANK>

Signed-off-by: Kisub Choe <kisub.choe.0x1@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 drivers/staging/sm750fb/sm750.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 1d929aca399c..bb2ade6030c2 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -577,7 +577,7 @@ static int lynxfb_ops_blank(int blank, struct fb_info *info)
 	pr_debug("blank = %d.\n", blank);
 	par = info->par;
 	output = &par->output;
-	return output->proc_setBLANK(output, blank);
+	return output->proc_set_blank(output, blank);
 }
 
 static int sm750fb_set_drv(struct lynxfb_par *par)
@@ -605,7 +605,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	crtc->ypanstep = 1;
 	crtc->ywrapstep = 0;
 
-	output->proc_setBLANK = (sm750_dev->revid == SM750LE_REVISION_ID) ?
+	output->proc_set_blank = (sm750_dev->revid == SM750LE_REVISION_ID) ?
 				 hw_sm750le_set_blank : hw_sm750_set_blank;
 	/* chip specific phase */
 	sm750_dev->accel.de_wait = (sm750_dev->revid == SM750LE_REVISION_ID) ?
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 9cf8b3d30aac..40051798efbf 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -170,7 +170,7 @@ struct lynxfb_output {
 	 */
 	void *priv;
 
-	int (*proc_setBLANK)(struct lynxfb_output *output, int blank);
+	int (*proc_set_blank)(struct lynxfb_output *output, int blank);
 };
 
 struct lynxfb_par {
-- 
2.34.1

