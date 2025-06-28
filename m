Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A787DA9C;
	Sat, 28 Jun 2025 04:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086767; cv=none; b=JMhGx8tCsAZxkDEzdNQQj0d+3RJawgJivd92KKdKWeKVGdaTmKbe617sipW4aqLhkWe7QG0BZ7l/yVJYZp/h7AOkbW4pHl1YoQnqlK37Alytpj9mtduEn9jpGpJbFk4sOD5KpG5IkJklptknmQTNpjaZ7Rls3Nj7mguEsWVANgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086767; c=relaxed/simple;
	bh=+lIP+e3qcItfXbEQi2WJcfVJn2GbwlTtYXEdcj1R2vU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TqRCIwZKA4DvY7lgb+CwJVQKrZemwiGlgfWV+mWGgZTZ1mbDR2aPBiQiCPOk+iAqZbiNLFltQQO7PXCYxUVd9oc/oT1PZ5NHlMFzxUNSxSx9PBI9M9hdVqHKmhqhnOBuN5IC/Me0/TjSNR1D+0WD4KAI6cyPHnZPybL6A4JqfFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMhS5jG6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMhS5jG6"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso615494a12.2;
        Fri, 27 Jun 2025 21:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751086765; x=1751691565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+Y62Y/ec8sThQYgTDvBjm17W/jeVagSDonchzednA4=;
        b=SMhS5jG6kDFIdL8Sfu0HXJpeweAlFx9fZmGtL1rwtmZMvASXsa/G8zfcpXFkSMxFIV
         qu6xs2kr4qjCWqAOH4aQWv4yZd3dFqaIKxt7erXs8pAoy7rCbbMLVrtYOT0154dp3cHN
         VPF11CtB4wbqUaV/3y1dNfSy5z5sU4B/vwfr7t4TGWLpM/s8/+q/WNXz3i7o7kata028
         kragNcJUAYujYUZWf4bhdxbBLE62VRTDm5VAirGjgQNQEs0LU9+IQmCJLnbhk7ktPCny
         PkC9NJG3nmDm4TMu9A561V2M7/1lb4xSW5FuFIr0Xg6O//p98AxCI8Ff4/inuCUulXIw
         dRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086765; x=1751691565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+Y62Y/ec8sThQYgTDvBjm17W/jeVagSDonchzednA4=;
        b=rFCGX9AgJFf/1Wq2GZYuEmC8QoYPhKNSynziaa7Ky3JNDLSTLb4ypY9SY8uC2eCupS
         L5wt5BaA38PEcu4U+08PhcDvmhYh66K0P7BZY2+e6ktgm5PlnsiEvW5X6MuFs/YquuzF
         HcvHBYiKNdEi8RGEK4hIGZpzwOWpEz3wUmCHO1hVmstlvdmAmiZGD/mWxfNPM926LxAk
         AbB45QdaR7ynirLRSY3+nAguOnulCtmvpQ72Z1v67nPGnJex5kf1cZw3u5DFRQFWFeKW
         EqJMxOzu8H7+jtBCjtYKcRDh4QTRrMkYO0z2qcENnpJ1cAd/QKZcd1e/8T6dA1NZUrW5
         RHYg==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZBWxYc4c3HJuOlu/7Q1SHNLKznCJ0N/V08zuPdgdQbApLBDCFCEW0LmWblW/MaH1wB9cQ2wAspnKCKky@vger.kernel.org, AJvYcCXDXEjgmlkBCwiWOwShQ1EbrcpdMctV0I97vCORoRWefN9EzkXG9d8scpSFgLs6H50QApK8y344cwmJsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpGbNQ9DsYeM2mupPaA8MdG7Zl8YQSaft/+4jWd+skPphhLYM8
	SpJ9CovtU4hFWXIY5MZ2xlqEH/hVYSuEicmqkR/svzXUCWnc61X2XvjZ
X-Gm-Gg: ASbGncsRMNcm2RUapIsrc+r+Tj38Tzvq7xk0g3j2mbcNI2727CjcRzSfYe8xPXklngl
	RBA0SGYOLhjx1uaEfOEZ5DCletQfYtqRgTtAAzQnCGlD6338oPsx1lCjQrWVOx+0kgXNb2tLZyI
	FDlLBcWcgWxz132u8ewnCj1mnup5NQAheatc0g9E8+AGhLkXK3ngHiiX69zOJV3rTAuWrrZBC9e
	mRfDyqRiZCaQlUPv1Pjd/I35k6d57+daUuzjRjcvodLCGuwBRWALslyvy6lSoIz0leZ9EU1p1nF
	9P4s77RZsEqiIMXNUrflEBmNoQuwubYw9x+oQh+6nsC7QGgPqLooRBW1iabuoWsNjAAxBRWsq/x
	0XQ==
X-Google-Smtp-Source: AGHT+IFjBRpEOyLZz+ltarHHoSDBE2VSSqu3F2myfOAXRHpw3MWf9uX5uh2VPQyAfd0HyDKo/Y1myQ==
X-Received: by 2002:a17:90b:2885:b0:311:ff02:3fcb with SMTP id 98e67ed59e1d1-318c92fa81dmr7733389a91.28.1751086765146;
        Fri, 27 Jun 2025 21:59:25 -0700 (PDT)
Received: from localhost.localdomain ([49.37.221.186])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-318c13a271asm3659713a91.17.2025.06.27.21.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 21:59:24 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: andy@kernel.org
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	dan.carpenter@linaro.org,
	gregkh@linuxfoundation.org,
	lorenzo.stoakes@oracle.com,
	tzimmermann@suse.de,
	riyandhiman14@gmail.com,
	willy@infradead.org,
	notro@tronnes.org,
	thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: fbtft: cleanup fbtft_framebuffer_alloc()
Date: Sat, 28 Jun 2025 10:29:05 +0530
Message-ID: <cover.1751086324.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Change the earlier patch to also handle the error code returned by
  fb_deferred_io_init() and update Fixes tag to point to the commit that
  introduced the memory allocation (which leads to leak).
- Add second patch to make the error handling order symmetric to
  fbtft_framebuffer_release() and also remove managed allocation for
  txbuf as suggested by Andy and Dan.

Link to v1: https://lore.kernel.org/all/20250626172412.18355-1-abdun.nihaal@gmail.com/

Abdun Nihaal (2):
  staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()
  staging: fbtft: cleanup error handling in fbtft_framebuffer_alloc()

 drivers/staging/fbtft/fbtft-core.c | 39 +++++++++++++++++-------------
 1 file changed, 22 insertions(+), 17 deletions(-)

-- 
2.43.0

