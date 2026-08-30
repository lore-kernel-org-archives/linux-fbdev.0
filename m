Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F7128F5
	for <linux-fbdev@vger.kernel.org>; Sun, 30 Aug 2026 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788106557; cv=none; b=HRO1CWvSkarZRvvA4SEi6uDhd7fISTim5iusA3Qu3T1gkNRRFuW747WlBsnoz+1GmGxGeZuu6FEuezGggLTUKRjKRCxCw8wVuxycrlQ7AImNvg9HpNlUcApTD2FFz2fP0RzgBTAtuVb8s/9NNu/GvsibwBhRQ7PRzvGI13GsjY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788106557; c=relaxed/simple;
	bh=wT3w65sxSrm3I0WipIg4iDjDoWq1ddzUQosWgvwZ/5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wtk39lTjlSvSmEGLRohCGaOGFaDj/JmOvhmcUOxEAYZzNEixZPCKgzjjDRMhsZBQJFPRbGgXm49SHNF6l+lSy/1TILUndDRsuYts+BViHTsXHBXndstt/MEJiVLfrmLPuhR6eYOg3TLzsdAN1wZ6okqLnziM9FObC+5yJxJLEuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM9XZ6gs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM9XZ6gs"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d91ff7d9acso1421555ad.3
        for <linux-fbdev@vger.kernel.org>; Sun, 30 Aug 2026 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788106556; x=1788711356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ftpZeIMiNCY2OcgsJYMYoL7K7phvSKcRMGjOcwR8P9Y=;
        b=WM9XZ6gsveAjhl4sy7CqgzfARAOuOb2oia0NvRElXsgnC7Pb/9qdhiloYS4ZEDuIjY
         Xq+93rtb7QU3GwhA10aMCeO5BU1cscXDFIjvdrkspaMSgOuc4VdSrx/JS3nGNh1kVGQS
         lBX+mSayD0mFjF7G5ht+csKRPZcTaJ0C9nvR6Vv67bEboG4RG3MOtA2Dn6/SCY0CJCVx
         z3gcwEOSQIDPvtgaz38rlaHBhCc1C59f6BhgkqGydMi0s8v6/5p2KQXMcovbEkYRoqBt
         0i46R9EufZXa+y/+oJXJLxLwGcj/VtS1NXMDM6iWiipFr7Z/jj/JQDAtvweSc3leh44u
         KLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788106556; x=1788711356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ftpZeIMiNCY2OcgsJYMYoL7K7phvSKcRMGjOcwR8P9Y=;
        b=BYjI9SJuHNpaofSU26ya2pKtPBgrrFVXoCQdrGwW4q055eOxNdLUsAZxTAhpQ7+LfG
         8dnNjKzdgxdLhUz02Cpm3Zd4gazF5AySVTfM2DWvjCcMiXvjefOKErKprN0FY7Ryrl1Z
         kVm0uUiF4fWYKsqKNy5qs120D5A/3xuQ+NWXe6I0eNsiX42sOsqlSlDzG00aFtJZZwNH
         eMtWlfbGx8tgdiWx1n3STrcz8rnU14DOAVj4Jb6wzi7de2AVP57FCmrp2U+NM3Sl9k0g
         E2qJpsSyV8tl0mPCtOsPKlr8/Lwpg/0oTR61SjZ9DWppefCrzxFjzK4N8CMuBTf3h1p5
         JhmQ==
X-Forwarded-Encrypted: i=1; AKwUvByfS7LNB6BJMSIVlcvfuAWKfsoYf588uRknWqcDuHbXCV/VtJTYIvLQDVoTUflF4t2frjlB65/uAep4gw==@vger.kernel.org
X-Gm-Message-State: AFuF++kC21366oBTWl5ITSKSEht33AfhTcTIsoMaNYFX6lwTTY28Uval
	M34nsoYLfjXRKYT9l6po52fBsYUMayPF7qxSmAR9u/fthi1z04LEjsVk
X-Gm-Gg: AYBFou0f41ERKu3IS+s6cZt1HBRfvDk8VigYdd/sGZLMxt6y5+4/nVIyYcl947qwMjZ
	0WR3g9Sasw/CYJb581ys/BODpVtCNFg2XJ86uUGdsYjqv+rqwkiB4VH4ECNe0pm204P2O/TNihb
	+mwU8FEnJQ7tdNeDlpbD9D7d8UFugRH4WgOA9lzBvumWLP4X+WfNUKO+l9zuYHRB00rp1vL/Usi
	ok+ZmJtbM2pqJt5hS1VAqj7Mq7H4rlm4X1SlBLDRw60y1Ggfg+ArmUPzJPFYiIoKZFs/pXLwMsH
	Q/Vhge9r5xIwGRGa+L4Vf7dZekC+dUqqIhKBjlSWpoC/8T78xD1a6Lu+4OO5lbWNw/IlyUqDbrO
	BapqVeDuDyyNqgrQ9Tr5hIkcwpCYLmev2uonIbdGipj/CVs0Vjb4OLBzhxr7IXMNKvLtCGq3bcN
	yZ9vEhI+rUUSQpZbq5u/e3vJoUcZMLW05ko6UMW7Gjl1mMiPoN7EpioNH2hII8wJXYn7g4/wle5
	WyRToOMzsoBaeBVZ80=
X-Received: by 2002:a17:903:2c9:b0:2d9:6db:9fcb with SMTP id d9443c01a7336-2d906dba09cmr88661175ad.11.1788106555702;
        Sun, 30 Aug 2026 09:15:55 -0700 (PDT)
Received: from Kalpna.localdomain ([106.194.26.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7598c3da2sm24396095ad.82.2026.08.30.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 09:15:55 -0700 (PDT)
From: anshika <anshikajain196872@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <error27@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	anshika <anshikajain196872@gmail.com>
Subject: [PATCH] staging: fbtft: name the no-op endian modifier in define_fbtft_write_reg()
Date: Sun, 30 Aug 2026 21:45:29 +0530
Message-Id: <20260830161529.14500-1-anshikajain196872@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two of the three define_fbtft_write_reg() instantiations pass an empty
modifier argument, which checkpatch flags as a fragile empty macro
argument. Give the no-op case an explicit name instead of leaving it
blank.

No functional change.

Link: https://lkml.iu.edu/hypermail/linux/kernel/2602.0/01917.html

Signed-off-by: anshika <anshikajain196872@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff1..e03aa251c 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -10,6 +10,7 @@
  *   void (*write_reg)(struct fbtft_par *par, int len, ...);
  *
  *****************************************************************************/
+#define cpu_to_cpu_endian(x) (x)
 
 #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
 void func(struct fbtft_par *par, int len, ...)                                \
@@ -62,9 +63,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, cpu_to_cpu_endian)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, cpu_to_cpu_endian)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.34.1

