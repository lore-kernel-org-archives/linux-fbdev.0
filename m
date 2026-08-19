Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1D83C76BE
	for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163669; cv=none; b=kZtPO3B9pZSqBODue0xyBP5l6GmICJtNpCunIrMQeEshJGEHup3wPsmIYHbwBDPYTKt8F7MREAKe5ZBqkbI/oACK+tWkzhcAidzynaZu4evtACfghQfXFKwTuOfMaJ6IkOOgaiIQCJJ5vB2u3sofLaFnJxt9DRPI24xCUe1JMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163669; c=relaxed/simple;
	bh=oVU0lu10u2nFA79Yz33CePdMJP68sQJhCqhyzyHCuvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOzgc/PigY/PUW9xSaO6al/+gmFG6k+qU+a3qgTbpd2mEIjdFPhPgjLjcDi+/MPiFlOZew00ZJXGFOwEJlyS/P2kRBthL73K1uaXMaP0Xvx4oiYBZY4fKqix6ffghkfZUOVeFWENnCSoMEj4lX5ydaPo2vCRyICbH4OOSE4/L8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8CP15Nx; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8CP15Nx"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a051904222so1981264a12.2
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787163666; x=1787768466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hThuAHpiuNPzFZaRiSmIoF888oHhxzPaNMpB0afArQ8=;
        b=Q8CP15NxU49pTPIlLrL38pZS/BO84E3fBaNXRyiiChYfhZVPWxmU1LV3F0F7zEaP5g
         4KB0hwkPWpALdwE0+31/GHTGQwth5vwz0u7YRJ4rBjWZNkjvQuZhANyvwaB0TLNbglyA
         uQ1tM9CU7G3L1derfr48DLKNwcgHu0itmd6fyZ9/Ejm4WgQlXXTv1Wl14p2qGttPIOrG
         hT3NEBhJzFLtGjdpBbSggBbCgQ8eaeqhizhbc8WzZe4S2/DJye6Yy8jCtO9hxPy8vWNF
         ZnypuoWU04OvtfrI3t61yCYzt17RfEeU12U7StnS9Vgh9IsBaMWMuXbiRQ6IbRZ2GbuD
         Wy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787163666; x=1787768466;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hThuAHpiuNPzFZaRiSmIoF888oHhxzPaNMpB0afArQ8=;
        b=ceOgKOWUutxw6XyR0sB7z4MHVceYJodRaF9j7WoSRSHBNVvMzmbROmz0z/e7k0embK
         Fw3uOXZKVZqhV1939pz7xJobdvm/EnW0pVQHGlXiNyqZq/TXx75dU74YNTDLo1g5w7+y
         2uUoD0BdkUB08+rpYm363I7vYfmP5Fzy/ZqpIDU1GivCnoQVAeJQhdafv7riiRK/DApC
         4MWHNAhmRMBr7wkjr2b/4+Kcf9upx4qZwpECjcYEXR7DWF0qI31EKV0iQemZUl5xnODt
         oypyRMMUovHiouWHlc0EycgJo53dU3cdMr8eJ1Qs0sOnWSReeTSCCPaR5oJ5ucZpSyO7
         WgSg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2YsrAROu1KD7zHOaU3tIEIHs6Qk0Gmw1+VdLpqeDbDRGCaiYGMekqw1k68PlyhqcU1W5rzWrcYqDajQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKmVy7DYMuIYq7oAEeh8boQqt/yEGf/9pEP2mWl8riPxhFb7l
	SztEtkkc58ryojwPFpsWWhE5jLUe/lHvDH6GZOxp6pqGdY7ttOruMt1L
X-Gm-Gg: AR+sD13CXr2J9wYtjNzLXIz4DMobsOUcOCFyb9+Q49MTJGDbkLbEvgS5KPIsQZrRc6O
	4s9mAYB9hTmFyM6at+tchWPe5vcXtAk45pylVnyDVLdpJUyUfyITYWgcI8R/mhu7673KaHC5xwC
	QM1A5xLy+bnJGwlHmrrfigO87Wg+4f6DgUl/X9rRroZpfEW4EnXad2uC36Y2oVSNMz8z0lya8h6
	ABUez1Yac5SEFY/VH31NeqByEdjXXjxtDpiII24EJiXY5ncDj6jMN9CYN6ch3RLoXRu1vJCBJ/9
	Qv0QPLJQE+WoVk81StzkiPh3ksrBglBDOOEPFZRiUaQJ8/BYh5YvMZOwqsuoqnkkH9vk6B4wDtt
	TL1/dCmlmK+d35wcVqSaiKIi43sMCnWdNyIrVxKHO9GL9oF3Xf5nDhzSX2ney7MQWAXJNrEkzjz
	tSg3Hv3hNscsQgWcjuznHXw/boycT4cYWyLZDGvswlyznQkqTIaNiajDHIuauSKjd5yCI=
X-Received: by 2002:a17:907:d649:b0:c20:1c9c:b36f with SMTP id a640c23a62f3a-c23f937aa93mr417904166b.8.1787163666346;
        Wed, 19 Aug 2026 11:21:06 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c5a0780sm112050366b.31.2026.08.19.11.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 11:21:05 -0700 (PDT)
Date: Wed, 19 Aug 2026 21:21:02 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tomasz Unger <tomasz.unger@yahoo.pl>, Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: prefer scnprintf over sprintf in
 fbtft-core.c
Message-ID: <aoX0DiIcLG4Cxvwk@stanley.mountain>
References: <20260819-fbtft-core-scnprintf-v1-1-842c0603634c.ref@yahoo.pl>
 <20260819-fbtft-core-scnprintf-v1-1-842c0603634c@yahoo.pl>
 <CAHp75VcGmmz6EZYjG871V+sYmJn=iGOFxj+D1oe4rtguWkipRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcGmmz6EZYjG871V+sYmJn=iGOFxj+D1oe4rtguWkipRw@mail.gmail.com>

On Wed, Aug 19, 2026 at 08:06:39PM +0300, Andy Shevchenko wrote:
> > (text1[50] and text2[50]) so the write is always bounded.
> 
> > In practice an overflow is very unlikely here: text1 only needs
> > room for a size_t value from an SPI TX buffer length, and text2
> > formats three small integers (bus number, chip select, and
> > frequency in MHz) that always come from real hardware ranges far
> > below the theoretical worst case for their types. This is
> > therefore a defense-in-depth hardening rather than a fix for an
> > observed or easily triggered issue.
> 
> This paragraph is not for the commit message, rather for the comment.
> 

The paragraph describes the expected impact of the patch and it
belongs in the commit message.  My problem is with it is that it's
1) Wrong because it says unlikely instead of impossible. And 2) goes
into too much unnecessary detail. We don't need to know where the
values come from since even the worst case for the type could fit.

regards,
dan carpenter

