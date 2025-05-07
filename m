Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D414A639;
	Wed,  7 May 2025 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628291; cv=none; b=kywbH/+coLYOG9oJwgJX/6vWu/UTleloyD/WXdO1XamOcFFEvnBMcR5CaaHPH2srgMlB4j6xo85Gh/B1BTctDJIYuK/BFwRDZvv4jNcndTQ2VJeOL/em55e0QqG16ZJs+DMfAgHZIQI1JHZ/x0OY2vTs9gzFnz4mRBPwFm+wFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628291; c=relaxed/simple;
	bh=IVv2wzn+wTsvN/udaFjlb4jJzZjRBVWq7YxzJC7vqBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BPqo6D0Nhu5vHn92B2uvxZrzp1jwI5ot4WkN/7Xkp5cbTyu+Q7A37kMQV1scTYfqpjOKbLHstKO892rFYc+FOM+87dHsZgQKxKSdfGbtlGHlMseDTMRgon7MnH+tgu8KUEH4KH2vOBB+KjacHJiCpc9UI6WJ/bG/4GDA+np0iGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwC9TMce; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwC9TMce"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73bf1cef6ceso7078207b3a.0;
        Wed, 07 May 2025 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746628289; x=1747233089; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V00gbHB3f6Rug7OZkkSXyWv7lM+Ur/ljUZ4R35v0M9U=;
        b=LwC9TMcec4rDdOi94aldd+kmBIbPw7Cu7GEwmN+oIFf30r7QVryFHX562H00mEGh64
         KZAQ6kkR2qZQ2ALAr62lbPHEX8dxbsAL1504HzUZLjkN8hK4UKlW6q6UymOdPrAVh5he
         9PcBCWFcLcviS0M1p/pzobuNl3L4QkzxQWJUj+3izJmt0nml/zGkYju9MeYMSyBT27Qc
         7/XspQKtNuh3NrwfIDVtkn3hVwRqjJdmxBOqPcNfhx2Ef1GjKbjzTly2zozUnSWCcT2U
         o9e39qlCtK3D1Cd7vHUWkRNIfPvGplQ1n7x+i/cO4MKxVfPaaciqXe2PxGVljcNtn5wZ
         gJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746628289; x=1747233089;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V00gbHB3f6Rug7OZkkSXyWv7lM+Ur/ljUZ4R35v0M9U=;
        b=vEXcrqhttIHF9poql9QSMXZWzBJSTBlCPGNNCjOElOh4Ki/BPUvUxSXjgA9gtpzVPb
         asXqJnNLV7IxamMMJC6x268QEI1X3bCoyp10Wjx+y0n3VOBTiwvWbJ/sIJyQD7+qjSDe
         nMwICXfZs2NTIhivHWoj7W5LmVF2GgggGlZiXyR3Wzylmze+2tfW6JKxjCFUeXO+gDc3
         LzI8H78+3+R0eK5EaHKaDXnQY9WQQt1jESZrWki+DgJ9pofPq8OjHyFrZ7MgcqbC0/gt
         FOsTjpI1zOaXivCz/WaF4mmdMLHCcpmCf7Y4Qtok4s2vwP3Rwa0UwG6vPfRcUBUmu9lJ
         he1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtSH3ZJYPyaERcZlzDh6huUGm86t3hrdfsEktJPwHyFOgqaNFxN6BuPzb0djqvqBhre8RH5nedxAXPj48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwldcylxedZMgAsh3fpUgVhV77kLFJp5yhyKPKu6fXwgnXLh4HN
	Q0Db9zTVUS4A65xdVgEQYUgwW2euaBBCjbb0stNEN8uteMqNNqoaawimXg==
X-Gm-Gg: ASbGnct1j5MZU6VnfDbx7cXyR2hUlX6kcyM/iVFAWvRYmxo6Q1N9lzR/p4HW7HyEXV7
	rRee5Ujmy/qkIRemU3CS6V6hMfdmxBXsoGBe0EFWmfEofRiDIqrwKoySos1eT8nQBTg5SG0TB/8
	flyZ4inAufSILb1iSTi6/itHXhY3BPgzt20TuRmhzD5EnQMGMzmbReVOk6i2+0d9FzwHOz+83PG
	Pm5XriAYHEmKR7u/HvZ1NFQgIuoYfVESZ0oWPrw/8P60ImM9o5Am4f6NedMm1S37RZf4FIVJIuL
	kPt8CIjwTYfmjbDEEei4fYpvqGEPqJjR159WITZ2Iv5cv2c+
X-Google-Smtp-Source: AGHT+IGu2cTVUe8urLeyXyOnJF7jzhdXw0YVp7nGLn1w1fUwSNZlmndsJQEgNnb9ekMO9wXE2KT13A==
X-Received: by 2002:a05:6a00:3003:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-7409cefc3f6mr4524741b3a.7.1746628289560;
        Wed, 07 May 2025 07:31:29 -0700 (PDT)
Received: from brak3rDesk ([115.96.77.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7c13asm11366231b3a.31.2025.05.07.07.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 07:31:29 -0700 (PDT)
Date: Wed, 7 May 2025 20:01:26 +0530
From: Rujra Bhatt <braker.noob.kernel@gmail.com>
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [FIRST-PATCH] staging : sm750fb : ddk750_mode.c fixed codespell
 issue.
Message-ID: <aBtuviJ2FhJXNg7r@brak3rDesk>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

instead of "parm" structure variable, used "param" to ease the readability.

Signed-off-by: Rujra Bhatt <braker.noob.kernel@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 3b25892af713..8f2708632c88 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -203,19 +203,19 @@ static void program_mode_registers(struct mode_parameter *mode_param,
 	}
 }
 
-int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock)
+int ddk750_set_mode_timing(struct mode_parameter *param, enum clock_type clock)
 {
 	struct pll_value pll;
 
 	pll.input_freq = DEFAULT_INPUT_CLOCK;
 	pll.clock_type = clock;
 
-	sm750_calc_pll_value(parm->pixel_clock, &pll);
+	sm750_calc_pll_value(param->pixel_clock, &pll);
 	if (sm750_get_chip_type() == SM750LE) {
 		/* set graphic mode via IO method */
 		outb_p(0x88, 0x3d4);
 		outb_p(0x06, 0x3d5);
 	}
-	program_mode_registers(parm, &pll);
+	program_mode_registers(param, &pll);
 	return 0;
 }
-- 
2.43.0

