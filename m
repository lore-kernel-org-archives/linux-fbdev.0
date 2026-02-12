Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD62877F7
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Feb 2026 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770874519; cv=none; b=UfFOBiM5vYITYK9dRK/fXPgYjJ9xYlRJ0H1VNPctyJV6CmSIAvbLoWSnj9DaVUil8fECx45iFE98VhhAl9s+qZ+B0kjrgeXM8mK7xPHe7+Ngk1nuAckD/zoFWu3fPNFw+uklFgtlb4WcYzj/xVQb9DPme23fnldq3l+X1p/wklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770874519; c=relaxed/simple;
	bh=83veI/vhVwq0xQcmpgxHqz2Io5xC4iuoCU9FzcUMvQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9sokTbqOefztsoHFxadM2WXZ+lKNtimtgl7+UEE+vp6D62mQmU/3B7FEtHspGxyW75QnfLAWAIRsDSZFq0F0KvxSGgL5vZpyQmecHLHLLMIirF/0DwIZ8d0s8o3vFIlzKqrvFBPvEfL2Q9GbZmdNhB2bTTBDZwrXMpP0Fzj9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tNAn7ihP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNAn7ihP"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4359228b7c6so3968711f8f.2
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Feb 2026 21:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770874517; x=1771479317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uGlTAM0CcQ9X7JUlNOqc+vi1n0Z9fGaUWQXZE25x85M=;
        b=tNAn7ihP68uJ6iN40ami9by8Mkrcwv0bYPTPGUvxwEUOc4u1O4tob/vA4TGU+FEGN6
         WhHshHGAs700v7GFXcXaHDF2aUMNqbSyOo27HVZ1Os4VUOmI+VYEjNPExMUD11vPEjm2
         7FHD4V607HmJ1MqXv4M0uij1AcxTCNtrRJzM2rl4csriATSMAmvvSHYVBtM+7dPL1PCd
         SOY8tE8qaBp+NvopIElGV0OM7EPTYf9mZEpiuCKCkOvyxGLMw8Xcx1vHagpNHhJpJLAe
         MKPJ0175OC9O12BEpXibdbJcy8C+6VnvE/OOkaLiMCKr5utBoUYMK/QcNS2Z6BCmwMVj
         O5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770874517; x=1771479317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGlTAM0CcQ9X7JUlNOqc+vi1n0Z9fGaUWQXZE25x85M=;
        b=XBSiPzHxDGMsbaGmIe29v6cNlPCChd4/JX2n2BL8dF+g9enoxqTXp2eBNqzWZpCdDT
         GgQjggQa9STBKa/BnwGaMs94Mo27H4dF8nEHR64Ym1zZFO7M0MkVvZSStJ+s29ufIHPj
         aOgyjKzDCb9Slg3CFRXJux5xNU/jSG+PKBMIIErP9X0g9I/VS+i0YFzG5MjHYWZhpREz
         KojQtPj+zw4YGaQgT7TAcU1T3MvpVrMEj27PClZC9+uLZk0nFQwui2vDX7AgVYFCAnru
         D/pEmmzUUKj8dHBtPC82EWu1vme5fJIL192mXya5VVEg5a8SfkWw2p0Zzxk1dYNOhMP4
         qejQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKoBqll6GY+BnhLceCy+hOjFljN8AxLHBbEv32XhYxg3jCsdvtARE081zB5YG/4hsOIdejkfC/9Tw3sA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmy4RTyhvQIdM8fri2M9U3FFoZ8q+ONUgamaLNH5RmxYyFmFLs
	/m64xgypQ7IP1aRF6nk4jdMRFk2zN9Xsn7bpvLWHIfMTQJ5ShFUO2212uaW15TZ88QbNgQiR6mi
	qlG0s
X-Gm-Gg: AZuq6aIYnsNmeFKBy4Yq/9RyWU/GMh/HaJvoUB7BgRQi46u9QQBQp44uBullTGyka4D
	JKK7nBaYDrXv1qI3hTqRARUUCWreMfANL+eSB11me1EHT86iJt7JKu7A5qDCSAPF6COtFzcwPyT
	eTGpV4vJsi16Qjy5iYpV/X29uEksjVZ/4jqsfjGaLEoBf5wo0GSdPNyHa5W87UTlsTOVJZEzoVR
	4vpQUORpm5h7VyCv9hwrKo1YuDtyICjUoTrmjN5eYJ9S3eaiy+4tPuA4ArG3rKTldp1xC1JyNzx
	k8g1GVPfGHWe0RIhCU3Mio8xhgZ3i+6JVdI4wFH6KwI4wGlanvi+yeYM4cHmoSgpQpBA70pbHMh
	dApdVQeMi1YD8J/XcnLz+1f5Td1yUXU+TGa1LfgKN9RsFst9ugHgh4k2rg2nira8nbdBewhVJOa
	1ANEw9Pfj/ct/gXlycWJtV40bhfBai
X-Received: by 2002:a05:6000:1883:b0:436:1989:46b7 with SMTP id ffacd0b85a97d-4378acad908mr2605377f8f.15.1770874516749;
        Wed, 11 Feb 2026 21:35:16 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e5c93asm8309333f8f.39.2026.02.11.21.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 21:35:16 -0800 (PST)
Date: Thu, 12 Feb 2026 08:35:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rachel Ovrani <rachel.ovrani@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: convert nDirection to snake_case
Message-ID: <aY1mkfl2lKKj4d55@stanley.mountain>
References: <20260211142423.4922-1-rachel.ovrani@gmail.com>
 <aYycB-fAZn-uTO6r@stanley.mountain>
 <CAPs_yZVzsHMqiMwWqM7m_7q9CRGDwRcHiAbx4VModZnCNzc0fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPs_yZVzsHMqiMwWqM7m_7q9CRGDwRcHiAbx4VModZnCNzc0fQ@mail.gmail.com>

On Thu, Feb 12, 2026 at 12:24:44AM +0200, Rachel Ovrani wrote:
> Thank you for the review!
> 
> The 'n_' prefix stands for "new" - the variable holds a newly calculated
> direction value based on the overlap between source and destination regions.
> 
> That said, if you think 'direction' would be clearer, I'm happy to submit a
> v2 removing the prefix.

I would have never guessed it was new_.  Normally n_ means number and I
couldn't think of any meaning in Hungarian notation.  Naming it
"new_direction" is even better.

regards,
dan carpenter

