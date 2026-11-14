Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794650543;
	b=rpjl8a+UqcobKQ46rsNxO3SWabWXKReLnYLXx03Q9qahYCaWr9O1tueTfF3HMFmOOvKO
	 qI6XU8HNGUOPiOR8Ic5u8cyXI22b+qdlTmOGczr8kO7outqsknlzB363P0wgSamwYZuZR
	 DD3GkueUyHB/UBfbOXk5sU331VAN7WZMubjVvlCz73sKxQU7xVA49Dw+RubwarKNcPLC+
	 HZFMhLcGpAnbROT3pydfAHGER9UV7RknpsKk9K7nxUmAXBe0M56jX6QYeTXNFF0SNEtJj
	 jQnh9e8fxBYMdN6MHbuFkDfZ5OBQX6mS/tJeW7KVk980lEVyhJ1Xb3p2exi+CdW15Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794650543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=56kD8uC/JQs1NVPB4BPCYThtaKRA/inwI9P7GjKzDmc=;
	b=I+CKRc6Hd7riG9pmWaGvvE2GUfqO+IVEZ9/yYGvOkzqitQRKegjnaDrYjIjA1jCKpwRJ
	 IGyuHixvFPAR+VTAHnH7iPUvBgj7xt0c7vR8ktS1K5PF4wakhn8D15yaO1ZBY80FtWHj+
	 ajRapurxf9FP7dSmQaE27kW0ssqJY/46EcBVjWs+QoIlkKjnhhuDqTCPbglpPyOGzZH3f
	 5uGzI3oR/UMfXkoArfr/dOr3aDLD2D7rFJdSuKkLyY3uyTXdZRpYfbmuNHrkq2FB2NhYC
	 fg0Y0RQHXQAVGBw06Vos1ijgTlrEcfVMS9TGQOBCa6iiDtAKAZUXOyYrlvljhDdGNAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0bvsNLa;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A231D606A327
	for <linux-fbdev@vger.kernel.org>; Sat, 14 Nov 2026 10:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A231D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0bvsNLa
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso21802915e9.3
        for <linux-fbdev@vger.kernel.org>; Sat, 14 Nov 2026 02:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794650541; x=1795255341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56kD8uC/JQs1NVPB4BPCYThtaKRA/inwI9P7GjKzDmc=;
        b=C0bvsNLaV9KaeuIJC/oVHjMVXQs87oWg+JqhC5fI8IZoalFy5Xo8/xyz5JCGQz9PVi
         DFZc+VNiFsf6j6PlGiopOsqWPMt5EI8PqGIoWP9/cDiITOI0B/6EK72fhp+anASg1VSA
         nojB9qjBNv/r41TIAxpf1l0u5vtCpxaV44hbjkENWbnVTcpJoJeCsqYL0z+zlx5nfzXb
         jri/tY9hh4x1imsne0wYH32oe18Z8P1NDUETD2Faii/exY6WK86w1ZqavAw37aOymhkh
         GDfuFOszOhfl4b9RA40rGtQ7QsoxH182MdDhJ5cVqep7OLs9ZiEMA9ZQr5SpHw6UeNvy
         Absw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794650541; x=1795255341;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=56kD8uC/JQs1NVPB4BPCYThtaKRA/inwI9P7GjKzDmc=;
        b=WxjhZOPnpo63K3hio5d2MXt76m+sWU9J2ohQ+YG0XjyiSyq7Dnb9q2vGFmcYs/U/6O
         OgYxnien/2uooHxUL8dvVuDRSIaXjMG0xTgSlYgQVmZM/p7o7VzmOn6J+xeaOnCDEH2T
         woeez756tdVe1nJGFcTq9qoc4a7mkCOX7xHa7HV9L0jptLpkbO+GP44y++4118OyJAaQ
         nvX4dhGg90X2EwzIPhZlYsCiIfryXcKycTyDZ9tsHBX2uITyLJowEfJkS37nBuHfnVAI
         G3xgqf18Uvr+ZJuoQMcB8z8WfT21nLJqvwfScOVVucoOWPovoIklQQHufjfLxGsAN/Rw
         s8Ng==
