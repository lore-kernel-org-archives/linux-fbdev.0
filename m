Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8D6524D7
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295891; cv=none; b=HVPwEXmYpRx9beQ7IIxdpCumJBRHmkFJ3jUpHTOkIx5920hByGWY1ti8Y/3miIMK3V184bkhS1wWGLrN7YhgN8O9gI6aDcbO02nQkeCKjmvCknIMZKOc4YLRiaxB0sw49ocJX/OkycUBQfVUhyIKhKY+S9R85QZoEegXZoXKjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295891; c=relaxed/simple;
	bh=dBw9nOUl9fF7SB1r66qOP+3MBsu7aeGgqc4RXD6dJOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjClijER4cDE71Uvi1+jpZCTM9CcWmEY0bMoo3VcGUN/Lc+wxD4c/LxkNBsnkuN1LN31Yb4y3pMwq8+NK65sNYTyR2KKCT4jYdm35e5DQEaShofba4qVrXd6jimJMp0155P5HuhV7EWKCv2/4WKJRc1+EWRwYiYX2Phvs97O3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l6iF9Mjl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6iF9Mjl"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35f223e7691so770590f8f.1
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718295887; x=1718900687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xm9fvtFl5M9ClXulLO7X4Jg5vRT4Wu2KsAzkRuWsuxo=;
        b=l6iF9MjloMNMalTqu4bJrNkh63RZPCb1R5TIjRuPBlINZJSC7upsx+9qirtNl7sSv5
         O8vTP9L4hmvWcVV7UA/pMK9brbYTPMnPV4PLyqKxfMvwDXsiyO4mcxcBzkbobN8JO/Sh
         a+QvisXIhJgw7O4ArHisT22shqw7OQuzTSz0krJJsDRvEBXSjM9xt8fSC7OxZ6EFwNav
         hc8tpJH6YnwquW09IddFRLQJ2fE0DQcXW6BUrbc7dpy0CxyT/JJsC2Zav3bMus3jJtGD
         DLOBx4ISE/bu05Dh5e66vQV7jdb+eA+w5jMg9wosvc87ZPO64OP7FQbzQ2XluXkeuj4u
         fNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718295887; x=1718900687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xm9fvtFl5M9ClXulLO7X4Jg5vRT4Wu2KsAzkRuWsuxo=;
        b=v1X41LUU7dc0sZPCNqvAEcCy0zGt9f9aajSBryNBLT1JZmAXFLe9czYTEr9GEu1el/
         f+Vl9pXH5K4qNfB2zPObfrL+Zqd0I9KCWMtE3yFSuIBS2wXfoV+hbnflTBYN9PPpwVXB
         vP4m0nDNnPaZU5GGrpG9rdpE3ZeIKVr0z1jaIrUKZB/MmPdHBaqB2Mut4Bj12XMLkpKm
         7Bycoz3Wy3szhjv9TDi0ibXMJo2073DFeWqfkWx1hL7/MgGAQlOfE0UlWvdxlPV5bITC
         RB6l7IPTXkPRjS7geUrAURbCBtO4krnApAjbhLjI95LU5EKKDMMnFkCPn/DySvrjduIv
         Z8MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaZJpWJOBIdR5yA7YtQnvPgGkQfagOSZ2Zt1xtNGwAhNiVBNCT2Kzt0POa0jkRyqnEI6dGISrEyOYO7IhlitzzwizpYvEtAwhW6do=
X-Gm-Message-State: AOJu0YySZ55x5Y2+gnvQcGFl4LYkU5APtnlhJpg7G4yC1RWjK07SMMFq
	2IloH07fyWbW4nfQZm+fS9e4i/bZPMEUE+XeS+JoWcGkbu8XDvE2DXwOYrYRcGw=
X-Google-Smtp-Source: AGHT+IGBrxpjL2E0pgPBIEJnLIDsTzjWGoMfXeByIRcty/Uu7p3y+ZFY9bPpjqA6DX/92MrGE37OOQ==
X-Received: by 2002:adf:f88c:0:b0:360:7386:1a49 with SMTP id ffacd0b85a97d-36073861df9mr2356972f8f.32.1718295887142;
        Thu, 13 Jun 2024 09:24:47 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad20bsm2130332f8f.54.2024.06.13.09.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:24:46 -0700 (PDT)
Date: Thu, 13 Jun 2024 17:24:45 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Patrick Gansterer <paroga@paroga.com>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] backlight: lm3509_bl: Fix NULL vs IS_ERR() check in
 register() function
Message-ID: <20240613162445.GA24098@aspen.lan>
References: <187b5bc5-a010-46c2-8ead-980df9efae79@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <187b5bc5-a010-46c2-8ead-980df9efae79@moroto.mountain>

On Thu, Jun 06, 2024 at 04:10:23PM +0300, Dan Carpenter wrote:
> The devm_backlight_device_register() doesn't return NULL, it returns
> error pointers.  Update the error checking to match.
>
> Fixes: b72755f5b577 ("backlight: Add new lm3509 backlight driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
