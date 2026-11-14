Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794650544;
	b=e2fVl38DsmvEdjxmvDA2w3S+/8JoqhA3TK1Ne1zBcSpGsTEGG87MTE3IcyVkV/G30+Lm
	 Pg8e5dES3iDJe6e/4ZIRay+8DNxKDBVrGN72VRSaqmRkolk3INpuc6nHj4cpyUEGe6neA
	 CJ5E2TCcBsAQq+VEdYlwUGb1kQ0fqgpD9bEM8WLKJSyVh3IYbkF51+O52+E5DHtX6PeSg
	 1PjvAoY2pWyoCUz43GE3XYzmuMwcjbmNldDrCB/PzJCUDQ7KOSBOdvgzO8VTZN0u4+C2f
	 lqIGlAwTspBJiJCJPvCNUCEr76s/vvRhQkVNrxxAyYRUdZterVNj66tQ2+ezEjIJmJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794650544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XwFZMvB4uY9ceiCAZLjceweMYbxPpefUPYbylRB7SRs=;
	b=x8TTcycmOYYe4KSuXatAflOerE7Prhgij/rnXAI8NlyHxZ0h56+rDAlyriT4+4gwVuo8
	 RggFwNYB448nfVYduOV8i9yW2538dzYYJlGmtF7hpd3BuCJ0i+uYFnYI3OGF7ME0G3IkY
	 BWoxKyCx3dTcMAswlXOdwACvQ1DIqenwCTi253MzuFLcQerGUHYl26iddhP0dLzxGUeNc
	 Fn6fZ6T3X6AVvrRXIWc30lyD7NUhQSx4hhJh5MU9Eb6OGJE+/LvKj99nOhjTWe7y6v2Ze
	 pIRtF3shN6cpKZT620Fg3i7gG6a2jS5ljxhZLex0po+XfVsddIL81G6s6nIorM79NXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Adsdm6ec;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B924606A337
	for <linux-fbdev@vger.kernel.org>; Sat, 14 Nov 2026 10:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B924606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Adsdm6ec
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a214af2076so11241145e9.0
        for <linux-fbdev@vger.kernel.org>; Sat, 14 Nov 2026 02:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794650542; x=1795255342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XwFZMvB4uY9ceiCAZLjceweMYbxPpefUPYbylRB7SRs=;
        b=Adsdm6ec/zmjbRKQ0f6KusGRFxW8VmYbzy+2DciYeCH6owdTVXMGNUofpTYCLto/dL
         huEoI687FjwKC2/FlpBQZIwrPGKSKj4Ihqsd785hKijZ01bpgH4mUo+LTCVX5nB18eYX
         xKivaAINrrdxiGqKs26PHwzxvX/1YjbMnocErnVO6Ve6+y9Cnccm3WpUsnWuqxfrDiv2
         OQ0U3KgbFCeB03ZOSDYi+3iiu75MfXNiJJmjjb4s39Mt7dbIDoPClvf7Z3YNK5NmHx4n
         0eQbufP3HVdyydDDTeeMXwh0IdiRKIquc4trFmJQ5WD2bb4TVlTBfzvftd9LUUbmVdRK
         7pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794650542; x=1795255342;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XwFZMvB4uY9ceiCAZLjceweMYbxPpefUPYbylRB7SRs=;
        b=KPjZndZY5ystuYTQfBebeLVkDc4e/Xfwu/IYHmXMyV8s+QPzU6V+v+Tndw3Cqt1FQT
         WZr8LvbTo6vh9H+YGiRRFlZvc/5ZnGhjXwSBnHRMRE41rPFRliDT5NBSgagsZ+YGU2Xm
         F/rfEFJZLJE1s3j4OrUjGk/gMbkOsSnDEpV9ybDhiCBjPRRU74GlgW2CPQLUUp5bCq6y
         Y53z/LMySn5xj6WCmF2CJYQo9vewdw5uVB4iK+Yf9mq0qenT+xNIIRg0Xbm10G7zB643
         6LCsVdqnluzJs0LHjmXYgT9G2IcXHrcdLYi5BClElDzLFlh4Th35KyXIvK/p4ZOH4gmy
         K1RQ==
X-Forwarded-Encrypted: i=1; AL+hErENI689ITsiBONJLkTA6VQn6EcoCEccwtmktumF3v5E1N6+Y1bOGGCPtg/cjPwnvuSy0mLYqTxvEqAZXw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Iixq/zkN0D4xCJzp/KvxhxV33zm0LsDeqfmp+0IS/GWOqE5EU
	/OGu4pHDONsfzQWr7DG7cuVjkkJ9uUW/4DjtyY5fhgQZioEAEG24DIkecVEZCwHIMOo=
