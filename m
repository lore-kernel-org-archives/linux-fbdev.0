Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1F9A95E
	for <linux-fbdev@vger.kernel.org>; Sun, 14 Dec 2025 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765691375; cv=none; b=hkaZ40S0UCUUl4lbZRPS75F5CBLMCkLOaOJbF387c5rCpJxNA+mre9uI5PM9Lgr0W3ADrSK5A46zNUoOfOGvVbO2VaoKrzi5SzXxvucrAjlkgEzgh8TlzCqyS766m/us0r89CuqTk9vw3jzVMo7JSgKtXsSxmgJJOoIloJIw3fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765691375; c=relaxed/simple;
	bh=/efv7RWjzElgdiVbEJQAtXjJDpHQ3qw31Zwxky6cu8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fn4d0UyBXB52qbcrPg6eAPpfy6kFLDd0QUMIjL8BcVR5CBb3zVzYm566+qgvQSmhlNW4SWqnWX/Hn++vwTCZQKSSyoRkFJkGy+WU2BY29S/ecoDPTRxqw2tlY/K4HYG3OOJEksFJHjC3xzfQfRGfl9ak0s8yayH795Mr5nb93Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJy6q09F; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJy6q09F"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0ac29fca1so4367745ad.2
        for <linux-fbdev@vger.kernel.org>; Sat, 13 Dec 2025 21:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765691374; x=1766296174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hDgRCphZ8iRo09ep5SU5olQTYl13jEHMw2TZJC3PDk=;
        b=jJy6q09FSju1hG+vgzkvL+v2QF36ZCgmob1DEczqYnp5vMN+njgsPMaSxXgWZIcrVf
         erhU1iOY1EhdPL+bEBcqP590lmnjn13jfjvMNJM1WPnIpPYc5lam4fMZJvUbnjm9hulM
         EW2JI0CttRwk97M9uktxxwj+RLtXOHqhKrWxW6n6mTc8fnGHE4sOKtElTVR+9VO1X1D1
         pkPqR0ZtHXBL8Ok2K3hpuws69/kBPkDXiqxrdekPBkeyTW7nGk+gcjjpT8L5u6aAzr9B
         NXkGnLlhNY4iOpeJC5xI2N9HLneyH8xXFwhlSfG1t9BTa4l0W2UdBgFd2zrzrN4y9u0j
         jbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765691374; x=1766296174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+hDgRCphZ8iRo09ep5SU5olQTYl13jEHMw2TZJC3PDk=;
        b=rghMt76oOytrccnISVBIyyA3ZfIAKiI2QiwWNdMY9iazdRcehcfNLTeH7G5TSRccvN
         nmjLsVXT9VyfqYxhz5bnBw4yMr9cMPIgj+2a56XH1wlwGHpgsdG/KvDkSKDRR7NzCvCW
         qDJzwaO+455q7vj0wk7Ostnk9qRVS8hRCD1MJxkyhzs4RaDLkTYaKEM7WKyriTIFE9MS
         cOGEEtOGTZc9JFU5wQMPjh6MAN9m4nkxjqSSQ5BMucvdjJslVfJWDXIqkF9XPxi2cKui
         Wad+6DbgP8zC+Zs6mxOnf6LhEmbpHfNJwOZecbSkbWghdYr1/X6N/L1XrLVQZEMp41mr
         d4sA==
X-Forwarded-Encrypted: i=1; AJvYcCUdY3tLdp0ZTKr+IViV+xJZOLjIQfgXWvHuH0TR7VT3ATMBNyKCcj5lfO904gcS4GqbrpSxIns6bAHWWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Dz4B6iH/YaEwjttGL1gm4Xa5svizWZfWPrA8Rj0zLA9YEl95
	meHxr8Yn7nfUprHxfPyHMeWKKyXGk0C/VwSkLaz2eFJiGAENIlsUWCXIuko6A2yX
X-Gm-Gg: AY/fxX7AoR7IzsooKFSNzLAWdsBCpTfP2U6u9ZOChTynusJvG5eY3ZnHmn3AmdBeRAc
	HxDPiIvK8aalYaTuwrVNPQxxN05/75JAblKfkAYehOx5bOSdMAt+xv0U4dTKhDWLpAeN3Hks2nI
	NoxSkE+mmzSmBSXWz0Wrpjvj8KUmran5g0ykHgn4IrMvdkZB0pmbO3fSF4qLZfaqzmAS+O/5zQl
	r3/7hBqyp/FJ6kJjDsnaKXy+sxW220axvgg0j67ztCcQkZuEzH8/yPlPF2WeK4peNRWPZTC0N0d
	hTYjdRzRFIpHxFFlLHGxZ/3o7ogbPW47bIA/+u06HRYn+6MS9Uc5WZxwXihN7X8kA8AmDfwtKjd
	fRX0/q1Y+XH1zvTXxihLmBGFmnd+P+8Lqf9v0GMzNuxtwWaMsxX9MBVo084mBM/yrXZAxNkB5QG
	4M2rNCVUMr9Ce0bQKL34c=
X-Google-Smtp-Source: AGHT+IHbBmMzxC9eOq1PBy6WNwWJgWsq6/i6rrCnGtJaL5axAS1lDM+WDsS6C+/2vxsP07EACEoEbg==
X-Received: by 2002:a17:903:120e:b0:295:24ab:fb06 with SMTP id d9443c01a7336-29f23b7620amr74234765ad.22.1765691373802;
        Sat, 13 Dec 2025 21:49:33 -0800 (PST)
Received: from LilGuy ([2409:40c2:105b:dc88:1107:395c:23c0:2b1b])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29ee9d38adcsm97224455ad.30.2025.12.13.21.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 21:49:33 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: sam@ravnborg.org
Cc: Frank.Li@nxp.com,
	akpm@linux-foundation.org,
	david.hunter.linux@gmail.com,
	deller@gmx.de,
	donettom@linux.ibm.com,
	dri-devel@lists.freedesktop.org,
	hverkuil+cisco@kernel.org,
	kees@kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nicolas.dufresne@collabora.com,
	rongqianfeng@vivo.com,
	skhan@linuxfoundation.org,
	swarajgaikwad1925@gmail.com,
	vivek.kasireddy@intel.com,
	ydirson@free.fr,
	ziy@nvidia.com
Subject: Re: [PATCH v2] fbdev: arkfb: Request legacy VGA I/O region
Date: Sun, 14 Dec 2025 11:19:14 +0000
Message-ID: <20251214111914.4976-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251213223850.GA419250@ravnborg.org>
References: <20251213223850.GA419250@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sam,

Thanks for the review.

You are right that the cast to (void __iomem *) makes it look like memory,
but the resource is explicitly initialized as I/O ports a few lines earlier:

    vga_res.flags = IORESOURCE_IO;

Since the resource flag is IORESOURCE_IO (targeting the legacy VGA ports),
I used devm_request_region() instead of devm_request_mem_region().

Best regards,
Swaraj
