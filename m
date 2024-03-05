Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E17EEFD
	for <linux-fbdev@vger.kernel.org>; Tue,  5 Mar 2024 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626337; cv=none; b=jZe5E/1yzFyJaYwSzVsKsio/f2wgG36gmoY7FjwyhThQbDkx3jDiKW8q+9SBNCdFS/RK9I1dxaN5LlJxKOjBwXM0TRoH16EnjnzJsplC4lLP7uuVYXPwn6Fe4DPGRYlrDi6WlpVl1CMa5jK8FxKiaGrV2NwhtskxfmiDOEtqji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626337; c=relaxed/simple;
	bh=NA41xUYJ0YMoD6hYkBcTSkjWUaJcxDDJPXNtIoNlDEk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o9H9LuC0nNvs489QNrWJYkEUKHp2Ak4s4yMAut+nKyA8lfxfamffTlQwsrHXB9ipBitCboZvjO5J8AD1LbpwAM4RNQRtoXyGIFHubzrCwmjnyhr8SedOn5aIyJh91CbaTotgTTdhuF7Gw/fgjqwzPp70TIhVMISpz3pSnqOkMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AgZWEaVD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AgZWEaVD"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56657bcd555so6662921a12.3
        for <linux-fbdev@vger.kernel.org>; Tue, 05 Mar 2024 00:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709626334; x=1710231134; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O3A/EAinpsgQWxTIMJ6yuX1WTjY1XiN+9FGOszAcRco=;
        b=AgZWEaVDMknjAsMuv1FKcN7RWKnMDWuyN4lpewxytVPw5vx3MserZdKrWamPD9Mamb
         YTlEUZGnfIetyTIGbtiyxRuwZ33aW2RL9IQIIU8HjgueypcJjFOwpGAEbW93x1MFrFq0
         4AbWTBRRO4cPA4U1prnPv9pgpttckLxgz1xsSx95yzhKkoN++khFz3E/cxzxYdkZynUk
         Lsvw8iW/SNUipyiCs+IjrIivYTIN59X1UBox7mCgyRNW20QMCPzJdjHvQcZ2+NYXZ9V9
         mqa5DtriRU92xGBiIduzy883zJL+gVyIT7EDFIW/424YaNhjFwENKCEf+CJVsI6TEXrH
         yrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626334; x=1710231134;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3A/EAinpsgQWxTIMJ6yuX1WTjY1XiN+9FGOszAcRco=;
        b=FN/9vdk/SXKS+9syPxO9MGJdhQ3GyXz3OGVaNEl+kDzrtiTzTCM9r956uvxIvWZZDq
         FpOEsbmxlC/YAYfLkEV5y2zzMBEEG618DuQSy9dlo1gyD0kcajEgeVLuAGSoyIiljAp4
         gfQwBFo7UF9pxoLtGPiWUCN/AJK4VR5q/JJeS3yGUJUOyP5I+6jZu87UMRI5D+mHNNw9
         1oU078WENiy1Eh06eTSOl9hi0q/T7Y7pbDeaoU/U8ZcIYi3G8GY9Rkv5M/6NjE4AVwZI
         ELSOnb+Nqe4+z/t9bmB8RcZiE+nmvNINek2Ypi7v4Rr0rRFMvVDDY85vXhaJxehwzfZ6
         jDcg==
X-Forwarded-Encrypted: i=1; AJvYcCWsCwjXjmnkl3YwDbEQuV7W4ujbKAIkPnYZ+QAzG15QnsGVzY58+j4IX1msPZqo6bgxf8hG4VPKUE9lEn3pNRY4kkBxjcmj0+RTtLo=
X-Gm-Message-State: AOJu0YyrGFZdHc7pHF7E3uJxB7JvexWQ2PfsQ0Hwvo/MRLGqh9Bjneeq
	G/XOj8D/sFdf6UQcL8iLgq34y0MkoAzBgUiQszvA9LrvUKU7NVp244AqWhwHl8NGVicOBv+BthA
	D
