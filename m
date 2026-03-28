Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43115355026
	for <linux-fbdev@vger.kernel.org>; Sat, 28 Mar 2026 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774730604; cv=none; b=OiC8etNP3tuv72uSK6pnSPs7s90m5eC1JFvKljAngWUcuW2n2o+9esR/AFRkE42dlsEzJAq4QkShqDwe56vvNYIuoaCrYvorTfT5WWUFzsZ4OICuBQ7v1f+tTx1MBNbkgt3E18ghxrO8FgYb4Wod4oYADQavtkUw57cKZqjhli4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774730604; c=relaxed/simple;
	bh=+EX5095f1L67iD8d4OUekG+X9JM3DOBgBP6fl+h7c8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P+YjG3SJXsMjUo0ozLLehjzXYqq3EulgwbQKxcHUzr+f3dtNc9ygOzrOH1pXgufGo9tEqu7X9WxsTgM9AA4RHtZt9tk35ER0BL8eTs1xJ1r6rE1k4RAEwu3XhFcjRv9hi7CDujaCBwgR3ZR+T6EtInpTtEfECasEKPf1Ke4q4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8DRqWk1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8DRqWk1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so30404465e9.1
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Mar 2026 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774730602; x=1775335402; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HKX+S1We1s3caipzPcYGWRj3v8GHW7uxnmBU1rD2O0M=;
        b=T8DRqWk1KPib1f0c8WrM6HRacctIXr+jlZlotmaptfspY1eUWhTDSbGJJmAeEF9Awt
         0sypFZZDl/fW5isEJV2jxaI2G8xchUEICMzBWeWqsGxGaLWcGdD+c5y2954DozgMrPe3
         HdXYw50Klo4lWvmTJpv2ifS1oj2/xEY2bQQsoDbGLLmgWClA+F+4I0WrCB6BQRl1vaX8
         S4pVn6JMvsBKK7244YH53v2tT4G21so3faMg/pVFuDnq/dPWPsPm/Qon8v767Ou/m7gl
         YkC14fQsQElHL40l72VJUChy4m/gwTixipe/o4KNVAP0Hs8Dj/MGqEA8AkuK2nvc11/Y
         Cacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774730602; x=1775335402;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKX+S1We1s3caipzPcYGWRj3v8GHW7uxnmBU1rD2O0M=;
        b=cH0ihZo2JqyenOsREeIfmHMTB8EBaa7GktZfIYFkBPhoM4Ww3lA5ug9okRGBpA+5uM
         0rvn/uac1Uo4+zavSL2O1XDpAv1AD+8Xd+GTu4T0Bc4cQBzvEzL8b6/Qy+YIn5gqV4RS
         Jp0QXf0otErEWH+OhMWbmd/bHg1YyjzJBZsVmy9xHg3xZg5ApovkKBlDESQxK/s9TTh0
         gEEhSyNBtjO60GyhgzhMXsaWKGnfqN3gMF2CP5nHKDH/RcD/QsTTZLM5XlR5DwYTeMT6
         l4TYPoC3ZnfPNAcvhuS/lvI5hKefHtW3468R99vw3xndhkUGrvQb2KcuxvKN2gCqlIyF
         m9sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0wRe0UMJEOj+cT2bVTn5CHjb0apLkS801w4OMqKi51TkIty8Joj1Z9Cep5o/tjVeUG+Sf2PqfnBZtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVpo7gsIuB+/YFibDg9+PInk+26/C/dnYta5GfTh8pyBcQ+2M0
	uOv1uAv26Cdo76Qo9F7MzeFJAoOBM5XkJoNZdUg7Z2agC8A2IL/LoJvU
