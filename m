Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18981F5853
	for <linux-fbdev@vger.kernel.org>; Tue, 18 Feb 2025 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905756; cv=none; b=tYb1vQrrqd3iHKZq+jThaz3FibevBz1EDUpfKujQfIlWa4Q4M9astqTswe/PTSxGBywsRUozjU1fNymtSlQg3qBHtcy0Crhqhnu5qJWgMAzuA4WQHVYtGftHKaaCSJWEa73KXwKlYwjF851YUtzCtcQlZR1DKxMH1qUyYxI+slc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905756; c=relaxed/simple;
	bh=vtkAZPDRpeVOssKKtc3/ZBtyBpcNLoSSRXvVxehsrIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGHEl9RLQpUj2NuxoEpmQjYonu/dYYC2LkaNA8t2YnIaa5qk1OBBHWEzoeJahtz5HLcPPjkCO2NXSBgus3oI5U25doHGGjbr15P/da5o/BCsgcbxuPz2MjO4dIUVwHAu6+HeIhamjXDDn7mWLn/9c3Pxyct3qUCDNywqCWOh3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yQ8+PFAY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQ8+PFAY"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so5128503a12.3
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Feb 2025 11:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739905753; x=1740510553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xsPSNeOLOsrs5K++JmVDCL05j90mUH/WwZrpY1dTXqk=;
        b=yQ8+PFAYU3EoFFe1afTQxcs9M5Tm46BhjXE+Ni49exR70aDh5k8D1+468WlAofxgzc
         l199bW8uI7z8hMSdXZxfu063NSXKygNu5eeMQagj8PDwFHH7pFXjhN1b614X1NsVr4tY
         zaseVLNxi50yxk2Hxwc7+xBmHj6ZLGoEDW2ggNcB/yhAZ65f/qoENuHZh5mzUmbIGMMN
         tlYi9U/4YcMOEfcaVSQQ9VAUOp8xrij9kMmiipdhe5aJaN2YLO50v6pZHDDc+UB1K5We
         IYim5GOOnK6Bj0aNEGrRC6m1s3fyAUYcn4Dca1GWWioP8LwcN1xqxbwGfv+ubXm4cAlt
         HrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905753; x=1740510553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsPSNeOLOsrs5K++JmVDCL05j90mUH/WwZrpY1dTXqk=;
        b=sECssS9tiC220ix6+qsPPwgWeVog90C5slwzr4Y07TzPB14Q1CdhOax36eQ9qsuWXy
         v7NP36KiV5/8HXdRWhNMbCwFIVs/+WRYN+9Dfan6D90Ek6FWrCUSsCBtaucofGoqi4Tk
         1z9LO8CYLtnl9FkKLRAlLxzdCgV20b0EdPgCuleGdRKo5oyxu0YvEJQMwgoVvFwJzz9C
         t+L1+vAbo5LPmJnVKCxx3pqmr2fMwpGyM2zM0gYRhokBBYQrYNhzmAfQfW8wgRaa/fDO
         4PCf9iaRwNzxUbxffnXM7t4pe+t3DsUCF5QFU1UU/zZMV9XCGujfB0YndiLG4Yc9mebY
         eP/A==
X-Forwarded-Encrypted: i=1; AJvYcCX64s65s8xdWEvmbsBSNN6Yj/WtADXRC5U4WnBtv0PkWM0wyPJFsnf5CmUG4OrWz90fSk/fdOg5YYZVDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB6RwdiXw9uNcLKqE2cKwYYzlwAdOu38uZAkFKwh7lEmh4sVaV
	/jpZiMa9SWHI4oqD+gW/V3sPN67G/3OUJzqDzebOEcX5pIuN9aQKCKEmgMynlLw=
X-Gm-Gg: ASbGnctPwJBUgy2xNBDPEbkI9WSrrzg3J8m6c8W4V4ePU6neEdEa6P7OgRnQ2LEJ1s6
	HbHFeTShcCQSRj/4T+qvJSo/xNmzCmjxnULTYMB16Lz6COPDNHfZz9WLxjDBofFAUbZKBusL6TA
	77+oc778NeHkNJhC1n6QA93VdN+piccfoQMj30s8/LtZvcc+7q1qxY73uz+lVzQpCgd4yfYJfOi
	H9i7mlWAPBVtLOdOWynJWp8qsq6P6QL/+a3ECkF7oFelG3gnaPVhUmThcYZUO/9/Rlx5X+1Aori
	eOu/ZNdDyecfkZDCzQw2
X-Google-Smtp-Source: AGHT+IECzgx+wcz5EbHNUv+RuNV/8qTPAQ4z0nfTNLzDceNq6d1mjgLqh6ZvP2PHnq3FwjFOEYPEyw==
X-Received: by 2002:a05:6402:42cc:b0:5de:4a8b:4c9c with SMTP id 4fb4d7f45d1cf-5e03618aa7emr37791483a12.32.1739905752903;
        Tue, 18 Feb 2025 11:09:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece1d369esm9063291a12.37.2025.02.18.11.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:09:12 -0800 (PST)
Date: Tue, 18 Feb 2025 22:09:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: sm750fb: Remove unnecessary volatile
 qualifiers from the file
Message-ID: <fc80577a-2dfc-467f-bb92-db9e0cc7151c@stanley.mountain>
References: <20250218185749.22144-3-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218185749.22144-3-madhurkumar004@gmail.com>

On Wed, Feb 19, 2025 at 12:27:48AM +0530, Madhur Kumar wrote:
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---

No commit message.  No v2.  Etc.

regards,
dan carpenter

