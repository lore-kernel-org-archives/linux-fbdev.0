Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06A38331F
	for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379651; cv=none; b=Q11LsBJaBPieY8cXqoXxGgg95hOZ6ZT9WwCtzC/qOqcdleHntFXZVJtw7QT5EsHhW9YuFR6IGF9wphcvYaQyWUZOdK/ChE5Pv/h5CSn+/VPJstM5l5XNFwj+EO411kbEK8ieZk40J4QkMLM4unTNcqvi1cq6ewDqDbllDXYkCbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379651; c=relaxed/simple;
	bh=/72cscm/GhIUlsC0TbwUIq4c9GFNo7DiROPBFIBmMLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnbGmgeqbZzVxLusNDxxwxmHKvaSNQTRRh6q8j+JWuYRt8l+11AAkoFp1fngpX1ktsFzsg/PDl6SEVkPcA/1WjRnVKUpft4RI2vPs+OGWt7hJBa7A9G8LDfx9ViYLRrABTHIoOzmAam924IRPaSbuYO3tLM++Igdt/oZgQsY7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy0f+Kfc; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy0f+Kfc"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-13810b63a1aso1642080c88.1
        for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782379649; x=1782984449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GgAGfvLU/sWq0xn5C6mnyJo2AmSG/YZOnlB2KZb/PA=;
        b=cy0f+Kfc+SvGQMREOCiAQZuk/Hq1XxpovuikX5L0oW+zzjtAegkSJ4VB3ZPa5EjAOk
         SKnhoMdnml+G0s6YI9XmvbARfI8qBU0p4V925atiED5FoIqCDF5DXhdyrl0/F6sj5eZ3
         SmvMg+5qkhMhf4kxWnCl5aCTJVuxYhEa0OdCFPvAbp3W8OZxf9SoAh4Bm4VdZXypuP+q
         q0Dcg1tl6nC/pE20RpQ3O4pzVRtkvBECchXvpBn8P4DlDtYf/OzzFV4FLDtpZLHtXJpu
         EEaxd020AfRavQpgqP6DjYAgfvDeyTtuLhjHL0YpYHonavBPBpeT+195M9ZsemrGeT7u
         gskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782379649; x=1782984449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GgAGfvLU/sWq0xn5C6mnyJo2AmSG/YZOnlB2KZb/PA=;
        b=kfFme+y5pjj2yL9fSSfXJ8KKI2NoSt13f1AwCyzhbIJHRMBSdW7K4wYsrlSMklHVfa
         zkO5wukCj2s536n0b2v4XdWeSWADZnX+iDPXv2Drc+dhc706agRgeJcad/SLg0P8AcM3
         1JNABBrFO1M5myXqIK3cH91XZqAiys3iRs7VDY8jblpU5MKAVZCXjGaRh1BGeRu6Tp3G
         DKhKoXMfMxLQmnL+vxLCyzPhnLkeLd8srlZs9jJHjCVGkVdzbQicWRf7H4XA58+shbja
         HPfAgILpSPMPoMPxqJkmbp6ZvesXbXxDakBs915RyLZEW5z/piLGzAXw/5FEmu2ooDek
         LV4A==
X-Forwarded-Encrypted: i=1; AFNElJ8ICYb60cyFabNQ8eljFKA3f7Wupyr7Ef6MlT44fFae0151FwHnBzcppK7sA+5oFzkJl1YTdlHfrRq+wA==@vger.kernel.org
X-Gm-Message-State: AOJu0YziuC9vk5ozdNmD/H9Nbcrcv0eDtB5OWbRQ9uOTxtoJdHt6vUMG
	+w/tDThBeUYxeBro8lzO9AL+ogjLu4uGPC5oH923XbIzY5cJ/DLaoXhZ
X-Gm-Gg: AfdE7cnJmUJmCDpixgRHhVKEVqsyA6f3VC6drAmdNXREhg6z6aLW0AR4qdZKFBafmXX
	JL9lGAS963Jc/O4qDLbfSUyE+wubpWp7cvlV5/i0x+aBd5LQYWsf16Bz2lgpBdm9I/g/J0deuLg
	SRL0fUvf+ZKJiuHvnEF484wwaLc6oPX+JJaWmaicVYOOlknifLxZUhLJhRV4lntRSFWYUN9Kf/h
	9RipK1pesVfzzQtWNISkr6DHoavzCRfN6i2K9qbyFOzGKPEiM1zhRfZu0FUVdOnuKsrdNk2W6yh
	fovQDVrv33U94R+2vubLAKh/7+GvvhTn3nbW6ryML6xc7ghi8zikaJN0O1bRi0poomFW16K6p6V
	XDPYHMDfXYDYBxo4eCO5RmacJs4xEvnLLeqln515sqctFy9XZz+H6nnI9ymTH0iWwO0P3CK1eGT
	eNZ0gqHbk2ffLK/6ou0lSUdRcEPrjaj2hCyipPDG5WJSfD
X-Received: by 2002:a05:7022:e12:b0:128:d4be:7438 with SMTP id a92af1059eb24-139dbb548fbmr1587576c88.30.1782379649197;
        Thu, 25 Jun 2026 02:27:29 -0700 (PDT)
Received: from 10-86-27-11.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d90e971dsm9709547c88.10.2026.06.25.02.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:27:28 -0700 (PDT)
From: suryasaimadhu <suryasaimadhu369@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: [PATCH] staging: fbtft: replace empty modifier argument with no-op macro
Date: Thu, 25 Jun 2026 17:27:21 +0800
Message-ID: <20260625092721.238366-1-suryasaimadhu369@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define fbtft_write_reg_no_modifier() as an identity function and
use it in place of empty modifier arguments in define_fbtft_write_reg()
calls to fix checkpatch errors.

Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff1..2169f8d1d 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -11,6 +11,7 @@
  *
  *****************************************************************************/
 
+#define fbtft_write_reg_no_modifier(x) (x)
 #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
 void func(struct fbtft_par *par, int len, ...)                                \
 {                                                                             \
@@ -62,9 +63,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_write_reg_no_modifier)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_write_reg_no_modifier)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.47.3

