Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA933C191
	for <linux-fbdev@vger.kernel.org>; Wed, 21 Jan 2026 02:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961759; cv=none; b=eQ6KFOKACaxCKiimkbJpFusUK8M3V2CoqkUA5Pye2xU5+nQBamxIsRAVpCPWsC0lepJZ3fJFNj5/niYoIrBdXPs5t0Eb0vVs1/suRkJKdOVvdgYngTI1D8/0UrLUIZYIwf5P6MzI0a2maE2EQPVcoVKkprlxXildOtk7jwqJrjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961759; c=relaxed/simple;
	bh=EiqxYFAKuDv/UY1/7/yWHVKgFO6ivnoIo7jCuJsb0po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUcqDdCwwAwC22vRtxBtNzv0n8QlDxTTShjDci3sLNxSvPKE1/bzGXS0buUPQtVO2hI0mwSYRe+mxTZoqpGqM0hjnCbAxKVIuz3k2CN6XojK3xpeGZb2ppfGRMhFRoq7pX1O8oZnZAv0MnuBL8g5AU2SMK1SdzQ5kQ+zmX2GjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKqBI4gY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKqBI4gY"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c56188aef06so2429724a12.2
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Jan 2026 18:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768961757; x=1769566557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBYj61sXNcZXb9zsbWXDZntUfG6O/Hy5NDGW/6P4u40=;
        b=LKqBI4gYZViIp/AyrM/140Th6+RN6hISQ8PzsDdgBrterxVfq56W8oF9/LtQUqFJuQ
         WZhxXH5R2suiUnje41NmrkWKEe6YXFlp4YImOX8RE4FzKvi/zG/WZO0e4Le7dmigIRWI
         L+qTlieQQDp1UiI1e0ZImAkuJxUtexuMx323k1rUlQ3byBX5J81H+u9JAIVD/hioVcuz
         xeNchi/9jnGUh0D3JzWUfkYbIA3DqNPgS9TV+L3Ek6rOmCdGFhdp5h6myoPqM/W3B0cu
         h6A/xMwHOv+gB783ua0A9m6dxoAQ70vhxaaTtzgr1e4ZqCSzNrBzI9T5Y59IotPZF7Ge
         yabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768961757; x=1769566557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBYj61sXNcZXb9zsbWXDZntUfG6O/Hy5NDGW/6P4u40=;
        b=LDXs0/4EM0WAUgSAR909YGJKhbn4ifrjUOVcEGE4chmbUCEDofJdVQHF2SYCLGnDBc
         M4GxgSLARZRYM04XBxSzVPvegozT67GEsgvMz9YOXJpkF4eLovDgOauySGKGFxl5rZiF
         fHUz1BuG69a68CLmyJmvx12StwvH2QY/Y8RfQ166HsCfIyk7HPzkuFak6fQVC4RWTg0A
         2hBGxnO3wY/e2xGE4Xcb6VPuAX3wlXkd6SYOXt4FcK3Tc2oGt8d5qPTRaNCh2k/YvULf
         +zPJ70IGo8QLfOaahWRc37QxK5CO9CmDOqGabQRGkgbr8T95TbF2njje3rUWnkDwS6bR
         emmg==
X-Gm-Message-State: AOJu0Yx/SZN2lnITksVsxS20MdRSY/5v6Q9+5SuBYt6emF7dp7GXqRoa
	39PIdxbu56WxIO19rMtCHEinCgBmn6Y6VR1yRspkePqb7jYIOXUGBZ/t
X-Gm-Gg: AZuq6aLMI7OsN9RyRTZGbbGhWBsM7xfXqZajfsrd4zcYIVlYQIjqvjTkF17RO3epdkY
	bWF3uO54d+9+Hsai6NvDrNx0MFvD3D5rsxhGJcpG4/aKhyHKp9MJ2mr+EN5vm6pJcrEr0R2Ze/F
	RNzzaUrs8AGMnYY2jwL20nGOubYQoaek30zKLeJwGMzAUL+58KJOw9fstUCCyk/Uk5BPvCJ/Kfc
	fP0+xMQyVknWjFY/zpggVZJtxVAt2xDOsJKkArx9TWdKenWqZmbOJBZNH1TpRCs98Ny+DkI7JCM
	LK60/Su4oIemOqrMjGkWFYly2nYoLewkUl1VZshDp2fyKS4BDSLGiD8LyjhiDTPBN8rafauIuUK
	wsp0Dz9KhTrrRb2Bu4ZuGykTUeYnaiFSXNt3yvddU1t20RbfCHct9u5AkAXni5qM+YyZo3TBx4O
	NyxgpxOL1VsX5Jhrcv8tbqf8LEM/BMJ1dOorlVWu/I/2fE7L06wkzbe/BaRPopausbZOWUH+Q=
X-Received: by 2002:a17:902:d48c:b0:2a0:823f:4da6 with SMTP id d9443c01a7336-2a7177da66dmr148370945ad.50.1768961757159;
        Tue, 20 Jan 2026 18:15:57 -0800 (PST)
Received: from ?IPV6:2601:1c0:5780:9200:cb0f:63ad:26a0:511b? ([2601:1c0:5780:9200:cb0f:63ad:26a0:511b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce4dfsm134107205ad.29.2026.01.20.18.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 18:15:56 -0800 (PST)
Message-ID: <aefd4942-41de-4e27-9777-aafff7b01aab@gmail.com>
Date: Tue, 20 Jan 2026 18:15:55 -0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] staging: fbtft: Make framebuffer registration
 message debug-only
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, tzimmermann@suse.de, andy@kernel.org,
 deller@gmx.de, gregkh@linuxfoundation.org
References: <20260117042931.6088-1-chintanlike@gmail.com>
 <20260117042931.6088-2-chintanlike@gmail.com>
 <aW3gCgB1YAsjuOZ7@smile.fi.intel.com>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <aW3gCgB1YAsjuOZ7@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/18/26 23:40, Andy Shevchenko wrote:
> On Fri, Jan 16, 2026 at 08:29:31PM -0800, Chintan Patel wrote:
>> The framebuffer registration message is informational only and not
>> useful during normal operation. Convert it to debug-level logging to
>> keep the driver quiet when working correctly.
> 
> Suggested-by: Greg ...?

Ahh.. thanks for pointing it out! Will send v8.

> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

