Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170103932E4
	for <linux-fbdev@vger.kernel.org>; Wed, 22 Jul 2026 03:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692699; cv=none; b=uCX6ieFAK/SCvN//PmzfEAjrEGHr6shoz2ti441n+cgsE4pPx/1gT7DN+2cv9ZjH6itWeQN6dthSYKLQ7FRHoa9o0kj9KlfO03SdHwiDejxMSGDgO0Y4KS7X+zTcmiafULGio/bazcvqF50slStc/8Zm1YQgpdk1nJW8uRYSPUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692699; c=relaxed/simple;
	bh=Cte+u9tH8fCR/6ttNQaKQJ6a1hf+2lqW1U/FDUKfMcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVuiPsigLfi6N47LymCUC01qlX5mdvHD5LeGpj2j/Z7hc3/wuXgKH1GnAMXz2Q16hZyVCPiukogY5TQv3eHOEw+dF4bdk0alExAGO/NiX09Q96UJlFd3lSJTfWupbVTwHRCZEUT1qz3kbeyMAcYUs555psxkDTM9joTmgv0w3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nw5zy9/9; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nw5zy9/9"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e6a434cabso651828785a.1
        for <linux-fbdev@vger.kernel.org>; Tue, 21 Jul 2026 20:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784692697; x=1785297497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0jeICyQW2fPpNALJsCTGYlCb9AbcZZPQ0wg+u4yTtyc=;
        b=Nw5zy9/9frt67p3YLOOCGI0qskLaHaA6gYXsPzs90wZedY0IJcCqfddHGsDRIPVAwD
         r05oqWN2ZawTv1wAJM+wSp5DHKH4E5wdxkTaUTHNQ7NA7mpPdFEuMgS98feDO+dxGvU1
         dOvYDISsK/UjbhSAnB188aAbRon1RiE6tEEoL8qwHimlFs9iZCqqUVUdoQYvE+PK+n2I
         2VbiUZzkYK7uVhk9ncYWuO7XUl8Try1mJdaTlHdAG89mBhHu85dqWqtzUQBgkdw5yDCM
         sTttZ7UD6G8yvw844UXqQcFbGn1rdW13F822BxEkSgdClVwECGMPBOMHAvkEtab5n3Ls
         qLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784692697; x=1785297497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0jeICyQW2fPpNALJsCTGYlCb9AbcZZPQ0wg+u4yTtyc=;
        b=H0+RX3FWJiA6gDyzphVoAuGCr0c1XvnHAJWkydteYFykOjPlDMeeItjvKCNXPrrY39
         wEHjtCXOA6vOVF2426iLE1OqHcRTkGP6bof9Y0i0/YENWHeFYDSYv1b9JGtIcDGgSDGW
         5WXx+tqC0hWGYseCXfIx/n6ML7NYtrx0kZkIPT2V+nz/gbRqTANmaKjNkW8TyeYBryvi
         lGZEwlTMgRIlxyfAd59ZmFq7BM79UVZV/SvRfRVb4TSgNJFHHOFFNuTZk+9nEW4b1LNf
         fLjU0uSOop8PVUP7FM/e5rxJVFyRHvPOdS7fsN31UK1rf69kZS3T0xB1bVWD/Yt4fs6Y
         ulPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpL0pAPywlsF4MhDg/zNfcBTYgPU1k73MQsuyWz2EFAAEi4O/CNVv+tNP7c6Mu/O9ocVN1fF29+CFx+UA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVYXsW9CzokzcYBCbs+OMSn38hU/5iZKBFkee2EYcIZKvpCLMt
	KQb+ioN7LrqI/7nIYGCsfNGUosS/3Ga6Yk/YSA+T/hT021SnjEVadE62
X-Gm-Gg: AR+sD12oLw44gFriyl7/x4kQebTR1gDmI83UuHcD9UMjwVccWB09P3Dd+dq0pCaJLl9
	dq9ZDsKu0f7AdO9BiZVkGdlxXB/QlDttiM0P8tGR64eTCUmduUSbx0Y1OA6EsYxfuMUC/JkrCq4
	VQ14CDa0lVTRF6XFs4PyIniQ/XAMwr78MvHr5xPFRnLxuIR9VdRE9RkbrYXzt17slF2BQazJ19O
	NdvnhWX79AMOdRZDFyXBkscXz2qfYMcqkFfAykpVfBKEydL8Akr+1Wo5AAMwy8wHmdCUzrGGdVZ
	T2UMbsFmZyuyCo9QApZ+AQxp2PxQchj27UmTtxh8gSeX8cgKpqoujNSkwtMvvRSY/w+g4QO1alf
	xFQILaQyBzrIE4xVSMZYlbuhmle/tMit26teBTPrutNJpd8wO8dlGNUdtljbuHMhdhFzrxhTpu7
	pJXhCvNrwl0qtZpYdQ5WVEwOmntEXqhSMLB2xlQOJHsZhL/Sy+Q2Rd1Q==
X-Received: by 2002:a05:620a:1a1b:b0:92e:cd21:447c with SMTP id af79cd13be357-930b3f3e243mr2072924785a.38.1784692696928;
        Tue, 21 Jul 2026 20:58:16 -0700 (PDT)
Received: from thinker (syn-072-043-128-189.biz.spectrum.com. [72.43.128.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f68c67d6sm65916085a.17.2026.07.21.20.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 20:58:16 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: airlied@gmail.com,
	andy@kernel.org,
	azuddinadam@gmail.com,
	chintanlike@gmail.com,
	conor+dt@kernel.org,
	deller@gmx.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	gregkh@linuxfoundation.org,
	javierm@redhat.com,
	krzk+dt@kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	robh@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de
Subject: Re: [PATCH v3 3/3] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Date: Wed, 22 Jul 2026 06:57:31 +0300
Message-ID: <20260722035734.14981-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <alil0p_s9-dM9j_t@ashevche-desk.local>
References: 
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

>>  	{ "ssd1327", SSD1327_ID },
>>  	/* ssd133x family */
>>  	{ "ssd1331", SSD1331_ID },
>> +	/* ssd135x family */
>> +	{ "ssd1351", SSD1351_ID },
>>  	{ /* sentinel */ }
>
> To avoid conflicts it's better to convert this ID table to use C99 initialisers
> (so Uwe will be happy).

No problem, adding a designated patch to v4.

-- 
Thanks,
Amit
