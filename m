Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618003AC14
	for <linux-fbdev@vger.kernel.org>; Mon,  4 Mar 2024 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550518; cv=none; b=k+MpiEUGltuy6nvei+Jav2yfke3HsmJl2hBa2ZkX4XDuFkwpPugfTs0CqDClgT6a4jouL4lLv42U48/vnxketyRdumQwQ+mGWSoXrRW0PGOTQb/OWXU+7Xk+134dUgJcT14cBKj+O0l5Y0loIIDIVnHuO4ji/xEXUeJX9jEU2Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550518; c=relaxed/simple;
	bh=J8QRT14PUSYYy03uk34X/ZoBf4XH47r3nKBEcmsMw+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgv1KSBVDCR8Knj122I4DKnNDZ/CRVYUikZFCk4IICwNWAuVm2Gzrz5a6d4vn60KOt/yZMATdqhBJ4e/NxgV+m4/RGCOgOScrccoixXNHP5iHTXvHxicA6ZZXSs36UVIwIr5dWoBSTV7PsKpcHoqzNiJ5JA0KesQTG0K74HmmTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QpCHFWAc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpCHFWAc"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33e17342ea7so2087596f8f.2
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Mar 2024 03:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709550515; x=1710155315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8QRT14PUSYYy03uk34X/ZoBf4XH47r3nKBEcmsMw+Q=;
        b=QpCHFWAcdkI19m5G5tOzbJ3x9HmLEVLjsi0QPJvVtC7fQLG1EB949j73nYX8DniMzl
         n0WmnDKEZRkfUIPY2sX8i0ywd4Z9O3wPfuMyC5HoipsvPH0bOY0lgDCdcWz5jSc+Aa8U
         rFw9GaHB9X0eFeGs4CtJ7rgVv+vqBXnxYxHnJZtXOMYSi0eSwv9leeyrxY1M+I52of9j
         uKSFZb57rpzopLO1OuFDSQfkNPBn0ZTAkxbjDgbg8vvj1fWPhXp9ocEKgI0UROrTXIvI
         AHbtsaZW0x/6v2t7GLeM0vC9DL6AfKI5H3nqd79Q1RCm2JGi3agN7V9AjGixc1M7JO62
         3Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550515; x=1710155315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8QRT14PUSYYy03uk34X/ZoBf4XH47r3nKBEcmsMw+Q=;
        b=dwh1IlMNR+tzCWuVcyv1KJkdnLd28LNXirmTk7CWpKUWVUw9x1J0O+NmxIqrjVls2N
         jU1oFUq+AZlUcZkmQ1iUWtudE9rg4CW1byzIRlFdb5XEabQwqa1Pax+fglq462+WSvCx
         unwm4TkNZvnx8J+RR7INfXv2h4IZ039XTn6mjuo/38+tPzGvmNCOrl5yc5eR3RB4eS+N
         K7K8aAGFpIMd9/Kt8EbtZkDPa8gxLDJDqm5AVnU/FM3gOmGX8V+sFtQTj2gQR+b1jZYE
         fzpVff6Xm2pkpGyv5qe5NyI7caEyABUb/1HC+Z/mN58I60sdC3nBQLefIomQID2+4ILl
         IUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV10stB27akA6baJgKqZl0cNv/dncugurHqWrbtRLLNCracNU6dg2DVuyGPm/PQs0yqV6Z5OfxsImXI2EIyZTbSoV6RFD85VNOxgA=
X-Gm-Message-State: AOJu0YwslKa8w9721hY+tGIvE6m8RFqwY15YGWwPwHo7ePi5pGdO/ajW
	dNS8aSAG9uePsxALFmdKeIRDSdF9zG0NEoOsQby8OAcGuXjgpjWZrC4TZEcx4ko=
X-Google-Smtp-Source: AGHT+IHM96X7a2A8hQD7HFP/kAS8dWVSqvNaJeysD5QyLGeU4kUUmWcLPlRWWkxANifuMKzE4sEu1g==
X-Received: by 2002:a05:6000:124f:b0:33b:5725:e516 with SMTP id j15-20020a056000124f00b0033b5725e516mr5363029wrx.51.1709550514754;
        Mon, 04 Mar 2024 03:08:34 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d53d0000000b0033de10c9efcsm11932573wrw.114.2024.03.04.03.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:08:34 -0800 (PST)
Date: Mon, 4 Mar 2024 11:08:32 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] backlight: pandora_bl: Drop unneeded ENOMEM error
 message
Message-ID: <20240304110832.GG102563@aspen.lan>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
 <20240304-backlight-probe-v1-7-e5f57d0df6e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-backlight-probe-v1-7-e5f57d0df6e6@linaro.org>

On Mon, Mar 04, 2024 at 11:11:44AM +0100, Krzysztof Kozlowski wrote:
> Core code already prints detailed information about failure of memory
> allocation.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
