Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA13E9595
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203480; cv=none; b=UzA4RNs73Qtt5f7sizGXM3j44jeQ3wWKHeIQZzBiazS39vfVl/Zq+OebtMNo5lBFQyWVVP3kYq1Whk+gytO0Pb7dZ2FyBHWKuexOMU3Emhh/tuTBGBStrGutfYBN4jmwIKDCvuYEdtccH6Ba5LfMpXDp9y5KpL4fkSux01umpiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203480; c=relaxed/simple;
	bh=jOoLb5UmrN94BtrDDOGkQJWrM24D2AE105Br1ixzEKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NX8em57i8vfqVKVvY2DVKlpqBMx5N6IwMKqucWwFXmRptgbyQlLAgLJbX3vCkL8jggWQsaMu3GzMwUIUusBIkQaIPY/4NjI6WCIFhR1tkatNugwaqZSW7nU0UM7Si5G5ja9iAMyhBGzDBsYtXKd6QYz8kEaOUYydcZzADZkfBGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gVa8yYFN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVa8yYFN"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so70717875e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 03:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770203479; x=1770808279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D6pD+wRMkpV8A1lHcdvyDOrZ0scIHltp3YZgaHXqsL8=;
        b=gVa8yYFN8MRxNAiyMMkUcm1h9KJgTFUK8wz2lwOk0NtpykSleq52j+/WSkdg2xZdn6
         FMHSODxCpq5MwwhbbuWDqA3zSa0/hMR/qTrbDhVF8vR5GsZQ+F1wPTLWg1TGyiKmfe2g
         8TPhnPHy5UB5t+wE4fQTQ+2htCHV72sd/8M+P4gQRKFgQHo5MMypnyOmLf5sz/LG1eO2
         SvSCIfxZf1cKt8Z4dZMKYBktVveKg1A4vZm4qD+/NU37JRdKZhj0urx/zqo3vo14KExK
         4RWX0FUVZWYlbKgbW9ONl5GAzN3V1+7DGZSF48qDob59xL/49++Vgop8S2Z5G2GAliCa
         NrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203479; x=1770808279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6pD+wRMkpV8A1lHcdvyDOrZ0scIHltp3YZgaHXqsL8=;
        b=lkPvIrc4hb4eHJx9kLRSCkd/234w7b6A776uzuSipf0Oc/5WMvte+41UjB4nHz53GC
         /9cN163BL+19tEvvDzQuvHAzVWj39aBfro8CSQN1FlQgV+j+GczaN7KBGsr3ZO+fXY+s
         nrJUShBM5sepGhx36NTLE/AFej/gkJcAsKYZox06x8okxuIGr5BsAUoZuVNSPvEiey1q
         M9ngrz5YBP0Nv3PWHtXK4ygoPLxaWq8y0YhStKRcxapKRUaG71vGCAmkZOBp3VS+7TBS
         qGk9WBqmS5cx51MuZt8NVj7QuBOWTrtDXzXWug9zFHzlyvf6OWYJdEy7UxHwAQvQ1r0W
         kpUw==
X-Forwarded-Encrypted: i=1; AJvYcCXW2ErHPvBtsoZ3q5LISUqjJybQH1yqd1xWVi0PJgs2WOKJK7KtmZKjnvJVmL2SLF3idDOuIGDvoMWgtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAbUYZl912kCmn+mu2PxqzbdC5mnA81UX8c6b8vIo4XEp6nqZp
	aQ7evXoSqipX2Sm8IaHzS4M2/tw1hglUmsAmC4dmsxrzTlBbVCPG+6xi9OI8LnA38Uc=
X-Gm-Gg: AZuq6aKa8NsbOl8OLapMcBN+SRsm6rnNuubgnHvA2knJhsU3x5ZO3RgC/gHMNGck0/s
	StegrevSlk8+jqDJIklIqi2zPIQAumhc5S/YRPirikqhDgPdK908zMNdxXZOya3wKkntUh0Rfob
	PIC5WUuR6Yj8Sfr5SwqKE5ftJ0JwZuqHpQhFcid/Oxm+wO41kt0ePmJeXO1xEAFWj26ohuqB6B/
	DMboNUrgWeV473z/feV+aYAnrUFWhsHsDYjUYao2gU3wJL1BbbaeAlUHXFVrJNw7GD2yA0KrbWq
	twCF1ej5g5HG48XlzwSsgACuxrvsxoR8eCbNPkzLslW8DkNdUspi9wh69VbTf2j3gR4ddVz9i/c
	UMGE/9yqnUrm6cvc3jKxinCSRAJjMDHyXPZjL5DoFLQWQJojL1KLBy8o0ZxjJNBtUaEvMtNtOcZ
	rni1lAu22xBLHaL0Wi
X-Received: by 2002:a05:600c:8b0f:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4830e98ab89mr33412735e9.33.1770203478825;
        Wed, 04 Feb 2026 03:11:18 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483108d79c9sm38085435e9.1.2026.02.04.03.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:11:18 -0800 (PST)
Date: Wed, 4 Feb 2026 14:11:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] staging: sm750fb: use strcmp() for exact option
 matching
Message-ID: <aYMpU3aWAwJjHqlR@stanley.mountain>
References: <20260204101536.3311-1-iprintercanon@gmail.com>
 <20260204101536.3311-2-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204101536.3311-2-iprintercanon@gmail.com>

On Wed, Feb 04, 2026 at 10:15:34AM +0000, Artem Lytkin wrote:
> Replace strncmp(opt, "...", strlen("...")) with strcmp() in option
> parsing functions. Options from strsep() are complete null-terminated
> tokens, so prefix matching via strncmp() could cause false positives
> for options like "noaccelXYZ" matching "noaccel".
> 
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
> ---

You've changed how the code works and this is a bugfix.  It should have
a Fixes tag.

regards,
dan carpenter

