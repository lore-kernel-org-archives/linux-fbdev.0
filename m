Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17AA274FEF
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Sep 2025 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317388; cv=none; b=DD03rL988OlPh3sPx5GFWDtv96xxJJbL7+VLAw9KOfd9hq2q/IYo6uNrrbRH5wKfD/OJzmyiNTlW/0Nm203SpDamnHPMsDTYPRIErPVKtfb6dIupuLperl5m2mHBkZtaRh4spkT/CfinPTzPRuEo+4++xPjnUBYkCm3cVNojV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317388; c=relaxed/simple;
	bh=Gt/3Q4eCw7M+9b+H8XPRAm/hfMkHXsiKakZZRnzhecc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k73l9P5cD60bTM6ubbyTMTUd8RPVG6P8cW1sQhvwKvR/ajtEwdEbpcaIdrcHJlzzmV87Cbiq6Hds89Bi2HBkx65QVrkQdL8qmWYZ/41WWNiYyWmC/nw5LmNTC+ltJ+0MSw/2nwr4aNqNNMnG/PLGyE9L1Egvd6Kr1QIBZYR8GbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7Qlz9EL; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7Qlz9EL"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32e372c413aso2565403a91.0
        for <linux-fbdev@vger.kernel.org>; Fri, 19 Sep 2025 14:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758317386; x=1758922186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vleSOAnQ7W/ttFzCw+PSwwPxqJNTbd1eP/1iar3uehM=;
        b=l7Qlz9ELegRfq5mUKmH/P36puEP0JAwz0cEUMzzKsyl0gk5hpCmnK8RBUs+hLAjxow
         qegGCkNvSvG3h/V8JXrk1p5WgpQkkqigAjCoN7s/f/cLbGojyH/93kLTCXO5l4HiQI0m
         QJG7XlEpAkTE5huwVaDxilg9DMjC6FLt9JGCWnPZn2cZXanmtl6N2J5xexagVa5kNvo+
         sxZJVYLyn9smRruIzomhA6izBkp+pnBtRul0lZFflS+E1LBWptgMg8A7JlFpnRrPlojh
         l31qYcGp1bRE3D19p4MyXdc5lRc2er01+MmzigORkMerdWiaMEOHK0rTSJDiG476QraS
         blcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758317386; x=1758922186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vleSOAnQ7W/ttFzCw+PSwwPxqJNTbd1eP/1iar3uehM=;
        b=VDWBgdi8AhuU0XxmaceNqYPPpnL6U7qkfRds08dLlB+14Uxzg9BNHDbeAVqmvOQPwP
         a+TYgEKcoSJT4TbYhJhGhJHwty4nvo157TLj6a8LWH8zmD3auFCKeW6JMOsQxFact3rg
         1rB42VWc5Tu8aakF51cPYX3OMdujWbHhhsCXMz7Dy0lMKckPk+S+Qk/dD5FskCc+/l1C
         NxGhZnMs5tob1/JqPhxl3wE9Vl5pAfHZ2hOUj3QAjFWrxt8yg3qxghUg895OE9qCrPTv
         U06GyMhTea57P1DEQVm3jBNImMKSOSoG3kCYdKJQt3oyyawymv6jWBO/F9egiiNktgq4
         6NpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdlkvy/TabwXaXpTCJ4pVfQ7FGy4Ug7YeA5cmx6Bnzmgka7GV0gzjKIlkeJlAQEVIO6AIPa76+D6D4sQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsvlWJYZN7x10JPgB0hN4KD2jjniTrRqxxEPVBOkV9aeVS8k0+
	dYQ6hG7ZruHZZ5SK3KDqq4JRYCZie8h0RWNVL+x53SnGhkiyUVuPxuPJ
X-Gm-Gg: ASbGncu4nNMAlW6zO0NcF3r7T22H2Y16X/F9Riih3MQjnjjgOBuCKEGoY5RULHaKX8I
	PlY/kTXO52AC1DewpeP7jWjHPrrbEP6lKhmNhL1Rk0FESM7TkP42b0w2TSnKHOn/6d/PxrsJJcO
	JA6+Kf48lnFLDcqwY8tPkRrU0Z8uBrlG+fmuW1AHE5Z9Q5ZqbxI5aioCsKjdvUXal9OsaDYEDzX
	f1/mrvDuROa6hNgKfnTb//rloGEQGRmCFMrr2G3bogq4MPlHuvCB+YWpySLg8VriWb6b+au/UIb
	Bfkf3O2gfVMCZsX+o1igD8TKo0wen4Yr2Zj7awXJs3MyMv3VGs+PByIiHtq2u3ayKeCqa4Wl08I
	+6d+upCutTIbZ2nEV//J3sYZLhxAXnoZFO8Vn/EZ19n4SHGO6LhWnGno3XOdERw==
X-Google-Smtp-Source: AGHT+IHsl189j2QSfxSlpgxEoKYSohVc3V9vQEcwrv5b1bjjq+l89ZFUZ2CsOgVd9B2doDfpl+okoA==
X-Received: by 2002:a17:90b:54d0:b0:32e:3837:284e with SMTP id 98e67ed59e1d1-33097ff70ebmr5944059a91.10.1758317385798;
        Fri, 19 Sep 2025 14:29:45 -0700 (PDT)
Received: from deepanshupratik.taild3063f.ts.net ([205.254.163.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff3fdb22sm5837987a12.25.2025.09.19.14.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 14:29:45 -0700 (PDT)
From: DeepanshuPratik <deepanshu.pratik@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	DeepanshuPratik <deepanshu.pratik@gmail.com>
Subject: [PATCH] staging: fbtft: fix macro usage and style warnings
Date: Sat, 20 Sep 2025 02:59:38 +0530
Message-ID: <20250919212938.822374-1-deepanshu.pratik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the trailing comma issue in the
define_fbtft_write_reg() macro calls, which caused
checkpatch.pl to complain with:

  ERROR: space prohibited before that close parenthesis ')'

The affected macro invocations were updated to pass an
identity modifier instead of leaving the argument empty.
This resolves build errors while ensuring compliance
with kernel coding style.

No functional changes are introduced; this patch only
addresses build and style issues.

Signed-off-by: DeepanshuPratik <deepanshu.pratik@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff1..60846185d 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -11,6 +11,7 @@
  *
  *****************************************************************************/
 
+#define NOOP(x) (x)                                                           \
 #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
 void func(struct fbtft_par *par, int len, ...)                                \
 {                                                                             \
@@ -62,9 +63,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, NOOP)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, NOOP)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.43.0

