Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10C222423A
	for <linux-fbdev@vger.kernel.org>; Sun,  7 Jun 2026 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780863445; cv=none; b=GSHG1e216WDEYmoQJFMY9pnxzIg5a7s8iNn5lPIRbWOgK+1N3H1GKtMks66eccWahqVOsxmer+O1jgGxvAxCfOXs2j8rh8BoO+jBI0I4np4GIey+/ycS/3iaenQw/Z69V88eskj2LNMcVIa8EPpGG75BY/xufWtKI3V+1Vh80DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780863445; c=relaxed/simple;
	bh=UOGYWWTW+WEXSYQLS0GAi7bVhWf1f6S3xCv+nvyx2Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nfyjc8/gQsssKoAqkHMx4qfGR0YvEM1G8F2Bx0sTCC+FIcLUmugBhvd6fTjSO43jxPNdinY3TrXg8ceH84fqDUB9C3Ydtkg2q+wpU4hTYuG9vgPr6rlHrHU52KY5P7xXDu2oMU4EFrlJ2Sw1jq+MbtM6lSDk44mixdZubBOvnEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMJauRXs; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMJauRXs"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa5e9a64b4so3831978e87.3
        for <linux-fbdev@vger.kernel.org>; Sun, 07 Jun 2026 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780863442; x=1781468242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy/zUtWfVLlQnRmwYycbaxD9q0kWKYQ8XVFOlWopOt8=;
        b=pMJauRXsAW6llB+DzM8sZqLkdzFJGf+3DRIKfTwaywgXfH8fSQ9et0FizY+IFe8aEf
         i+GcWyLmwJp08CV9MphHt0CKE7YB/hrIJwnFMeUTrkEOe0a38R2PNnm3qFGunqfRm3Ol
         HRkZ+AY8ql9C0q6RnxOipJ7KitNMZjxXI23tWFYjc3jqBgHyD/cV6JdcB+8Sd7vFslIV
         Pm8Iro80TBRFUBUpTOAwLtjOW93WHmYte547QKElbSjD5gEdnuEsplMlHHkHNogzAS0c
         MZl9LI3vXeGv6MRagf9xEo46+bR2YwCBM/cQkeYmKXZImvdTB8mBjPj+2JGe8R1cShXi
         fkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780863442; x=1781468242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cy/zUtWfVLlQnRmwYycbaxD9q0kWKYQ8XVFOlWopOt8=;
        b=HI9CNzPmUrNWQYVPqugZOGsmIARzspk6DOR10vdhldu4F51cyENssa1tXI4ZKW2tOT
         NmxNgad4DYZwfgXLQeMztFlj5Mq7VJjdP6EPT8K2HXaWX8UM2CqqTHOC6Wu62bTsCCM1
         c0Y2DypjxLDOHICH1JYSlj9XTSK0anDIQAWTNdLzfCqhDk5ctHr0rjG1iK4lOcm064GH
         +6SjQXfZovANncaJQfmwNbDbaGqGxxOZXSC4z2G8lm8aMxosb7Qpa6dWErLHhD8entgj
         qiEEI+XlxmMHUCN09omYdp6bHbNakbVNE2AItjKbqI6whAZ/9PsCvYA+y8CR/fJHKWIG
         XlfA==
X-Forwarded-Encrypted: i=1; AFNElJ+TsiahXm0Z6U/zeZnoEH7wl03XOulr7eJy2iAW9+Ni6UFn9yXumjOzRurzGJ1acUnGETzzCIAdqsqR/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjVe/3BJRPyWv9SVwgnEYTrdTDD4iTDaubhWL1cO/EKkbjSnV
	MVxeGnQMinD/c9VyxXz5orCd5EqwxO7Os0mW7QfJKVc6kk4C4pnBPw4M
X-Gm-Gg: Acq92OFXIQihPtahh2SZgfT4ki/HTsLFPnAkLdu64WGFSxnhXo0lfAJY1xThJGex08A
	Zd1mNNzFJ8QF9xQsS5CnU8Wnepo7pdUuZZrIs7TsZNHDLlOQfZ73b/8J3YjIcV2lLIRKmjoEFqz
	3edJRNoKXo40xU/9gA5pF/XDbptQKMD6gy/QC8Kzclfo3ezpKFcqUOm9J4jRnRQomGgJW0QafjO
	Kue05PAcNLYr6y1IFnpEZgwiBb4hyD1Nei3n9MxdsUHDyTHwrT30l4hpEveAs+H5yTnNLrLo0eC
	ga4elE3s58er+DGIBAMSW0sjve3E76SN0AOh6q6Zu3sIf3faGi/yHEazs2cIb+9rP2lRnasIMF0
	QAvZfsw1ynzIM0rKFZkZ15+ej1uDuJQ1quvixD+TQ8Dawt4xbx1XCdUA0FZzXN/SxIWCbtqLsy8
	jtQeMIxcVO7UzRqGHLWwvLbUG07s9AW10=
X-Received: by 2002:a05:6512:32c8:b0:5aa:7078:4a12 with SMTP id 2adb3069b0e04-5aa87c23abbmr3618491e87.42.1780863441904;
        Sun, 07 Jun 2026 13:17:21 -0700 (PDT)
Received: from fedora ([37.113.99.0])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b907269sm3276268e87.34.2026.06.07.13.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:17:21 -0700 (PDT)
From: Georgii Druzhinin <ilovelinuxgames@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Georgii Druzhinin <ilovelinuxgames@gmail.com>
Subject: [PATCH 2/2] staging: fbtft: fbtft-bus: remove prohibited space before close parenthesis
Date: Sun,  7 Jun 2026 23:17:08 +0300
Message-ID: <20260607201708.88644-2-ilovelinuxgames@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607201708.88644-1-ilovelinuxgames@gmail.com>
References: <20260607201708.88644-1-ilovelinuxgames@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch.pl error: "space prohibited before that close
parenthesis ')'" by removing the empty argument and comma
in define_fbtft_write_reg macro calls.

Signed-off-by: Georgii Druzhinin <ilovelinuxgames@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..409770891c54 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.54.0

