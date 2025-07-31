Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1EA4689
	for <linux-fbdev@vger.kernel.org>; Thu, 31 Jul 2025 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985594; cv=none; b=XTLgmSp956ceGUONZ46jGyJjN3fJT5DXOmlu+NhgrCV5nopOa1H0yj0tj5MUm/nkOcUVd8hklA+XWg9IPbSKBrTdJAColNylTiUIinE4FvZcga5si6yRra/j/Taq+zGPXXIwL5wGr+o2tR9wpSx6EZ/i01NJl0o6bJBrI6xBB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985594; c=relaxed/simple;
	bh=wFLSG1Ulab6iKXiKYb5seOCv5xy4H4N4O+mXSaEOb0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbRckkwa5IaT9vfd7E7pwpj6BZYUFTwwOdjLoVTiwoAS5hWimXTCTPTW1reWUvg+YPOajHjFyhr8cvEohStbrtXoje8vUs5v+YkEPJcEY6s2Ao3Oat4P3G4bCre6cAeM9AfmVkpSYR1QiqxM/cxmzOqeEaWnrRpnyaKNxAMlpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b3qKAIvK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3qKAIvK"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45622a1829eso3146245e9.1
        for <linux-fbdev@vger.kernel.org>; Thu, 31 Jul 2025 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753985591; x=1754590391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=khPC5CAFWL6Dx66QS31uBvJHhzcyJG/ZzOS5ZJNRudU=;
        b=b3qKAIvKe9aFGTneLKZkXKAYN27jhXo+91HrDe2nrt6WXWki27ifvT0jSN9bNpsaO0
         JX84Yda3DgfvL5PaQ0SX8mxou2CQNVnfY9GdOuidZT41PdYMAL5/BBiMSNLpb0yVF/Or
         m6V+6d4G0qo33W0Q9R5wMZO9FA348OTGdWySyOvAXHcaj9KmX9ekWR8c+dYgZNIQuG2j
         B19U9RBn6QONDod839TVKkQXXQb5MRLakBsoEoLbIznNBmLasnXwUNIbgif1Sgq1BCm3
         09E0AScTWuYn6Qxmdvpl4ipuwMDcxnGMpVs5zgwUsQm/VTF2BclR9wmkeFynXaHnxXAw
         3taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753985591; x=1754590391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khPC5CAFWL6Dx66QS31uBvJHhzcyJG/ZzOS5ZJNRudU=;
        b=X5i60fCl+UId+nORnbuO6cHzZ8NJqBrxoHMAX+NwatxM1n5VKeNEVIw7sRQbU1g/RQ
         rpJ07ehL7nroxEdwSkNTpGxdnNwokZ3gixl1dYaBJ+zYZ1+giV35TO4NgAEv+1ffLxad
         kQ2S7EIM1lXOhVE4fq8CWqw8fmn/k0e7K10LDFbDXWQdLxFYrhbloDMlp5bQ7utT5Wdk
         yQpKZzmOHALNwZu41uqI2nWTChzwpNu4W4Cwn2Db35PWFBHCma/KtoJwCuJg/8GWo+cd
         gXKaTG9eASuArzkGdAEpNMOjLCOreNvXs1s3iQ+Egw6sSz5ZD50iHRaqQ3mndPimahvX
         GOqA==
X-Forwarded-Encrypted: i=1; AJvYcCXfR6LvbsTV30Cq4N6lcuKv17GZvaPJkJP1zn5u5PVbueYYto5t6vkY/FrQL0lmdP6RKYhpp4+kPuVgUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xD47X2ZM8dn6pBCDbXQxuvc3RDYxP4DPGU7etUawn8bgrSHG
	f6TRNhZJd24FSQWgNuXrtuXYXI7VBCTUx8TDfH+adGnLBnurr1j/g4yuoP4dhNee0Vs=
