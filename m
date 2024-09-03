Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866813D518
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Sep 2024 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375495; cv=none; b=qEbDZ3eGHdVMwHsk6mbBkmRJdPzvZxVsCNe+AfmZJ6Z96G4qrUqjokSGWUEwb9QgBLYB2NuKq8WC1vbS58bkSe1S34VaYdpOxV3WjnqjbPi1jxIpWUUgRFENtLGJsdsxRmcsXhupbsIVqS0Vx5M49MLNz6zA1IR3hEDLcefTRRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375495; c=relaxed/simple;
	bh=bSPA4XGA/HMWn0mqAHl9enAU4Xta3+rBwl0NslhmQ4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKvrY2nQJQtn+aqI7zfU9sLSYyBuucZmChoLDQVmPT4fAaH7WnaYguFHRj/A9cQxdS+crM1mdlKLVzUXA8lQpwzS5t3UFHcldlk+q8dJbzdbm1DVio2yLWQVYgGLYE0WxYLkfeKkyqmc92Qcb1glfdXibYFKRjSEOyWwSC5Am50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lIyRFw1l; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIyRFw1l"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86fa3dea99so297048166b.2
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Sep 2024 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725375492; x=1725980292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bSPA4XGA/HMWn0mqAHl9enAU4Xta3+rBwl0NslhmQ4o=;
        b=lIyRFw1lLt1N4KBYLJe4r4S45HgeBfbcNLAEnh2gs0MOk+2TQuPfRXERT3FH7Kprqn
         kXi5jJwKLU1Ze3viAkY6kig3nODZfR8ErkYVm3jr3kYY9vO3xYC6jIOm2Conye6hEXQ1
         5HzEn6/OpwfI0BhDPklgGJd3RSB/Kpgzs0Q2LdcBKth1ZY4wTExZjIow8SawSf1NSTUG
         Qo4UBCrzicIfZAh5Ves5Ly5Y3b7iY7TMad4N7KowngST5vhQkrRrLMzSkR5xuhhxyXVo
         IauuuUfuuq8AarSjj6/7Ljii1r2DwfRLitBogN3Snho1JACUANYX1f8Qsf5tpU9zo3Yd
         I+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725375492; x=1725980292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSPA4XGA/HMWn0mqAHl9enAU4Xta3+rBwl0NslhmQ4o=;
        b=lxjp/zMlP/x/KunaPavhC11SAgK0AVvecLze5Y4+oz0b0JlemSLbz/I/e4oWseEgnf
         uDABuOggr6KN13o+GfqD1lutBPV+7bqrh/vw2mQ9S2g+0uWSU46VW61J9U7FK6vX86RI
         TX2ReiwitDvPCR4UpVMzss6HNW00ffCTPQ771QOFiczP2MsNAgC7gYEFQgdzoB2J3CbT
         ang0FG/LUfNpQQZJhr4ftrNJRKs7RrA5Gb+otxtwCRdwR8WJQFfnlVdvXOa5KvU6SpFp
         kdwnPowsgiz8S9PubfL+QrRE16oEPPo+ym2TrkHe9b9H3Pac9wrcBIoUhOMS1+hhqHtd
         RLTg==
X-Forwarded-Encrypted: i=1; AJvYcCU7tOfjdlC1alelsAZ84gd7463VpTvwhy9Jn4tDJySr80nSsEs/wNoDq8bJDqGSk3j/TemWfiixYr98Cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQTjbKjLD7aM0ry7PofT4/bC2b0YLZhRi61SrkBXMZ2s+mRQB
	my7iK2Pvmp4EQptxvGHFPipYxHd3wvCOQha4Q/8omjm5oTPr8MvYgew5/I+Mo0g=
X-Google-Smtp-Source: AGHT+IHDyxRfrNtN1k34SW/ZwHHE7I+ng+iaoDNfy1kS+LWoqGSB0gPz+2XnTlBVg8+KYaoyIzNkPA==
X-Received: by 2002:a05:6402:40ca:b0:5be:9bc5:f6b4 with SMTP id 4fb4d7f45d1cf-5c21ed315fbmr18026702a12.8.1725375491662;
        Tue, 03 Sep 2024 07:58:11 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c24ff04551sm3631120a12.35.2024.09.03.07.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:58:11 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:58:09 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	bonbons@linux-vserver.org, jikos@kernel.org, bentiss@kernel.org,
	shc_work@mail.ru, s.hauer@pengutronix.de, kernel@pengutronix.de,
	shawnguo@kernel.org, festevam@gmail.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 00/28] backlight: lcd: Remove fbdev dependencies
Message-ID: <20240903145809.GE12939@aspen.lan>
References: <20240820093452.68270-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820093452.68270-1-tzimmermann@suse.de>

On Tue, Aug 20, 2024 at 11:22:38AM +0200, Thomas Zimmermann wrote:
> This series removes most dependencies on fbdev from the lcd subsystem
> and its drivers.
>
> Patches 1 to 3 rework the fbdev notifier, the fbdev's fb_info can
> now refer to a dedicated lcd device, and lcd defines constants for
> power states. These changes resemble similar changes to the backlight
> code.
>
> Patches 4 to 19 update lcd drivers to the new interfaces and perform
> minor cleanups during the process. Patches 20 to 24 update fbdev
> drivers and patch 25 updates the picolcd driver from the hid subsystem.
>
> Patches 25 to 28 finally clean up various lcd interfaces and files.
>
> This patchset is part of a larger effort to implement the lcd code
> without depending on fbdev. Similar patches have been sent out for
> the backlight subsystem, such as in [1] and [2].
>
> Hopefully this series can be merged at once through the lcd tree.
>
> [1] https://patchwork.freedesktop.org/series/129782/
> [2] https://patchwork.freedesktop.org/series/134718/

I shared a could of nitpicks. You can do what you like with them since
none are major enough to stop me also sharing a:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
