Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D63DCD80
	for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388859; cv=none; b=fFfKHSQNhISPxkhEIvcIX3GQondcmaNW3PSYR4InPdQx7rO+e2SDXPXhPbXfrlxXSqRotfVGFYvxV79/Qy03N2OdzR1cW7AgnzC/3wzE1bVcReFhCohY9/+2DTxOO94/BKIV4BqQkUFhLCRvu6/QnnUXDEddZJ7CNQY0SKClmt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388859; c=relaxed/simple;
	bh=0A+XA5sZigyJDUsHUd5Oo1tLE772EOJuScegvrWm3jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMP/HXVsvzQdJWh4lvboN9qmyLew+nhlB3ERCeDqtQ/jz4/k/GILM1BvNXOeQuM2+7cy5RcHnWx7EbD7rUST7G5Icw51N8r0vNXzqaWzkLLG3sYv1lmEJuHAHifoyATKvp+9YpYqESxrcD8NadnC2KI572TpZutBxDpf8mN9b/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNnp2swf; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNnp2swf"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6a0c604b9cfso1699517eaf.0
        for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782388857; x=1782993657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxsefe/wUailqJDNAQGtmAmRQTu3ij9uN6odmHme2Dc=;
        b=FNnp2swfjKhfZPb8rCQ517tmu22J6Ce2ovWmaBsm0S8uFzF0T/HYAQXoJcI90cYAA8
         JEOV5BJZv3IaW9x3y3KRynk8ZwtkrPQpckhoBESBRY71dy/cnLH2JTfrGK+zyg55RTx0
         1qLHWAP20eqHroJjoSDvY67IL+IOA7Ul8X0MvKcMSeK6YrDZLHPNP+6/QKUGAuO7ZU8m
         nbgu6luiRKQJl8+tMjvocIIh9WdoCpFItB+ePUiX7AqhYInQTQ9AGyRk92dBoBoGs+JC
         X/XzabkJk3cbOlrAb7E6PomHSxAebM+SyURxOflNq7pjlj51PcnI1Bf3NV8FYYwRvpq3
         nNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782388857; x=1782993657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxsefe/wUailqJDNAQGtmAmRQTu3ij9uN6odmHme2Dc=;
        b=MCj4D3s+1X57tJPlbdcNwNgM/EZMBbk/VzDJd4AXV5JQQ+08uRUngNOsMEUTZJ0Ylg
         Og6aq44FEAgyVB7vy9faswDe+JY2z6AsBO9rhUI7oLhflsAk/8AL7Y/QGTDWv9/6ivnw
         t16TUfAHQzYmqGfMZ+Ib2Ze9+lnK+0wbs/0rgjdAUdqva46i6cEG7Oaud33VHtn3j7vU
         1g3u/ERyxnmc3EY2OmYjpa/c9eJw1EO9FavbyzZ908nsRrA5aJFVA5c+qmr5gODUY5Is
         MTNIqqbmQzMzGTZUygULKbqSdi9xadNv3vzRtyk/dcwxULPRtwLG1ecuSETrfNs48t9Y
         vN4A==
X-Forwarded-Encrypted: i=1; AFNElJ9Mzo4xfZP91hyyk38M2W/TkxJEchRe2xOkk+ivbt4IRFa5lvzYGNlZ4h0GQ8VMfjvVV9vKpviYHt3/+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOipIL2njduFgtJewdO6SrXZCDgjRIYb65PDFXab4/B9q2GRIE
	WfTmlGAuSeLe8pveL7V1HEPNEuTO+ThOAdJ+cluOcJ8+2Ms2WQzir3yBXQFG2L7X
X-Gm-Gg: AfdE7cnj6wZryvvyQo5aiYFnSFp7hDbyygV/rd9+q/CFDxsvYgt2Gibl5BuvoYHmPav
	mLEvzYQBokoq+aKy1ZcOlt4Jkz+yDuFCFBz942ZkREEC9HlQ8N5aMCnbc3MbXSJ8+hO5cIsx6bI
	sfi/Zxc4BcFM4fHNp6WgMRkf7IRgl+Jw9vckD4KPnC7xG7yPS0yZWKyHEDzc9y6wNPtGr6aZNyD
	Y5ZslF3fht8sBqxV3v31CkA5c+xDfR2jh8j68Y1yzOvu8wJF6QnjfqfFPNhhj66xlXoydkwRnt/
	C1dTFRs+KLpawA2FkpBp5nU0GjnI4SoHxicW2mSxqN88mQdeZ/izDYKDKR2imKu+54LAPRZJXQx
	683N25/nXy2bzp4vXa7prm1DJJaWRtQRJCGtTP18CXtzmffAU0+37ltl2TSsgXN/o7ukwKnT4HF
	8VXRXo
X-Received: by 2002:a05:6820:82c:b0:6a0:e2d3:8659 with SMTP id 006d021491bc7-6a1351969f5mr1724499eaf.15.1782388857443;
        Thu, 25 Jun 2026 05:00:57 -0700 (PDT)
Received: from localhost ([74.80.182.98])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472e79af8fsm11115403fac.0.2026.06.25.05.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:00:54 -0700 (PDT)
Date: Thu, 25 Jun 2026 15:00:47 +0300
From: Dan Carpenter <error27@gmail.com>
To: suryasaimadhu <suryasaimadhu369@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix unaligned access and txbuf safety
 issues
Message-ID: <aj0YbygQwhlga4Om@stanley.mountain>
References: <20260625111602.438761F000E9@smtp.kernel.org>
 <20260625114215.325973-1-suryasaimadhu369@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625114215.325973-1-suryasaimadhu369@gmail.com>

On Thu, Jun 25, 2026 at 07:42:15PM +0800, suryasaimadhu wrote:
> This patch addresses several pre-existing issues in the fbtft driver:
> 
> 1. define_fbtft_write_reg(): when par->startbyte is set, buf is
>    advanced by one byte creating a misaligned pointer for 16-bit types.
>    Use put_unaligned() for register writes and fix the SPI transfer
>    size from len * (sizeof(data_type) + offset) to
>    len * sizeof(data_type) + offset.
> 
> 2. fbtft_write_vmem16_bus8() and fb_ra8875 write_vmem16_bus8(): same
>    unaligned 16-bit stores when txbuf is byte-offset for a start
>    prefix. Use put_unaligned() for pixel data copies.
> 
> 3. tx_array_size underflow: both vmem helpers subtract 2 from
>    tx_array_size when a startbyte prefix is used. A small txbuflen
>    device property causes unsigned underflow and out-of-bounds heap
>    writes. Fall back to the non-buffered write path when the buffer
>    is too small.
> 
> 4. fb_ra8875 write_vmem16_bus8(): missing NULL check for
>    par->txbuf.buf, which remains NULL on big-endian when txbuflen is
>    0 because the PAGE_SIZE fallback is little-endian only. Fall back
>    to direct write when the buffer is missing.
> 
> Also replace empty modifier arguments in define_fbtft_write_reg() with
> a no-op macro to fix checkpatch warnings.
> 
> Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>

Is this how you would sign a legal document?

This patch does too many things at once.  Split it up.  Also please
a delay between sending us patches.  Otherwise it's overwhelming to
deal with.  Bunch them together in a patchset instead of sending them
one by one.

regards,
dan carpenter

