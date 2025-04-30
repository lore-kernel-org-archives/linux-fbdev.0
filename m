Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154DF1E2845;
	Wed, 30 Apr 2025 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992628; cv=none; b=kpeHK8gWy5txZ+CH9sTgFJ3ljMIR7QijgVd7f+9Yieczu+tO0A/3ft9rDRPDIDz79JaLZBVQUlOSGBN4AWriqX8KnIPF0dL3T+qHf5qUIcR5ee+DoJApbNWLJWtBl4Ex6T/PQMHoKfvguUAiKvwEuEXQBknnrrzF9Q91f/P/MUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992628; c=relaxed/simple;
	bh=AqkrxvNmNSFYAfLVvhqlILUEtmSOv6o0GLSnBLAdudg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WzhDdpUM88XSIOUVEl8FklrKvnOrAI377o3kBRp9oGpl5s4x2j6Zbb7HDbQqFsaKxt5dRHiwjsPQj5MUMTm7z/YqkUszJs0NdKbSm3XeUyRj+qBPI7qI2i7K+aeAE8CmjRcr5hJNlM7yhi8fWk808xtpq6YtwjalqQXTZyeqBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlAIwTOU; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlAIwTOU"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-22c50beb0d5so12136505ad.3;
        Tue, 29 Apr 2025 22:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745992626; x=1746597426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SIeVaE3oBK/bbYkLO4xya3KMnkaYWVmL+CNJDLXtBE=;
        b=UlAIwTOU0ovE81+anWPJip0HpuhCbEfDrZt0opKCf6+HNRSQczeLMQzTIMVroyWqGN
         5cuBVspUqf9+ZkX6h6sNFQnS0guXaXQCnJcGA2gUCrSlU/tQZT3hUb51V1vOR5DUyctJ
         k4LwAcgpzp6Q/lB5uVjImvOosYMyuzFpZ1RJ5PD8mrDRxBclHkdHrjO2EYlANhYbQb2b
         YfHYsR42jJgv1Q1Ko8YlqWBre+Pop9Mf8g2tJaG4gXNLnUup9BoRn3BjAPsI1fu6+u1S
         Lx1IzeBH9KOy6g4jra44o4dIqz2sFWooaWFiRa3JbpFgsPu7dz+BxlFQSiSHacFii9kp
         +UQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745992626; x=1746597426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SIeVaE3oBK/bbYkLO4xya3KMnkaYWVmL+CNJDLXtBE=;
        b=M/kyZ3PrWIBLDLZ1AnbWYfTdXJPtgZeI1zmK4K7ctXqBkxmYWyoGIpGckziLCarAS3
         pF+tPoJS6KuduayhHruU6y2UqlIRDNifFYzVtdyZCwAzZVAYRpKFmXk64rslz8hn32Ye
         SVvgDtvzgNiaWL164zst8dEho4p64mVnshjNdOw4NMlYqYnzTBSRF3acY9CXdninxd6q
         5/p2xGxTVVIPac0ZFmVx1kJ4xK0YDdsf+Rz6KH3AZhzZt13gX8owHbr0Q/mzfnaAKdj7
         Xd24auw98DYolEFbxeGDSEY76FjPQyJhDXOwkr9GVG8NvhgzXUUqgZQdtBgzp2TlaL4t
         Kepg==
X-Forwarded-Encrypted: i=1; AJvYcCV2woTv8vPUlwm8VafxNkjBW2fwlCrVa0DxCb0jjVcUGYgF0X4pYKLYwdimTTqUVh+32DA6hdTfg1sWygpm@vger.kernel.org, AJvYcCWk2PgoUv0ilgkRU+o4GsuEhzcWoqP8C0M5/J6iByF614bE57Ou4WKJjVy2oHvLFS+4R0lyfZFG2rtGMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaX2BTS1Cl8XClwlZLaKARtIy3h8Mom5n1aZ1ldYQt/hEF10kl
	ax77uGcR0NSB22uwYoIbjzACSvJGHho53xDJKNkxfF21fgQZNfYm
X-Gm-Gg: ASbGncskScgu1aYSQcjp9A9XSeD3YtEJC5M3G28Ygu+YJ0K8Og72XaI0EeAQmUqn4DD
	jasCmPANlVwASGDXbGhw7T5spVhfldOAAp0apGMb18Cuudfzn7VwJxcWWasaLpuIx0etIjSX8fu
	sCON00YKaQkzTVKCsWcXp5iTRh5EDA9hQThqhKd+vU10mGbGlCpS+syRMmeptFMXYajyPXg8olc
	sY9RKjwgaACVr9ac3T7XleItsVATYf4vmKr8qatXja74eDKQgJTIoBOc4kqw2vKGShstovtG16k
	jxrqmRMErIQc3Ffzr1OYezSUnmtfwLk5Cd+RLVgkuLiM+b9FGJe7I6U9kDha/jUmrwkPbKrgHS2
	aiqVSr2vv9fkk52aQUgWkv4yNcC/YBsSwxktjYtY1gaA/UmVcfdxxmrk=
X-Google-Smtp-Source: AGHT+IGgrv6SDWIMuXsf6C2RnU9bCVyPaLjrO2DFm+ZB4E4lIHxEQvyi56OVKwlLm1oqqujIrLoTuw==
X-Received: by 2002:a17:903:3c48:b0:220:e98e:4f17 with SMTP id d9443c01a7336-22df34aa388mr11537185ad.2.1745992626163;
        Tue, 29 Apr 2025 22:57:06 -0700 (PDT)
Received: from kerneldev.localdomain (162-225-124-171.lightspeed.sntcca.sbcglobal.net. [162.225.124.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221a82sm113383895ad.257.2025.04.29.22.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:57:05 -0700 (PDT)
From: Eric Florin <ericflorin.kernel@gmail.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eric Florin <ericflorin.kernel@gmail.com>
Subject: [PATCH 3/5] staging: sm750fb: rename sm750_hw_cursor_setColor
Date: Tue, 29 Apr 2025 22:55:37 -0700
Message-Id: <93717027d952d14d9b17f78e8440a734e4dc5d89.1745982772.git.ericflorin.kernel@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1745982772.git.ericflorin.kernel@gmail.com>
References: <cover.1745982772.git.ericflorin.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename sm750_hw_cursor_setColor to sm750_hw_cursor_set_color to conform
with kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <sm750_hw_cursor_setColor>

Signed-off-by: Eric Florin <ericflorin.kernel@gmail.com>
---
 drivers/staging/sm750fb/sm750.c        | 2 +-
 drivers/staging/sm750fb/sm750_cursor.c | 2 +-
 drivers/staging/sm750fb/sm750_cursor.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8dd32aa6ac6e..483a30841c77 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -141,7 +141,7 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 		     ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5) |
 		     ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
 
-		sm750_hw_cursor_setColor(cursor, fg, bg);
+		sm750_hw_cursor_set_color(cursor, fg, bg);
 	}
 
 	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index a6fe241e7748..e80d6efe0ab1 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -72,7 +72,7 @@ void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y)
 	poke32(HWC_LOCATION, reg);
 }
 
-void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg)
+void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg)
 {
 	u32 reg = (fg << HWC_COLOR_12_2_RGB565_SHIFT) &
 		HWC_COLOR_12_2_RGB565_MASK;
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index d0ade8e366f4..edfa6a8202cd 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -7,7 +7,7 @@ void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h);
 void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y);
-void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg);
+void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg);
 void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
 			     const u8 *data, const u8 *mask);
 void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
-- 
2.39.5