X-Gm-Gg: ASbGnctt7xkSbDDQ+bLdDFJjhb0RpSmu8Uc+eRS/5UhGZH3Wy4Uk13GmVGkhUA7R4Cr
	RrLIne2eJBiJszft7tuugd8jR36TKVdnwdzoJqBZ1synq7AjlcgdpLlzXp9qdpdOz3q1kSDP3zq
	RG955Qjqo2x5DmVs3qdNLp6adu2szrJZ52KJEA3GnJ6+xESgwMgD2YqTA4h7IH614j1yIHXQIKY
	5E37GikQwwgmrpkT4BEgIoz9vX6weGYE3Q3U+6UJNxn0Axn9vObRibFcMW9XB6Aq7w6Rn3m2NMd
	zeig4dZTQOOQ1Bq6lk8LwNBC3t3YGVDIhtkMOXp88bobhS5gPEdAcoHGT9fuZzS3Kov1dl0JOqK
	FK1rEjdj23gQOpVuuWFGJxqnGMfQ=
X-Google-Smtp-Source: AGHT+IHEqCFNhgCLiwP/29jshYubmNscmwnmSCzs+vaDOgyXEAUaqK75fKy7u401XjtvRY2P9tl/Jw==
X-Received: by 2002:a05:600c:6304:b0:456:191b:9e8d with SMTP id 5b1f17b1804b1-45892b9d0bdmr68568855e9.11.1753985590948;
        Thu, 31 Jul 2025 11:13:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589536bc34sm73465595e9.2.2025.07.31.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 11:13:10 -0700 (PDT)
Date: Thu, 31 Jul 2025 21:13:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [External] : Re: [bug report] staging: sm750fb: Fix polarity
 assignment for vertical and horizontal mode
Message-ID: <ed4c5bce-d252-4d86-9358-65a48214d3b0@suswa.mountain>
References: <20250723192528.77109-1-alok.a.tiwari@oracle.com>
 <dbd2df69-27cc-4fd8-8e5b-78b6872d5d16@suswa.mountain>
 <25636f64-7b15-41d4-9ea6-216c22d84be4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25636f64-7b15-41d4-9ea6-216c22d84be4@oracle.com>

On Thu, Jul 31, 2025 at 10:03:46PM +0530, ALOK TIWARI wrote:
> 
> 
> On 7/31/2025 9:41 PM, Dan Carpenter wrote:
> > On Wed, Jul 23, 2025 at 12:24:31PM -0700, Alok Tiwari wrote:
> > > In drivers/staging/sm750fb/sm750_hw.c,
> > > the vertical and horizontal sync polarity assignments were incorrectly
> > > ordered.
> > > The assignment for modparm.vertical_sync_polarity was mistakenly using
> > > the FB_SYNC_HOR_HIGH_ACT bit instead of FB_SYNC_VERT_HIGH_ACT,
> > > and the horizontal polarity line was commented out or missing.
> > > 
> > > This patch corrects the logic by properly assigning:
> > > 
> > > vertical_sync_polarity -> from FB_SYNC_VERT_HIGH_ACT
> > > horizontal_sync_polarity -> from FB_SYNC_HOR_HIGH_ACT
> > > 
> > > Please let me know your feedback.
> > > Thanks,
> > > Alok
> > > ---
> > > Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> > > Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> > > ---
> > 
> > Did you find this copy and paste bug by testing or reviewing the code?
> > How does this bug look like to a user?  Please put that in your commit
> > message.
> > 
> > This looks reasonable to me, but the patch is badly formatted.
> > 
> > 1) It should say [PATCH] in the subject.
> > 2) The body of the email should be the commit message.
> > 3) the --- should only come after the Signed-off-by line.
> > 
> > Try applying your patch with `git am` and review the log to see what I
> > mean.
> > 
> > regards,
> > dan carpenter
> > 
> 
> 
> Thanks Dan. By reviewing the code, I noticed some awkward assignment.
> However, I was not sure about this code, so instead of sending a formal
> patch, I just removed my SB and marked it as a [bug report].
> I will send formal patch with proper SB.
> 

Good eye.  Put "I noticed this in review and haven't tested under the
--- cut off line".  If we apply it and it breaks then we've been
properly warned.  Something needs to be changed, if it's only to rename
the variables or add a comment.  But I think your patch is correct.

regards,
dan carpenter

