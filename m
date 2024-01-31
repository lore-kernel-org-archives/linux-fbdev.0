Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E029CA
	for <linux-fbdev@vger.kernel.org>; Wed, 31 Jan 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711649; cv=none; b=dyMKTLPZfeFczu31TrmiN3fuf+GHhLjyWWe9CkearbZGsIXdJZS6xr8vkrTt3XjfdAbUNpwmPsiruJi69WgaxRvkPguOwdKjLiBXOCHuFKPYu4A1SSHpGGiTkf0WJljTzmNyE6E2lGmYnBhBEPkTxs+bspClkFoPhlaoA0765qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711649; c=relaxed/simple;
	bh=pw+U8iahJ0CmhuCN4ZbIgl2mTW7ZjtW2xezbf/dgrRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwJ7AbzFFAD6qlZALMPup+jJN0ODFKvX7IZ20g3tameSMUQkJwW5JbPKyDI2cFt2UPcepHQQ+DTqtTr3sMZKcxFFwR5B9k1NSTT/SDpNctto82gclBJEv1cDuk7gI/R/J4HzjVor2PsQUymtXWkir3UNTbqLcwUU75yTyfsLqhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ynnVoJSp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynnVoJSp"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ae7ae9ec5so2200335f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 31 Jan 2024 06:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706711645; x=1707316445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pw+U8iahJ0CmhuCN4ZbIgl2mTW7ZjtW2xezbf/dgrRE=;
        b=ynnVoJSpmN6+EBPst/BcvEzVF9bVaW8nhpB9VqWK4HMFL89VCmAYiUZH4ZxYu80/Bk
         Lop+DxvXDRvzZNwxTcdtDgnI96ikIz1N94fI+SEGzHVOmjBjjZyxjC7VhOVUt3LMavP8
         M45WS++SrDwrDYUL3Vm0ofiYyNg1gAE9q8uvvQ5z7B1OgHt/AtxwmfdjORFUJ2aKyXqj
         T4uq+LUe6Ggl1dC46p7BQuroH9v5K/w3bfYumzR+q6CoRN9eD8z43DrmriKp4L9JvDZA
         c1yq7m0Bioz6f55+1AdxBfYRtr9tw1O1zu/sk20zynYHvDC/O8BetVJk+5GPrAilc8Ii
         1sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706711645; x=1707316445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw+U8iahJ0CmhuCN4ZbIgl2mTW7ZjtW2xezbf/dgrRE=;
        b=qtq9s2FR6BWdZfLbMB2WqOcZC1Z6gQlGCVvlr10gjUcSP9a6M+VLiaUG/M4tZTBbT0
         DmDIDjHvRdBjHav0JorTwAjoc1oppnbWI6q68f14DemkGY3FswmKxI4mCNVesjTGUoF2
         3/H8ICF9SKhQ3GivPaBBJ7eoTez8vOAXIPUX23fRbvqvtIlBGxloMh04rUEWKbyQojlU
         Gru9MKhEwvszdxRyszKMba5QCGFcgt7iOTFheuzfPGawKjgtRwuJ4EFHa8E/WVoi17r5
         Rqx4dp9QCCMtj03gONoT/b8EgVpd7vgKEEUfgkIJqWwC/z2FKu2FnMrFHoYbSkkbdiZ9
         jB8A==
X-Gm-Message-State: AOJu0YzG9tgivFtGofMUiqDoMfkmUV8Nv/y+uKQ01yg6xOwTQAS6RfgC
	MBlDMAw3utCf5vz7JENuBhBndDve50tHgjUDM71JNTW02uimmlnFeUrGZbyhll4=
X-Google-Smtp-Source: AGHT+IGxibPRLhmvYBASqTzPoOPDIA2DlXiwWGSJOIVvDa/pebaIEuqr9bjfmEhnBIEEMlPlSKnUWw==
X-Received: by 2002:a05:6000:1379:b0:33a:ee08:7541 with SMTP id q25-20020a056000137900b0033aee087541mr1386289wrz.35.1706711644956;
        Wed, 31 Jan 2024 06:34:04 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n16-20020adfe790000000b0033afed6e9desm2888638wrm.98.2024.01.31.06.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:34:04 -0800 (PST)
Date: Wed, 31 Jan 2024 14:34:02 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Jianhua Lu <lujianhua000@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: ktz8866: Correct the check for
 of_property_read_u32
Message-ID: <20240131143402.GA5929@aspen.lan>
References: <20240129122829.16248-1-lujianhua000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129122829.16248-1-lujianhua000@gmail.com>

On Mon, Jan 29, 2024 at 08:28:29PM +0800, Jianhua Lu wrote:
> of_property_read_u32 returns 0 when success, so reverse the
> return value to get the true value.
>
> Fixes: f8449c8f7355 ("backlight: ktz8866: Add support for Kinetic KTZ8866 backlight")
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
