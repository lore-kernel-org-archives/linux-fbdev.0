Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FA41422DD;
	Sat, 22 Feb 2025 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740252792; cv=none; b=OH2U94m4a/+W8YK5GNwFCVHshSvjXXS/Wblu6klbDLOaniUrjMJisa4REbl9HNUg/CxmZhg+Ip/deATWBoCmRSRxgnG/7uKFO/M8ku5JsmvfnysTCfDQYfvRWb64hgHd3U9Q6me1PRB5mRmjlbcsSLRRoJdRihAgbiHOsVBOvnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740252792; c=relaxed/simple;
	bh=OfmZMEvJIkp5Fj0oy2tReM70wDR8EHOpSUyCFLG25yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6K7VsCYaYWTemNpiDH35W2La6o37cbBEQuM6J3J0xinEENpaGhuh/QXjSvxQFcg+ouBtuXe+PAV75kiUgk1J7SA6EpQdIYlwr7DuNGpj4vyXgwKnz+kEdZLloeNHJC0gejy1j/9fnAjeivtR3jDtd78R1rrHAqQO/akOL8kSQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ax7Xgo4p; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax7Xgo4p"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220f4dd756eso63682945ad.3;
        Sat, 22 Feb 2025 11:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740252790; x=1740857590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oG1Y4xUVBy90l/AWrqKDSxBw1CTC/BkXHI7h/Zxom7o=;
        b=ax7Xgo4pw3V9T14qH4ua7+3WaQ6ZOouVprOfaBYE8+sterxggNdPFSI2rdz45iOkT8
         L4EdhxpseabN1TzBa5bXQfaoz6aW0k/BdURfd4g9wxWLQ/juEzjfkNNxGfDp0SdVWwG5
         t3u4B5p5QL1dHNQJ9+8Wcfte4s6cPpaI/LcU+DVPpxJVQ48XFTNO/z5leizxEMBlTZqp
         hqqgI7npgPoBZ96MWpTr6yUE673dVvGJTMkfWKlA17d672uelc539petQZ3ZrIwBfvpM
         4JyJqOPAciNm/F7qOqbVGemlhcR1fiufEhxnrGAXSuwEjTc9mqTq9poE6iGTAaiAb6qo
         +uFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740252790; x=1740857590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oG1Y4xUVBy90l/AWrqKDSxBw1CTC/BkXHI7h/Zxom7o=;
        b=Hv9h1dRQg0wF2TE4bj314g5qYEpKrcV72Y7orRh1alJg3C/RJULQDQrNEcg4J0H8x5
         6I3xWA7zivARlFEtVztNAZQXURzR/iPmGDcfCSG1W0VvXzNyiWLDjEsB6YvqBmikOoBv
         L1KgvK0yWfqroLZ8d0rRZcc2kJuXNIV6uwlRpdBx/yNFZn/101MrfxCFrO9L8SUdDYFi
         riQkHv8vk4GtEIuf++EAz7xXSURjYPWfJiu8SqPOagFk0alMmQJUdNEHvLFJBp0hobIv
         fldG9uo/Z6MnvYVWguizMCAvX04SqRA/aTaGbYz0bJmYhk1XgT17/q0t2Uja9WuJk6Vj
         spjA==
X-Forwarded-Encrypted: i=1; AJvYcCW4mcNL8nnWXuGzvJlD/TJ/gDO06Y5jtQ+rXIrniye91Ex/i0CRyHum8HPeu5hE2ztucCuykrXDcjRn5c71@vger.kernel.org, AJvYcCWqBA9tyJY1I7F8rDQe2T8P+BtD/EDpl8og0m/ppwAdZI2XOB5U2C6oE7IRJdkwvmgo557RSPRtyPvZmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1MQcoi/yeM1IW/F2Lk8RIyYlAU2tnPRZoMfx4WEk7YpJwaC2N
	Y64d45k3q6PPCT3nTYDvjclu5FQIjnbU4hPvt9AISobhukuu/XJb
X-Gm-Gg: ASbGncsQNYR5IOZABTVr5ZmcVp+FitIDkpa96GK+A5DPfe2h4w3+51M0FROBlOvCNTe
	pSGr/qccu7l8xh9CreyG0e9dcKxwD/w+fDaUp/v3YRzL/hMi0fTIVpKBuU3psBQYSWpZ2EffzR5
	ZUDEzOKUD1nRB5PtvAWFs4/sQGSkFNYbbuD8t8dV6ScyPgl6lXd15cCkix/6XNPzI9C2K0kq7ED
	x2+3c8SE3j0zsnFU7MPdy1EES2Y4LZXdaBgTTqtTLfRHiPYNfuTtrTvNscoVttB/pNga5wW1bku
	0Uy0NFq8rVeop7ZDCpXTsfE1lPFYo74xr0+JhCBLEoU=
X-Google-Smtp-Source: AGHT+IGds9hYYhM7lhNXaP5V5VGPOZOdlf0A/D+v1WqyQMFkqW1PLY9zki3n+7oIDnzn3VBbkXHGRA==
X-Received: by 2002:a17:902:cec1:b0:21f:55e:ed71 with SMTP id d9443c01a7336-2219ff31895mr143259245ad.5.1740252790272;
        Sat, 22 Feb 2025 11:33:10 -0800 (PST)
Received: from localhost.localdomain ([36.255.84.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536375fsm154131165ad.53.2025.02.22.11.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 11:33:09 -0800 (PST)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH] staging: sm750fb: Replace architecture-specific defines with CONFIG_X86
Date: Sun, 23 Feb 2025 01:02:42 +0530
Message-ID: <20250222193242.14302-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the use of __i386__ and __x86_64__ with CONFIG_X86 to adhere to
kernel coding guideline, make the code more portable and integrates
better with the Kconfig system.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 02860d3ec..67a2f6044 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -229,7 +229,7 @@ int ddk750_init_hw(struct initchip_param *p_init_param)
 		reg |= (VGA_CONFIGURATION_PLL | VGA_CONFIGURATION_MODE);
 		poke32(VGA_CONFIGURATION, reg);
 	} else {
-#if defined(__i386__) || defined(__x86_64__)
+#ifdef CONFIG_X86
 		/* set graphic mode via IO method */
 		outb_p(0x88, 0x3d4);
 		outb_p(0x06, 0x3d5);
-- 
2.48.1

