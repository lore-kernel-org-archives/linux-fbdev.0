Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B6296BA4
	for <linux-fbdev@vger.kernel.org>; Mon,  5 Jan 2026 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767599367; cv=none; b=ankTU4JIHp5UHggTc4XooPLS/a6Nael6M6fL3mflRgVys2FExuV8Mz68iBsh8go2jTLcKme2eo4nNsP7efhNhOsYNhIQ2aXhudRDavGEA2tsUIFq+4UhjbFWyfxLS3jikHqbhxY7nO3Tq/FpRn/n743nN2ONbRFPkVoyJeUtRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767599367; c=relaxed/simple;
	bh=2e+qUZBzZPaB+8JASPhZhCBLmvrbB/WcJwRR95/MPoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2hg/r7lfBaoO9NbPhhWp0L7Obqghizn6jxbatimIapWPsVWoPBrdpToxcOw5B7DpoIVGMH7vpGHMTAlmG0Utr0jz5nDvEqDQN655ZQ0kftq+1NOzqLRf3CFmNamO2v1GYN/ryR/1ekNQPbpLg0OmTlif281vZg76CvoKzNebGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCIxwqtN; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCIxwqtN"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso15999329b3a.0
        for <linux-fbdev@vger.kernel.org>; Sun, 04 Jan 2026 23:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767599365; x=1768204165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Tw+5UZKK2a5tWrH7+zI3XadSX9Gy4gWxqz5gPACZqA=;
        b=QCIxwqtNiSjTEJQgi1w0ez28nyhoW8brhDuJpKenHBHuXSMclwSStK1RFxO3QSR9Kg
         YWlrG2SLnP/T5MSXE8NyVpeZ9GiupnFJwcBVaCb1Ylofd+8jjvbcJ+H0klY46jkJfMYZ
         scpvX7E0XZZ1pbHBVyFrWnjWXBsiY1++PoNyyK50clsi0qlP4UBuqLfw33dISeSgQfgI
         1vXzP4NVrooOpKrUZuVjIc5mGe/TZtyV6qEjso1KsOAT0HI/6xEd5I7tnyKFOK5jilBO
         Qf8c766sumImkqw6rHrzGKk3MdF/I0PB0l8HKX1UwTpquP8yKs5pj9uv/xfIoSPo5jbk
         Jjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767599365; x=1768204165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Tw+5UZKK2a5tWrH7+zI3XadSX9Gy4gWxqz5gPACZqA=;
        b=CuKdjWq5bLpy0bug8VwSXipFnl9DxvPZBzeJAAWzx/ulH6hLwBK7A2W7cBxzS/bFM3
         k0GBRy+RALN74N32KdGIjWdiZOVUmWuVNJfpGK0MY9zuxHO9iIZCY68mAdz6fZbL4bPc
         DUqbhqhpYV7gbTZMjDrZYL2LLfGYchnEERK2tfU25ddKl/1afMHbLSn1dyTlAZqSnQXV
         KHO/n7S+GNwuSkJhy6azsWZCTAL4Nu5F7B71poO/f3ZUFobsZ7GwY1ZD4AnIvm31jNO2
         z0ZCxpfJ9DNprgf+Wtk98KQTfj4Y95TE8m/r/O3cpp8kd7h5vYYbytmYMubCDdI+ou8O
         IHnQ==
X-Forwarded-Encrypted: i=1; AJvYcCULfiQnu9I27JvctXRvqaWTLP7iE1mYHcnLTtTMqeEUKyhL6gCMKxkNTbHix8SrzHalhZOtN9f1bi6eWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykNC7jlOrLmu+Wj7idI3Z9xxGcRPqgHG3DicrsnmwaU51mtMUC
	muR4icZZ1dp95d9SLc5/IdlKB+5tDbC+GHWSdxdXUQlfVXcFGe2H+TMG
X-Gm-Gg: AY/fxX6SzokjaOVdlE8xqcRGzFXxt7HxXbndbhvf7JZAhPRL64VhYuJMk6hjgWwH39M
	ujHIlwDNwEHtlLNNruj5YOJuJTEqTau8bKJ9HIynHOZP+NS/4mMuHH7a1FZ6Ckb2cpDLoPOTfJg
	S7Jev43RgakXqmSHhkHLbvrMIsidD+Zhx25+yDsjiqBGcEJwqwFB3WnHGYkc4bW+GVhIAN8keZd
	Fg/OziUp3VdRN1jVbpKkbktrDp3z1oi2vWHJWNKu02swCnK/8xwNVh+DskwtIVliu1Bcrj+lfsr
	Sszm1sLlBPneLSYD7PUVjNruaNSwKROOlpz1MZD+O6VE2sotJgxqDoiin1/l/uUk9kQn0RGSsWA
	q3Wk6e3ouFTzxuL0tmtObSeGEywgiERcyLwTjUsD+UYSMMOOfDgaF5f5T+AcJWVHTehbwmFGMkv
	QqUZD5kqEt811nsU9sx/Rwzqr34oAw3KDSvZ0xuep3vM6vNPlE5dDkMXoEKRG1Tp0lgRr21v1CW
	WLD424=
X-Google-Smtp-Source: AGHT+IEDGBEmVFhFh6A8gmS92Or57SIz9MAqhTSuilHM60miXSe8yjL0NRxA9oXSA/2fwTAZDrIQYw==
X-Received: by 2002:a05:7022:61a:b0:11a:4ffb:9825 with SMTP id a92af1059eb24-121721acbf1mr46920289c88.6.1767599365350;
        Sun, 04 Jan 2026 23:49:25 -0800 (PST)
Received: from ubuntu-linux-2404.. (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c0c6sm190874535c88.12.2026.01.04.23.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:49:24 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: linux-staging@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v2] staging: sm750fb: fix unused tmp in sw_i2c_wait
Date: Mon,  5 Jan 2026 15:49:17 +0800
Message-ID: <20260105074917.607201-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105021026.556244-1-sun.jian.kdev@gmail.com>
References: <20260105021026.556244-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang W=1 warns that 'tmp' is set but not used in sw_i2c_wait().

sw_i2c_wait() provides the delay between bit-banged I2C GPIO transitions.
Replace the loop-count delay with a time-based udelay(1) to avoid CPU-
dependent timing and fix the warning.

Compile-tested with clang W=1; no hardware available to validate timing.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
v2:
- Replace cpu_relax() delay loop with time-based udelay(1) to avoid
  CPU-dependent timing (per Greg's feedback).

v1:
- Used cpu_relax() in the loop to silence -Wunused-but-set-variable.
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 0ef8d4ff2ef9..d5843fa69bfa 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -11,6 +11,7 @@
 #include "ddk750_reg.h"
 #include "ddk750_swi2c.h"
 #include "ddk750_power.h"
+#include <linux/delay.h>
 
 /*
  * I2C Software Master Driver:
@@ -92,12 +93,7 @@ static void sw_i2c_wait(void)
      * it's more reliable than counter loop ..
      * write 0x61 to 0x3ce and read from 0x3cf
      */
-	int i, tmp;
-
-	for (i = 0; i < 600; i++) {
-		tmp = i;
-		tmp += i;
-	}
+	udelay(1);
 }
 
 /*
-- 
2.43.0

