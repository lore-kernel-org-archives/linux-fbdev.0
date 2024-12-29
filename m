Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB5BA53
	for <linux-fbdev@vger.kernel.org>; Sun, 29 Dec 2024 04:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735447853; cv=none; b=V3soxdbLAdKAon+PlyG12GQfeADQFv0UfUEwa4cavZaF0tGW2HjeVtZa5C0jfSwcRURIZXodpM0T5127C+4DelF3R7DXySrLafT67IDUi+9aMug+SXvX7YGa8/xGmHrCuJOYGyaV/CkCR2C+moVCBa1j9jXIdpVYqn2qXeHIHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735447853; c=relaxed/simple;
	bh=A9Utw4Ievs8DrIF+31k4OffyyIv1G+bxB759Ajy1L5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIH5xI/dZ66g842h05Eoh0GFQ8ksyAAExZ9l6iEt9bKj8LTaVg4wpIdTLS5Lzn2xasBsMrXMeh7nLXhTh2Z7bGoaE2xGUAly8r+/AIxCSr+FSGwdBaYz3hl5eMYEuXmka7jWfwoVFZwDniTqDbdBzMabKrETK5w7I251TBRkC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fVr63XfE; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVr63XfE"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3003943288bso96623021fa.0
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Dec 2024 20:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735447850; x=1736052650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vkoVwSLPI1coIX/JA0W8yclcKQGo59oXgI/Yfces/4=;
        b=fVr63XfETAbwrTb4QgW9oeJezpuV6eR/El2vKIAKiXzyyyAKQ8s5pMBmnOehmdl0Ot
         i9AA0y7B7uAd8/RM2nCT38SzGjxRl6WnlFNomztrFqaDZ7Z1KtUaNKxzpEFU3F234eDH
         5p2pjWO6DmmN+QUEbYJ8l+leniRXRWGCo6FDn5w8q6T44DFYFCEmP96B089qKUtGyhtJ
         FTzTnwjrjye6OWTX3P9lxKCsCHiUBvUOa9NeDJpQaOS9oJMg3lDKifv+eYtAjyCRUNjq
         S00l8cZwS/DbKouAthCppclmTrX9ZrLMHRdbXy031795EZCQDrrSz89n0SHSdN2rCkrb
         Dv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735447850; x=1736052650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vkoVwSLPI1coIX/JA0W8yclcKQGo59oXgI/Yfces/4=;
        b=lbSmSp0cF9pRKGjFugypKKQSnq09pe1vGfvFasjCzmfH265Ats4F8nfQ1jPHt8hPFZ
         X4BZ3LBv98Mkf90r8EM1bwBE4C3yQpiw4U4/DfFLv1+S2EP7d4s+6UO5xZIMRvLduis5
         fqe+G85vR5pC06uclcWB7iS8BAj4kbszR4o5MTaH5twjhM/c5wz7/tx2L/uQR6q1SGbT
         v0LbgGaX1r9GVn8BBUmKCPM0ChtYxGXLFzfxFI2G2GX4++1G0ReuqPguUWDeyIxT50cj
         Q9wg2UISfih0FqlyaggKMZesi+qM4Vi/CRbqvAaUy1eHBU1dOPnWPaadee5yrqtIzoj8
         1Qqg==
X-Forwarded-Encrypted: i=1; AJvYcCWcWoc/r3mLNnFewzxRJhND+7iu83JU21i+hV+PYT1w+CkmIEtDuTO3kc3bXzqFOHX0zwsZ951sLCqDbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6CFXzmS+ucecZkwk1cppdl+QkXci63ifKA8xI3xAGFHkU1vLs
	9yNaS0ybDmVjnXyzqNFZBKnjYMU1xrW9VINjaPv4GWXri1XgpHSGgHOLksVapwE=
X-Gm-Gg: ASbGnctCYK2h1TkwYhGzhuuT/d6lE9/7CWyRtIJozbeTNasgwiuC32pKOq/G9mJaVex
	68KnQtkIxIulXssQLb54PNA4jEzDTT16LuxsMWVzeB67E0CtQvazciycls9MdLW3+q7fMzs8Z5G
	3v2HpBH0Wq03gcduGdtHN6c1xq2I+AOEk3GOpDP2f2s1vkNkhZX8oHR021BajduYIM9cSSqFO1d
	8r2On5MXa6kjnmYAZtddfp4lDIrEkde3JZ8yiTDj7SMP+QPhzbtunqoR+OCgSkq1oz49V3PZCEJ
	O8TejxA71e8HnrDxiAEBWSCKozCVE3va1sTg
X-Google-Smtp-Source: AGHT+IEsNXGZt2QOXuXj9OJSqWCxJoh9IxQNwSFDjV5JTFWQrndLXIX8JMTwPgrw564c1ha9VHBhRw==
X-Received: by 2002:a05:6512:1114:b0:540:2567:469b with SMTP id 2adb3069b0e04-54229533e5amr11323899e87.16.1735447850491;
        Sat, 28 Dec 2024 20:50:50 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542236024c7sm2833143e87.110.2024.12.28.20.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 20:50:49 -0800 (PST)
Date: Sun, 29 Dec 2024 06:50:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: linux@treblig.org
Cc: p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch, 
	deller@gmx.de, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] gpu: ipu-v3: Remove unused functions
Message-ID: <gugwtvw6qqknstlscr4hxfrvcgfa4gfwwgxdosr24mf7huk433@oh7axkbesrjs>
References: <20241226022752.219399-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226022752.219399-1-linux@treblig.org>

On Thu, Dec 26, 2024 at 02:27:45AM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   This set removes a bunch of functions in ipu-v3 that
> have been unused for a long time (since 2012-2017).
> 
>   No changes to functions are made, just full deletions.
> 
>   Build tested only.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 


For the series:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
