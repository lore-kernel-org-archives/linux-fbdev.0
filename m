Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5581234575F
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Mar 2026 23:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580362; cv=none; b=CpNWr7evUogr7XfV0KHW5a4y8aTse2tv/a+HBvcLU8nijltZnPCTEHU41RfBbScrwS2vV/B1L3xuBMOwEUtqZl+qJkqT9vnkzmWhtTSnwEQ0D0oSzlVcU/5te+/eX5mJhjYcZG68nju4PVPkNn38XtaTElRAIWcymZshcvnM5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580362; c=relaxed/simple;
	bh=CMbTXXHmeZIBffm5ithIzujhIUER4PeHVeuPkMo+WLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keUSFQ2Dj79Oa5/F/1EeNCDlwI/fSPX6GdX4GEfNzvOgQwYAETXqbt/wzHKWGa+U19awAIGfNDiMcnBnI33RrLoObQXNCgeFYNa9fkPCJ8uMFY1W/IZ/KpwIvlqm7CL6+6SKkB95jYu0IgBeK716WTCpfB4/SCYdl9YpogQkkTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxY3LHlV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxY3LHlV"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48378136adcso37264715e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Mar 2026 15:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772580358; x=1773185158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr0JagJVxfAuMRUkqo+r5ILWFBJrm67ZsEShfqkvTiY=;
        b=IxY3LHlV56H2bkWi2HsiU7YpkqeZ4+eOqnPvF6vZpysUOSmOZVQ4/LgtR9ceKFCTGq
         vlhPZ3TDII0WaZlyt4PnCbC5Q4RhApQrcAS1F+Bp0qRNiXJWd3U5ReX3LysEodtrdUXW
         RPUG0Y0ekI8tCbpy3RDij1MCruxDTuEQUUB1GtfUlLZEsHP0EBEV0iysAEu/5m51qJnV
         Y64cElZp/QLlAuUd8Uk462NzldG1lLsVFsPMfSY/cWKxEo/cqEt4lM4qwiX9UXjqVY3a
         ov/B24LwrRozuD1bextqxkx5DJ1hCxBqJkN8UnaoeuOh1wdpiUu8of9fAR0AfbTbqecC
         nPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580358; x=1773185158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kr0JagJVxfAuMRUkqo+r5ILWFBJrm67ZsEShfqkvTiY=;
        b=qhxts6tRl4IU+9y3g6BsC1g3sjMlKdf4JYyckBt9ITFVpET+hPkJybm3VeylFVzOvZ
         XatWNvKrerTjjEe4PcSk9AFVPCi5IXneQM6L4fUakTo/U92lZPMh1MmjJfRk/tG9vd60
         p+pISpvBx982X2WdGr6ay75BCQAMV18DB/7GlTJutQx1JhfcUjpqkilAPx6aZBgAM+wc
         U0RG/thwSNK7qTVULkmI1pSXS2mG3+fUbjiXBwKhRa7YbuTqETipcbIxVtobQc1WZauN
         YQ+fC4CZ6Za+dc4O64Wj7P2ZBANM2CTF85goPQ5FJiEZSiQfu5cz0b7aAKqZb/1t+V2l
         2BKw==
X-Forwarded-Encrypted: i=1; AJvYcCVT0TyzBApO8S6nCsfEJvEc6JIr2YXXMJEinQhOqIJZSrrA2ZWdD/CU757Bu6FGUZFNonbo6cnJOuWJYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUP7hnX666M79vWO8ZYbvdeRYfhYiCT1CIURY9jl9SGEXUn8M
	5744WAsQSBK52OZAUyPo0Syx71Vcz9F9jThaUXTtoBTXFKPIFFAm8zxY
