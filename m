Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662CA38DE4
	for <linux-fbdev@vger.kernel.org>; Mon, 12 Feb 2024 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735283; cv=none; b=ZCDjBQkV3xaguziXIYHuDym06yK5UdcpwgEObCEWcD6aG5TZTEGr+ppB/NNFS5YLxna3HDVdoAJg2BpwHaoG9szr3CLwJU3YOo1/Yd2EaTs8kxGnW/fA+rzBEf34BH1nnmtUV6LCBo7Lr0vuk+kxfctk8ZuHDlPyAvdV6rJZdJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735283; c=relaxed/simple;
	bh=AN73LICug5VW++U499t0Wayh8Nvzz5HHvSHgzNyjW2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckk8h+v6z2BVOiZsWLeO1od6Sv1Kg9eGf80jLHyktjdoA7uv8SP9QCOzBaunEtlqeD1XfYNUy+gIZzWELwQAkHAcqV1gQyL71gh7aFwWzxbXXwu2eVMgYLp0G4AqcbTHiAGWLrnFhkhh7xeCLyYT7hEUvTHuPKLeUyqqH4mk3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=euifF5nB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euifF5nB"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b8806c22aso153583f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Feb 2024 02:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707735279; x=1708340079; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AN73LICug5VW++U499t0Wayh8Nvzz5HHvSHgzNyjW2E=;
        b=euifF5nB+ifEOc5Qes2Z7UsNMzAiMQ0zgymIJCJBqilR26t166cteBvFmEW8CT22OI
         4oVWHgrcQpyKefyRenUF3EwaA8Q/Vef/sq//7LJcUQJ7uPuquv7qcZe1ZvTLFRbUcr8T
         /ETqMAM0ilXg8WW3SH1XOOnvRxDc4SZVHBb0fIRBTj/irpzjC+rxGNW1MgcPPLsrceqS
         CVeuhG/gBWyBVYkV0AVTQKs2lwfQiLphFa5ZSjJu/9C9jgC7YPQkaF+ymwgkmS8uZ3oe
         1ln9FaMsqMaonTvyRDTQYKOqv93YqXCxSgJOP/+sKU9kdMlIHufTMJDXplC0M4BLfDIO
         W0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707735279; x=1708340079;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AN73LICug5VW++U499t0Wayh8Nvzz5HHvSHgzNyjW2E=;
        b=uBNQ4hmsXUNBOUEkgOrT72KCIrNgGnzLIVyaH/uZxqi/fffqlnEz4DplTK5b58Ft4k
         xrn/4iFaocza60sQle3VqNrlKFE8OWQKNGY5Ba0HCChukq7j+xZMmyK/qkm1HD5zD4mR
         QOccn1aAt67uiAKnTolED8xPHYLXH/5cW6e+gOEv5qUmykvDn+WajnpCnGDevh9BXIfV
         ltCH79kAcHXNpKeWXJ3bM2zAiEgK2CazEKoGc3GU6Hc8Nl04FFkCFE5gRmtnIfREgDEP
         ZEyeTbFvfCAYxShkKLA4vIO9yghFJKOhohrlIp4bRZWVMc42Iiwdhl/D4WorRC/cqv5d
         cVKg==
X-Gm-Message-State: AOJu0YyDeEVM5lJBV0MZClUMIIq9AjAzhzhRT+4MsiVBZc5CRpVzJ6M5
	2yECTvuIi7qqwct7Sa1gE9AayKwmwqa555jkxetbP53IMmjuyF830tLKGWOqzdI=
X-Google-Smtp-Source: AGHT+IHSe4H9vS5lPNXIEa7nwJk3bFBhiBabiLH5VYY4Y79eetaSZxnzvF+amgrzd0Ufd1oi5wt6wA==
X-Received: by 2002:adf:e441:0:b0:33b:60ba:d990 with SMTP id t1-20020adfe441000000b0033b60bad990mr4371624wrm.19.1707735279570;
        Mon, 12 Feb 2024 02:54:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCe2LrvntnsOtdZ25erDPdrpNU0Pkuuo26fivdkvy0LpaVzwmyVxiMipi/TjvBVoLO9tSja2KfIgxo39/LF8ZZKy971lfFj0uGuYDx+hXduyixJ7m2zvDCJR/CL1bBaj8wgx/MRAFx2GIMdmJUngscf1naw/2ab1L4SA3TlW4AYI50IWqiD8Dwevo2r9ZpxFwEK06jBUUgvpUYco1fjh4E8XHGQw0wG4Uc5htxi5gHOiMbfn97Vf7CFenQPkqsbhnXGzl94bt/1nOrN79/8R9pKwF0ylax7jpvsveEFSqBUnP3QQTI606SpqMNvOxY5A409mHcK3fPyNqjMz6y/+ZqbgkbGOZyhfP8ZRnp0APrGaqE/Af8ocgj6OdGI0ucQJxZYdVYAt4rA4EpzdRxug==
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ce9-20020a5d5e09000000b0033b8808355fsm592374wrb.28.2024.02.12.02.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 02:54:38 -0800 (PST)
Date: Mon, 12 Feb 2024 10:54:37 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, Karel Balej <balejk@matfyz.cz>,
	Linus Walleij <linus.walleij@linaro.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] backlight: ktd2801: make timing struct static
Message-ID: <20240212105437.GA4593@aspen.lan>
References: <20240210-ktd2801-static-v1-1-90ad2e2e8483@skole.hr>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240210-ktd2801-static-v1-1-90ad2e2e8483@skole.hr>

On Sat, Feb 10, 2024 at 05:16:17PM +0100, Duje Mihanović wrote:
> The struct containing the KTD2801 timing can be made static as it's not
> referenced outside the KTD2801 driver. Do this to prevent sparse
> complaints.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402100625.M0RkJhMh-lkp@intel.com/
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
