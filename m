Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC67C0A2
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Feb 2024 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869085; cv=none; b=fCjqOD+XMA6nJkd0N5A5roSt3wmeEwbYHowarGUc/H1YM8pCass7FGyusg3DTHvRdBP49PxK4ZOOBNpeRIw3ahVLLpTBTzBMO7/gSRAJcBwjJcX3rOdral31yJZ8BQTxFtccLj+js3170QCsUV6viu1oU6aR2W1v/Iki33eiVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869085; c=relaxed/simple;
	bh=bNlg5tluenjxqxv+IvVDSMicjYmmaEPizk6q+pCzwOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8VZwFdXQ/LufoGd+VcB3ZCzjXJAMch20RiXdu39rJmF2wxuEsYtXVMCz7ids+e3Rni3uF50MWTdjXQdL35NMRC83sDedYjpCbzvZCVN11ij118EVZzTaSqKboeULyPBr4syZ6ouEyq9GwyPANScIJ19MsSaPlrCVHLxzQdIiXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i94w2u8r; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i94w2u8r"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf5917f049so22900811fa.2
        for <linux-fbdev@vger.kernel.org>; Fri, 02 Feb 2024 02:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706869082; x=1707473882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bNlg5tluenjxqxv+IvVDSMicjYmmaEPizk6q+pCzwOc=;
        b=i94w2u8rqtuJ0vxWQklXPDDeb1QDgLFugY3+vMlGKzKATmWiEFs/ESQVFAUiH0W0HK
         3Z5phWU3QAMSwVx4mkxrP3wtWMlK/rj6cwWW15KnR+CBdHM8iDJWI+2vPbrJe0HQzCTT
         JocUz/WKkupZjfmlmyBMLUEs9X101v34ALETJur8bJoTzmsISYZB4AkRAjhv9pFzEJn0
         qt6/YwuYFd1vrpwJlBV7EoCEPcaqmCrR84+QLLMqrMb3EZoldar3jkNoUmsjY+pSjjby
         BegYfveICovpi4OTJNwB2pkFgVdUG8rzWSjjibzQc0L/S0ogdguEMl5yTMhCpQRqP5UA
         LR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869082; x=1707473882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNlg5tluenjxqxv+IvVDSMicjYmmaEPizk6q+pCzwOc=;
        b=o4eXLBqf3VGMIBKkQnFjCIj10GCbPVPFsX/MmeQ2i52G62C726Aerwo775xjqC1/dn
         TKJtEIxj/oY6sbazo7tFlZUiLQ2osLm1fNIrpxTTW32nUG855eIp3uuZFbwWkWkD3im3
         A8+bvrBjvcaup0iy2yeXimHNmXaWemMzlvV2JP+VsUjJ6zJn1hENMgchhqnM8V/b/EEA
         u5GAjBXJF7W42OfqKBkYFA7cDEcjWfpBr7RBn0QqoLgpoQsFQdCyxcaWKZGiziITbZp7
         HMu2NqlnUlgpeOdpBDThxprX+76fcn/SDndsQcZevzyQfZq4yn6xAW4XQOngF4Wbu4pF
         LM4A==
X-Gm-Message-State: AOJu0YyjlL2ZAZZTb8GPEJER/xUhtapmnkPev0c99s7sFtK5rQpWW2ZV
	4C8lqe6y/8BXclisR2QA+uG8GD8v/KjLlWuARf5pZppl63txbIfCRaXGtB/d2ck=
X-Google-Smtp-Source: AGHT+IFb6pGaht1vtGLugyU4EquI8JZtaZf3lgnGnF/CXwI6w8g3Qk0atL5pvkeoQeSoAoeHfJkBOA==
X-Received: by 2002:ac2:528c:0:b0:511:3a1f:1cec with SMTP id q12-20020ac2528c000000b005113a1f1cecmr389005lfm.0.1706869081832;
        Fri, 02 Feb 2024 02:18:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWKhdLF3m6XfZrlisw1SIYzZ1pIiAQ/yxERF8VJJmEocp9Zl9ZYpN73n/FjIk39BnSihNUrjeVZUOFMTT3TzzlsQuGHcdVxebBFLyMHvCETTY8Teu09KoOvRvA/IrZuq0Hn96bif5qhjv6BdVy1vZkm7eO5NHbqdLCxLTjRC4zYdSd06xoONW5rcYAxUpqT3NGCuM556TOXllEVu3H8IZYcEruH6CNMxbywzPq1BaqA3Lan
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c1d8a00b0040fc828d8d8sm1204371wms.22.2024.02.02.02.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:18:00 -0800 (PST)
Date: Fri, 2 Feb 2024 10:17:59 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v2 1/4] backlight: hx8357: Make use of device properties
Message-ID: <20240202101759.GA373571@aspen.lan>
References: <20240201144951.294215-1-andriy.shevchenko@linux.intel.com>
 <20240201144951.294215-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201144951.294215-2-andriy.shevchenko@linux.intel.com>

On Thu, Feb 01, 2024 at 04:47:42PM +0200, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>
> Include mod_devicetable.h explicitly to replace the dropped of.h
> which included mod_devicetable.h indirectly.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
