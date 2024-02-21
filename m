Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99A33F8E4
	for <linux-fbdev@vger.kernel.org>; Wed, 21 Feb 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509174; cv=none; b=R2RRUkwAb7jcLLQpsCGXvLvrbjkWqOzuiz+5HbtwdESV+0b3dY2C5NF8jomEA5JMjhxplSb8asbdtO9yXW/VzBfA8yl+14tV8Ke/A5z42n83gxtUgXf8EUrIB7F+laMdyyDbUc7q6DFjuIry5TWIuKkV0I5DrAGXM/MwqH7DR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509174; c=relaxed/simple;
	bh=hpQIzkAUkfjw1oAO8oKeaMgVV1gBPRjHKKseAjgbpXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Byfmn9EAd49qmT44fl5IinSn08supOVF+xvhqbiZgHHG0PQrLHt0To8uZBlRc9X1FyQ2iVUp9uyMyYMSGCg3VNzogyqEZDaTEv5ajwk7C9ZTrtbR/w4ZzyRY3LJJKb2wXMJqUrYRq+ASx75nohI5CqQ9jpFldP4LK/Q3qBRrPnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fglnTSOa; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fglnTSOa"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-299e4b352cdso1066095a91.0
        for <linux-fbdev@vger.kernel.org>; Wed, 21 Feb 2024 01:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708509172; x=1709113972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=umbo7IOMB+N5hMU5uXuhZHNVgY+ZT3DkUOlBqWz8poY=;
        b=fglnTSOaH3vr+7m3nZ9hZe5kBDQryDFO8lpqHKs/pIJgDSSZMUpul3OXxLMmoLXkGd
         Wi1r1xLNL6wC3PpWvxlyucEAV66L+t1uV2O5KRKg2KgU3jmP+kx2NHdk42vpogbZzNwp
         RbEuYvrhZJfSC7N5E4g5jNXV4BTVRKB3hUz2Cx+UXyFu86asQ1vYOVCXPG2e/UXGiWzC
         zBpX4Pu3gLnHsIBggRlJ27TkSn7r7QpFnKWsjlTc/Fij20eaiMUie03yfrpIutBIbseL
         MlVI24x+0/lv7yWWJYA8FYb6fSO2+omBtMW5m+xUbXxB25WcX2fYkGtYmY6OicscoIPs
         tPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708509172; x=1709113972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umbo7IOMB+N5hMU5uXuhZHNVgY+ZT3DkUOlBqWz8poY=;
        b=WsS//dtwFc0rRPbaJgqKbFPXHpclMhDUEJzLk2JMtx+xW9Tkz+027SfoRida6je+r3
         rldHnTd9A4j3Zt4woGuMRaWbvLSViLGSYK5nySmqWnoajSGsO1hipkYkMFhP5mFZGmDB
         AdWhSH2kPpTwy+Z/DEu0otDexOkD/+DnJu1JQLDOEZgWfpVYuu2KMcyOZ6VPIoWrlWZ4
         LEvXwW5hCW92V22tLrTz4Xm63VK/FIeD86RCmCVXrOcX+ZfhkicUNEJYtT9IWCDt/85Q
         N6lK2x9N0D3Bmgb3hyqxBB/SwtO7i84zdj7e/cU7Hjv5MTYGR/JAt1yxDYQSbMf2ldtM
         0Njw==
X-Forwarded-Encrypted: i=1; AJvYcCUmKt/doRGpdT/DovUx6KJqNxbzCuKoa4MxvvSa+kReGYf+YaoYEL0yGsnrCZL/ulnSLWPYCC3vbGtMHh4+YiG0pgjnRLGWHGcREHg=
X-Gm-Message-State: AOJu0YxSP9dDTbaoOJ1juNjdqq5vnd4OG73g13t1X8Kbr+mOIZAoKcn9
	dKYTtkEmjigM5ycLrP/CrDf2JW2ndpyI73NTJQ0lHvB0XwL0GX79
X-Google-Smtp-Source: AGHT+IHVR2SHjyVF3c5NtEANlYKund2uDElKO0tgKWeUMqRiBx6wQMP4L/8c6ILH58TxmxIy3JESng==
X-Received: by 2002:a17:90a:68cf:b0:29a:1b37:4bfd with SMTP id q15-20020a17090a68cf00b0029a1b374bfdmr666223pjj.7.1708509171837;
        Wed, 21 Feb 2024 01:52:51 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a8b0300b0029942a73eaesm9124093pjn.9.2024.02.21.01.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:52:51 -0800 (PST)
From: sawara04.o@gmail.com
To: gregkh@linuxfoundation.org,
	sawara04.o@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH] staging: fbtft: Fix "space prohibited before that close parenthesis ')'" error reported by checkpatch
Date: Wed, 21 Feb 2024 18:54:04 +0900
Message-Id: <20240221095404.592464-1-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyoji Ogasawara <sawara04.o@gmail.com>

Since whitespace is prohibited before that close parenthesis ')' in a
conditional statements, remove it and fix checkpatch.pl error "space prohibited before that
close parenthesis ')'".

Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 3d422bc11641..02a16671f2a1 100644
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
2.39.3

