Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F42F260F
	for <linux-fbdev@vger.kernel.org>; Wed, 14 Jan 2026 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411080; cv=none; b=bzpb8JJ26AkIWG/RpR7aWCUPvLTa/ie4/vf/yj553X3fjW+YWYuhxVOa4Ol78xDfTAUxl1+wd2JpjmdUHBHh/921G/ls2WNb2rdlBmid+DMokBFONkUHvfNOEMK5MQk81jDfbFEE7PNinFFRIE4JWL7Vm9CV/RNqx1lrtJqzpSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411080; c=relaxed/simple;
	bh=HjnoYpbCeDj1omo7DgKuMORs8cBtchJFKrZZqxLDVq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFga80xdgNj11RYGVllle+Hgse1xMaXCt5wJPvt9ffKF9/hrgqiuCE4f6sWXIhlGdUQZeX+TxV5H6Sfihuh2Rm9a3gK75uwBo6QZ1IoBC3i2i+gRmhoUkW0jVTwcwrgIL7WOWQXvWED67WKFgyR0dTTJNvhx07Kh/7qDyT8Xaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqWRsgFz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqWRsgFz"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a09757004cso81224275ad.3
        for <linux-fbdev@vger.kernel.org>; Wed, 14 Jan 2026 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768411079; x=1769015879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v9nVIWgI/ofdqTvXhbFUpeYGkKVLTQt14mGlLNA55/Y=;
        b=BqWRsgFzmigoGg/KhICUy8rWpM3UaskHEeCg2nbYrDkLkQsCN+S9pPcQdLIbR7M5CH
         7JmmQNaUk37ftTI+SCcPNBkkwu5O0iWmTTP4wO/R0Doh8/vOdaNFzAFv7C9h58VpnzmZ
         DxJsL4+Tf8E1aJjOK4wxTjIFFZJbq2TdTqa0qlXaymsJGbOSGnBCJTbPw8/U6K/xrwAL
         n6bDFMuyw9RNUsV4az7IQh8seZ/pjr9xFUQbejz399aC0GYhzu6sczqR5SXNP0R88fpz
         i8U+gJrPvfio0f7DctYXue5vFFQTqfFZKkv7i0/HfKvs6YDTs+iP+f7HQKlJb7S576uk
         nYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768411079; x=1769015879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9nVIWgI/ofdqTvXhbFUpeYGkKVLTQt14mGlLNA55/Y=;
        b=S0ybkdkLl3B9qPNrsEnGqH0lE4VWAWKO+DPdLjNJgVFy14V9RBbM5YDLEWqq+SyHMU
         FnvCNiasuHE/rj4+pb/7IALSrREGcUcjg4ib8W/VwhQWDdpVKOtBm0z3h0mAa3cYxrpG
         jfq5GyjBrPxwq16AR8o/9y8Wgaj/FzurTTDeRbSBe7rhUSYV69i4Cz8odzwfTwMbRtX6
         6sLztmDzI4dzOwJNpyyay3jrukEcqkwJvGFBU3UugP8AshEgBfXZYz2pUAGptA93gTWr
         ZG6mqdpKWXcREHyJjxj/HFxK/+pfJLllqjdLvOxNyQWZHzdCfP5ELjj/GlfQ5N0IZ6Ko
         AYgA==
X-Gm-Message-State: AOJu0YxqMXoT22Uxp/QYKsveqUCWlquvOHqPheQQSwo9Duytk73TlpMb
	uw1AhEkDQifsGvJZkh/V2AceSOBaLIPtCF3WNGh6v0Zj7F/8h4IyqZXN
X-Gm-Gg: AY/fxX714Qe0SVjowwC4R9rU07H4Rq3b1rSyXh66Cs1yjRH7L9ag7wDp/1we4MdZWQU
	x2afWN7reGXGpgwT7TjSEBiRG5ic2089E8bdtnvXH2IC7rv5HJpsM4vaOvSLvp8aUMQ7cAyLJk3
	OjQ7p64LomgmWquls/NSvWl9qZShmFWmvKx703OO8Cz9PT0gpoiBf6R4JhjnlMuNQ7qdTGA1eQI
	TkCXA3fgsJlDzYH03CXahcGOxJqUsHpN3kQelYkuTJ9/snkJDqqUBEHjJGHxOZHZr5mjMqGO7Gj
	z3l7nB6T7fQcdYVjyjvSvKWiULzbU3CuzNLNvBwUZ05ehLIQy3j8n7guW0kmdraxChHP9n0TTnM
	GHN1sRy4dz2KMLRvD1jnCqiaF7y8TEKC8Jhb+WuBlXnA9yrsrksF1d2xtFlfugM7ylfiHOBkqnv
	Or6tTQO9nKxAs25izoEzpKmV4=
X-Received: by 2002:a17:903:22c9:b0:2a2:f0cb:df98 with SMTP id d9443c01a7336-2a59bb8d639mr30181465ad.25.1768411078776;
        Wed, 14 Jan 2026 09:17:58 -0800 (PST)
Received: from karthik.bbrouter ([103.215.237.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd2954sm67314095ad.86.2026.01.14.09.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:17:58 -0800 (PST)
From: Karthikey Kadati <karthikey3608@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	karthikey3608@gmail.com
Subject: [PATCH v3] staging: sm750fb: Convert sw_i2c_read_sda to return bool
Date: Wed, 14 Jan 2026 22:47:48 +0530
Message-ID: <20260114171748.34767-1-karthikey3608@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sw_i2c_read_sda() function currently returns unsigned char (1 or 0).
Standardize it to return bool (true or false) to match kernel standards.

Signed-off-by: Karthikey Kadati <karthikey3608@gmail.com>
---
v3:
  - Add version history (Reported by kernel test robot).
v2:
  - Fix invalid "Unix Antigravity" Signed-off-by.
  - Submit as standalone patch (detached from unrelated series).

 drivers/staging/sm750fb/ddk750_swi2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 0ef8d4ff2..9d48673d3 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -180,7 +180,7 @@ static void sw_i2c_sda(unsigned char value)
  *  Return Value:
  *      The SDA data bit sent by the Slave
  */
-static unsigned char sw_i2c_read_sda(void)
+static bool sw_i2c_read_sda(void)
 {
 	unsigned long gpio_dir;
 	unsigned long gpio_data;
@@ -196,9 +196,9 @@ static unsigned char sw_i2c_read_sda(void)
 	/* Now read the SDA line */
 	gpio_data = peek32(sw_i2c_data_gpio_data_reg);
 	if (gpio_data & (1 << sw_i2c_data_gpio))
-		return 1;
+		return true;
 	else
-		return 0;
+		return false;
 }
 
 /*
-- 
2.43.0

