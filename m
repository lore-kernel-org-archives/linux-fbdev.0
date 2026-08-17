Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6F839B96A
	for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977482; cv=none; b=fnc9QohWghQ9g26Z8MHL9PO4nkZtBamsfYN53lkSMNT3B0NaLdSccgXYEyjY7GuboQb5TiyIw5n28CiHsB2ACdSgVxMQHXIfOw7RrUio/px1DFU3jDaKHk9kJdHGIuQaHPdCkW4F8siLMEgOiYASU3CDcGln7E7vdxz9vYfUBb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977482; c=relaxed/simple;
	bh=vyLsd1AwGP+DY6/tZ9uGZDLmHOzQabRTOmJ39WxtkfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1KSWhN8Ij6bZa6297/f4nnZnflv5QYJ//lZX3zRlfQbmz1OmWhIocdBCmc7m80PiOiVStv1nS6Rjk+10eZYRcFpTpph300dVVGJEadHPRvHlYMjXxRnY1kwo62qJR5lgnFfvOTcZrXuJ9HctaJHufGOl7SHtNI9Da7dzotzcVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RriJJzoV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RriJJzoV"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47de0093c42so3085817f8f.3
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786977479; x=1787582279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OBLew5lB37WQynm1dR6uSGp6+f7VUP2zu8Ib7jym3v8=;
        b=RriJJzoVHYEXIFGAcx++iS9KqqsHE56D9oW7LV/IxbB9TBj7BcPFeWeURJiNnUKRqJ
         WUCpk55JUtc5cyQn86N6aW0CTDbMWcQFjPZSGBrJWAELmDjMLaNoiVBAl8xuRVYX8MW9
         A/c3gpXcSMR4+Ow5On+IGbDmUlRcUsOnhFzEQaRt8yBO60LCbb15xEnE4oRTt5DM8xG1
         XPEj94tqqQPdeEOoKspiwAF7blib/tT6pqioLu2l8ZbggCbNO4omDFExsdZbNG85BoiO
         VSYtFI17D8u9ECNIxnMmSxC8suUIgjvuYLMJY60XYq1jrDVla43q7f9+XpeDUnjtR89V
         xLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786977479; x=1787582279;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OBLew5lB37WQynm1dR6uSGp6+f7VUP2zu8Ib7jym3v8=;
        b=Mb1H5sp/rcFTv74dr3CEqMdATVpFjebjRDuJRRi0n3NOeyGa3TaDDPdTuKNIrlCl//
         G+/+BqKh/by0+x9AyyO9iO1hQz/a1+1ZhF4E0F4nr4kP7cen0MHfob0LU+m/aVWycBNt
         H1JWOaEPNAbtABORYp6lq3kUhiXpw7s0nRStDRucVUiGG1KmCG6XLZ5rQuH1gV84Cj94
         wngbud1uwztz2NxYETQIuuknrtEEg5d16ILNiUDUfI+CGKpWVz5ZEv50bIPmT0RgSO8U
         yZWrnADq0wKU0osWAcMmDg7yJFvy2Y905ejh2oI82k9cPVTKCpq7Hq138gAJ19OrXYdw
         Tttg==
X-Forwarded-Encrypted: i=1; AHgh+RrIEhh5whPcXcCRI+DoUaRYOtXHsFXa6s05Lld53jyaBvlOiPvShz8Ks3NUAjoXC+nKlByGHdrkB0EnSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOD1ciuLuBhVXuB8+Z2zmlUaEGdg9nA0jW1oVjCX2U2yPfMTf+
	BNnYyIVNobRl2HuY8VJzoOKxcnBZKPVQaZnEEnjldHLAgOSvVIcI5nhG
X-Gm-Gg: AR+sD11P4mPJtZDur1Yo0VkMyupVBC6by0ja7PLfs9P1i0oLhs5TAqNjBZLYrTK2GYL
	ihlncPmFtuBIcSoPzmnvwchuiihdaeACsIKP7gG3dzbDHgo1OnyO0wUoPUaBbTwpt9utE0xtMiW
	l/hFqdtLnPFlDoAP3eVtdknj9fwF57Um9wxAdDDmyGTCdgwCR6m1SA72KFDcKJJKJ6pHolpvijp
	5dzd+n2zMRblsVpxD6Hyrw2CUMhBtrkjpcwsDm9UBUZGQUZ2M+Vmn0rTj7/5XsbgaIoUYrZmcYj
	F7v5KKi8va/Vzr7EhwuXsAnSZzHhcoDcukXWdyENXjGylN81YRPrYb7411X1J5QCOkOy4jwTrhI
	DX/De5Vxl08xtH8j1t6bA14GaM0bJ9LyGJKO7dwWuVd9TiWhvc2XaUa1n2LROkn/tKps4NIjxrQ
	yopivErZhBklEecKAQ2puPkMiz5cYYifjYMhp35EM6sjg4tpn+kXMUHR4QBGXvN1qAY9vsLilPv
	mbBQHEvo23WFsrFUPYnbI67vZeRqaUFU60Z
X-Received: by 2002:a05:6000:3109:b0:47f:e748:3ae3 with SMTP id ffacd0b85a97d-4816070bf1fmr37790737f8f.3.1786977479416;
        Mon, 17 Aug 2026 07:37:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b816f7sm4136493f8f.34.2026.08.17.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:37:59 -0700 (PDT)
Date: Mon, 17 Aug 2026 15:37:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: yuebingkun <yuebingkun@kylinos.cn>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: platinumfb: replace strcpy with strscpy
Message-ID: <20260817153757.4a683d24@pumpkin>
In-Reply-To: <20260817031816.188833-1-yuebingkun@kylinos.cn>
References: <20260817031816.188833-1-yuebingkun@kylinos.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 11:18:16 +0800
yuebingkun <yuebingkun@kylinos.cn> wrote:

> strcpy() is deprecated for use on fixed-size buffers. Replace it with
> strscpy() to avoid potential buffer overflow issues.

There is no point using strscpy() to copy quoted strings into arrays.
Indeed, if the string is too long the kernel build will fail if strcpy()
is used but strscpy() will silently truncate the strings.
So strscpy() is actually worse here.

There are plenty of places where the destination size isn't known.
Which might be worth fixing.

	David

> 
> Found by checkpatch.pl:
> WARNING: Prefer strscpy over strcpy
> 
> Signed-off-by: yuebingkun <yuebingkun@kylinos.cn>
> ---
>  drivers/video/fbdev/platinumfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
> index a08d955d9b43..fa27a3a4f05b 100644
> --- a/drivers/video/fbdev/platinumfb.c
> +++ b/drivers/video/fbdev/platinumfb.c
> @@ -320,7 +320,7 @@ static void platinum_init_info(struct fb_info *info,
>  	fb_alloc_cmap(&info->cmap, 256, 0);
>  
>  	/* Fill fix common fields */
> -	strcpy(info->fix.id, "platinum");
> +	strscpy(info->fix.id, "platinum", sizeof(info->fix.id));
>  	info->fix.mmio_start = pinfo->platinum_regs_phys;
>  	info->fix.mmio_len = 0x1000;
>  	info->fix.type = FB_TYPE_PACKED_PIXELS;

