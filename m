Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420636;
	b=pmMjwirFB91nea2g0YMAdzuL/sPlFyqDz7yXz312lw86iMdy83vXWl9MnDG4pL/LQh2z
	 bnGPzlBEquUY4DMiERFqcVTZCHOfH0wFe9smhTfL9HUVch6paFmM2NJZKeZZqeA/CE4hO
	 06S8fNXunSWJDxucuzru8n977PyZPMcktdBTm6uwAfarQ7L3ZT2shXqaWQ17VtJ/YfLti
	 q0GsImUv1555FFkASubRBB2NttODAzGrlLDsh5OaNaRUgyezmmnWi9UNWiJ/ILlopm9/G
	 uJ12nJHo6pktlgdojuWcG0ugE0bUqeNjxqRWIfWMhogw6rhpS7BGx7bSj56coAAWRCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oyMiLoLSdUtmLwvkMWGKLcY+WxNb77Nh3Idx5n8lKi0=;
	b=Ckx5JnI5kzur0bI3yFaa7KdHQF0sYfmYVMWOfqlLu6LXw5TYQcgHJ4XS3h2bFM/KfPd4
	 0Nzq4eeNmUSQLzZy8ejBrmB5//tT29RTcSK8u1mz8FZRxBNu0/SZ8C1RFvOSw2zMsFRME
	 Xa3UmoycWBzQFLRu72Y0ZR4Qtuj/pLUBYEbM26295JtmHBPXOdnbYKTF2iNNq1oPZbRLQ
	 h8zz3YR6fVK+xGEPk4VVlxzSeNHFi0VwLAF675MhNAQdfp/Lir1Ii583rHBGoDMsFZJeO
	 njSc0sbGinF87jMckytQb/u5Wl1IAK8ONoljQyxxJlf8lqaAb4QFSoLAMQZb8LdQXAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gSqAaJbr;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95947606A31A
	for <linux-fbdev@vger.kernel.org>; Sat, 31 Oct 2026 04:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95947606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gSqAaJbr
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so44206a12.2
        for <linux-fbdev@vger.kernel.org>; Fri, 30 Oct 2026 21:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793420635; x=1794025435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oyMiLoLSdUtmLwvkMWGKLcY+WxNb77Nh3Idx5n8lKi0=;
        b=gSqAaJbrKK97699YAQ3syVbr4zaddIwIfQLSciJGI9nsXLgGpV8Xw886Oa72h5lOzA
         Dgd0mZTYZT/7eaJosw3cwNANjFI+A/aF+yf/Z6FZ72e1YYKmBaiBsi5ZK5CkQV4CnQtV
         7uFROqLbzdBLezncfo9PDbNmZ6b7LH3rRoCT32YaOg9SuIkarhYwZ31/RgPA0MDVr2a/
         731cHZU3oSg6kGwp5IDpLchC13hLN5eOu6UlRzYJKFM+Rn9AHlccuifKDWjwnVSr9yHa
         +pAQbo3bDj9hpQfrtrn/R9uAB7MxOIX82glEVH0SzKXMZmDraEQQii9PVNsU8zBxMQ+n
         o2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793420635; x=1794025435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oyMiLoLSdUtmLwvkMWGKLcY+WxNb77Nh3Idx5n8lKi0=;
        b=qtiMgGn/Dg6SzYu9JzGuqZOVYPKQ9und2azYWYNVhhHWu4ykpMpObY9s4UJmBXQ2Uh
         ZllQDJId1lk0W9aXuIf8OwbZeHapFgAHnFkO60qPWBp9kFyvVf8rTJHy3J/uTOZdmuX+
         1R3uu1ZGFfvr9D7umNOovbXiYsBVPxoWJ9SkgVvt9yewTi3FPC1kQrROxZFwofGOoLYh
         TXKfGLdiOqTTBF+UTb1ETRGX+08cC+9hrEg0wJeotTxLoXraw4ROcU3M+Q15ZoRyJj4p
         0gN9WChnyfQUpepY0VyihiQnYOALZsJXqkHd8s7Aa1prRsueDKP+88e8AtutjNAn9FIC
         jtDw==