X-Google-Smtp-Source: AGHT+IHvfrycnRsoZbXowUc2gzxlYIB4odgKPVGzXcP83qjOfADAzdEhMwsO4VKb1yKnJHztwRB7jQ==
X-Received: by 2002:a05:6402:17db:b0:566:41f4:a0ea with SMTP id s27-20020a05640217db00b0056641f4a0eamr7342577edy.37.1709626333890;
        Tue, 05 Mar 2024 00:12:13 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b005672a346a8fsm2761557edb.57.2024.03.05.00.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:12:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/7] backlight: Simplify probe in few drivers
Date: Tue, 05 Mar 2024 09:11:55 +0100
Message-Id: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMvT5mUC/3WNQQqDMBBFryKz7pQkagpd9R7FhZqJDhUjEwktk
 rs3dd/le/DfPyCSMEW4VwcIJY4c1gLmUsE49+tEyK4wGGUaVasGh358LTzNO24SBsJaOyJNnqw
 1UFabkOf3WXx2hWeOe5DPeZD0z/5vJY0KqfXtzSnnLdnHwmsv4Rpkgi7n/AXzJuZ7rwAAAA==
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=NA41xUYJ0YMoD6hYkBcTSkjWUaJcxDDJPXNtIoNlDEk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5tPVGtrbAtNymcJcqPS8RdWTQCnBB6XqA2oyK
 IoVP3o+JlKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZebT1QAKCRDBN2bmhouD
 11a6D/oCkJmOBb/REyIVR7/UoJl+wJNV70fc2JUAMC0ZNw7J+WJtbOaaolizi7a0aFCspcu5QSu
 ZzsvcpbIm7Bgm8E5aS88V+d/AqEajMyuumKROdHfiPc9aUCTmp1KRMfAxQjHFc+O4xfW7Aim/Z8
 qxfjRRGfXd+kVUDToItIu3ohS0jqWW3ScElQXK8RtdJL9SHWES5YTCTvjNhIplx0qY2VGm/UnUA
 Gm0XlD5kZMJi23Ezx1m3TSec3xnNokZdu7EGvHYpe3vxYtOb4cFAAMGLsBGVCtKhIUB7aC8cKid
 fF6NC4AOocPNHMqKCfDObUlpypdfodV91i24C05ejcw0vaG7q73kU6AbNIrBmjLJy5zOl7f/lhH
 rl6Aruyw1dsg+92+R9r4AEY5H/7VEtaMoUh4HJ9ytDEnATk3amNzSJehfbA9N7h+TbgRyTmc8ut
 l4xgRvpB+fVGn5HTGassKARss52v7pKqE9tCjMtcLpAJhHT8BbbyOWgv5kc0EYYX0AC1MHc0F+V
 iiX1wUxNqTvFxBczhG/YF/omVLKWQGDD/i5LzVwhRna323AizMD4ghANLXaTkEJFKEaHbkHXsAa
 N/yAVP3KnJYG1ncyn5VQ9xWsCtFdbcy9ucDwdSiUE2MrrunER7MRqFJSjA/6lHznwH8JBvUNF27
 eE6fCO3SwnquZzQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Simplify old code in few backlight drivers.

Changes in v2
=============
1. Patch #1: Drop "Error :" msg.
2. Add Rb tags.
Link to v1: https://lore.kernel.org/r/20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org

Best regards,
Krzysztof

---
Krzysztof Kozlowski (7):
      backlight: gpio: Simplify with dev_err_probe()
      backlight: l4f00242t03: Simplify with dev_err_probe()
      backlight: bd6107: Handle deferred probe
      backlight: as3711_bl: Handle deferred probe
      backlight: lm3630a_bl: Handle deferred probe
      backlight: lm3630a_bl: Simplify probe return on gpio request error
      backlight: pandora_bl: Drop unneeded ENOMEM error message

 drivers/video/backlight/as3711_bl.c      |  6 ++----
 drivers/video/backlight/bd6107.c         |  9 +++------
 drivers/video/backlight/gpio_backlight.c | 10 +++-------
 drivers/video/backlight/l4f00242t03.c    | 34 +++++++++++++-------------------
 drivers/video/backlight/lm3630a_bl.c     | 13 +++++-------
 drivers/video/backlight/pandora_bl.c     |  4 +---
 6 files changed, 28 insertions(+), 48 deletions(-)
---
base-commit: 1870cdc0e8dee32e3c221704a2977898ba4c10e8
change-id: 20240304-backlight-probe-31dee1efe662

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

