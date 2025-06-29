Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFA41E51D;
	Sun, 29 Jun 2025 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751208073; cv=none; b=en/Ar3+tPM+ZPmE59uZK2FOazvqE6ASisTH6H5NFWMypEQmpUTcuJQDbd79OZO70vbrvU1b71GrzxQzQ0vlakrgTi8RIT12rReYIj1PSj2rrVxlmHN1462s2ZiT8rK5tH2qRufIYb+jSjYMdvhLbGP8XKFZpz+m81o9m2N6lDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751208073; c=relaxed/simple;
	bh=iCNtVUFqhKvE4SJOApR9iY9D8ji493pCEBANWLuTF8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cw8PM4EwtcQ3y90fkm/cSB8yNaA0HfeVifyFwm/E9ps8w+d5YSjLDx2Hzy/g/1+eW8E9GsC+pEIUae6BGJK0Vu9/W/jgT0A3fYO4lSlKnSRnvCL2Y6f5quMxJsrsGsAmFjI2HG2IBy01JLEQ7/VIRMmcvBDf4GkFccW0U9MFZlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/9gTcCD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/9gTcCD"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-749068b9b63so2760416b3a.0;
        Sun, 29 Jun 2025 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751208069; x=1751812869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ngH93iqwU56AyBIpW4Url2/UbBhraQmZe5IjknGkMe8=;
        b=P/9gTcCDbYm0fPDIT2iD4yCTmpj8+ew+3vhEgjqTvMF+IcBN2IDol8OsR0EquVXCGK
         GTuLpweKs9i54h35h+4f9LAHfZsLWxWLGRY0gCAN0uXJyPKfwTjDigFYws5JhN+h7AyA
         4cicKFURKteRuJjZkr7DS37rIdT/kBMcEu6QaKSMh244ZoiweND+p2rBbuPSS3IeB/b0
         4oJypvo36b2nXCvCgERDHXd8qq7PG7RSzzBLaHbMceq+9S+FN0Yvshq1SapPXiRCjgFd
         ktdPaMwR/5A4UDKKJxoBbwGFy6C938FiKbRUWhSGJZkRju0iLHfgYH+O+QIWalNFHQTb
         5ohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751208069; x=1751812869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngH93iqwU56AyBIpW4Url2/UbBhraQmZe5IjknGkMe8=;
        b=ATCk1kkLGj7HyW6G5+8KmLqIuDYwGn84hQNznvG3V+KDEEAmZfJkSKDq3wEQFOK+UW
         IFXkbxbVpCJA8GY+u88Ju3a7q3TlGyo18bURwgbzqrN079Yf7pRoEIA03ZMIK1zmWyTS
         pfT3E5dDk0vqk3iX9Vj75tECvzpP9p9+uuzF6XzUo9h1t6A/YcK+6ymL3pcCZmy8pIfF
         OCIqfpGlyE3M+QAngo/ALV+fN3XNUDmpdKoQL5qkI476qOHqUMxA/axStRJH5rUyywqp
         0+qzEpXSIxVlF5LWcPWJg1W9Nhu9eox3BWUmOKWCXyaE75bdqX74uu3fCRe0EsGPyaar
         /8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWZHJTKWKavscidjSa2iY2fx1Gy2mMrYEAsPVOEdragXIsdaFEKt8n1xM0sUoCr6Ee0GklEi/45Mjvywwss@vger.kernel.org, AJvYcCWrvrWdErq3lDvrEzMJlppA/NQrALPqyTIqae2iSnpcxcz8aGimCXc+/wvuT/a3nBfW+LsC/IuIwyh9Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMiaTHTozzcfv/UQHzxqPmIE2p8OtY77WobDdmaovR7iW5k2MJ
	+fQKZ+jdrnguFhSmG6lSO5hxUNdWWranqjcHBYWR+xxcBNcI8fF3kJKR
X-Gm-Gg: ASbGncuL4hBvhL13u0SMTiDVT3o66d+GfON5h2P7djxTyX6zQVPKecfGXUEV7upxlaY
	UDomfXQq4/wHlv6ZpH+uNgXvqKwJWw9EsyI/U9mRvfDJRggWVp0I3wOcgHWRjJDF43ZJl8JrQt5
	XgZMlqOcPTmVO4LZgnJztXkqx/wQ81FORxpYOTYVZ9YWqqo6L6Jgw7YETRESkaDrrtSuWf7bDfz
	IyKltrcwlCliACRQLfKjn4ocREtHkftKstJhQDV3p7l/MkgBBL9Ktbf5DHJ1RMQu8hcQVSbLcxY
	xXGvImkNbB/nICKU6rvwga/oHR3kuG65IRnaJY6gGbbZ/15sqro5YHslPM3mOq6enOhlXXBFCOT
	9/m4lfYn6sHKk
X-Google-Smtp-Source: AGHT+IHtRc/795RNnE3dT1YxPcD9508ibGAtu/WX122P8XMCfUg4pdoaiikvlcOosNNP++JAPhMsug==
X-Received: by 2002:a05:6a21:339c:b0:21f:becf:5f4d with SMTP id adf61e73a8af0-220a169c8edmr14074658637.20.1751208069031;
        Sun, 29 Jun 2025 07:41:09 -0700 (PDT)
Received: from localhost.localdomain ([49.37.221.186])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74af55c7e89sm7039127b3a.109.2025.06.29.07.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 07:41:08 -0700 (PDT)
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
Subject: [PATCH v3 0/2] staging: fbtft: cleanup fbtft_framebuffer_alloc()
Date: Sun, 29 Jun 2025 20:10:09 +0530
Message-ID: <cover.1751207100.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a potential memory leak and cleanup error handling in
fbtft_framebuffer_alloc().

v3:
- Remove a redundant check before calling kfree

v2:
- Change the earlier patch to also handle the error code returned by
  fb_deferred_io_init() and update Fixes tag to point to the commit that
  introduced the memory allocation (which leads to leak).
- Add second patch to make the error handling order symmetric to
  fbtft_framebuffer_release() and also remove managed allocation for
  txbuf as suggested by Andy and Dan.

Link to v2: https://lore.kernel.org/linux-staging/cover.1751086324.git.abdun.nihaal@gmail.com/T/#md111471ddd69e6ddb0a6b98e565551ffbd791a34
Link to v1: https://lore.kernel.org/all/20250626172412.18355-1-abdun.nihaal@gmail.com/

Abdun Nihaal (2):
  staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()
  staging: fbtft: cleanup error handling in fbtft_framebuffer_alloc()

 drivers/staging/fbtft/fbtft-core.c | 38 +++++++++++++++++-------------
 1 file changed, 21 insertions(+), 17 deletions(-)

-- 
2.43.0

