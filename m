Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3C17C228
	for <linux-fbdev@vger.kernel.org>; Tue, 10 Sep 2024 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952965; cv=none; b=SZIb1oIPdKvoPjYmbYjLn6lxojPs6qekmCLBAYnS5DqryFUThI0pQdKtEM5Qo7rZ9VbEOexJktKNgg8TkkFY9yxOZvI7VOO7fIAiGL6N8rKybpqNLVWFeJ14aNBxmfK1+ig9gG6kXDguFx58/jyHF4Dc8cv7NMdtDIy85FowHvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952965; c=relaxed/simple;
	bh=SpCPdaf+rqMdpwxcYuM94rsX5LB7bRciqtjUhbHrjD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMWoSzTJy8yfvWE32AM0NajfcSpB8myHEIsSVi8WvF+YNLcPIkuaym+xKOKJjVEXTvbvfUcN43E2OoEHs82JJz44fCnghcEuybTRb5c1ZQ2tueZtafOu5nMh24lH3HEsbi10+d4NeqV9l851IZtluQovPLnFLRkrpbBqOGinUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=LvOXJ2qr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="LvOXJ2qr"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d4979b843so318889466b.3
        for <linux-fbdev@vger.kernel.org>; Tue, 10 Sep 2024 00:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1725952961; x=1726557761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t2XzcGJ9CHpUVmI2Qjvu0h7RfZYDHRIyC3QcUD62zzQ=;
        b=LvOXJ2qr5ODsTpwKsXlIRZU7PeIiZwaWcry5ekJS+bAAOYKW5lmGZ9gYKZhx863r28
         WKMnifGvNErZ5E++Jv3RpBKJhFsc3t2jr2wwK1pSGzMQ1Aw7HHJaP/g1Rb8FuvFEYvwi
         h5Czfg61LE8Ey4yXTmPMmakcESDpiocl7TECM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725952961; x=1726557761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2XzcGJ9CHpUVmI2Qjvu0h7RfZYDHRIyC3QcUD62zzQ=;
        b=tzR7B2wqUpN0Ptt8HYhNXFmZS6B53tVicznK7IAgXgEMhxyicmwNv/akxt+UTYTZ6E
         t2sdVR/39VHDuJuJHAYNuzeFPpJv7T9qfFXwPvLZgIWR9fRCe3nQBJ0WPNVI9ZbN116t
         fGhdgJafRcjhVrJILrgxxq2Qrol0s9mZ+olyXHD2UglHIzXOJCF/ZkiM5KTMpkG60ObC
         TSHoFCyI7Jcb5FHiGUVS9AUH2P+CukIK0q/U6TXdnqUNOBXrWfc5OOZ6vIZfler7Ao9Y
         3KMyn4lFM46x+dPrzcYsbFjo5ju6cwVHwSSpKSyA3hYNEH24NEE4GXYOJTR/GDqZMf+Z
         bMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuQuuBppwtSBadSSn/Zj8HcWpcTUq+XwwclxHKevYr0wuylr/BgKKJ0QZXfAEYAbqxQXaDBlX7ef7sdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8ndUyo9J4dTdSUxyVXjm0LMpPxHI/vCLcmeF51GD5jz0cH6y
	rV7Uyo2+/yHXHdvpvAjm2sLQ4fbwUsa82KtKRP/vgI1IGTzeqgxjsbL4SGQNd/E=
X-Google-Smtp-Source: AGHT+IEguAdmxCBaR1QB8kCKr4wvM2lfEhrwmL0iuSI4thRN/LxomXCTbP9/stpoAL4vqJLfL4K0dw==
X-Received: by 2002:a17:907:3a96:b0:a8b:154b:7649 with SMTP id a640c23a62f3a-a8b154b790dmr817815766b.15.1725952959944;
        Tue, 10 Sep 2024 00:22:39 -0700 (PDT)
Received: from localhost ([213.195.124.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ce9277sm447915066b.149.2024.09.10.00.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:22:39 -0700 (PDT)
Date: Tue, 10 Sep 2024 09:22:38 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
	Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
	xen-devel@lists.xenproject.org,
	Jason Andryuk <jason.andryuk@amd.com>,
	Arthur Borsboom <arthurborsboom@gmail.com>, stable@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev/xen-fbfront: Assign fb_info->device
Message-ID: <Zt_zvt3VXwim_DwS@macbook.local>
References: <20240910020919.5757-1-jandryuk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910020919.5757-1-jandryuk@gmail.com>

On Mon, Sep 09, 2024 at 10:09:16PM -0400, Jason Andryuk wrote:
> From: Jason Andryuk <jason.andryuk@amd.com>
> 
> Probing xen-fbfront faults in video_is_primary_device().  The passed-in
> struct device is NULL since xen-fbfront doesn't assign it and the
> memory is kzalloc()-ed.  Assign fb_info->device to avoid this.
> 
> This was exposed by the conversion of fb_is_primary_device() to
> video_is_primary_device() which dropped a NULL check for struct device.
> 
> Fixes: f178e96de7f0 ("arch: Remove struct fb_info from video helpers")
> Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> Closes: https://lore.kernel.org/xen-devel/CALUcmUncX=LkXWeiSiTKsDY-cOe8QksWhFvcCneOKfrKd0ZajA@mail.gmail.com/
> Tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
> CC: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

> ---
> The other option would be to re-instate the NULL check in
> video_is_primary_device()

I do think this is needed, or at least an explanation.  The commit
message in f178e96de7f0 doesn't mention anything about
video_is_primary_device() not allowing being passed a NULL device
(like it was possible with fb_is_primary_device()).

Otherwise callers of video_is_primary_device() would need to be
adjusted to check for device != NULL.

Thanks, Roger.
