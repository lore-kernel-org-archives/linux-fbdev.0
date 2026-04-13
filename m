Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC8396D0C
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Apr 2026 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066601; cv=none; b=IjlMaKpFjlnORKoIzKzVAkc7ctfh2872Z9EKOmFALjMIMyflQg4WC/3Q9tZptGq7V1EnpXQople2lxlJHUNvnftb6S5amMJ847sz4ewKVFqx8vKbJhCwpaVkFm76+Mm8YuL8VrWO3L96sB56bk3/u+/MezV2C7vJmJRS2C3PLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066601; c=relaxed/simple;
	bh=p1JIwpiE8WyS1G2umPT/FSZ8Zr/GEnNXT20hxvR/ly4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEtvfQm6MvlsXouN2RveyenKtymVhB2miwmmnISiKtF50W2EYgDC79BUqIYwia33ukMSTXo2aHySRbgt2ThFgwOnHTt1naKwS259xszhxcZHwa+wHm92nfK1bfi1IQTykNCwqFy6yBxiL6GfeQSJeJLF70JRErfLtwsnV1C/z3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7IT+rUo; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7IT+rUo"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d73422431so746796f8f.2
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Apr 2026 00:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066599; x=1776671399; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HC7LQ8RAmg7bI/yzALEW4YdRB8hh0C/jyOgOuDqTf+o=;
        b=Z7IT+rUoHvp6NmgxcTsxm7I2XniMm8vQyVQamJQyPgKpgRgk1wz9f0JkhEtaG5QFNV
         uqsMUY3GZSPPPtj1Ev8eBwaGVBMNqxhfO+QCDZBt8wiNOVercdipPvIX8OzehYipk9Qy
         PFwDzxWuEqP86sCN//MRGgqTl9iRU+bfZBRZwM39ZGaZ3G5WRDGlVTWTWi5G0Sd41jEF
         IWC8Lr0so4WpCM9XKPmvyLKeJNYvDPDWsT7nJs+grxcjPuq2XoL3zltJd9mgyi+aor00
         zBeORlEwLt9+cnlGBIfWL1iJ8WbEyXU8vrGIf7A29GnAbj5fnvJ66XnJko/zw2L/v+iw
         4wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066599; x=1776671399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HC7LQ8RAmg7bI/yzALEW4YdRB8hh0C/jyOgOuDqTf+o=;
        b=ZrxtjWEsR1WL8vcuiN32UYk91tFmBcYKKX8ihcqHp+065g2uQSD8rUyCeVaUHLemkH
         KoLrk0P6+vKKbQ33z0luBFfe60/hTz6lEHe+wv89Fix/3uWNds0ac6priLf+hbTt6zYf
         eNei0TWiuJIodeMmgXS2sGI/LfTDEVNd8+w0oxc0k/BvuFC3kmGUgc1Bz/BRjSRlPFNR
         YhKIpG2LUeZR342QcYXpLgXB57kEfCRfjpY2kNRmUs8vF6p9GYwiYhuZnTv5dou1wNPH
         PzBt0xf0BFQOak/f/ngAbk95fGneqEngbyTcMt9ePgC2UlOyXWgf8+zQJsDTfyTxtXHX
         Fgyw==
X-Forwarded-Encrypted: i=1; AFNElJ+ArxG+21yCAMigjNSmn35OtsNa/K+xTce+Lsk75Fq233tPqP+4CU9f4Gf5RLx4SlPNW+BHaAgpNdi2rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLXkRpdS17U+xR6RIZfMNNWUr1efdQv14Ph6lsgNmJQZJndon/
	6GZppcf7LsD9UjRbgN87/cw0LhlD8NTCBVysWhNI/orW4DSWqIbeyybo
X-Gm-Gg: AeBDietQkornrvg27DMAy+7MyN1scKTgwy5+PQqfau/lD11UxBfWNw6fFf7S7qztTcE
	tOzjkVY+Q90WGoj4nMEZ4PWnLitHtE5jXaAUAYq/thBGx1ESFJZuatcFSjtmtPOcF4vzoh1RwZF
	2RrX7oH+In6qhniLJbTKHsoc6aAl8IMBmRNo6jCBY3ceiLRdHcauHhqlg3JN2uxGAmXzkR54gPV
	76IvwoZVgzxJt46/G7Kgw3kdKSpDe9uSJRuzIXGw0xvp4vdolO7alXlG8vjDl/NAnz8ZZ/lnowd
	lzUNkoUV8r9P+BvuKJTywO+lGdwuX8GgK+MI34Jx4CCjBI7//4sAMTvZUBjWO7Se+Q+M7YyO2q+
	xO7hsgX/Dm1WeMkwiHWhIB4k01igKRPZZi7w05lzcXCUHqo5A21Ns/zZ3NWRxkJQ1RGdUv3fEG/
	9F9ql9vKpHbXRe0jFVT0o=
X-Received: by 2002:a05:6000:2212:b0:43d:795d:5dda with SMTP id ffacd0b85a97d-43d795d5eb4mr2951035f8f.2.1776066598511;
        Mon, 13 Apr 2026 00:49:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5062fsm29721599f8f.31.2026.04.13.00.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:49:57 -0700 (PDT)
Date: Mon, 13 Apr 2026 10:49:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Use %pe format specifier for error
 pointers
Message-ID: <adygIkRhnsGv-LwM@stanley.mountain>
References: <20260412144552.18493-1-mahad.ibrahim.dev@gmail.com>
 <CAHp75Vdu6pih=NqkYT0CR_oLyr3YgNKBeqYM3+naqVp52UCgVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vdu6pih=NqkYT0CR_oLyr3YgNKBeqYM3+naqVp52UCgVw@mail.gmail.com>

On Mon, Apr 13, 2026 at 10:03:58AM +0300, Andy Shevchenko wrote:
> On Sun, Apr 12, 2026 at 5:46 PM Mahad Ibrahim
> <mahad.ibrahim.dev@gmail.com> wrote:
> >
> > The %pe format specifier resolves error pointers to their symbolic
> > representation. Previously %ld with PTR_ERR() was being used, %pe is a
> > better alternative.
> >
> > Fixes the following coccinelle warnings reported by coccicheck:
> > WARNING: Consider using %pe to print PTR_ERR()
> >
> > Testing: I do not own the hardware, therefore I could not perform
> > hardware testing. Compile tested only.
> 
> I don't think it makes any difference for this driver. But I am not
> objecting to the change. Up to Greg if he wants to apply or not.

I always like these changes.  I wish that there were an equivalent
%e which printed error codes that weren't stored in an error pointer.

KTODO: introduce a %e type format thing which prints error codes

regards,
dan carpenter
