Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84FB3AFCE5
	for <linux-fbdev@vger.kernel.org>; Thu,  8 Oct 2026 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486796; cv=none; b=kqd+r/3AqY3b/+abFLui35eoiV6C4l0T14URxTV1O60N5haMHFuseLKpNwj1OdMwBv+ulsSkhjohiMxUPQcDX20hfThymMmx0LFv5WRNxbCwnNfDj4XAwHjsQSY69BgUNZzoedCuWYCx8Egs7+3CrkJt0Ga7thejsmOAIfXkvuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486796; c=relaxed/simple;
	bh=AxXokR9yTnXIXLj9Db4ukgIhemDv2YeEJlYdS2h6TgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lwEAD5hTc1CF8BZARLi+GthOHhek89EZrpszetIYxeyiJLunI+HJVKzQW1I9vGdnujl134SY/NRf1IJTsUbFKXgYDz7NUFoTM1N+E1VgYJ2OwBWe0zIatebWUbJdZc7iqmVwLhwscZOxeL4EK+DrnDbh7+MkxRkerRV8klrYDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=OkTt84SU; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="OkTt84SU"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3141721eec.0
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Oct 2026 12:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486794; x=1792091594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gGgE3kKeoX2vWEaOMwOk44hmNWlNe6dYYIaxJ66sqbw=;
        b=OkTt84SU0jCVjp5gMtxmuLTKXYSfNiaWs9wQbHvxY/Ej1FzriFbZyXBFgvm62+2/Bq
         qJG0uQfyrh0RXkmRswzCHiMBrZFUx2Ox9IYl5/jIQZCJNEXB2Zd/CwkdZ5PooqfLxSOZ
         dTK0fM3p7XJAhLSxdgdm5BIHEkvGoD8ncucIvGyw3TsrxGeBAvmokCn+N76MQ77PJ8Pc
         4+Z/oPkFalj7ejSsOQQOjjDSzhWOBu7MpT8CdAf4SLB92RnRBoWgQFxyLjA5QLbMrSen
         I7ldRopW5H/zMoW2u7KJWeTgn/XEc16T0Vi5bAQg9MEJTjeUMPgQnIVEIHGDf69DCizK
         d5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486794; x=1792091594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGgE3kKeoX2vWEaOMwOk44hmNWlNe6dYYIaxJ66sqbw=;
        b=sS25aGprhfvscDFbVpumLxdYOWiP3flzIzesltp+ugdOGqs2NWC22rDAg5iKC/mSnL
         TH2QUGl4tlvPBtqMXefMe2PfO+hLNYvSgZTgDyhtnehZF7fa6LteZPyyT5uTSnSLuXmM
         gVqUCYuc2S2RS0PqFMQoKIHUFBA4YQ6BHe8jqJkaG0rFaOVbAk5p53tV8AvVxZKJS/Rf
         sGBScr84AbR2VvDlECXgqvCZrKVGc02EHvf+05KF4tkW5fbYH/DRbyAdmB/5Xxb1EBpR
         AzqQ4iSdLork7najrlPrbZ87rz++pDaa0ZlUxt9r8Y6oFInPZKY0cYGlTgvW5be2N1DK
         bu3A==
X-Forwarded-Encrypted: i=1; AKwUvBwAM+1uSqmWWPvtQHui5J964p5Ly1gaCmZ2os8Yt9wXv0EUm2/WKxWLwzlvjFKDeQLyN+H+HZHz1oNdmA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKM70WIA8FL7yGrMEjcoXTbjdQllIBYf4mueXR3ZgYuHD6THYP0
	E0U3f8aaOhWS0s/xqEZESl9tDwXEMPUJFeLi9/SmUC6cJiBkFlQnycDXnwA3NT4+1Hc=
X-Gm-Gg: AYBFou12+/e3Mn2JRj+5jPc1gvJ4x9ZjNDH0x/2UXR6ZFH6YrbGpQ0LUiyI/MKnGJUr
	uchSU8vbCznjlFlHfK90Y9GNjL4vZyh5zkU7uW7KG98Z07d/437c6nIhACwqncI2Wvu+NAYrZki
	hHmTAF1nO/wrj8xthBOMeopILXnJPr5uUEyyOgDDTh1onkAAaU5B/0/pAahc5fzMHXVYkPS3VJE
	VwADGxkx3S5LQYzn5lPGzU5JvPT2UPNppkA5jGa6XJ+iIqMWYPmkLqyPrZ0CjZMfXrEPL/dy3OD
	Y8i0oi0+nNmaQ8Jy1a7gg/00lun2kG1Cg9WFZS1QhVDAGhisIIb9xxq0wuttGJ7Ws4cgTcOAO0+
	pu8214uLDiaBzsue1WKP/cjD8d+SncrT6EftlPf4X4+zj1mkXfzFDQsx+HSpFzSh/H/8Uft5B27
	6DzsdPayP0ZvvcPTXQvP2Foy2v2H/aB1Yl1Tn6nifSH0eaF8JpnycN45AaKzAFUNoMOjMjlA42X
	USsCYGm8mWMf3cjq7FYdok3/KOtONiL08lRCC2wKy6ECFNSjt4FH88+VYNOrMZzAKjCcMg4rY0B
	h3CthQ==
X-Received: by 2002:a05:7301:c8a:b0:351:7ec0:cd4e with SMTP id 5a478bee46e88-3517ec0ce24mr3629562eec.41.1791486792986;
        Thu, 08 Oct 2026 12:13:12 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841579sm94214eec.4.2026.10.08.12.13.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:13:12 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Helge Deller <deller@gmx.de>,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH 6.6.y 0/2] fbdev: backport CVE-2025-21976
Date: Thu,  8 Oct 2026 15:13:03 -0400
Message-ID: <20261008191309.98263-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and maintainers,

I'm working through the smaller CVE backports still missing from 6.6.y.
These 2 upstream changes belong together for CVE-2025-21976. They must be
applied in this order because the later change depends on or completes the
earlier one.

The complete series is already present in 6.12.y, 6.18.y, and 7.2.y.
These fixes also affect 6.1.y, which will need a separate backport; this
series is only for 6.6.y.

Could you please consider this series for 6.6.y?

Thanks,
Artem Dinaburg

Series:
  1. fbdev: hyperv_fb: Simplify hvfb_putmem
  2. fbdev: hyperv_fb: Allow graceful removal of framebuffer

base: v6.6.157 (79643295eba17affbd16ca97f3ef04c90266b28c) plus stable-queue
revision 958ddf240a33ef26b1771be944f0ea6c3b597472
