Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE9A410D0B
	for <linux-fbdev@vger.kernel.org>; Thu,  8 Jan 2026 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867068; cv=none; b=n2T1Voyw30og2IrVAQrnjE7KXT4dNP0pXHuV1LADdrxED9EuZW5DKEaVPwOdIK98alnHnbLzoRZASFSJyCfnFPackuWWmQkwWrHPwDGIpX08GdwIf/ajKhu0fa4F9kGKXnHu91Uv2A0gVKyubbPa8u57lfooa1fBaDA0AAC+8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867068; c=relaxed/simple;
	bh=h9uwAqvKFjHNqaoUbE4IiDPfzSZFqv76YqNJ94qfNIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWzJWCkXF0jho2LmAzrZ1Fz/JUe/4A5LWuDsYG8V4c3RaXR9o9bagIQ/aeVmg192kt+evTRrTFbzRLKu/Csgb0HauwWWIEP5sdmM20NHVdj1bd0aTUlJXE+6T9GTgx/LEjDtZACnj8S4dmtp9Snx3Yn7lLY1oqZzceXPKxVK5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExzkR868; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExzkR868"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso1943943b3a.0
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 02:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767867063; x=1768471863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9uwAqvKFjHNqaoUbE4IiDPfzSZFqv76YqNJ94qfNIw=;
        b=ExzkR86830PqjWTqv8AeVJlbiUCUKm+IltakOMgMGOnePObu1C/RxSCAB9hp85xy2B
         GsdANdtTv68HomD7hIJLquCH4zJGqhSZGf0a5R3s7i3NpYMPqpW/8hf2G9f0LDoAIOog
         7gtVGRawd6XUw3SYlVZqu8BxdJK1eZbKqyEunqUnXVMCYZII3fighJKCK4VNiYn21+OO
         9GDa0WunCxA/RKNDCN2picmdfCw2F+nrgcZN//nDh3kXU7MZ2VTWu53PpvTs9RZWiU2k
         ZFxffnTwdx8ZX8d8FRqhtNBOQGF1Ze6gFhAI+E73mlA0g+rzJbZIkclXmf/EH9CSVOf9
         /36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767867063; x=1768471863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h9uwAqvKFjHNqaoUbE4IiDPfzSZFqv76YqNJ94qfNIw=;
        b=YGo2JAqgg6HJQXpw5qYXJfBgfv4B1NW0CF7wdskMFgpmaF4U/KU9yUy4K6eTwBTzTU
         sAyxMkfmH0lVs09kv9eXqc/PtSf4sdOnxYo4L1qEOiozWlPBs5+ZsWNW/qpodm4rEL8c
         ZLymJbGQcFDdTod6O5fJ/aGcE8AUsHiW+Y71q5JVBznjhQqqynlrmHckY3PH/oOt3jOO
         oNmm9tWnTBFkKaqN0VxQLQoyvEhOtdmoL7mXSVNGAob2RH679LL0rGsaQ7NRs+ZSrZ4X
         CO1pgE4Mq/ajpuJM+hvKqHK6eOkZrQgwEJ7tZwRgQvn84q8unr2YcmURHO/RbMyWfcT9
         TKrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7+EI0arKzrWTk15AqIZJRNELTlOalPI+0yxbnF1jYYhPDAGmOyeM7JUO324DAiiAeOpZmgKoPWO2Jig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbkvXAnzE5NViT6hN+elpzBP+f169Tf37sFoAgLXUf+HARd0X3
	5vofQ5XrTEImWwb/jVFuPLLbO2iN1WWLSbV5K27+TINQaF8Wuiw/a89I
X-Gm-Gg: AY/fxX7z0YP1t26zZmBgraGro3HyVfcnStJyTmG5SKDik5nC3l5tDT3BLZ2btfSPtwW
	DRIf3Jd/QeU/A6hynJuBXevNjOWywTRZiVC0Lk0bLADeJo2miLGSGD7RJhxAJhDz9UmKJ9x+ojR
	FI8D4OFTblo8REocD45j37VBEBE2sWPPgjFE2YCR2gWyeAHQ4JYiKW91sZFNIH4G0K7O63PKS3r
	PGlK3GOky8h1cceyKdqU/cGbNQu/NTPBe4eb5kywleETrSDZxrro/5Sy3hq9qXAS4RK8fXqhGX1
	gtYg+JH9nYWeVbTCQRphR2bVNaUgTVySZJBQ2qsCO+6GF9vBO3/qHsAQ4Y3LYxkrQ3B0lXIyr/K
	b4G3BDtbJ85Ibs018J86DRJ4kcBeP8oBr3Ph9PhL+7I8DVkuOynZWQdVj2AwOh9Joxm+pwCtHtj
	DsPEjviXe6QormXfKZnh3ydcv/nR6NpUCWcelJ8oCnAKtdjHUIew0S2m3KKFU=
X-Google-Smtp-Source: AGHT+IEHYRvD7hq42mCwI2aLKv7F5lVXS2SHsFyfxpXbBk1ir1DO9ZQE/5l1NoYaYnM2SJIL+BGJXQ==
X-Received: by 2002:a05:6a00:8d8e:b0:7b9:ef46:ec61 with SMTP id d2e1a72fcca58-81b7f108957mr5322486b3a.26.1767867063293;
        Thu, 08 Jan 2026 02:11:03 -0800 (PST)
Received: from localhost.localdomain ([2409:40e3:44:c9c0:8d34:cc3d:a8c9:1a48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819baa19242sm7318484b3a.7.2026.01.08.02.11.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Jan 2026 02:11:02 -0800 (PST)
From: Chaitanya Mishra <chaitanyamishra.ai@gmail.com>
To: gregkh@linuxfoundation.org
Cc: andy@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: align tinylcd write_reg args
Date: Thu,  8 Jan 2026 15:40:57 +0530
Message-ID: <20260108101057.9340-1-chaitanyamishra.ai@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260108094709.92561-1-chaitanyamishra.ai@gmail.com>
References: <20260108094709.92561-1-chaitanyamishra.ai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks Greg,

Agreed. This change does not improve readability, and checkpatch is only a guide.
I will drop this patch.

Regards,
Chaitanya
