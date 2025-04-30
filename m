Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1571E7C23;
	Wed, 30 Apr 2025 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992630; cv=none; b=QESBNUriKtTNLWWyXhJjXb+K3D5b2OnkXvVerrqgV9S2XuVPPLaLfKBkliwxQ2bViOOObv2gWO6LHUIX+f54Mfigmi5tqDkrAmqy2cTeE0PnTc7AG5GpbN1QFZPFwzlkRU7rgkOCQxAY516AsNURlLoyQsReCWn3n66Uh5W+Nbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992630; c=relaxed/simple;
	bh=OPcdA7WzHL8qbupr9CeaRRLP0cf3U+p7fWUcEB+ist8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N7p22M9gf2TeDkGLC5iQ3Jwb9iW5Q2tewDgOpz4f9JV5q3fZFh3LZ/2gys4g3GaecVGBGaLSXzvy6v52miWL6XpTXXnRAYZGBwKbacJ8+AZRhre+IQFf55FXBV3eckLZk8JKNzAHpBvcUBTTOUoCy0z9rcZcWSGA7iK5rTmM1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxpdCETO; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxpdCETO"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-227c7e4d5feso13116475ad.2;
        Tue, 29 Apr 2025 22:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745992628; x=1746597428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkxFjjdv6suYqQJlXMyq90HjSEeRgcZf4756/6SBQro=;
        b=fxpdCETO1z/BMhmCti/OaeYINgtvbU8bNMlyZn+Fz5R2SNd9T3acst3enoxTe4FazE
         Iu09H4I551sbHTbf9TJf24gLJ0gfmcP7I0ytFxHtnPpObHmi3uUvyg2hgQ/hAbZPKjGN
         WkkjM7eqMh8a244vjHdUWaRODsWRqUiCcQOiOM1NnKB1l0i4ylilCxDbRpiTKDrCBKCc
         DC+mN00bMwuVDm3opRFO7XPiR/fBNH10WtRamFMONswGjnWqrdVmfIzgLrZx7SdAe05U
         XDp8TMt0rbk4xQ2JnCKq/rVK8cs7cVZaW5tW+CgWq2sBe/PWwh8B0nzQ1DcjgRR7C8Ly
         HfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745992628; x=1746597428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkxFjjdv6suYqQJlXMyq90HjSEeRgcZf4756/6SBQro=;
        b=UytfI+3GhW6QzxAXO8LeNbXrRv3xbcmqyGTE7LgedBtYaWh2s06868FvVMilYjBbno
         Vss1lwUd7yBRoG87n/g5xjsIc/bDIB0x2iUtsl/t0Rd6EDg+S+88Ygc4tm/Dek7ey9Q/
         9fIOzL6oxHcWCuVZ1VRX2HtHKenE3aDY6eA5jtLt2R2y1PWE2CqkE7aqCyRCOJA2Lq1U
         bL00/5tclUIaI0T/nzZpIGBH1IAyHSlCJ/hLTQvUiG0Z0CXJmEjsRxW3u71aKvRxaZpU
         OsCA9tuicNn96rT8tmVwDpmTCZuXh7Ra7DKqoHPrtpYmEs281//Gfam9mnFKeHxzXlBT
         paGA==
X-Forwarded-Encrypted: i=1; AJvYcCVU+hiSsx2cnY9GSoHA2afZ0vjTXbiqUr7h9lwk9jx7XSBt2BTjn/Wq1XDHNOWYYMjKxIWIHDA6TM7ZSY6u@vger.kernel.org, AJvYcCXP4LWzOZJNE21hgQo7Ey09MGeCsknEBSKviT4/7hiwVsHouGMA99gfP+m1Mq5XxqIdbVjcrZKdbbJorg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbbzFbNSDS5SK9tdb2FTSt/6f03uqSezULaJWc+ZLKhYHIveOF
	pY7An4e2F7GRAsJwvYW/woLJTHlflxOBq6T+B8QAYGB0M6H5n6WX
X-Gm-Gg: ASbGncsMXka81e4k4Y0RKdRaPulLJBKPGcwSRvIKfcbWTGfJlOqN/XOZctzTu8yBqzJ
	HQFTnj9hVNxjNmlkVTEsqOINCOTedI4nUjI9oIuiSAoU5Wli9y9XKuMB2eixAtfpUQneTt67Omg
	sQgMWpM+FKJRbBMAqXxOoPaMrYzQlreqheUfebpOeUDh643uGoM/RiV7t3Y9+CgRXCbMdA4Rxjk
	JOu4bSs2To7e4zt8dbbUmDgESo/EQ+5Qk3NNXqk3ke7Rt9R7C9mN+clecqFstmtlDR7Rhfo5NdN
	u+vA3qzPpAr3pnmqwd7kTql/XE91SgmPsn1kyuk8QTdNSdtOLgviY80LxAWv27SHLMbDp1IK4kB
	eUJfLJkyBFPrMekB2cp+p6xJCJFNoizX22oPmMgAQJv0czaemrijxJ6g=
X-Google-Smtp-Source: AGHT+IHBJYloTgN8pwH+ee69VUknLa8QX3gHDwSiGfv0vAc8H9ceexmkgnOwBPKpCv3nT5A+ZkD2wQ==
X-Received: by 2002:a17:903:fb0:b0:223:28a8:610b with SMTP id d9443c01a7336-22df358f8f4mr11530585ad.14.1745992628441;
        Tue, 29 Apr 2025 22:57:08 -0700 (PDT)
Received: from kerneldev.localdomain (162-225-124-171.lightspeed.sntcca.sbcglobal.net. [162.225.124.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221a82sm113383895ad.257.2025.04.29.22.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:57:08 -0700 (PDT)
From: Eric Florin <ericflorin.kernel@gmail.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eric Florin <ericflorin.kernel@gmail.com>
Subject: [PATCH 5/5] staging: sm750fb: rename sm750_hw_cursor_setData2
Date: Tue, 29 Apr 2025 22:55:39 -0700
Message-Id: <af5080150498adf635be36e332a7ce7121692f93.1745982772.git.ericflorin.kernel@gmail.com>
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

Rename sm750_hw_cursor_setData2 to sm750_hw_cursor_set_data2 to conform
with kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <sm750_hw_cursor_setData2>

Signed-off-by: Eric Florin <ericflorin.kernel@gmail.com>
---
 drivers/staging/sm750fb/sm750_cursor.c | 4 ++--
 drivers/staging/sm750fb/sm750_cursor.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 3aa26ef00011..7ede144905c9 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -131,8 +131,8 @@ void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
 	}
 }
 
-void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
-			      const u8 *pcol, const u8 *pmsk)
+void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
+			       const u8 *pcol, const u8 *pmsk)
 {
 	int i, j, count, pitch, offset;
 	u8 color, mask;
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index cbb896a35160..88fa02f6377a 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -10,6 +10,6 @@ void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y);
 void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg);
 void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
 			      const u8 *data, const u8 *mask);
-void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
-			      const u8 *data, const u8 *mask);
+void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
+			       const u8 *data, const u8 *mask);
 #endif
-- 
2.39.5

