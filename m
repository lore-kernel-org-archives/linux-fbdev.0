Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864EB56440
	for <linux-fbdev@vger.kernel.org>; Sat,  3 Aug 2024 04:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659043; cv=none; b=ZAwTJgfpqMeuKhggGYd2e/gtZUJIqPLqmRadnfgnbT1CrUIZywJqZ5qrU/FArjmlKN3b3KBvFOHvY++o11F4UtyUqqtURnJAMogCbXgMfuufR7dQ5orok7OQyV56sZ2OTYAp3JGeC0K02IP8HGroxLdEYlHaQsmw4oWNzKfGMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659043; c=relaxed/simple;
	bh=Jp2OHDRssPjIQ+nSYXpj4QTUcyhYsJPhqr2EF2nlkHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu5xB/xdqi53++0Lz/88qokw2Jw/twIvx6JjBsrcZghTauXCeg6jH48RYnOKQKNTdWRxK5/aaGmb0nyYU5aqQKGXoSm5KwDR8TgAy8vzHLZh3/SUfpofxX0dKcgyWnCwj1pfBwIRyTxSfjS/XZR4ftpOl2Sx2J+dkGxQdREF1Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RsTZMESx; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RsTZMESx"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5aecbe0a9so5317876eaf.1
        for <linux-fbdev@vger.kernel.org>; Fri, 02 Aug 2024 21:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722659040; x=1723263840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XheisaESTEudpbi3rO/WWYBhJwYeNAh4Hr324gZmrNU=;
        b=RsTZMESx5/1aUoDOZcVxfMUW7jVNWAXeAhJvrczjWaCy95wuLtk7GGbK2W28WVTpdj
         USSEDA+KdTfVplzNHY8OCanLXzr51je1gqus0wskqxKPsY2ZRDrxrFmVPG/nq0XtPp9/
         CYNtZHrhkM8OjkFVa3zIVbzhcyLCOO2vZNMPjUtQX4GmLhw9+wpLC5e+PHiIloZkTBg5
         tLqYnahb7EvimxMdNKuQESeeGasPw+tM5uml67JAcp1+D1xJCvFy/9xxQpOVcgv/6ERZ
         /V8iJqB8TQtO1BCZmPtJYXnYkLEGELFQ6xMC4/VOK5uamnylDEDT0H7eMrf2smnBAZU6
         v+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722659040; x=1723263840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XheisaESTEudpbi3rO/WWYBhJwYeNAh4Hr324gZmrNU=;
        b=e4pF23737RWcQh4d6Jzf4muqsTsQXxPGBsclWbk00FYPauXk+iQV1+0CpkzRA5agJY
         W31s0T6sOA1gZhqT2sQSeAnaPxRtxMQ9eUVx/sYori+q0mR+TfYayMLFzTtZDMBicyv5
         SGZOKypnMv0YjY0t0oNZC2gfeSp+AbegPdC8ParSD01VuARPhfQ5pIz+001r896rHjds
         8iT9ckapFOb3/SSzUatsz32I9NaVxAH5lNy9fB13GdV6UOq12L1G/Yct5xvNy/rQ93rt
         rwe0695QJmBoawX3P2viN4IAGJ6gkxv+PWcZIS096E2aPb8XEF5mOuGoPT12RbfEd4b2
         Fv5w==
X-Forwarded-Encrypted: i=1; AJvYcCUHxw3ahGYX9IwB3t9D4xpspY7LjIEQ2XQDX2ch1xINBDVNko0H5UCmFn2Btp4BoekGDfkXdFffRGQvfGnkYfRG++WiedyeGeOxJjA=
X-Gm-Message-State: AOJu0YwIvGm4T8KgcINMZhS6Rh0kzOALpEt7b3klHUs4Y9/Z6Hj91dAL
	HtBYnBE0j18kVzJYsAzzd/GF/uv2QAtg6eSwYD73nc3ed3XF8LINpYYi+fIusro=
