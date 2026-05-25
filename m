Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650115ECCC
	for <linux-fbdev@vger.kernel.org>; Mon, 25 May 2026 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779696119; cv=none; b=Y6VG0VrV6NBYjj/MlJkMparzSTduLfIgJkATB9Tk/DK16WhZsndqyjRwwYHXpS+KnN1gXnoTNn04kUuXmHSiCs210KSC+dpdMOjl2SrI6TlzzW0BdFc+DJryQpopfe9ZK1ENg1f24L67eENfTwCr7uePEB+1WfZGIt0QyNPSCr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779696119; c=relaxed/simple;
	bh=gxT0mGEGc0x6fTOQayF1sxxS6ki972VUL7prsGHTFzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxgR7Gi9W/qh6zPtqZldlW75uyPo1tTMgFuN3u6zKHmLV4mdFQ6rOs1JhLPAThmClxKRLWsj+I6VJ+VXUb1APtLxD6Aop6l134QEF3d7OAeP0PNwb4/vPlTe8jY6aaAMCwhpOsWZ9XLJ0ridmDoWXaYmYI5oYtkju/C5vUIMkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xjtxc7v2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xjtxc7v2"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45d96d21e82so5062516f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 25 May 2026 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779696117; x=1780300917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HALvVAGVZpW4SFGgUWC1AAMHEQ6arvLYXGA0/5eX59E=;
        b=Xjtxc7v2QV64N3trAaZiDtBoLsQCScm4uAWpxo9atpqMak0HVRBIzv+6peROQXFimy
         BH1tHuh6ovX+i5qXV6VBCO/lt3XbLApJUX8BZ4H4SVMCU/mdyBSe8cTvwMYm8/F2E04X
         42Nnlhpnir+hmnTl9psoba79/ug8LL1MG9JbN+WDDNmvupbFmKU51YCxqLsM4FuFiP7a
         H1MEjWJcPNOrO3eN+aNEX4vKYq8vgpLzb0jvdVNRwoRXF5lYXaeVrlMzZxfI2UO1KCwi
         DYmo+uzoOwQmhrCiVOm2cgjROHavAVverL8zwtQXsqQxL+EMim7RK53+1sOi5b74tWUd
         6nNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779696117; x=1780300917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HALvVAGVZpW4SFGgUWC1AAMHEQ6arvLYXGA0/5eX59E=;
        b=VAfdFRhogmS8HqjPPLbbGFZ5CegSjf0uStQSMHBvnsSM4+e+Bc4iFJRuvRR+4kHLAU
         aeRJyT4bEcV/W0qYJQBfmgcaho3fF3Vsaya3EdQ3sgSS3muu6NYqT+P5meKOTyITajjV
         iLlbHK0U75cRrCIO+I6+lEmspbpIumcU3lLmRRDUAnY8IUHXjZZyn/hm0pE0B0jcyWPl
         hhLcfMS2YZU35T+3PBjYGqbqnpv/WzI/UMAYCO3iEkMaPMwG2fevdXMT6AFdw8sWv7u/
         ORwUFwaM4/ZVPY1xD49IND9hdP49Ex5xdMdNAAuoCAY6s6qzEtOVHzxYa2BAj9H93C+a
         4uog==
X-Forwarded-Encrypted: i=1; AFNElJ/B8pyjboCPBraH4Qa0NlQ9THj64+P+Y+6xsxBVETw4dXsiyBA0I64AN9DfxRqkTTlW5ey+VsIi4u81RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Q6IG3cwPOJzAJTBVTe7B1mQIPZ1qUpYK7obfPoRHL3Vq2RRl
	K8DPz2TZPlp1Nrzb4JWMosZgwKSigkuvvJBGTu6Sdvqz1B/DytAEYLPsO9Hplw==
