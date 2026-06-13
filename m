Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CF737D132
	for <linux-fbdev@vger.kernel.org>; Sat, 13 Jun 2026 03:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781321523; cv=none; b=nhWoCNrVGC6yTWHbIV8mzQ/3Is5Wpl72rsMLGeSTNBkyB8yHEM+a7GMKSeHawLueMgDL3r+OmwLICnZUZ0eaMnnxU1hE2sZWbgSbYsFzV1gmyFIKUZPTPwXhQy+5AF0/dkX6l61WkUALhjodT+0xr0fo4ydRlHTBGzF3RRSqNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781321523; c=relaxed/simple;
	bh=XEGNtJgL9zV/iYvc+RbEVKQGxheJ2tZMTihk7BmV8fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rv72+DEMqHPqC3vDAoHja+2EJC+Q9JDXSMYJXR9I+ipaLZy2eCU9F7/mqawyi7QR2SQh66P6Inksm/TPuNKO5pmNW31eBCDT1K8BuyZM2vp90kHwrgQ2etNf+SPEqJnaShhKvq4hFNRWYFtj9nvbyGnNxNkwfqLPWrfenP5dFBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldFT21cP; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldFT21cP"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137335bc3caso1992480c88.0
        for <linux-fbdev@vger.kernel.org>; Fri, 12 Jun 2026 20:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781321521; x=1781926321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YB2UXCTST1G3EKX58d9G7S+JZrvHFI4WiciNlIDqnEE=;
        b=ldFT21cPronIyrkDfdk4OFdUfONZ8KnTr0NMJozvaFyOCgPmlw4yCrSMB3jDggGtNe
         jD6yCMsYXas33ZledkzeDw1Hv5icvH8oqEhV5f+/7JNVCsc2bNpw76puhFMbDQ+TN6wn
         njHf1kbM5A8qr53nN1uWFjIdJlrKVc8heVvthtcM/V64rCw9XS0CtsKp5xMJH2yOfWbt
         Qi1YGPg9hAXNzEAmDP43qFQgtxJCzpRDNN4MTvgQ+vjb05Sp+2t2nNgPay99S6OOOgRq
         dnYYuMk3+dUSk2aLbFwtyR8OzEw36h++l/okrpnjIFHwX1n7r3JVNbd+Eeh1IkXL73Pu
         0OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781321521; x=1781926321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YB2UXCTST1G3EKX58d9G7S+JZrvHFI4WiciNlIDqnEE=;
        b=b3qZzn8gRzwTQxmyhfNRUNVnJ5LCJaxbqhXZ6N0MD0qr61QxVeJfN2OfQVQMgljDYl
         FOFUd8ry3be08pdhDizE/fb+UmvQWOuEGQr8g/Fn9za8gcaqIvlWVbweVtAIiubXKZX5
         RDUrmIAvM4Yng5sqliQ7KAH7/WzW0vFO7gtMqfMaJ4a75PSZeRtUBw+7h6LfelIpWRY6
         SFsuwLzDJyGwdqfpJpuMfD3lOT58CVXtEe28p+LkVw1X597FfIhFxF9mtowzaTr2VdUT
         bbF8lKAn2ZIfVHSQu5/IxjRjtTz7WUxdfpQIgZcOqrCOrS52XJm93kFdS49i+FlFAACO
         vaZA==
X-Forwarded-Encrypted: i=1; AFNElJ93smsLqSnKE2b6/0jqRXrgY4CuSIWArtY0ynWFdrgVd+iefRPUkyxoCKcT3vgA+2evxAzUzw9f11CbYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy2pk6boKoNLnNPHMtXQXV8t59djT5jKrWfOO+XFDed7x/3FWb
	Qk2MOUzocfs0y91ET95EzuIsUuQ172oKNnx4PhpphQYRVm47a3CEdvzP
X-Gm-Gg: Acq92OH6S/I5fWMsRV2DYOTzpLFjZ8QVNiC5Jo8etH9ZfzAeB4LnSSxLL8lhjR0sE4e
	Jd7Ag86BVG0Yr4ggo4qJpHGPB9pzxZgQUTIy4arrvrsp2GHtkwz/NxK4uXJYjuX/dyaIjYox1xN
	6aIY2OsYBMteV7APAZ+fshmiauyeM/QoH382C8X4LquawXgNLEgdJZEy5SL3fCHOKpXkAxFiKD/
	ojr0SGSN1BsTFJesQHS0k3j7+SgYI+UvYMi0JKWiqMkB8KoE7ZOArtzjSBnxYZ0FPYHAkWbfRRq
	JDWMBylXJz2gnzLHGibKIorMlpVy0NGwrFnIMfZpTRheuobRyQK/8/3ftf3fJGc3p0OKj7KY1zy
	ncLaUMVyVxzzRgTQKlcfDmAuUpxe4paVpBdh/2zY/4RNE18ybie5yb548ujf5tf2CTOo5AgPdy/
	4Q+5tY+CIhNb3ZdE4HDhFDkw==
X-Received: by 2002:a05:7300:aca5:b0:304:5b0d:489b with SMTP id 5a478bee46e88-30820098d2emr3305528eec.27.1781321521004;
        Fri, 12 Jun 2026 20:32:01 -0700 (PDT)
Received: from 192.168.1.17 ([179.63.13.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d810fsm6136001eec.12.2026.06.12.20.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 20:32:00 -0700 (PDT)
From: Gabriel Ramos Barbosa Mota <maguraa53@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	deller@gmx.de,
	fero@drama.obuda.kando.hu
Cc: netdev@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Gabriel Ramos Barbosa Mota <maguraa53@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] staging: vme_user: remove obsolete VMEbus driver and Kconfig entry
Date: Sat, 13 Jun 2026 00:31:31 -0300
Message-ID: <20260613033138.601841-2-maguraa53@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613033138.601841-1-maguraa53@gmail.com>
References: <20260613033138.601841-1-maguraa53@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported-by: kernel test robot <lkp@intel.com>

Closes: https://lore.kernel.org/oe-kbuild-all/202606130547.TsvyPMvB-lkp@intel.com/
---
 drivers/staging/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 2f92cd698..0e6e5330f 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -46,6 +46,4 @@ source "drivers/staging/vc04_services/Kconfig"
 
 source "drivers/staging/axis-fifo/Kconfig"
 
-source "drivers/staging/vme_user/Kconfig"
-
 endif # STAGING
-- 
2.54.0

