Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B221146C
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Feb 2026 04:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770094336; cv=none; b=jSZESJTbi353BFENceVxo/313zMioe1b5290ZoB1/XAOBtP0/Ji28b4P7LCA7oVvSM2eQH2X5LM6UGklp4XB9p7+j3iV/3WeOpJzhsGyhVpFD4m8IRD/kNhnpFVssjyEZ5aapmtDI+oDweN1cdCnLiwF61D2n+hdawYbWIlHYwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770094336; c=relaxed/simple;
	bh=Ftf6AxmGQtAtNVtlE38F82dj2LDYE/4g8fYPDiaBt6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTIxYIdRJRsplp9LNoxXNfh7IwXKxfCqGntvEYt74zXYjWrwyKWLL+QEPuLd1fDMc0B/mHAOYP0vZDT/H+iD792zJTerDSp0WbmT8YhtQ/iAUf2hlJJfbQ2tIEpUhfdbjqi/MtDEVFptHIf7ctncSeN2Mi3H0RXyuIJEnL0JJpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mosc79Qe; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mosc79Qe"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a09757004cso41713615ad.3
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Feb 2026 20:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770094335; x=1770699135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sahNc25e8V/0vokuer5AdT6A9YG4/1fX8go429GK/ZE=;
        b=mosc79QeWdoFCmTFGg7W5VHSnPtqZg0ERaFER+CvXtToh5h1lE+YkZYHiqqZTkiDvK
         C/ZcGXyBZsGTeO5tmERakKQvG5AJ601QZ1OdnYXlrm3GXHNvPCAMWYq7hcpHEPt9GcIh
         D5fWN54BUJr0SbJolo82l0E+wej/JhZ8dddmdYyfNaNyGu+z1rWM3D2CQELlLW8KY++p
         pVJB617oc4RXp9ZaeStSd7hIgxH81AIcYZaHMyPX+85QpmKBgnyZyKQQZ+MJNg+GGKPo
         kf11CFLQCH77dwK7dXDqcjZG13dWdUKiZHH+J0OKBdLtW00kuVY2oYMuPmD1d6CdyAcJ
         8rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770094335; x=1770699135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sahNc25e8V/0vokuer5AdT6A9YG4/1fX8go429GK/ZE=;
        b=bazaxPRx5TLZVcV+R2PZMQ00OMaC8akKDHGqMweZvwm5GKk33bkkGC2dsQCSNrgj7P
         PKMk+Mr1AFmUiEkggNnD/9hG78bT2Qtmju1ay+2m81Kmb5MV/BLVGgcFfcijckP8BR8n
         5KoWkJS9jh83g5tJhk/fMCUkkktmte891mgv9yoWLqE92KtjbnHs8ZgbtArJ5nxxJEoF
         pd8Mduvw62l9N73acP1EksrGrwH/sPzVWV7aR2pYa9OUgPTeOYRVCZmUNxRgMtyU5C3/
         cXJ/jOWcbHP0BW9wn85K/HoaSr0f2Nu5uwCwUEboy9c/9tu59GYWpagcuBLDmgbqoLH0
         briw==
X-Forwarded-Encrypted: i=1; AJvYcCW8ay0fyaSbnj5Z9Za9LEnc6E2g+QGM2j9jdTtTaH2ImuDlmrN5xSbtgQEY5pPT5M3pwV2+qi2szLt//g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyWgUFzun6zinksCNuiM7w3JotUv5npENh2vU5ygfOgoh9+gpT
	2NaSqm7tTn2b7vKyoigZGcoNBWC+sfUVpOQgkNXKURGYruCZCEpG0XTq
X-Gm-Gg: AZuq6aKOmh7A7z/RX1ZpkbGhqusWJYy9V68V1CrIpIJIhlClDX2QH1zs4VmqaZU9tP4
	W3kq4zJi7rk2K6Wy0jh2kzHy2PCwMfCKj+YUEA/SPdaEFQFlcyNQtwYAZmyUorA4w6l1abA4buN
	IkDFN4yuM/a01gpqZCpycvcS2h/idzyuCO0zPd7NYYJQyY6Q9H/4mQ2bpWLFBHoMFG7ssAbOyFh
	KZZHAJ7J/spZ9Y5jLQEIPQLiG6m8e2Q78KD56RS+j51apk0fTbGDUE/GJwGHq3xucMV0h0ykm7L
	/IOZ7reqk+TD0GsWqbN1NirzdQtvmM4/3WwzpZXottdlpji+sJ78JyXKdUMviOzWIr+bQHBX4Ji
	NnnxObrFi3qitK12ytgpIM6HMYYX777spnhwmIqCmrhGzpwdb5gaVTgJAxbdz/rpOX+/VFsz2a5
	pU6Xjs/+Mrnem5kX9/FBDHA0Q=
X-Received: by 2002:a17:902:f544:b0:2a7:fe78:a344 with SMTP id d9443c01a7336-2a8d959c5a1mr143542085ad.6.1770094335015;
        Mon, 02 Feb 2026 20:52:15 -0800 (PST)
Received: from krishna.. ([103.220.210.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8ec56da60sm85791515ad.38.2026.02.02.20.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 20:52:14 -0800 (PST)
From: KrishnaAgarwal1308 <krishnaworkemail1308@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	KrishnaAgarwal1308 <krishnaworkemail1308@gmail.com>
Subject: [PATCH] staging: fbtft: fix macro flow control warning and empty macro argument in fbtft-bus.c
Date: Tue,  3 Feb 2026 10:17:28 +0530
Message-ID: <20260203044728.23774-2-krishnaworkemail1308@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203044728.23774-1-krishnaworkemail1308@gmail.com>
References: <20260203044728.23774-1-krishnaworkemail1308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch warning by adding identity modifier for define_fbtft_write_reg().
No functional change.

Signed-off-by: KrishnaAgarwal1308 <krishnaworkemail1308@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..0ab4f5c4f886 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -10,6 +10,7 @@
  *   void (*write_reg)(struct fbtft_par *par, int len, ...);
  *
  *****************************************************************************/
+#define fbtft_identity(x) (x)
 
 #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
 void func(struct fbtft_par *par, int len, ...)                                \
@@ -42,29 +43,28 @@ void func(struct fbtft_par *par, int len, ...)                                \
 	*buf = modifier((data_type)va_arg(args, unsigned int));               \
 	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset,   \
 				 0);                                          \
-	if (ret < 0)							      \
-		goto out;						      \
-	len--;                                                                \
-									      \
-	if (par->startbyte)                                                   \
-		*(u8 *)par->buf = par->startbyte | 0x2;                       \
-									      \
-	if (len) {                                                            \
-		i = len;                                                      \
-		while (i--)						      \
-			*buf++ = modifier((data_type)va_arg(args,             \
-							    unsigned int));   \
-		fbtft_write_buf_dc(par, par->buf,			      \
-				   len * (sizeof(data_type) + offset), 1);    \
-	}                                                                     \
-out:									      \
+	if (ret >= 0) {							      \
+		len--;                                                                \
+											\
+		if (par->startbyte)                                                   \
+			*(u8 *)par->buf = par->startbyte | 0x2;                       \
+											\
+		if (len) {                                                            \
+			i = len;                                                      \
+			while (i--)						      \
+				*buf++ = modifier((data_type)va_arg(args,             \
+									unsigned int));   \
+			fbtft_write_buf_dc(par, par->buf,			      \
+					len * (sizeof(data_type) + offset), 1);    \
+		}                                                                     \
+	}											\
 	va_end(args);                                                         \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_identity)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_identity)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.43.0

