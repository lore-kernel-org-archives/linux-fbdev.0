Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552773B3BE5
	for <linux-fbdev@vger.kernel.org>; Sun, 24 May 2026 23:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779664393; cv=none; b=DPSR0HtyD4yv0RaW6ACdBECb/e2RVunEoErzhFLEVf0N56zkgP2M5f8iYP8MuFVzsoNxLGN1gfsq5JwZKNwJjf+9PFOt6k9xpCF3PSJXlhDh/cuisklEcbxQXhLqsZ0S2K8mfKQ+R6KwSnlU5EohMtELf8pqirrwByuyN7uD3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779664393; c=relaxed/simple;
	bh=ghtTJnS/NvCsA+vIBbl6m6PoiATZqfVB2noOWi3YZvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDw9VJcKMtu8/sg05Zpw92oINMN6N9FA0737M8u6RMZZLfB0vXp1osSvkuC82CvySVdm01381epU3JB3FkHvLaqOOu6HsmN2i/pnOXltpuC0E+wLNYVl0y13cN5y2o5QSh53KXQJKkcuxINAJR5BhQLHb4xsqhHgEoPVJd6XAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifl2Otoz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifl2Otoz"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so4983198f8f.2
        for <linux-fbdev@vger.kernel.org>; Sun, 24 May 2026 16:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779664391; x=1780269191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y/iNeZb6FKh5gV3yvVj4pfC+LDioS88XVB83Lk6lMMk=;
        b=ifl2OtozKMkCILcVOrWZjPfgdA3Kppte4lUVUP3/yyVl2JnPauWXQ6a1u4Fknc3W0J
         7nrLccL+nRGBkGB+YtW2eSLXz/747KYCYJX+99QvA/IQZmQ+vookDu16C+rowDsVZ9fa
         TRRNi0mq0hGNI4fQTg8eXFBmwGwfIe7IAJqVbmH5pVHH9uG/UknCw44z949BApZTYOJ7
         ugv3WV/TT9hBGnatWjjBmd1fvhGR09vq1Pkw62d/iiottQGzFabztu/ZOGDPLJycv6K1
         i0+7504IGA+IMFxtL2Bt35eruxP5vk3nWCWfMGI4r+sJcOQzHJr9qTik0JZFWM88YdUf
         5lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779664391; x=1780269191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/iNeZb6FKh5gV3yvVj4pfC+LDioS88XVB83Lk6lMMk=;
        b=W9Ze+nzr8Y0cJEoBn73WqzZqRhxZ9os/GnzIpAPZ2rYdbnYNauN/TyucHQ3aU8W4hr
         Ua429zM7AlAnciOFZN63Nrn1S3GzxPJdMibMJ0oRSi0Fi0bogK9eds+4KWazp9gdGQvk
         xLhZwLLYmJta7NowaLlrIg4/Tz6VeO7BQVcTaJGQaSca8rNZNuUMBR+DoUiTKQokeFSO
         fKMGSD+ArxeanjhUN3FVlz/lQdt7qqhctpr/Q50TNSJfN7qdXRr/mJ62kcwM+FYMbp39
         CkfG5byGP2cBJf+a3GU2owfSpov7BS1I68TWpExQKqor6SVhOopv0jsSh6DgquVtWDsJ
         6Giw==
X-Forwarded-Encrypted: i=1; AFNElJ+e/N9B7yeyc72PeujEtsJ1slAz5gpTggOepU4oae+eUVNGBoDLzSQUcvW2H2qmFc7cbaCBVL4hkAj8Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSD1Fohiu8vHYFnDEELwL0gIUNZDG6ROz+8qRUTiusps4bEDdu
	nFXOa8LNOa3jcfMb/JwTNilJucsjgOF88IZc+aNcbKuxgZAY+0wgudbI
X-Gm-Gg: Acq92OGVGdF54VofvVB3Tlypf35CtHOpoBtRbgTLrfydzP0NBFBTdOefSjBn0VjdCa/
	plTZXbCdsBLpvh9FFF4Sn5LqDGbfIVd/8dsOUN6krTZirQamVjhLXnrisnw/sVVT3xw5gLnGJBf
	GHgUQUip6gn728IdGH1v/BcN8UsR4X18tsqdS+fgC1/QYkU5UN2OnP3kKB3j7LAjSdRCm1FKiNF
	dz1Dg28SDM28yHo8anmEIvLcWNOGCAYN4NHZizyqHY76cYyzeKQdTsc8++xgJdAeq/GAUintUfZ
	DCw2UMSW+cJIJrCVGeV8w+uWK/q8mQS027voYvaCeM//SWFmZlzKkZjZFTs6JwitfPq7OtNDL5m
	Xt4jlzlxyLS+Mq3mfzz+2rmCbFg8mKFXIfNfagLB1I4nIr440R2opsOHBjsORgK7MOqK00EDw8c
	1dyRpoo/qLc6n1oDpKn6CBeZLxedKCe7MQQ4PNgrX4F87bsd0TS+oPOSpSJiOfj9ACE7kN5w==
X-Received: by 2002:a05:6000:480e:b0:45e:739b:3e3c with SMTP id ffacd0b85a97d-45eb36418d3mr18111822f8f.0.1779664390580;
        Sun, 24 May 2026 16:13:10 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6cce0a4sm21813310f8f.12.2026.05.24.16.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 16:13:10 -0700 (PDT)
Date: Mon, 25 May 2026 02:13:08 +0300
From: Michail Tatas <michail.tatas@gmail.com>
To: Dan Carpenter <error27@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: sm750fb: Change camelCase to snake_case
Message-ID: <ahOGBLV2g5HUZrr6@michalis-linux>
References: <ag-XlRifxjqXF-Zx@michalis-linux>
 <ag_ucCZEOnZuJOCz@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag_ucCZEOnZuJOCz@stanley.mountain>

On Fri, May 22, 2026 at 08:49:36AM +0300, Dan Carpenter wrote:
> On Fri, May 22, 2026 at 02:39:01AM +0300, Michail Tatas wrote:
> > Change variable names from camelCase to snake_case
> > as per the Linux Kernel standards.
> > 
> > These changes remove 9 CHECK messages from checkpatch.pl
> > regarding sm750.c, sm750.h and sm750_hw.c
> > 
> > Tested changes by building the module sm750fb/
> 
> Don't put this kind of meta comment in the commit message.  Put it
> under the --- cur off line.
> 
> Please wait a day between resends.
> 
> I don't think you're working against the correct staging-next
> tree.
> 
> regards,
> dan carpenter
> 

Thanks a lot for the quick replies, much appreciated!

Dan you are correct thanks for noticing, I was 
working on the main branch.

Some variables have not yet been converted, so
I will send them on a separate patch series as a v2