X-Gm-Gg: ATEYQzxCDHNWjB+IZhntHefulyXleg/aC3NbimhEuQctQGUoRPma84aA+2KKSrLONbs
	guOVZKe3nIPYE8vNKlraOQ1yz4rlElLkphE2h/Z/qIv22V7Xa747+5G1Zqd2ZB5DaT4X+LmKvfH
	TkKTUdQ37ECUaFzf/mSMy3wPKS3BBY5N9Mb+Lm9Buoj02KzvA1QjvRhGvoz+Jyg985TT/HUSrjp
	k/lzbokgm+iXLsFDWkvFbdxPxzQkehw3xTVvRYojxDOhlYZYYNWPvUSTu36glLNdEBaOz21vNFK
	n14UaRRf9XtOSJfrqqu099GOGmD4dpPYZb7oEVw9NXWjWlyP03qLIf820cwf5Im7pahI6Ud37gu
	3dF1DLlGflrcrKiM9AtyaGloRZb0U4+n6NKayQo4pmLzgbUHXzkOzS77n8bwrgTkPy+EcA8Jqd7
	P90CAxNM/j9AbNQ/qndfWAghUuPYhXgoww57qV+1WGSX3cfPpcAyxDzbTxXdPz
X-Received: by 2002:a05:600c:6389:b0:480:6941:d38b with SMTP id 5b1f17b1804b1-4851989f63amr407045e9.30.1772580358488;
        Tue, 03 Mar 2026 15:25:58 -0800 (PST)
