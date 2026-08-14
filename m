Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31141B362
	for <linux-fbdev@vger.kernel.org>; Fri, 14 Aug 2026 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693496; cv=none; b=gQofTqPWbEjQESDDYY8f39uZRO+NoXmkhC2TxlLWkwTnWt1Zw8mUZDH+Lfk2OvWPZOz9JAeQWy3BE0k6Cx5sm2F1laHLucSHMtOQ4ORyHwucjLNidsdDzlz++qYfHtvoTKjS+C6Tvc45qQLx9KShiw16m4va/4qPYitY3v+evVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693496; c=relaxed/simple;
	bh=JgaZlVMkDe6qDCqmgpIIx3QmwudO6Mvh8tOMiOQ11bU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRqu3swQQ1kjL/6rnwFsJWdUpmt0m3boDfACMP1cLYCMxfgzIrDm+uPMLSWHpRUiSxldW++fC9NHQInMwh3odqvP2N8I4oIuUquwNsHuZ9/UbicSb0gbix1UIWDAjLTLrkQtGruXh9voXwyBI6epICjwoIh/IYafDoRQYDT819A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuQZQOUg; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuQZQOUg"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso971751a91.1
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Aug 2026 00:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786693484; x=1787298284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cwYk4ejoNMOniCBgkjcxx38Ml00PjaYwyPcbfZWz9ws=;
        b=WuQZQOUgwfu5zQxjbX5x1vuUUv9Enuispsa3bTGii2PdLecScU/nr1vnXb3PSYxtPD
         QNx901YmAeDeREmuB/IyyoFzdJxX2iTRxuZWaWXzLm6wdZ8I8lp+AVM/jMNSXcLXBt5k
         BJRsn95bIDYQdVlFSJ5sa29hTxi9yWJnSYyY/d38Iw3lUzWsYB5hGxIwPQPojneeEZWy
         CGnTjahbOKbHI0fH2kmMAqKxADK4ZfoQtT4YgIeI9i0ky9R+FljGmEOfMmpAjegODhO3
         fc8OEdZBC+uIDd75ZJoB64typ81TWbPZg+MPXzoFzdciocNGEA0biolONXgqaPWx5OzQ
         BqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693484; x=1787298284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cwYk4ejoNMOniCBgkjcxx38Ml00PjaYwyPcbfZWz9ws=;
        b=Kc/qryLu+D5o+yMwb0wYC9IHnOj6C9dPWzXtXI6wKD6AXZsfzMVjkgaxZRkZpgnipA
         p77r/rvhrvpjMIv+gIMn8+AsM4/Ko2XPCaUWYB7N2hAzr9qa2Ibb+4Vxky+M5+2tZb/n
         WFVTyh4iJx7UL7XqiKt7EfcvgrgYlVPhqSc72+Ch8LEwWXkRoqbSg5wzj3A7d6za9dZb
         BWOZx54TH/gQf5nWyBB/H1cL6a3pACrxjjbXYFeA/vXs9yidRnnZdn9poIUkH318Snly
         boT4cmBQAuRrlH//M2HLrV3Oqa784gFNloEG2SLXJmVr1zjfu+CzxiFTPLMUMp4VaZut
         dEsg==
X-Gm-Message-State: AOJu0Yy7wlP7S62hQraiJXLmILLnG4DKlDKAUMI0mFMM67Po9nvLhiVd
	hUNGTm3SwLdAaCUmANMmhjNO8ElXMem1xzJfWEwgoqV+Txa3oC7CwwOF
X-Gm-Gg: AR+sD10Z1hWoKb0IQj6SJY4t0Y0ZrL5sV31lUg45LnRBuRM3H1hSmEkkudTZ4MlM09k
	sO3Ar/8j14yJ0l2pk9ocaZ7ZaFf5uBBH/6h7BlSin7kQpS9KbhM+FJj93xHL082EgMU4X+poyq8
	jJ+by6XhnfOqC00v4YbwQfjT9CbUGGvA/BDnhTafAU/qIBv3J2k4M/1M400BB17Tw6vVjNrphaN
	TvQ2y3aIMXSuE0ChVBbM2cC55gmvvlKjQXZEUjZXIqvejkTikaAegi15UP2yYZeuOg5dzrfROns
	jFNSSb/zcYW6h0ix893SumBS/Zot1DL3wdtZ2qAaYlpYpjz6Rpf09Jl/OooiB4JXpFQonduknWs
	8Gi857xWmd77f63EFzvs1+DHMqKL7pWbOPeUE1nwQXyV7LhPBs28Z7y+ER+1sWMQ8DhsiIIlp3L
	Kkgs6hdv+mvk4lBXoIUIq08/JnM13j+CxZYRWgU7DooRFVfCgzh7mpAgY3a23R3hEB4SkXn/G12
	u4=
X-Received: by 2002:a17:90a:ec83:b0:381:e74f:8a6a with SMTP id 98e67ed59e1d1-3933b8c1041mr4446396a91.16.1786693483969;
        Fri, 14 Aug 2026 00:44:43 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-394ebbcc34csm1462260a91.15.2026.08.14.00.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:44:43 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: FlorianSchandinat@gmx.de,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH v3] video: fbdev: via: refactor strcpy and viafb_name
Date: Fri, 14 Aug 2026 07:44:35 +0000
Message-ID: <20260814074435.277441-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated and unbounded strcpy() function with the safer
strscpy() alternative when setting up the framebuffer fixed screen
information [1][2].

It aligns this driver with the ongoing kernel-wide security initiative
to eliminate unbounded string copies, hardening the code against future
modifications.

Additionally, convert the file-scope `viafb_name` pointer into a
`static const char[]` array while preserving its original value "Via".
This allows the compiler to execute compile-time bounds checking and
optimize the string copy operation without breaking userspace ABI
backward compatibility.

This is a proactive API cleanup and there is no functional
performance or truncation risk.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
v3:
  - Restore the original "Via" string value to prevent userspace ABI 
    regressions, while keeping the 'static const char[]' optimization as
    suggested by Sashiko AI.
v2:
  - Keep variable static but change it to a const array
    'static const char viafb_name[] = "viafb"' as suggested by Helge Deller
    to let the compiler leverage compile-time checks.

 drivers/video/fbdev/via/viafbdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 80f95dac32c8..f6823beb4d7e 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -16,7 +16,7 @@
 #define _MASTER_FILE
 #include "global.h"
 
-static char *viafb_name = "Via";
+static const char viafb_name[] = "Via";
 static u32 pseudo_pal[17];
 
 /* video mode */
@@ -144,7 +144,7 @@ static void viafb_setup_fixinfo(struct fb_fix_screeninfo *fix,
 	struct viafb_par *viaparinfo)
 {
 	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id, viafb_name);
+	strscpy(fix->id, viafb_name, sizeof(fix->id));
 
 	fix->smem_start = viaparinfo->fbmem;
 	fix->smem_len = viaparinfo->fbmem_free;
-- 
2.43.0