X-Gm-Gg: AYBFou383F0LjLpc2ekgwSUydGzPxwBMJ9CS5T89rb0IQSiPdVxJuHc0uHzaj0Qpe2Q
	BHhGWWItjB2+58JwMkxug87nbuc5nkIZfnQSM4rHaWlRY5mMkblAoXKQ+fFNnvzY/bk4Ne3WJ+F
	LFM0rVuyjqqIV2pbIDKl1+cGq/6dnrmN1V+jUnLCOGaUEDdjp24KXHjOHn2jAN5jZsIgs2OrzmB
	aLXKm/ygGNMazYap6flWPUeCd3Hi9KrCwVScTmGxwEP6ESV5SdvRjhmsu5jMFySsn6pMEIC4wyz
	PtymyzCftBSWaAb3n23VAoqAFofMC5RHGYO2YsxG/vcpoN4296sue1qspSWKDS62QnQ/b0OAiuS
	ZNJGdK+Z+9eWM0WgJen00zNA9xD9ylu2PHClzHZ56AfRkXUEG3t2g4DW/VfoG5wX9mSDkFk8zeI
	qA21crj4kim56niGDB7BspPq5f5xolP5RlP2xwTF37NfcZUvkslHNkNMwvf0yrays2O8px25tM/
	jX/sYw+P5preon/5j58DMToFNBcq1vvjMFgBfj609hd6Zjwijk4xXQ18Enk3TWcqH5zcxfdYJd0
	UpNE2kPh8hRmLOff6drQ0WzG8QTY5eUeu/fspe3//ivRYf8TbYlLqqs=
X-Received: by 2002:a05:600c:515:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4bb55a6a658mr71519865e9.27.1794650542390;
        Sat, 14 Nov 2026 02:02:22 -0800 (PST)
Received: from DESKTOP-TMG47OE ([176.41.25.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608cf46dsm10520184f8f.43.2026.11.14.02.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 02:02:21 -0800 (PST)
From: =?UTF-8?q?Ali=20K=C3=B6se?= <shroot1337@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	rppt@kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: sm750fb: Replace set_DAC macro with a static function
Date: Sat, 14 Nov 2026 13:02:05 +0300
Message-ID: <20261114100207.9124-2-shroot1337@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114100207.9124-1-shroot1337@gmail.com>
References: <20261114100207.9124-1-shroot1337@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the set_DAC macro with a static function named set_dac().
The helper has only one caller, so keep it local to ddk750_display.c
and remove the macro from ddk750_power.h.

This provides parameter type checking and follows kernel naming
conventions without changing the register operation.

Signed-off-by: Ali Köse <shroot1337@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c | 8 +++++++-
 drivers/staging/sm750fb/ddk750_power.h   | 5 -----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 4e390541a507..d619e00fd88e 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -4,6 +4,12 @@
 #include "ddk750_display.h"
 #include "ddk750_power.h"
 
+static void set_dac(unsigned int off)
+{
+	poke32(MISC_CTRL,
+	       (peek32(MISC_CTRL) & ~MISC_CTRL_DAC_POWER_OFF) | off);
+}
+
 static void set_display_control(int ctrl, int disp_state)
 {
 	/* state != 0 means turn on both timing & plane en_bit */
@@ -151,7 +157,7 @@ void ddk750_set_logical_disp_out(enum disp_output output)
 	}
 
 	if (output & DAC_USAGE)
-		set_DAC((output & DAC_MASK) >> DAC_OFFSET);
+		set_dac((output & DAC_MASK) >> DAC_OFFSET);
 
 	if (output & DPMS_USAGE)
 		ddk750_set_dpms((output & DPMS_MASK) >> DPMS_OFFSET);
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index 0c4ab2120385..61f8608e59de 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -9,11 +9,6 @@ enum dpms {
 	CRT_DPMS_OFF = 0x3,
 };
 
-#define set_DAC(off) {							\
-	poke32(MISC_CTRL,						\
-	       (peek32(MISC_CTRL) & ~MISC_CTRL_DAC_POWER_OFF) | (off)); \
-}
-
 void ddk750_set_dpms(enum dpms state);
 void sm750_set_power_mode(unsigned int mode);
 void sm750_set_current_gate(unsigned int gate);
-- 
2.53.0

