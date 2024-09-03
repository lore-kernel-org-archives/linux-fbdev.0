Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658C7462
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Sep 2024 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379403; cv=none; b=rV04A3Y0DRCO/MqzW7HrTPh7WqJXG5iRd4039YREn135XNuQ6XXUMq6FtYwxZea5AL88URoR8qnQWlSohzs9v0jmMGKzEpDvC6y2KaUqODQXhOq2buEVjpEBb46qbVOD+5/bp9PwP9YdfLYwDaZwP+FjDPYPlFpHqGpkNEVRnFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379403; c=relaxed/simple;
	bh=TRpYNXWzJe9pe0LP0QmTo6lFgdRXfbDvjnKxBzy8RYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPqU1UjHho94jIrwCMaP+y30w3irsomr8qFpfirtm5KZPGWcSCs+e63L2YhsEbp0GZxguvWY+oFjATKZ1EL/k6t2/0OCi0jQVp3NnAHKoHwXqwgMR/fXDW9FSYGIc6iHMfeNqxZAU2V2zwPDW0xa97MW3c+1W+qnq28FS2Mta/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VQ6KtiVh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VQ6KtiVh"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so3108887a12.0
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Sep 2024 09:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725379400; x=1725984200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRpYNXWzJe9pe0LP0QmTo6lFgdRXfbDvjnKxBzy8RYs=;
        b=VQ6KtiVhHcgAgWoHsXXQvnonjCHr74tiddzL3vfWujPb9ZD7ELQWskThCWDSm9rBCG
         kCYP7IjsVtKi9iK00oAKMkzsCiewV4yVUYyOFK0a3hwyj0Yb++PmZq9p69iZr+cFMo6S
         /ee/QApsSHBPpmC/2vdWouJK/OFOyGUXVdEJLuqlhqW78wLYxB3SIat9HU/zE4bK4TuG
         NEr0iXS46RMs+GZTmwsEw+KVOdgIk9kQFhFdj3ZjjlQBqpzLx3HY0rdMblwfgY+VkoIL
         JQaCM3mPMiQitjLCMDdn20YKql1HmcWvH+yIG+gL750TzZX0/aPxdCHT6Sk4Q32Wr/o/
         lXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725379400; x=1725984200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRpYNXWzJe9pe0LP0QmTo6lFgdRXfbDvjnKxBzy8RYs=;
        b=ceu/b3ugQVgWJIA2m+/F8x6NCnjieaGgtnd5dijcc1GhTrY9D4LCDmwa9vQWGyTDUP
         rxPZoRm9mAB5yhsHGJOrp1qT5o8i9f3MPZHnLJ8i3yalN+Ymdbrm85VLzs96YDO6+z1k
         EJEYrhX+fsfvohY/e4oPTtsi+b8907GIATgcym14fvfaEMCTNnh3fEVZI7AjWtHM3k9S
         a8dduWK0mP5iweHBefFIoXvfhqGm0OapQ+3ggSY1MDmr+1x+qZlEb3ddpJXV/h0bhhIZ
         +hNNu0pqWKTUQaFobXmkirVMpKxjiGmZXFXSLNFM/RDzsEBONUXrvu/kdbACU6R/fENM
         4SIw==
X-Gm-Message-State: AOJu0YxH7qYvvhK0sJIczQE/fD40as4tV+wwP4519pg5SmiPX+t14bI4
	HAEfjR6ciihQziMlmnEUYQQ9jCnNjLXSdBHdMbMAiJFlDG/HtEI+FkoWu4+SyMA=
X-Google-Smtp-Source: AGHT+IHS1Rvzb8UqeT7n0pUD9/wp8DOfOLzfqdZFhgAaqZruEi5DiDVN2tFicLvnOryGuMKxr9gfgQ==
X-Received: by 2002:a05:6402:35ce:b0:5c2:7570:3a2a with SMTP id 4fb4d7f45d1cf-5c2757dc9a0mr1279823a12.17.1725379396617;
        Tue, 03 Sep 2024 09:03:16 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c24733a74bsm4490101a12.86.2024.09.03.09.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:03:16 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:03:14 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, lujianhua000@gmail.com,
	lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de
Subject: Re: [PATCH -next] backlight: ktz8866: fix module autoloading
Message-ID: <20240903160314.GH12939@aspen.lan>
References: <20240820121628.42321-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820121628.42321-1-liaochen4@huawei.com>

On Tue, Aug 20, 2024 at 12:16:28PM +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
>
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