Received: from arch ([2a02:1210:2e28:2800:36a5:7f85:ccb8:1176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851335648esm68036615e9.5.2026.03.03.15.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:25:58 -0800 (PST)
From: Gabriel Windlin <gawindlin@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Gabriel Windlin <gawindlin@gmail.com>
Subject: [PATCH 5/8] staging: sm750fb: remove unused memory arbitration register definitions
Date: Wed,  4 Mar 2026 00:24:26 +0100
Message-ID: <20260303232434.1850583-5-gawindlin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303232434.1850583-1-gawindlin@gmail.com>
References: <20260303232434.1850583-1-gawindlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LOCALMEM_ARBITRATION and PCIMEM_ARBITRATION register macros defined
in ddk750_reg.h are not referenced anywhere in the driver. Remove them
to reduce dead code as noted in the TODO file.

Signed-off-by: Gabriel Windlin <gawindlin@gmail.com>
---
 drivers/staging/sm750fb/ddk750_reg.h | 132 ---------------------------
 1 file changed, 132 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb/ddk750_reg.h
index 24e826c31721..dd1d67fb9856 100644
--- a/drivers/staging/sm750fb/ddk750_reg.h
+++ b/drivers/staging/sm750fb/ddk750_reg.h
@@ -77,138 +77,6 @@
 
 #define GPIO_MUX                                      0x000008
 
-#define LOCALMEM_ARBITRATION                          0x00000C
-#define LOCALMEM_ARBITRATION_ROTATE                   BIT(28)
-#define LOCALMEM_ARBITRATION_VGA_MASK                 (0x7 << 24)
-#define LOCALMEM_ARBITRATION_VGA_OFF                  (0x0 << 24)
-#define LOCALMEM_ARBITRATION_VGA_PRIORITY_1           (0x1 << 24)
-#define LOCALMEM_ARBITRATION_VGA_PRIORITY_2           (0x2 << 24)
-#define LOCALMEM_ARBITRATION_VGA_PRIORITY_3           (0x3 << 24)
-#define LOCALMEM_ARBITRATION_VGA_PRIORITY_4           (0x4 << 24)
-#define LOCALMEM_ARBITRATION_VGA_PRIORITY_5           (0x5 << 24)
-#define LOCALMEM_ARBITRATION_VGA_PRIORITY_6           (0x6 << 24)
-#define LOCALMEM_ARBITRATION_VGA_PRIORITY_7           (0x7 << 24)
-#define LOCALMEM_ARBITRATION_DMA_MASK                 (0x7 << 20)
-#define LOCALMEM_ARBITRATION_DMA_OFF                  (0x0 << 20)
-#define LOCALMEM_ARBITRATION_DMA_PRIORITY_1           (0x1 << 20)
-#define LOCALMEM_ARBITRATION_DMA_PRIORITY_2           (0x2 << 20)
-#define LOCALMEM_ARBITRATION_DMA_PRIORITY_3           (0x3 << 20)
-#define LOCALMEM_ARBITRATION_DMA_PRIORITY_4           (0x4 << 20)
-#define LOCALMEM_ARBITRATION_DMA_PRIORITY_5           (0x5 << 20)
-#define LOCALMEM_ARBITRATION_DMA_PRIORITY_6           (0x6 << 20)
-#define LOCALMEM_ARBITRATION_DMA_PRIORITY_7           (0x7 << 20)
-#define LOCALMEM_ARBITRATION_ZVPORT1_MASK             (0x7 << 16)
-#define LOCALMEM_ARBITRATION_ZVPORT1_OFF              (0x0 << 16)
-#define LOCALMEM_ARBITRATION_ZVPORT1_PRIORITY_1       (0x1 << 16)
-#define LOCALMEM_ARBITRATION_ZVPORT1_PRIORITY_2       (0x2 << 16)
-#define LOCALMEM_ARBITRATION_ZVPORT1_PRIORITY_3       (0x3 << 16)
-#define LOCALMEM_ARBITRATION_ZVPORT1_PRIORITY_4       (0x4 << 16)
-#define LOCALMEM_ARBITRATION_ZVPORT1_PRIORITY_5       (0x5 << 16)
-#define LOCALMEM_ARBITRATION_ZVPORT1_PRIORITY_6       (0x6 << 16)
-#define LOCALMEM_ARBITRATION_ZVPORT1_PRIORITY_7       (0x7 << 16)
-#define LOCALMEM_ARBITRATION_ZVPORT0_MASK             (0x7 << 12)
-#define LOCALMEM_ARBITRATION_ZVPORT0_OFF              (0x0 << 12)
-#define LOCALMEM_ARBITRATION_ZVPORT0_PRIORITY_1       (0x1 << 12)
-#define LOCALMEM_ARBITRATION_ZVPORT0_PRIORITY_2       (0x2 << 12)
-#define LOCALMEM_ARBITRATION_ZVPORT0_PRIORITY_3       (0x3 << 12)
-#define LOCALMEM_ARBITRATION_ZVPORT0_PRIORITY_4       (0x4 << 12)
-#define LOCALMEM_ARBITRATION_ZVPORT0_PRIORITY_5       (0x5 << 12)
-#define LOCALMEM_ARBITRATION_ZVPORT0_PRIORITY_6       (0x6 << 12)
-#define LOCALMEM_ARBITRATION_ZVPORT0_PRIORITY_7       (0x7 << 12)
-#define LOCALMEM_ARBITRATION_VIDEO_MASK               (0x7 << 8)
-#define LOCALMEM_ARBITRATION_VIDEO_OFF                (0x0 << 8)
-#define LOCALMEM_ARBITRATION_VIDEO_PRIORITY_1         (0x1 << 8)
-#define LOCALMEM_ARBITRATION_VIDEO_PRIORITY_2         (0x2 << 8)
-#define LOCALMEM_ARBITRATION_VIDEO_PRIORITY_3         (0x3 << 8)
-#define LOCALMEM_ARBITRATION_VIDEO_PRIORITY_4         (0x4 << 8)
-#define LOCALMEM_ARBITRATION_VIDEO_PRIORITY_5         (0x5 << 8)
-#define LOCALMEM_ARBITRATION_VIDEO_PRIORITY_6         (0x6 << 8)
-#define LOCALMEM_ARBITRATION_VIDEO_PRIORITY_7         (0x7 << 8)
-#define LOCALMEM_ARBITRATION_PANEL_MASK               (0x7 << 4)
-#define LOCALMEM_ARBITRATION_PANEL_OFF                (0x0 << 4)
-#define LOCALMEM_ARBITRATION_PANEL_PRIORITY_1         (0x1 << 4)
-#define LOCALMEM_ARBITRATION_PANEL_PRIORITY_2         (0x2 << 4)
-#define LOCALMEM_ARBITRATION_PANEL_PRIORITY_3         (0x3 << 4)
-#define LOCALMEM_ARBITRATION_PANEL_PRIORITY_4         (0x4 << 4)
-#define LOCALMEM_ARBITRATION_PANEL_PRIORITY_5         (0x5 << 4)
-#define LOCALMEM_ARBITRATION_PANEL_PRIORITY_6         (0x6 << 4)
-#define LOCALMEM_ARBITRATION_PANEL_PRIORITY_7         (0x7 << 4)
-#define LOCALMEM_ARBITRATION_CRT_MASK                 0x7
-#define LOCALMEM_ARBITRATION_CRT_OFF                  0x0
-#define LOCALMEM_ARBITRATION_CRT_PRIORITY_1           0x1
-#define LOCALMEM_ARBITRATION_CRT_PRIORITY_2           0x2
-#define LOCALMEM_ARBITRATION_CRT_PRIORITY_3           0x3
-#define LOCALMEM_ARBITRATION_CRT_PRIORITY_4           0x4
-#define LOCALMEM_ARBITRATION_CRT_PRIORITY_5           0x5
-#define LOCALMEM_ARBITRATION_CRT_PRIORITY_6           0x6
-#define LOCALMEM_ARBITRATION_CRT_PRIORITY_7           0x7
-
-#define PCIMEM_ARBITRATION                            0x000010
-#define PCIMEM_ARBITRATION_ROTATE                     BIT(28)
-#define PCIMEM_ARBITRATION_VGA_MASK                   (0x7 << 24)
-#define PCIMEM_ARBITRATION_VGA_OFF                    (0x0 << 24)
-#define PCIMEM_ARBITRATION_VGA_PRIORITY_1             (0x1 << 24)
-#define PCIMEM_ARBITRATION_VGA_PRIORITY_2             (0x2 << 24)
-#define PCIMEM_ARBITRATION_VGA_PRIORITY_3             (0x3 << 24)
-#define PCIMEM_ARBITRATION_VGA_PRIORITY_4             (0x4 << 24)
-#define PCIMEM_ARBITRATION_VGA_PRIORITY_5             (0x5 << 24)
-#define PCIMEM_ARBITRATION_VGA_PRIORITY_6             (0x6 << 24)
-#define PCIMEM_ARBITRATION_VGA_PRIORITY_7             (0x7 << 24)
-#define PCIMEM_ARBITRATION_DMA_MASK                   (0x7 << 20)
-#define PCIMEM_ARBITRATION_DMA_OFF                    (0x0 << 20)
-#define PCIMEM_ARBITRATION_DMA_PRIORITY_1             (0x1 << 20)
-#define PCIMEM_ARBITRATION_DMA_PRIORITY_2             (0x2 << 20)
-#define PCIMEM_ARBITRATION_DMA_PRIORITY_3             (0x3 << 20)
-#define PCIMEM_ARBITRATION_DMA_PRIORITY_4             (0x4 << 20)
-#define PCIMEM_ARBITRATION_DMA_PRIORITY_5             (0x5 << 20)
-#define PCIMEM_ARBITRATION_DMA_PRIORITY_6             (0x6 << 20)
-#define PCIMEM_ARBITRATION_DMA_PRIORITY_7             (0x7 << 20)
-#define PCIMEM_ARBITRATION_ZVPORT1_MASK               (0x7 << 16)
-#define PCIMEM_ARBITRATION_ZVPORT1_OFF                (0x0 << 16)
-#define PCIMEM_ARBITRATION_ZVPORT1_PRIORITY_1         (0x1 << 16)
-#define PCIMEM_ARBITRATION_ZVPORT1_PRIORITY_2         (0x2 << 16)
-#define PCIMEM_ARBITRATION_ZVPORT1_PRIORITY_3         (0x3 << 16)
-#define PCIMEM_ARBITRATION_ZVPORT1_PRIORITY_4         (0x4 << 16)
-#define PCIMEM_ARBITRATION_ZVPORT1_PRIORITY_5         (0x5 << 16)
-#define PCIMEM_ARBITRATION_ZVPORT1_PRIORITY_6         (0x6 << 16)
-#define PCIMEM_ARBITRATION_ZVPORT1_PRIORITY_7         (0x7 << 16)
-#define PCIMEM_ARBITRATION_ZVPORT0_MASK               (0x7 << 12)
-#define PCIMEM_ARBITRATION_ZVPORT0_OFF                (0x0 << 12)
-#define PCIMEM_ARBITRATION_ZVPORT0_PRIORITY_1         (0x1 << 12)
-#define PCIMEM_ARBITRATION_ZVPORT0_PRIORITY_2         (0x2 << 12)
-#define PCIMEM_ARBITRATION_ZVPORT0_PRIORITY_3         (0x3 << 12)
-#define PCIMEM_ARBITRATION_ZVPORT0_PRIORITY_4         (0x4 << 12)
-#define PCIMEM_ARBITRATION_ZVPORT0_PRIORITY_5         (0x5 << 12)
-#define PCIMEM_ARBITRATION_ZVPORT0_PRIORITY_6         (0x6 << 12)
-#define PCIMEM_ARBITRATION_ZVPORT0_PRIORITY_7         (0x7 << 12)
-#define PCIMEM_ARBITRATION_VIDEO_MASK                 (0x7 << 8)
-#define PCIMEM_ARBITRATION_VIDEO_OFF                  (0x0 << 8)
-#define PCIMEM_ARBITRATION_VIDEO_PRIORITY_1           (0x1 << 8)
-#define PCIMEM_ARBITRATION_VIDEO_PRIORITY_2           (0x2 << 8)
-#define PCIMEM_ARBITRATION_VIDEO_PRIORITY_3           (0x3 << 8)
-#define PCIMEM_ARBITRATION_VIDEO_PRIORITY_4           (0x4 << 8)
-#define PCIMEM_ARBITRATION_VIDEO_PRIORITY_5           (0x5 << 8)
-#define PCIMEM_ARBITRATION_VIDEO_PRIORITY_6           (0x6 << 8)
-#define PCIMEM_ARBITRATION_VIDEO_PRIORITY_7           (0x7 << 8)
-#define PCIMEM_ARBITRATION_PANEL_MASK                 (0x7 << 4)
-#define PCIMEM_ARBITRATION_PANEL_OFF                  (0x0 << 4)
-#define PCIMEM_ARBITRATION_PANEL_PRIORITY_1           (0x1 << 4)
-#define PCIMEM_ARBITRATION_PANEL_PRIORITY_2           (0x2 << 4)
-#define PCIMEM_ARBITRATION_PANEL_PRIORITY_3           (0x3 << 4)
-#define PCIMEM_ARBITRATION_PANEL_PRIORITY_4           (0x4 << 4)
-#define PCIMEM_ARBITRATION_PANEL_PRIORITY_5           (0x5 << 4)
-#define PCIMEM_ARBITRATION_PANEL_PRIORITY_6           (0x6 << 4)
-#define PCIMEM_ARBITRATION_PANEL_PRIORITY_7           (0x7 << 4)
-#define PCIMEM_ARBITRATION_CRT_MASK                   0x7
-#define PCIMEM_ARBITRATION_CRT_OFF                    0x0
-#define PCIMEM_ARBITRATION_CRT_PRIORITY_1             0x1
-#define PCIMEM_ARBITRATION_CRT_PRIORITY_2             0x2
-#define PCIMEM_ARBITRATION_CRT_PRIORITY_3             0x3
-#define PCIMEM_ARBITRATION_CRT_PRIORITY_4             0x4
-#define PCIMEM_ARBITRATION_CRT_PRIORITY_5             0x5
-#define PCIMEM_ARBITRATION_CRT_PRIORITY_6             0x6
-#define PCIMEM_ARBITRATION_CRT_PRIORITY_7             0x7
-
 #define RAW_INT                                       0x000020
 #define RAW_INT_ZVPORT1_VSYNC                         BIT(4)
 #define RAW_INT_ZVPORT0_VSYNC                         BIT(3)
-- 
2.53.0

