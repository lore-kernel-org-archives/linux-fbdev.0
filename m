Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BCF26A1A3;
	Tue,  8 Apr 2025 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107666; cv=none; b=aBmvC8guYdnp7b1BsS1PTCiGRkeY8vIVp9jaIpCNzDpua8UvszBuXsfdWq3D/cjhzdM7A2lmFvqu/dFCf/X3P9wMUIS0aPfhXQlI1Qt0ONvjyTw9fiFVGAs0BAT4nSpYfAKkSwuCcuUMUU/cl+c+7CyuMmnA2+XSoj557RsGD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107666; c=relaxed/simple;
	bh=+7dT3tL82Twj4medpCe66/0q0Wl1ZErhjrtaxQu867M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jNplqiIpT79uwiJwVvo+ZDj+tVWN7q+auvRKJ7Em2rgtb5/uY6ngdcdozhwGKrgbzDFOgDvYHjCSIi0nBXnUaDXRjurvUNyjPw4TUAXyBGr1h+jMg+fFL06ZNC+xMhvJIrcVGX5lgPQ9awMSwVQsjMQK3uAsM0Ke6daXvotL62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEEffAGd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEEffAGd"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso29753595e9.3;
        Tue, 08 Apr 2025 03:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744107663; x=1744712463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4QDk5t1ncy92IlUqUOHalwkPhSsIRI8ajRfXHeyssg=;
        b=MEEffAGdCrOOsFoOQS5hu+yEcx+p9U0fJoj9G9sWxBtg3f3dhoLokRnCWH8uJ+0M2J
         95b4pQCcERpOy0Dzcc9Qjz4VapCTt4U9m4v1ngRVfAqkJ9k9HifoAhwDbW3pGyrljVCY
         WqFTyKq3eepOGgauRUGfmvSlqyzdFJE+zLMQ7yiXHDnhPtXAxkOLtRjQJuxQ4ybtawqy
         8W2TD77hk5QlGPq8eGQxwXZiahCPycSvww1f+ITbNXIHgU4aS8tfFqwcA5iXBHyeUiU7
         rnOpAdncZMYVwTYRNQzWJARKHKGMO20b459uwHWpg4Zcb6dFHis4lC3OUMw2RVtaDcbM
         HfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107663; x=1744712463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4QDk5t1ncy92IlUqUOHalwkPhSsIRI8ajRfXHeyssg=;
        b=QYhHaAD6qoRFqjGUr4ArX/+NAv1osMrtsWRgZOdOTtQY9CkRg+JzLVbBlQ4IgfTkxH
         v42kVxjXYY8xwW74ETuqlFIutuQl2Fn98QJaZ+mW6RGGXcZR14GCgX6b+2pDqyKTWco9
         mg2Hhm14tYMFq0LvdSsXBS5r/EYbnBbPJ3mRZN9oS8o3zfaxeIESbwUKWlY2Zz7bw2ek
         qNfXawkwiVhBr+9robaLdGtYnVIdL6xXCUZGqEgO+m9WFcfkct390KBEshBYH4oExkbR
         YvCbGZby4ZpqXFjcSBvkBxNWN+EMhb0HtVuWuzH04XMIM4MBf/AlMkqJO5gOUBpi1HIQ
         bm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8+6cyg5jUq95LFfnBSuX4TfyZ7fUxZtNRmF59PO2lVcqTRuygOcTj7vxCfx3efLJ9k9gI8Cul9BUEIA==@vger.kernel.org, AJvYcCXkzFgabQTr3wsAB58EKdFOA5czYwPDr/it7cdvYVKTvp0y1yprsXVJxP2cXBvW+oO+mNCxkfrTpzccuDK4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnxu9D1bzUkTJu7JsLWVIY61iu1niiMXxXhE9CuDrGT7m2Ts3l
	rwh8/kxce+xerjWqEpbHIkVn0CWSHrfcqNxIPge8MH9gsE/yDSJA1R3GEIs+ZO0=
X-Gm-Gg: ASbGncsBvD68Jgd1HXcmZyYFooWw4mGpxQbJRRIvPVneKM5INRi0UlB3qBBI0ZgIl5q
	IZrngi3Xg5eww3BLcgwpjGmwRcrudjLgfq1mGd3MR33uSZzO81JLFO3RDd9tk4p7mSLleGlNoN9
	pYsnSdcLNJ27kXMKlZLIThowx/0VG7ehq3Dqei4JBcNy52zGtr+JvBpb6r/mJBTDwWyHH17Hxbn
	Z2PexQxENHAieu60JL0e9MGdLbbMaoYBELfK01BpwJ8DuHBEzMjRzJx5FEQ9Ek/JlOgyxAbHGFe
	cN73XrY8jwb/3qtNyT6BdWtzULM=
X-Google-Smtp-Source: AGHT+IGqji64W2lk6xzwBAi67a+TNfZqjDz2g1ujSqj8hFJXuoGxtXuka1lU6WBSwWNlaeNBcOjlcw==
X-Received: by 2002:a05:600c:4f4f:b0:43c:ec28:d301 with SMTP id 5b1f17b1804b1-43ee076d88cmr109745295e9.26.1744107662728;
        Tue, 08 Apr 2025 03:21:02 -0700 (PDT)
Received: from parrot ([105.113.112.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226bbfsm14913352f8f.90.2025.04.08.03.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:21:02 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH v2 4/8] staging: sm750fb: change sii164GetChipString to snake_case
Date: Tue,  8 Apr 2025 11:20:36 +0100
Message-Id: <08eb6104c7b82aea32796163421a7e795d3d8964.1744105389.git.princerichard17a@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1744105388.git.princerichard17a@gmail.com>
References: <cover.1744105388.git.princerichard17a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change camelCase function name sii164GetChipString to sii164_get_chip_string
to conform to kernel code styles as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164GetChipString>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index bb7538682b7d..c12df1f9fb00 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -19,7 +19,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.get_device_id = sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
 		.reset_chip = sii164_reset_chip,
-		.get_chip_string = sii164GetChipString,
+		.get_chip_string = sii164_get_chip_string,
 		.set_power = sii164_set_power,
 		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
 		.is_connected = sii164IsConnected,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index b96f9369fab4..d0b80b86a4d7 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -261,13 +261,13 @@ void sii164_reset_chip(void)
 }
 
 /*
- * sii164GetChipString
+ * sii164_get_chip_string
  *      This function returns a char string name of the current DVI Controller
  *      chip.
  *
  *      It's convenient for application need to display the chip name.
  */
-char *sii164GetChipString(void)
+char *sii164_get_chip_string(void)
 {
 	return gDviCtrlChipName;
 }
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 45a90489c95c..c15cd6a5d53b 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -32,7 +32,7 @@ unsigned short sii164_get_device_id(void);
 
 #ifdef SII164_FULL_FUNCTIONS
 void sii164_reset_chip(void);
-char *sii164GetChipString(void);
+char *sii164_get_chip_string(void);
 void sii164_set_power(unsigned char powerUp);
 void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
 unsigned char sii164IsConnected(void);
-- 
2.39.5

