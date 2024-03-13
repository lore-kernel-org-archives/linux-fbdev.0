Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0564CC0
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351373; cv=none; b=qssmkNWhOBSVAbrqBCwub7SMgDD/pVZnMKzYdtwr1QGFauoTHmRm22LS0laSDDKuFh02Nln0VnQk+RBmluDzoMq76eJrRbZuHabRhy+0h7WRb8noQmTbJpof2MhHfse+E5SYdvApOLwsCnbUVKyCwl/VPU3GT2nkLBncXgYChzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351373; c=relaxed/simple;
	bh=hy3ZcXqWsGnwgMjCN3gWHOD5wGz+6TfcBmfAdzS1Ayk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnECWa4RDYeUqA8zUHxK5OjpSaXEz+vESEkskZmQWmYsbAl11kVt76mHhqGMbb0kLf3egr3sGsK2teF9l0KG1F8L3azgCind2XsC7ANduI78jQ2882+kZ90Q9AqG7w1lGjv1fA5k0bsNCmdPdTYsPx+apfu+CMV8WwEirFM+344=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A/xleoXO; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/xleoXO"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so113617a12.0
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710351371; x=1710956171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hy3ZcXqWsGnwgMjCN3gWHOD5wGz+6TfcBmfAdzS1Ayk=;
        b=A/xleoXO6SPdBTiJPjRUdFMn+QfgP0nS8W7cRss3Jkm/UwgJahASg8Vb6zeDOlu3e0
         N1G9F3ESAx+SW/gZdrH6T9qHTGLUaI8mWpXeYEwnukz/B7lvssLBRnduV4cDBLzQMGyR
         s5L2Qnluc7pNyS8OJ1jgVjRAX6g3A5dRC/neOflibMqNA7eUPUe30TE4cWaVX5+teEPD
         v9VjY6DilrTMQgQrbKvu2+tB3UhCS9Ug7ihWXkiAm7KcGCQ4gJS7wZjkS+rUxkIHgWTB
         S1GaCTHHEgZBjYP/81uL3S7IyqdhWHTmBDFFnl1xQVczDQhEADbKO/GmqnaQZprDvHIA
         QmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351371; x=1710956171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hy3ZcXqWsGnwgMjCN3gWHOD5wGz+6TfcBmfAdzS1Ayk=;
        b=mNtlNWaKvzUeeB9Ui1BSA4BTC/ihroeWNXy32MsLBUlF1gITE0/UEiLm4DxpmCnIam
         Y0y5CtS0beEQANyEsf7ktOEr7zhNJnYYflZ3TiiuTdKSVC1zUfL1fFrlAYZ7CAbB+lCX
         DbgRkfE2YSxUdDhX9O+0zuS9GEX67J2XFy6ooNoT+kf0lD2IWVR+7n1otEGljW6k0Ltc
         cQTnrVjpEoPy8JIAjIhEb6QPoOttnXq2q/ueGdFRRam/s956ZDUC9GJPHI7JEtJ6kd2a
         z9uZX6oG0xC3Z2kx6b2pE/gglvdsbF/NXc13Iml19FXlox6eoXIbPWgdkUXwKwbsMhC1
         GTfA==
X-Forwarded-Encrypted: i=1; AJvYcCW83L2GdbVpLWNclPzAIWELSl67a6Ygi0EC8uIc4lkYOKNCchCIZpAQeRhIrDUkU8RkuUbDO8zz5MGyUSRmxffvVm1zva4U3oBeOOk=
X-Gm-Message-State: AOJu0Yx38U/EV0wfikZMA/dSy9O7rNDNeAdu1cSM+sePRCCAVJhQc5Ze
	+PUHl5A68Cns5gd7VOrL3cI44kVcDg/907dew5L1FVZLKFtpnA5W8mp4TPqf4+E=
X-Google-Smtp-Source: AGHT+IExQoPPhPaloxTdBAgfGGayI9aL78L5ibhJ6FmItWzqbpizfE4VIcY03GGG4q3JsKWFKpVR0A==
X-Received: by 2002:a50:aad2:0:b0:567:f643:fc5c with SMTP id r18-20020a50aad2000000b00567f643fc5cmr9870160edc.20.1710351370355;
        Wed, 13 Mar 2024 10:36:10 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id g16-20020a056402091000b0056886827496sm764414edz.70.2024.03.13.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:36:09 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:36:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 0/6] backlight: Remove struct
 backlight_properties.fb_blank
Message-ID: <8c6cb7ac-54ee-421d-b36d-644667309310@moroto.mountain>
References: <20240313154857.12949-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313154857.12949-1-tzimmermann@suse.de>

I was only going to comment on the staging bits but, heck, I reviewed
the whole series.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

