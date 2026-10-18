Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63685414A1F
	for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792330726; cv=none; b=MjDrXcrljOmbuy8tSnNBlt0x+P6RusDf4L3uXy6Ba9EnuP7TWvUGRho5RbF76TW2GaDB/CYeuxzksjcIi1Cka9qwBu0ncsd7hWxnHGVguYpmCJUXlWDCs8fKlYKZQWfApBuEscOVc2w4PwcIXxyeDN7hDv0XM4ZFHqZdBKer4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792330726; c=relaxed/simple;
	bh=ldNYRwI+5doEBl3C1g/4d7rWHQk38M49uk56iBMi8q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Er3QBs5ssnTtWBnR3fzaUp+4MbAwOZUQWvOt6afvHZSXh5ywQyj3dCln1wq/+Ghcpsiuw1SYFpgNrN88nSqlnTngxFVL9TajKmG71rasC6IWtjzn83jxVyUHToLY4JXVlv194HjWUbxEGl2dBMdFsv3ke/eoTqDurlmpRMillvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rddQ3MSJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rddQ3MSJ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso14252065e9.2
        for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792330724; x=1792935524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KgtDcPhGOMWpmKP73xncVKfTZT69mE2yBqqaKdxCDiA=;
        b=rddQ3MSJM6VOl3ZejOuezsTyZgu5Trd9+3r5KYFg9kY/HoNmnEo5JMka1j2sU5ZIc/
         Qq+aHijmyB9+idhrqemeDL3POm7hXwi3rtko6+v1dEJPzbWJv/WDJRx1YbnAr5GkakPH
         6YvKV+tMhTMTtpxi68VCeVpI2kkMe0LtgCrXIifDOd3JUK68NRoihWVPk/tlwUeX29gu
         b+dSDR2E+GWiexdIhSxMaVOIU0D9qq28iRDwBMPkXF5uVCnQH61JioxHBgE3VwNiMdk6
         m3P1p55bjt335SLSrhGDyO9gxATBkQeUgypMgPxyYa3lQXkG2o1WYVLT1wLbDX0yEY9x
         M8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792330724; x=1792935524;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KgtDcPhGOMWpmKP73xncVKfTZT69mE2yBqqaKdxCDiA=;
        b=vIo3yzNHjBx5Gm7415A2vtRhL1gAFf4r6GDPCThrIqh5elFiOflZKTTyE/LmfJo5e7
         OquFqowhnqnbKbZ+GBUF9QvktcRf+fwKoo8zFBgrqujpMwyfGwP5snsOV34RW1FDJ3he
         SfRrcfWgFh3GZeEE8uj9A6fzc1v+cpyO/m4EyeF9RguzyF2XopGMc++FKlWbEqyCJXOa
         Q2eNz3N+XGm8lz8OCk3OYwUg48f+or2XF6WK9mc+YbSSmizDaq4OEDJEF9bnMX7mlHp5
         Q7xQawaC0W8mFiDJBz4Hh0MzcTJ8OCvI127I7M7ARzRvEgaVY4QBbn1TAW/ij9we7i6a
         0F0Q==
X-Forwarded-Encrypted: i=1; AKwUvBz7u4spBzDQ/jHNBsBQ/6nKqS4GgZ8gZBSnfkcXNyYIevchiob8PiE5KlWVsvQRO+qXiFYek6iOiZEb/A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKZw426RpeXxdgb6Wfg5sr54x8JEqzegAT/X5dfefuo7iNBU4Jo
	wikcGcPXl98er9yPjgnItfGBJw43XvT49YZ12zzPujFlI88DQwmWERDt
X-Gm-Gg: AYBFou23IKUa91Fgxix1GYbg/g9O4GuvFgq5Mtu9uffLbJa0US26sPrIbJnfn2hz96w
	SAQsG2bwP/9F2QE8LLGNBuMLuoECLvA8ImYjoqU6UPGZOTuUMI7fCUVe6LQZXzV7FfKUE0pZ0WZ
	o+yazJGmAPUrX0k7cP+jPCGU79IMAdtYXGnJL7GhEiQ/fxXSfyX5WFz3IjA5ugdFfGy7YGMw+7j
	9VVeyd90Izm4ZDo2JmNFomBsqdkT9ct1yjnAkT70vJsN1gGr4u3wpmffokCUwQ/BustHE8AaZw7
	5I+iobDS+VkTSrK2MiKCpoyg9jV/UhaD5yjNNcTkzBzHVOAqNlgeOm8S1uT8gUQfeVrsuZ8wwQR
	WI8DYRpr6qV5qdyD90m5ct42P/PCWwlm4RatM5se+zCg8WKR7PW8f3BgbO2AxQ5er2YHvLfVSz8
	0H7dgKNMt6qB9809/Fvk1sEZJFDPN+8m5sZX7ZpIuN69j3Vm7RjxDDRi6O7UZdz838V8E=
X-Received: by 2002:a05:600c:1393:b0:4a1:d248:25b5 with SMTP id 5b1f17b1804b1-4a1d760e327mr104897945e9.24.1792330723415;
        Sun, 18 Oct 2026 06:38:43 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d2e93a01sm188694095e9.0.2026.10.18.06.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:38:42 -0700 (PDT)
Date: Sun, 18 Oct 2026 16:38:39 +0300
From: Dan Carpenter <error27@gmail.com>
To: Bashirah Lawal <bashirahlawal017@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: fbtft: Fix continuation line alignment
Message-ID: <atTL36chMY_21NCb@stanley.mountain>
References: <20261018123430.148379-1-bashirahlawal017@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018123430.148379-1-bashirahlawal017@gmail.com>

On Sun, Oct 18, 2026 at 08:34:30AM -0400, Bashirah Lawal wrote:
> Signed-off-by: Bashirah Lawal <bashirahlawal017@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index afa8f1c740c5..d58b1247262b 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>  	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);

The original was better.  Search lore for the function name to see ealier
discussions on this subject.

regards,
dan carpenter