X-Gm-Gg: Acq92OEI5yzrWb8JgfSJi4fmWeHzxlrHtXFYkM/QmQqWoMtxyADCS0ukBYbeoqh1yF/
	qGj99k8Ygz6VcEcr6oUStTdH90uan6AGdzX5MlWROwG484OJM98lpJsG6uYg/rpHeswW6Nm4oNt
	AnzCcYbv2oSR4BzHgrAPlvu+C6MPNm2EHAJWRDvsnna7AxN394vXiLyY05S40Ss1RyRysdlH9tK
	+/bPT9P3nraicJzX0V/WUQKQzpHaYwENUNnIYSrQKfn9WwaA2hfIyvwHfLcp37soiSabAJ2Iffq
	l5/2v1LNnWh0gpyxzyfLlZCqoVxWrVBgeoHuo/ni/LoiJOICGkCaf4TttvOXlDiMacE5sO96jnV
	+dg10TiTkJDyieUJxA42ojWl6RWlITA6qQ13J416PkmhGzkWq6Jg/308eyiXcR9rvfy9gMVDErF
	ukXaB/2/MgmLI4pemxfxmjOeA=
X-Received: by 2002:a05:6000:388:b0:43e:a9ba:b194 with SMTP id ffacd0b85a97d-45eb38acbc6mr19616507f8f.34.1779696116400;
        Mon, 25 May 2026 01:01:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9b980sm23029778f8f.3.2026.05.25.01.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 01:01:55 -0700 (PDT)
Date: Mon, 25 May 2026 11:01:52 +0300
From: Dan Carpenter <error27@gmail.com>
To: Ahmet Sezgin Duran <ahmet@sezginduran.net>
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] staging: sm750fb: deduplicate fbinfo loop in
 suspend/resume
Message-ID: <ahQB8C1gTr7LF0FO@stanley.mountain>
References: <20260523051509.166152-1-ahmet@sezginduran.net>
 <20260523051509.166152-6-ahmet@sezginduran.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523051509.166152-6-ahmet@sezginduran.net>

I was waiting to see if anyone had other comments bout this patchset
to decide if I should mention these minor nits.  But then I was
confused about v2 so I think there might end up being comments... :P

On Sat, May 23, 2026 at 05:15:09AM +0000, Ahmet Sezgin Duran wrote:
> @@ -388,18 +388,18 @@ static int __maybe_unused lynxfb_suspend(struct device *dev)
>  {
>  	struct fb_info *info;
>  	struct sm750_dev *sm750_dev;
> +	int i;
>  
>  	sm750_dev = dev_get_drvdata(dev);
>  
>  	console_lock();
> -	info = sm750_dev->fbinfo[0];
> -	if (info)
> -		/* 1 means do suspend */
> -		fb_set_suspend(info, 1);
> -	info = sm750_dev->fbinfo[1];
> -	if (info)
> -		/* 1 means do suspend */
> -		fb_set_suspend(info, 1);
> +
> +	for (i = 0; i < sm750_dev->fb_count; i++) {
> +		info = sm750_dev->fbinfo[i];
> +		if (info)
> +			/* 1 means do suspend */
> +			fb_set_suspend(info, 1);

You didn't introduce this, but the rule is the multi-line indents get
curly braces for readabilitly even if they're not required.

> +	}
>  
>  	console_unlock();
>  	return 0;
> @@ -414,6 +414,7 @@ static int __maybe_unused lynxfb_resume(struct device *dev)
>  	struct lynxfb_par *par;
>  	struct lynxfb_crtc *crtc;
>  	struct lynx_cursor *cursor;
> +	int i;
>  
>  	sm750_dev = pci_get_drvdata(pdev);
>  
> @@ -421,21 +422,12 @@ static int __maybe_unused lynxfb_resume(struct device *dev)
>  
>  	hw_sm750_inithw(sm750_dev, pdev);
>  
> -	info = sm750_dev->fbinfo[0];
> -
> -	if (info) {
> -		par = info->par;
> -		crtc = &par->crtc;
> -		cursor = &crtc->cursor;
> -		memset_io(cursor->vstart, 0x0, cursor->size);
> -		memset_io(crtc->v_screen, 0x0, crtc->vidmem_size);
> -		lynxfb_ops_set_par(info);
> -		fb_set_suspend(info, 0);
> -	}
> +	for (i = 0; i < sm750_dev->fb_count; i++) {
> +		info = sm750_dev->fbinfo[i];
>  

Better to delete this blank line so the NULL check is next to the
assignment.

regards,
dan carpenter

> -	info = sm750_dev->fbinfo[1];
> +		if (!info)
> +			continue;
>  
> -	if (info) {
>  		par = info->par;
>  		crtc = &par->crtc;
>  		cursor = &crtc->cursor;