X-Forwarded-Encrypted: i=1; AL+hErGW88Vhgl4ZBAiBRMsBbB9jHb7Ru68H+8feEv6IEymdj+p27un5M6d493W0LAdfykCT4RP0jjd0ydDc4Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+UropyLAzD0FVhUDGs7QkdlPbiwGJWrCDGHKQF7wAHe+WeaBfq
	wNfBydWIj+CMsIqtnr2A1SDdrH9RohDhzIEhKyWkNFQzsPNaxMel+ORB7FrseIXO6oqW2w==
X-Gm-Gg: AYBFou1kL0dm5yF8w6ps0qIY2T9SOudoX9V1ADRGdyxSsAfCo7aMpV2Tg1LRnMTMlwa
	rq1Uw8Mne82KnL4oTBNuIdhCzxBexEBmKf8a8ezShunqLmb/CYw7fFegUyQvKwzAGfkaNOG76/B
	v3d6Qyqbej//vDtcnhZ2Jx6LkzRpmrO4dOFUJZN/ZyihlaAQ94PNqXgDm6kh4pvNWGwyjbucCaO
	5P0/LzbK1LuVW8Up901WNBBMxj9yjnHIsCE1gkK7OtN9vZT3OUWrTEJTW2/LV1yvVTzL6yl4aA4
	WfIGQPNddNQRXijbpv9DfR5V9ZUWYSA6C1KgyLnAM1nIwfLQ81B4BUvpO6i7B5OwPDG5D08CI4/
	KeqX2FMdB6JeqYfIBbJtmexwEsiq31Kj1QRTEZ0GizzMjJ4RKcQunhwfiUZogm2mEmMB2QnbIiY
	TvLGEgC57RTf9CY8K1duE3LqC3kS8lS0tp8pM57zx76JQlJ7Ng+V8vPb3ZiLz7QuL3TKnKPopCj
	r1GH1xVprlGHpAgW1rIUyZF1WLhHZ4yv9kqfPivAwYUZ+JO4uaSvcDef9GkViO+QsilIqKEJhYN
	CIWDDMM37u8ka8e1f+eYTshONxjkSVkIyw==
X-Received: by 2002:a05:600c:6308:b0:4b7:6942:39bf with SMTP id 5b1f17b1804b1-4bb55a68492mr112151695e9.28.1794650540956;
        Sat, 14 Nov 2026 02:02:20 -0800 (PST)
Received: from DESKTOP-TMG47OE ([176.41.25.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608cf46dsm10520184f8f.43.2026.11.14.02.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 02:02:19 -0800 (PST)
From: =?UTF-8?q?Ali=20K=C3=B6se?= <shroot1337@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	rppt@kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: sm750fb: Clean up helpers and fix DAC power-off handling
Date: Sat, 14 Nov 2026 13:02:04 +0300
Message-ID: <20261114100207.9124-1-shroot1337@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This series replaces the set_DAC macro with a local static function,
corrects the DAC power-off bit handling, and removes an empty software
I2C acknowledgement helper and its ineffective parameter.

The first and third patches preserve existing behavior. The second
patch maps the extracted 0/1 DAC state to bit 20 rather than OR-ing it
into bit 0 of MISC_CTRL.

Based on staging-next at 6628e7d4c6b (Linux 7.4-rc1).

Validation:
- All SM750 driver objects compiled and linked into sm750fb.o with W=1,
  CONFIG_FB=y, CONFIG_STAGING=y, and CONFIG_FB_SM750=m.
- A standalone mocked-register test checked 72 DAC state and register
  preservation cases: 36 failed before the fix and none failed afterward.
- checkpatch.pl reported no errors or warnings.
- git diff --check passed.

Hardware testing was not performed.

Ali Köse (3):
  staging: sm750fb: Replace set_DAC macro with a static function
  staging: sm750fb: Fix DAC power-off bit handling
  staging: sm750fb: Remove empty software I2C acknowledgement helper

 drivers/staging/sm750fb/ddk750_display.c |  9 ++++++++-
 drivers/staging/sm750fb/ddk750_power.h   |  5 -----
 drivers/staging/sm750fb/ddk750_swi2c.c   | 19 ++-----------------
 3 files changed, 10 insertions(+), 23 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

