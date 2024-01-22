Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F723A1BE
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Jan 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920220; cv=none; b=Kvgu66Qy+ZkeuiFsWee9oV0+sJF3CY+mOjCguVPXRFEcNnWPfxrl8GAxHGt9iNiui9nWXJM+x2gtMlKM1APiaXJPBhfmOwRyxMvEZ4rqXO9J5KQKJ+O1Qwn3te4vfMweGy0U9J+ijY2SEWuGmyAt35Pm5ztLpbIpIf0ygTu2irk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920220; c=relaxed/simple;
	bh=SYImlEaJH/Jealdq0FPzHywiTrW4AlV0b9Sn8/s5j5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVEM1Odavxl2JsA7xOUvaSwRcMmyoIWsqZRWi0UbTdCtC4krB+ZG3Subib0Ihme7PZ7Bzq9y0PAO5K2+BURZnUv//kJm1/mt9Rzu06i1B+z94i7v2DGmE6Qc88YM+gmJzz8l6ARmEI3xw5hgZvPigugxx37UeSJJ2Tc3x5Emj7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qnX4o8CZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnX4o8CZ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40eab3912d5so10971215e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Jan 2024 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705920217; x=1706525017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mBWNCLLFubdT9fJ3cv8e16Ff7jYhvZKyENiuEu8Dr8s=;
        b=qnX4o8CZr21tY8pU730x+25Zw7BPm4w3XKVCxtmKCk3H3/frj3c+2UT0awZ7dg0AOp
         gCss1Kcg1DUXAA1C+u+C5HqkAlo6f5HLplnumd/F12/CLk08gypYvO2y0/vEwSUoXzjF
         gYt+LLnxcrYD4AnlxgWM58EmXRXop1SwUpJJhQQimC4NvB0vAeepY+1UbF7MJ2Cn48xG
         0bc0BLvM8QlcS1uo5CXF09whkBCyhICOYVBTJXBhRLTm5fwhPCZSRnWFfmtxw95jfICM
         5Sh17e2IhPvT//KSqcHBEY6ZApFKD6UPMSL99kZuWEtvVlBjDzkW8pEGA2YdR918R+ov
         HLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705920217; x=1706525017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBWNCLLFubdT9fJ3cv8e16Ff7jYhvZKyENiuEu8Dr8s=;
        b=tIkF9jLBCKzcIcwDrrBwhMbkwh4a6H+xcg2Cfut/PQaXiNV+J0NnKjmrnWYEs5b8se
         WrhstbFjdQhM8ZISDKLLhzPU5pOJx8R5ghYk52abbnYFIbVwua3YQgV7w8tDTsEU8sGU
         1tPCBBX29L+Cp+gFo6OReyfWW4AO3Oycp9cXb05ekPQNgNDa/F2iwsOdvcOegPLyY7Gh
         TlWQ/synSJfEqaCmta0UUWhTssLQHaJb/NChF5CHWPSmdYyXYTJPGzuLCnlR+IebNAue
         thWxpRZyHS81EOu28/W4zYkRIvX/dqycpP+HnnvJcijdkKlqLfFTiZihVYDexjRq1MrX
         9pew==
X-Gm-Message-State: AOJu0Yw4NHGQrrAhMzKbQyJTvGUwoSk7VcW0pm3l5actGxBwlaIzZQx7
	FlKVMox5T1UinSWPzdJe5d1PiSTnyFMMTwVQLyMkup/07IFKz5atCsxqOv/3J9jfKBEyjMIDi1o
	D/To=
X-Google-Smtp-Source: AGHT+IHzftdJu5Tfe2SF8LvabynhKKZASp+dGkCarsLc7Hm4XRhrssvAPcplXGyZx9jwYzzGDAuLwQ==
X-Received: by 2002:a05:600c:1d87:b0:40e:ae91:1d38 with SMTP id p7-20020a05600c1d8700b0040eae911d38mr512318wms.33.1705920217017;
        Mon, 22 Jan 2024 02:43:37 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040e3bdff98asm42176303wmn.23.2024.01.22.02.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:43:36 -0800 (PST)
Date: Mon, 22 Jan 2024 10:43:34 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 2/4] backlight: hx8357: Move OF table closer to its
 consumer
Message-ID: <20240122104334.GD8596@aspen.lan>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-3-andriy.shevchenko@linux.intel.com>
 <878r4rovk4.fsf@minerva.mail-host-address-is-not-set>
 <Za0g47CgOH4MhdRe@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za0g47CgOH4MhdRe@smile.fi.intel.com>

On Sun, Jan 21, 2024 at 03:49:23PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 15, 2024 at 09:22:19AM +0100, Javier Martinez Canillas wrote:
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>
> ...
>
> > > +	{}
> >
> > While at it, maybe add the { /* sentinel */ } convention to the last entry ?
>
> Maybe. Is it a common for this subsystem?

I'd answer that slightly differently. Backlight does not aspire to be
special regarding this sort of thing. If this pattern is becoming common
within the rest of the kernel then its absolutely fine to use it here!

There are certainly backlights that use this convention... although they
are not yet the majority.


Daniel.