X-Gm-Gg: ATEYQzwOK0HboCz7Mf8xiooehN/i6vGbgpvXW/QpCShVpzikkwwjkTHp1XCoCcIb0AB
	At5Hm0fSO3RdFo0zWu7qE9CISlKfSHMgGZyb4MlTwmtwKLVb+nA6MkJbHZ1/TKhxtrXi0qQdbCr
	sXxtqSV+VO5WE8CURvtOSaunozgKoTtNImampxGiX0/+WMzNXJW6CcqKc2Q1Qk4yngKp4Up6tFp
	0sWEfxL3y2Eu/MSXsS39PjaYnvkU9ATLbuW7+qOUxND7yjTdWNtQg8178+5e0o3gnuSH/iLhHGZ
	zTT85gOUfASGoHcpcuLeI4Jl6KF1u6OZoPSSPKO+4rp0THtptZb4o3KTn8VXXrq16O/HMSAPOq6
	MD0CbcQCt312sJyQR5hfDkGUJ0lUkajuouwi7mx+oPi0pw7hTalYGgL44vKNH9wFKORkj+zSuDp
	9VNJEXM/8LJAt4UTvzn6ULzwpY9ezuMlEyNtdFk3Yar8dRdLlRR0fuVS1gxIodG/1wWBUx1CRJB
	jwmGU5g8tRckX0mXiiyY7DwBw==
X-Received: by 2002:a05:600c:4e0b:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-487290a9254mr102394915e9.1.1774730601395;
        Sat, 28 Mar 2026 13:43:21 -0700 (PDT)
Received: from [127.0.1.1] (93-140-187-240.adsl.net.t-com.hr. [93.140.187.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48730628efasm109519825e9.5.2026.03.28.13.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:43:20 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 28 Mar 2026 21:42:16 +0100
Subject: [PATCH] backlight: ktd2801: enable BL_CORE_SUSPENDRESUME
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260328-ktd2801-pm-fix-v1-1-007cb103faeb@dujemihanovic.xyz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0MT3eySFCMLA0PdglzdtMwKXUPzVAtzQ9M0i2RjcyWgpoKiVKAw2MD
 o2NpaAFlB42dgAAAA
X-Change-ID: 20260314-ktd2801-pm-fix-17e8715f8c37
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056;
 i=duje@dujemihanovic.xyz; s=20260328; h=from:subject:message-id;
 bh=ZxchMbxwniYIWnT9R7/2Td04/zp5hTI04KiKc8j4Q4g=;
 b=owGbwMvMwCW2z0j3+uHIyKOMp9WSGDJP2KbHtWVJlUzc/WPZVv0I27N23+16d3Wnzf39bl7+j
 oXvMxyyO0pZGMS4GGTFFFmYl8pd4ksNn+hQZJsEM4eVCWQIAxenAEzkQATDX5FW8dMPdCXrznXM
 nLJB0ap+xqH2987aWyZUy7s4d+8MS2dkmPQxZZOGwjfGGCXuy282TzVXupY8dWbx9jULg9O4epL
 nMAEA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=9BD463017690089DAA8DC266275F544B3B1B4792

From: Duje Mihanović <duje@dujemihanovic.xyz>

Boards using this backlight chip do not power the backlight off on
suspend. Enable BL_CORE_SUSPENDRESUME so the chip gets powered off by
the backlight core on suspend.

Tested on samsung,coreprimevelte.

Cc: stable@vger.kernel.org # v6.19
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 drivers/video/backlight/ktd2801-backlight.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/ktd2801-backlight.c b/drivers/video/backlight/ktd2801-backlight.c
index 17eac1b3bce4..1b1307e03b20 100644
--- a/drivers/video/backlight/ktd2801-backlight.c
+++ b/drivers/video/backlight/ktd2801-backlight.c
@@ -53,6 +53,7 @@ static int ktd2801_update_status(struct backlight_device *bd)
 }
 
 static const struct backlight_ops ktd2801_backlight_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
 	.update_status = ktd2801_update_status,
 };
 

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260314-ktd2801-pm-fix-17e8715f8c37

Best regards,
--  
Duje Mihanović <duje@dujemihanovic.xyz>