X-Google-Smtp-Source: AGHT+IEhe7YsubngD93lp7hk+e4p2ONzcD+teDCo40j5gj0QLHG1gPkMMTeH6J6MEwjI5GGBN+DNRg==
X-Received: by 2002:a05:6820:221e:b0:5d6:79a:c4d6 with SMTP id 006d021491bc7-5d6636d2bfamr7653033eaf.3.1722659040377;
        Fri, 02 Aug 2024 21:24:00 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d7571789fesm707877eaf.1.2024.08.02.21.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 21:23:59 -0700 (PDT)
Date: Fri, 2 Aug 2024 23:23:57 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vme_user: vme_bridge.h: Document mutex in
 vme_dma_resource structure
Message-ID: <1e74a5ef-7d15-451e-8cb8-2743ef95089a@suswa.mountain>
References: <20240803001814.7752-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803001814.7752-1-riyandhiman14@gmail.com>

On Sat, Aug 03, 2024 at 05:48:14AM +0530, Riyan Dhiman wrote:
> Adhere to Linux kernel coding style
> 
> Reported by checkpatch:
> 
> CHECK: mutex definition without comment
> 
> Proof for comment:
> 
> 1. The mutex is used to protect access to the 'running' list
> (line 1798 tsi148_dma_list_exec function)
> 	mutex_lock(&ctrlrl->mtx);
> 	if (!list_empty(&ctrlr->running)) {
> 		mutex_unlock(&ctrlr->mtx);
> 		return -EBUSY;
> 	}

Why did you chop out the "channel = ctrlr->number;" line?  That code
looks like this:

drivers/staging/vme_user/vme_tsi148.c
  1798          mutex_lock(&ctrlr->mtx);
  1799  
  1800          channel = ctrlr->number;
  1801  
  1802          if (!list_empty(&ctrlr->running)) {
  1803                  /*
  1804                   * XXX We have an active DMA transfer and currently haven't
  1805                   *     sorted out the mechanism for "pending" DMA transfers.
  1806                   *     Return busy.
  1807                   */
  1808                  /* Need to add to pending here */
  1809                  mutex_unlock(&ctrlr->mtx);
  1810                  return -EBUSY;
  1811          }
  1812  
  1813          list_add(&list->list, &ctrlr->running);


The first line after we take a lock and the last line before we drop
the lock are hopefully chosen because they need to be protected by the
lock.

>   This prevents race conditions when multiple threads attempt to start DMA
>   operations simultaneously.
> 
> 2. It's also used when removing DMA list from running list:
> (line 1862 tsi148_dma_list_exec function)
> 	mutex_lock(&ctrlr->mtx);
> 	list_del(&list->list);
> 	mutex_unlock(&ctrlr->mtx);
>   Ensuring thread-safe modification of the controller's state.
> 
> Without this mutex, concurrent access to the DMA controller's state could
> lead to data corruption or inconsistant state.
>

It's also used in drivers/staging/vme_user/vme.c
What you should do is rename the mutex from mtx to XXX_mtx and then
rename all the places where it is used.  Keep renaming until the driver
builds.

XXX_mtx is obviously not the correct name.  But "mtx" is vague and
useless.  There are 3 other locks in this header file which have the
same name so not only is it useless as a descriptive name, it's also
useless for searching.

Since you say that it is "protect access to the 'running' list", then
that means you need to check all the places where the running list is
accessed and ensure that the lock is held.  Or if it's not, what makes
that thread safe?

These comments are supposed to help us understand the locking but it
feels like we have a long way to go before it's fully understood.

> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> ---
>  drivers/staging/vme_user/vme_bridge.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
> index 9bdc41bb6602..bb3750b40eb1 100644
> --- a/drivers/staging/vme_user/vme_bridge.h
> +++ b/drivers/staging/vme_user/vme_bridge.h
> @@ -61,6 +61,7 @@ struct vme_dma_list {
>  struct vme_dma_resource {
>  	struct list_head list;
>  	struct vme_bridge *parent;
> +	/* Mutex to protect DMA controller resources and ensure thread-safe operations */

"resources" is too vague.  "ensure thread-safe operations" is obvious
and doesn't need to be said.

regards,
dan carpenter