X-Forwarded-Encrypted: i=1; AKwUvBzV1B4GDZK3XH4EFbL9lLXXoAJGolM75DQDq7cFc+dwnaxA9BlUl8RnsKJ7P9++IwEIZLAT/7gsSUlfRg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJPiqBTzzFwKAm9pw5Z9pT6Iv1cWvjfQtoh+Ri7TQFGOod1sv3c
	8hDHWjzZ+M9dVJ/PAg21o3gdz7u4OMIpozPenj6m77JHu9LG3MXSLnMa
X-Gm-Gg: AYBFou3m2r/XJ37WcaVz3+0bcTwodRs2hzhdJLwufj0ykm2Zi9vzWzLSsYS7pp6gAmF
	Ty/fLUUQR2innQ+eacTRpavuwEJm5/shwZrPdyvZVW/DVPnLr14PMvt1X+NqyJrYZnrC+hP+Amc
	wN4B38gKXiv8nQUkwHsBDGiqTfi0Hc5HZ24afqTylikgt5b9os0I1TH8r6InEzowMArA8ZZcZ+X
	zjMppLZv3qJAJs43SSTdd/e9r4romVyqXb3kv0tCsdqGUFi7hbEWibGCUcB4fAcfHp/EZdUhXcI
	c0p5IdxoSFd53K/Bow2AKZQrV9qCBgRLJiGrmq6bY92UUIkNN9ltyGfBbIMutN+83CI5z5dJHny
	TRHnIKvFSK94tKA09mdXbDFA6pCPOFHl5zTUFVveJFAFqAazAnWWbFuEHz6ImiiTsiuEjoRYHWL
	MUAalyL7EsmKM+eLHywSzrW28i/tW8mM6IlVvyfrC2SGO1g5BAGl0us3y5bK7SOsVjwwklCERKl
	IpPnxnKWcreuxy1jBQ1Vuba7RCeKiwzF/G7WKIgH/bVSPhUQ+U8B5njCPN5hZpPAkbLy7Iw6Bxa
	47RLbg9c6ntMUv6TkFjoOTvrDY/JA62TQ1SpWnzZy1o4HrfneOB1BpBBRTNHhmlzGDo=
X-Received: by 2002:a17:90b:3f84:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3ae89776af6mr3372365a91.11.1793420634944;
        Fri, 30 Oct 2026 21:23:54 -0700 (PDT)
Received: from localhost.localdomain ([223.167.219.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84596e3bsm6344526a91.9.2026.10.30.21.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 21:23:54 -0700 (PDT)
From: Eric LI <eric.lee0305@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eric LI <eric.lee0305@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: fix space prohibited before that close parenthesis
Date: Sat, 31 Oct 2026 12:23:15 +0800
Message-Id: <20261031042315.1122699-1-eric.lee0305@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up the following checkpatch error and warning in fbtft-bus.c.
drivers/staging/fbtft/fbtft-bus.c:14: WARNING: macros should not use a trailing semicolon
drivers/staging/fbtft/fbtft-bus.c:65: ERROR: space prohibited before that close parenthesis ')'
drivers/staging/fbtft/fbtft-bus.c:67: ERROR: space prohibited before that close parenthesis ')'

The reason of that error is the modifier argument is optional to the
macro define_fbtft_write_reg. So, even if removing the space before close
parenthesis, another error "space required after that ','" occurs.

In this fix, I change that modifier argument as optional, so that
it is both ok to use that macro with or without modifier argument.

Signed-off-by: Eric LI <eric.lee0305@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..e483ecb10938 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -11,7 +11,7 @@
  *
  *****************************************************************************/
 
-#define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
+#define define_fbtft_write_reg(func, buffer_type, data_type, modifier...)        \
 void func(struct fbtft_par *par, int len, ...)                                \
 {                                                                             \
 	va_list args;                                                         \
@@ -60,11 +60,11 @@ void func(struct fbtft_par *par, int len, ...)                                \
 out:									      \
 	va_end(args);                                                         \
 }                                                                             \
-EXPORT_SYMBOL(func);
+EXPORT_SYMBOL(func)
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
-define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8);
+define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16);
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16);
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.34.1

