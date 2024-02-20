Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5822F76031
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443019; cv=none; b=MgbCX8anCNcfjPmeaTxhHLOET49Z08lnNt8fduo5ymbEVt1AgHBfTwTOJ2QlC0Uw/Z2lQM5P9MHo6LkvxTlDmZ3x142V37a2ojINDXGXOxhC8PN5hSJWOuxcYjTRYMiPJntuqzBejgF2yEuSLBC9SkcuaC7/09V0f9HMgBR/SPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443019; c=relaxed/simple;
	bh=6zpSeqO7y+SNzwDQbzzOqhJOB01yNdtQEGbzwhAOBHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZesgrTpqXAVCxS27TPdEDkv1bpEKaO3pS+9rBLDhbKUkGHnST4oe3+F/9AT8KqdkVZEJcn1oLtIybj4CCK4S77SrMz1Jy+UDWeTOIZNvK0JAFsoUN2g5oZduT9COXxSoiSGBzdFS3GJaS+LUrg/xdOtoxAVfbvPv4Qce7dNpDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MKITkwRs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKITkwRs"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4127190ad83so2537875e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 07:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443016; x=1709047816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IY5Fl8EiIpjATBqz7xetWyCUjSktN1KtrnTN2tZhCTw=;
        b=MKITkwRsd5Eu8HuUHaa1uW+ZxcAuLnXgC7jcs6LfbiKVCqaH0bXQWXcrKW2eAQWPTG
         LGXfx7+aB14MLre93IPbH6xn6SFj9wr3KVGYmhTO9PyVcndB8FhfAUAGXzJ62qXQEHcb
         CYXnEjXWxi+cIRw0ArGDgmPClFnK3ojqkJbVOsMNS7KKL9sO7LqyNt2zONAMNe8e4CP+
         fs+eaHc1ULW8L23OFclrmo2HGPAe6VdbBfpAZFV994VhwzQE+YBq9+o57O5OBiauRCpx
         rLN7VBiHtbWrQbBI0kRoqS4q776dydABnfVCDUlVsTlDr2mX9KbF50ZiaQknMMR7D0g6
         6mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443016; x=1709047816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IY5Fl8EiIpjATBqz7xetWyCUjSktN1KtrnTN2tZhCTw=;
        b=OECnfuWifawgYzfnw8KOWKOYjRBh2gBE6TEiOdk8EhBU4004gfd2xY0NBa6yLNORpz
         LxlcFB0mpwnSTFc60g0eUIPddWxWCyuzTMPVDbCyjO7rWk95rreDglr5XGtRRWTG3ZoA
         FEYtplfG/UhX7UrZLoxJmZ6LhZucVaSXwp51JvbDUDQ/EiUm/h2BGLGmd+C/yhADA4sm
         Z7WBhm0uQroxYZiShXzlJnbb5JoJwBZqcwZld7mAky3Esoi3UB2XRISENiJKjuSIlRXu
         1NszvE8Gt81XcXtoC5fvPOBTpGRpzHK8saHzTxB/vfA4xP5jBsilbqbFwLUK0moOl68X
         UgYA==
X-Forwarded-Encrypted: i=1; AJvYcCWcWsFq1XUsiI5zZ2PqtpNXXe6bSjnFeXrYc1yOoe6/oh2MRIHqkdsOdRxdORNf5jl+uojPtuH6j37AkYvvcZ4WhWfK+Z1Jz1lcEsI=
X-Gm-Message-State: AOJu0YxShWNpJUJtjLPDPCiVZ+DY34v5yIUjYyPwGIbBOuRKNPpFM2gr
	Hr8sDG9ovol382bTG0XgVsp8yKqe+s9PjxvTP8fHrnZx4tFh41AVCPfwc/LM3qs=
X-Google-Smtp-Source: AGHT+IERmi+P7yWUq4uVJnrZIJuMSM97Nq4UuUDoxY46okU9MBfkMBuvnG45Q1sfupCdozb8l8+9Hg==
X-Received: by 2002:a05:600c:4f49:b0:412:5670:e5c6 with SMTP id m9-20020a05600c4f4900b004125670e5c6mr8316824wmq.13.1708443015690;
        Tue, 20 Feb 2024 07:30:15 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c280400b0040fe308ff25sm14691564wmb.24.2024.02.20.07.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:30:14 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee.jones@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Ensure all backlight drivers zero the properties structure
Date: Tue, 20 Feb 2024 15:30:04 +0000
Message-ID: <20240220153010.76238-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Luca Weiss recently shared a patch to zero the properties structure for
lm3630a... and shortly afterwards I realized I should probably scan for
a similar class of errors in other drivers.

Results follow in the next four patches (they could all be one patch but
for the fact there are different Fixes: tags)!

Daniel Thompson (4):
  backlight: da9052: Fully initialize backlight_properties during probe
  backlight: lm3639: Fully initialize backlight_properties during probe
  backlight: lp8788: Fully initialize backlight_properties during probe
  backlight: mp3309c: Fully initialize backlight_properties during probe

 drivers/video/backlight/da9052_bl.c | 1 +
 drivers/video/backlight/lm3639_bl.c | 1 +
 drivers/video/backlight/lp8788_bl.c | 1 +
 drivers/video/backlight/mp3309c.c   | 1 +
 4 files changed, 4 insertions(+)


base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
--
2.43.0

