Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE6331961B
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Feb 2026 04:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772167873; cv=none; b=d+SADPiZC0kh4NW90VOpUWkmd+kMK8DgBHG/KITd9MmqLGNksqdMexYRtY7iRnVSdxrWdTtakDm1UAzmAPBEINCKnIx1gqrx2plgyxw38LRRTKUtUj7ZTzKaeDoP5TMhKEMcbfhH+C0uSn92wrKFArn2O3DwTEdzC2ktiSS0Q6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772167873; c=relaxed/simple;
	bh=88StybOU0Ec/gubmYbovd3Oc+JYBooELNU9E/jLothI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czPmrYVT4tC9WUDYfI2XYCTExrzdnczRtw18eBS/206xlkphyjRmErF0yyCxNqjoko+gVLd36Bh5VC8K1Bi8K+T3BBZhnfp6tMjPhlXOWnJyyQSv8BaCSPFVwWN2a3b4r4NecMufrTXmUfoT07cyuIO6YoWxcgRmc4ldtMotxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHSz3Ai8; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHSz3Ai8"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c6e1f417918so488659a12.3
        for <linux-fbdev@vger.kernel.org>; Thu, 26 Feb 2026 20:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772167872; x=1772772672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xlc5/wJcGMy2qVaQwNIPCexEitX/U5dL8H2UtAkaHiA=;
        b=ZHSz3Ai8dW4sXeDF8BiTiLSeykM3ndI1+v2jv/nv2cOr0zAcukIx6mWpYlbwo+kxci
         8AQSsXKasSgRy4BEbBGf8VW7/hH4Ax83PFNLfnxcjhLubD6RbyvFRrdvnAHYQEzvArHi
         mDXQiCoiTfYtuhHX018rk5NWcZXgyiXzXGSPL24mkjW5zZIWnTLBHRD5lpQBzIWe1Vnu
         DLe+3/spKXWi/pRR37WHDMMMZR4OArTOphb2JhQBaJyYMU0kxU2ZQ5ktDVYdLSxua1+x
         tRTG7lk7+bW1iDc22JQxrUNem2n8Hu+uif+JBCKA8YMbmEoSqfEKk3gI5n8uZ6Kh0Xyx
         gd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772167872; x=1772772672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xlc5/wJcGMy2qVaQwNIPCexEitX/U5dL8H2UtAkaHiA=;
        b=Tr6Hu05FEDdwCRD30jo9KrGWKdsMr+SVDEdrpH76jSEoAKEvuJz+G/Q7ZGlN3h8NkR
         OB8ce5USgmt1gXay2UKtp0gA/dVK+B48Rvxi4Dc7GPjDQAl9mfLcZSPm292auQEUKdg7
         UPkUtk8Qon+NJHBRhiZtFTXX8I7gv3mkItH08jLgJcUyUbpjTv/mIYepFwB4pXFWw/nw
         p4FsDnfuUXK0KUQdPo/Zf1dB9nNYL9j6SnvUWQaNG6vFV5CiWc7ztC910tmJ642dW0M4
         AAf3hPdfb9L3WkaR9t71UpVEvs9+3dZHkQ30Sg9m1semyObupuB/TFkf0QnVoQw+T2GL
         9Q3g==
X-Forwarded-Encrypted: i=1; AJvYcCUpkA63ZCzFcUyCdWS4jrnwYarYjfzW/tNVJRxaJbi9VJsagkQpFWEuSH6bNO/T5/LXZcDpJGK7yTBKpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfS76UJT9DUVoePCXSggxHfEaDBuRAuueLnpx2MAhHe1eOw4mc
	/x/7YNFG09kXnMTvqi5/YoA/qpwxLWUd5BhrKMoL/vdTrgFKck5FpbLS
X-Gm-Gg: ATEYQzyRAjvWu+786s1/Ss2/ygPIAN/uNJ1yvrLr5QBLWoUWx8Bkg3fBAFZS5eXhARY
	PXlYlSOfb04UeSEPnaH2YY27mAU42OyFw/8fFmafi0gIry5lTza2Bo26QSQ2kOldpsgRSwymr25
	tgaRZjMmQovVtkt3Cc1qDwTryzRN5DvaSpRqgFMhstJu5Z62kgxZrTfXq44ZM5UvuTnwerRXIWa
	THES2oBTrJmAOxOc7koy4RZK5gqHxNKRTO2Zl5KfjpCtCbceG1E/97s1diR/1OExwjCL7eBSVc6
	bQDb6zI7eqmTjSctIe+r38uhznRhgwxI/Cz6phgHCQ9v3sN1FbObqJEj3EI4AL68J4uKAvmqDhX
	Sn6zqCKUJxOzkVh2OobLj/d7ZRILVLEHbTVvvUbK4BQqTAdrvICUM3x9Q6yDRYd49jD+1Z8kH6r
	uvSu0JL4nbv1qqljbGr70wdF32+w==
X-Received: by 2002:a17:90b:2496:b0:354:ad98:7d1c with SMTP id 98e67ed59e1d1-35965c3cb32mr1089009a91.11.1772167871672;
        Thu, 26 Feb 2026 20:51:11 -0800 (PST)
Received: from latitude ([2401:4900:ae25:bd8:c189:b262:db26:b797])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dcc9c37sm3706534a91.8.2026.02.26.20.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:51:11 -0800 (PST)
Date: Fri, 27 Feb 2026 10:21:05 +0530
From: Dhyan K Prajapati <dhyan19022009@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Donenfeld <Jason@zx2c4.com>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix macro whitespace errors
Message-ID: <aaEiubs2v51xMmUN@latitude>
References: <20260226172531.13714-1-dhyan19022009@gmail.com>
 <aaCIqUXPB75vR6rK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aaCIqUXPB75vR6rK@smile.fi.intel.com>

On Thu, Feb 26, 2026 at 07:53:45PM +0200, Andy Shevchenko wrote:
>On Thu, Feb 26, 2026 at 10:55:31PM +0530, dhyan19022009@gmail.com wrote:
>>
>> Remove prohibited spaces before closing parentheses in macro calls in
>> fbtft-bus.c, reported by checkpatch.pl
>
>You haven't compiled this, have you?
>
>
>-- 
>With Best Regards,
>Andy Shevchenko
>
>

Hey, sorry I atleast should've checked the definition, i'll keep in mind
not to trust checkpatch.pl blindly
