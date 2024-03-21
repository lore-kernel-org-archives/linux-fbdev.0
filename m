Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C153B1AA
	for <linux-fbdev@vger.kernel.org>; Thu, 21 Mar 2024 05:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710999702; cv=none; b=UrWGre2f4MaUMXumTfnpoqZeWZoDunDVAV+gfZYSuQ8aLo40Ie2nqhQJdNi7Tdkl7jOzAIP/tbdK9djD0bXg5vswQjOD0vEEy9dmqcEX1ca0wqQT5A6GlWh8InIGO3fqqFph6lLctDh5RTuPdeodfjwUo68L8n5+APfZcx0cddc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710999702; c=relaxed/simple;
	bh=sLCJ5w7ZjIc5OwI8r6fw90adJAwfvrKs/3vsEHc06vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzC1zF5/V/H16mWBvDkImtSwHYXYnzqbX0WujTjTtIDXKP3pwLHG6ILgpZvA0jQgnJ+h4hUr1kKCnW4Bh1snVEqd/CN4AtkESczE1R1SVu36GMPLQsxYbFCda69SfUno+7aCZCHDPSNryRq5IATgDRFjbofszAFwTxT3zHZdrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NGYuGR/K; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGYuGR/K"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-413f4cb646dso4294065e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Mar 2024 22:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710999699; x=1711604499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zm+dDDn/qjmssizpNHCqnR6eRhc+Lz6SbwtuAIJ0yjA=;
        b=NGYuGR/Kti50Mc0lathcf0N6IcRQM03sKHvQYt6ENoNUZdv1GLqSkhfqFHKBK8p71O
         T1hYI21l++lUobPtPJzwkwAOt5X83AkTzSDf6EGFQdzS2C4apaqpJ8bcVxUAEafuQwTD
         ghjfPAhoHGDSUqQL94H9CB+9OGWyDSUj/CCWa0gvOn4+gay9nsjzSzuYDoJW6bK6XKj3
         G8lK7OV6BMrMRYrPehLwOLPbrbrjPp+4WoE7dDUJG19G6REZj0k/BfKNLmiCbTELewsR
         MjJhJFrvj1sxtYHZIYlPyWh/DfQAq/KnCaBbDtb+o2+0BSSy5kqMH+ennDL81KpQHke2
         p2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710999699; x=1711604499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm+dDDn/qjmssizpNHCqnR6eRhc+Lz6SbwtuAIJ0yjA=;
        b=YkKH37UMicVQR5lFCCR4sZ36W5+Op2WBQ7ly90FgCboDO9fyv1B9yUrD0NQE0ri/Uv
         eVE75AZnOVuGVCt3GZoPI1iValVwdw+PIaMcaGnLw1dDBsUVRzfA83hjw126/qyfhBZz
         +3LryB53F9v/vemL4gfXYnHi4Qsn0U3zUU33UEFITbQ+ffPUPwhySSqDG1wEN5eX5ck/
         Y2sxfjGEOdEqwGURW8Q7upN0v3qpTrkUbkjYl0PrQRSf0BDrRhqATRxTX7XmZ809Tzuj
         DTy4uhgsjtH2JFtYUvDQKkLbaZAN7AA0rhGkM8Zn3NRe34nY1YRn1z8Iyuk9qcBaWKZ5
         lO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPfBxJpSuhhE/j699voYARSVuP3HB2fb2TkDsU/GVEeal/EGWxiy8C0NgLGP67b55vrXd2ekcBJhKf1JYapkYiyBRnHD7ANLTnLrc=
X-Gm-Message-State: AOJu0YyzUJo5sYWE9rtPXHtKv/szGWmDOfNXjVqMrf2xYN7COkbouFnh
	B1Sas0jBGR2aUKH0iOseGyXTCrulTeSnTrzNtSSVMCjs7piPgwsi0ROXXldPhwQ=
X-Google-Smtp-Source: AGHT+IFDFiJPls7HzGZtyNHBa42C+coG8tOL6Rb1hcMWDpZDq0e6ExNBc1UHVkYbAtN2t7TZXly4Yg==
X-Received: by 2002:a05:600c:310a:b0:413:ca0:5cd1 with SMTP id g10-20020a05600c310a00b004130ca05cd1mr488156wmo.39.1710999698539;
        Wed, 20 Mar 2024 22:41:38 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id fm22-20020a05600c0c1600b004147266a37dsm1370015wmb.30.2024.03.20.22.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 22:41:38 -0700 (PDT)
Date: Thu, 21 Mar 2024 08:41:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: sm750fb: Replace comparisons with NULL and 0
Message-ID: <51797d72-056b-4762-a328-1d968803b931@moroto.mountain>
References: <c4a5e9e8-214a-4ac0-b8ee-01a9e7a1e5f9@moroto.mountain>
 <20240320180943.3683-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320180943.3683-1-chandrapratap3519@gmail.com>

On Wed, Mar 20, 2024 at 11:39:43PM +0530, Chandra Pratap wrote:
> Replace '(opt != NULL)' with '(opt)' and '(*opt != 0)'
> with '(*opt != '\0')' to adhere to the coding standards.
> 
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
> Changes in v2:
>   - Update the commit message to reflect the changes better
>   - replace (*opt) with (*opt != '\0')
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


