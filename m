Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1881A727B
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Sep 2024 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187706; cv=none; b=cPaOtLUVhsbu5HptCgrmLc1xbVcGSByum8hre83VIhmJ0P1CrXQvHL7E4uQNcY0JxCqJAVbNjD9gHPchM0EwCFVE4LLnQjzEnGJJC5kGMbyLjqf+d4najYK8y4qiltE4JiVTlDglZaNLadwPnXvKUCbgdaVH+TyBfBypZ234q5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187706; c=relaxed/simple;
	bh=0jE7zZ9Kb07Sa2ZoNKVf4bA2466TM5Ueea7F/IGYDa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu/796nX8HL86Uj76GkE1Alc+1cJNKtV4HVhSO/R+4bO2C8bKIbjBTyN2hQuJd6QQ3gDesVckU6NaR3pp7mbDEZ8G2qelEkuZvMdj4zVHac+pBKBVYLsSLFGK/3mTvxTmyygfVSeULQ/jYAaKSWE1KjmbOtfveAPyiFofvkCp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dI7Zw2tN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dI7Zw2tN"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-535dc4ec181so5556992e87.3
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Sep 2024 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727187703; x=1727792503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APtwNX4goi3YuxtkCvF33AuyhynT4SX43dIq2QZAR1c=;
        b=dI7Zw2tNFkfdiUzXIWFN+vF2PVKBIWxuC61z466ElJDPQMZoewpslBbL1f8kFGUPHN
         rzRlauRfp7h85XJVIeNWLIQF1+NjDRCoK6dJJwiSNURbR512Lpmx7x5VgSTZxZzC6Jmm
         3V3mLENOIrlawviVa71KWEU7YAZ5ws0RaMe8+HIvx9xJbx/p7NuDPYo8/VGDNelqM7Xj
         /bl19aMmNO3ZWwj/maEbDZZnaWuGszs0ca+uQSHca3PLRqiXnUXAzWd7Amk3h/tW+s1B
         sHs4ipLZdybTwWGPCj9dloeSPfz1OfhhqkiY6tzZDwl14GZlUh9C4OLm7TFxtT/TrGzJ
         FNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727187703; x=1727792503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APtwNX4goi3YuxtkCvF33AuyhynT4SX43dIq2QZAR1c=;
        b=HhqpMwrXFeLnih8dvlhldpytXuQDR85xKw3z97mSszZhuSrt1puSSqg5/Huv3dUhPB
         WR7qpJVxRkykd8JPW07/cOWMuc18neeHxUTkCwj+Ola7U3cXGuoehjG7jW2pemJUVTmv
         Y2ezVG4YwkWyWG/KADeqMhIReaoHgcYlZPqqBmgm/5zt7DbJydFs/YjlVxmLJQ0HFYBx
         21ofgZccsp5dY53tt/WLX8b9De59IArLW+vJUCQOPpCjfFMFmQnk/2EcjxvDmPI1BU60
         1KBWeQsCGgm3pgTio7QWaeAyOyQZOgHruGZej0jnGNbAwPuZR6tITgcyRdcFXgaxBq7N
         +NTw==
X-Forwarded-Encrypted: i=1; AJvYcCWHru9kULQnUYjos23P8lH94FvVob1VpW2+3hucadE4q5Zt/KgWFz/jHtKwfkIfOElhN9q5gsLTd7RbVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YytpcCe7xRiQuJ68TytNr4eyphFA+E9NRGcvtuIE6NO2U22VsMI
	SaALrQ4yuzrKdNzdYHfeLO0WVQZG9D4437RKb/hRpvXNr+7SBzLG6idi114w/WE=
X-Google-Smtp-Source: AGHT+IGZ7j8dNC9vmJkw2CsVcVLyyFojx36RieimtO9D6Pm1dMVRIcFmkD/e9Y2L8+9PptcHq88tQA==
X-Received: by 2002:a05:6512:104c:b0:533:46cc:a71e with SMTP id 2adb3069b0e04-536ad3eb9d1mr9233953e87.54.1727187703078;
        Tue, 24 Sep 2024 07:21:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85ee5a1sm244879e87.83.2024.09.24.07.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 07:21:41 -0700 (PDT)
Date: Tue, 24 Sep 2024 17:21:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, 
	Derek Foreman <derek.foreman@collabora.com>, kernel@collabora.com, Jani Nikula <jani.nikula@linux.intel.com>, 
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4] drm/connector: hdmi: Fix writing Dynamic Range
 Mastering infoframes
Message-ID: <adsevd7dledyzrbe6smq7d7cnqiodinprsj3jul4i4nd4gc2p4@dzyvhhktsrut>
References: <20240827163918.48160-1-derek.foreman@collabora.com>
 <172718718877.90582.18381097503447839347.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172718718877.90582.18381097503447839347.b4-ty@kernel.org>

On Tue, Sep 24, 2024 at 04:13:08PM GMT, Maxime Ripard wrote:
> On Tue, 27 Aug 2024 11:39:04 -0500, Derek Foreman wrote:
> > The largest infoframe we create is the DRM (Dynamic Range Mastering)
> > infoframe which is 26 bytes + a 4 byte header, for a total of 30
> > bytes.
> > 
> > With HDMI_MAX_INFOFRAME_SIZE set to 29 bytes, as it is now, we
> > allocate too little space to pack a DRM infoframe in
> > write_device_infoframe(), leading to an ENOSPC return from
> > hdmi_infoframe_pack(), and never calling the connector's
> > write_infoframe() vfunc.
> > 
> > [...]
> 
> Applied to misc/kernel.git (drm-misc-fixes).

With an empty line between Fixes and the rest of the tags :-(

> 
> Thanks!
> Maxime
> 

-- 
With best wishes
Dmitry
