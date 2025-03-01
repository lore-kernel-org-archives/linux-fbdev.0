Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BFD1D63ED
	for <linux-fbdev@vger.kernel.org>; Sat,  1 Mar 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740823445; cv=none; b=twaz7O+1ULu8HMvPTsu2umjNlCRUuD7KGT/EpIuO/8Xg/iyDRFqlExHU9q9i9Z9iOHwNC5yUJ3lBqaA8URignowadELo9D2ozwrlXLY4RinxfANc9/lepLnGKRUwaOauj6dfH9ufldK1zLGQoGD/5PKLqRmoE/OQJqX33pYxYnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740823445; c=relaxed/simple;
	bh=ed0rxhmjszvCD6sXc1nM0sLqEzWbX15UwVBTYrlX7o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paGwE0z9RWhuewri+bJzwanRUuBfxfLFPihLyJOL0X/PQYUjVmg0oQVEqW3wy3vqqWCwgyM52Ez6TsdlcTuO4tiwl/VSTejbrwCsW513qkdeRHsOxydEY7te04d+7OeS7Jyko0Ha4HCEo94AQlxuISaZKLepiGrnjLyPVGMnPyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtO2Qlm+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtO2Qlm+"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5494bc8a526so2172288e87.0
        for <linux-fbdev@vger.kernel.org>; Sat, 01 Mar 2025 02:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740823441; x=1741428241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76ANipvR3P/jVIpgRlnkUUgAgrkLoL0o+K6EABpA1ek=;
        b=gtO2Qlm+B0LgpLMulFjM9s9gA+B6U+wBaztr+IB7HA/g7HxQKk1OUUVw9R4eYoZKlQ
         GV7PysK1TweGty+29iQnzmBZ9NdZWKnj+Yb65LptAjQ/gI3abn381Uk0Z809Cj5UvS4P
         Z1VwGjWLt4G93ulkvgZeQuIe0CXbYsbr1JoOjciuO13Vc3zMsOv7L6WefflM8kX5ItVw
         QgcAjVN0VtDngXIv4T3f3QrepcLuZDNDQTUJICqt5Mm/xkARc3Z+/Imd1iY88H7lzYgE
         719Po/9MPExADEDfT/IU+RXmxI/Ll6+9655IsH0U4bA4EXcML60029J0O3DJfvfJiDkj
         Y9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740823441; x=1741428241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76ANipvR3P/jVIpgRlnkUUgAgrkLoL0o+K6EABpA1ek=;
        b=nlQB0FbryD4UzrrMvMz7j9i1o6VuOy01aM7TpSo6kjxqETcb8Fh982Vc/dp90NnObI
         60wbskwnk4ZL1qMfhtkjEckrhrk+KOBcCVGiOrw1iWiMhKabCgn5MqtcTXvOU0ipuuWA
         FsX/y09grbwyFLEcYcxyc7OXZH3gjKrfs2F3RKMnqY0PQIckFOu6yoIfHaJSXoWJAob3
         4PRkv53nXVgZ4ti0myP0QxLc33og1v8nr9M/PEldzUMhRLbLEYfcx1JqVC60eqbNyGY6
         Q1qR7ieBm8AA9l/9ITWHkXnVPBiGVZNAJUbV9zNGCMMpC8NYZ9iQz+pqAeEqbn/beKzs
         YVHA==
X-Forwarded-Encrypted: i=1; AJvYcCVABFZtPv3ThJeAuwUtLES8f1hTOK9/JRefsd72SNZDR6AMO+WP7d7Rd4g0gNYgDj7NxfGj8Lr1JVXrww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNtb6GI2mYuB431d5WQ7w9of0y/TOIkgZVjjegqLugaqhXdwT
	YpmwKC5+KBbdqarXBCoM0bDjSpV58GA7BDCo1JditBDBCay70Mh4TJ8+/tXCm5A=
X-Gm-Gg: ASbGncuYGULc8TSXIJiGoirj8MKZM4A6wVAa5mRXfY4/f6TAqwSAtcDPJV0RHFZKP6L
	yqKJjHzq67HOddzyAKO8imK6VtgJxiZvYqx9p4Gn2cQyMOE9KeAooPGzsZcl3yjU7UenZ7yvEkf
	eSh3Kl9NEhx5iLcl+5R3VJ/D12evb3nm5pdp7Bb9CowwWwjol0SyNXElhBDjcKrWQalHaBmj6Jr
	QitPdc+gGANBV/2cNA0C/Dp+9R0NpmdyqhT2paQ2OY64JaUN+kC43dAlkWWFV3Jx0r+XUG1uH/J
	ai0aeGO75zTp11+L/ywbAA/eT2EeDkcPlS3bxuVfAcgRmgtyrZHjQl7bPbKZhr5SkqO4A4Oa2PK
	JS6WRsjBSBGpv
X-Google-Smtp-Source: AGHT+IFuYzubuDyf6X5ei2oE/n7MHEB/XJ+jimftn4XgARTj9v/mjL84XjfF68VTOLYEok0MXR5YaA==
X-Received: by 2002:a05:6512:3f1d:b0:545:aa5:d44a with SMTP id 2adb3069b0e04-5494c33304bmr2297080e87.42.1740823441381;
        Sat, 01 Mar 2025 02:04:01 -0800 (PST)
Received: from eriador.lan (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494f8bdde9sm463722e87.148.2025.03.01.02.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 02:04:00 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	deller@gmx.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux@treblig.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] gpu: ipu-v3: Remove unused functions
Date: Sat,  1 Mar 2025 12:03:57 +0200
Message-ID: <174082343297.2941786.11452976094065423321.b4-ty@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20241226022752.219399-1-linux@treblig.org>
References: <20241226022752.219399-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 26 Dec 2024 02:27:45 +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   This set removes a bunch of functions in ipu-v3 that
> have been unused for a long time (since 2012-2017).
> 
>   No changes to functions are made, just full deletions.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/7] gpu: ipu-v3: ipu-ic: Remove unused ipu_ic_task_graphics_init
      commit: 16e3bf497fb2d379f3d461fa0c85d14de0a3d183
[2/7] gpu: ipu-v3: Remove unused ipu_rot_mode_to_degrees
      commit: a52ba18c254c0a3819e632e6371554f1c6f5bd16
[3/7] gpu: ipu-v3: Remove unused ipu_idmac_channel_busy
      commit: 4f9c64e95c3510f4a5192bd401de5611c1dd5637
[4/7] gpu: ipu-v3: Remove unused ipu_image_convert_* functions
      commit: 96e9d754b35e87a5be2de7dce3c810ffdd769c84
[5/7] gpu: ipu-v3: Remove unused ipu_vdi_unsetup
      commit: 27985c86e283e1e5ac8a9809f189f03643a6f5f2
[6/7] gpu: ipu-v3: ipu-csi: Remove unused functions
      commit: c687c3147d5de801ed835b077802b68fe85d8a3d
[7/7] gpu: ipu-v3 ipu-cpmem: Remove unused functions
      commit: 2800028d5bdee8e9a3cda2fec782dadc32225d8d

Best regards,
-- 
With best wishes
Dmitry

