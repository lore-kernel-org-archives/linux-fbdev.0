Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DFE32863E
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Jan 2026 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542824; cv=none; b=B6Bj8nkwLnROCZa0L5bJbwzD20jNRptfs/jlhftNvL3Id/3l/LmNBDPiF1DKFUTgUnTfZlMKx6EXWSVdka/oMmr6XbeMV/vagRsZZbsNhxjpU2yVNhfTvfS3HzJtPnL4QuBYlkHYoHf8Z8pnyovTImxII2iW/nb++FvuHRHfZBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542824; c=relaxed/simple;
	bh=zvk5je7zKiUla10UlKAmaAQo+KOtZIQ20YbfxH9bHi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSi5sCE7iU5ljlk1MiNGTD3cRog9xSibqu2LU0rLThtpelJopxAc318TtFrJDvi1Rw3XJf1O9Mpp9H/rZU95jKmn231F1O+i2I4ui5AotUgQFqBEKJQRlCPECd96ASJkYytwf3hgrjXPvuTrfy3yrgI2o3CMvzo0r0yoV7sJ2ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJVu4Q5x; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJVu4Q5x"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so3291475e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Jan 2026 11:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769542821; x=1770147621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b52qO2yFLp3y0SMOMTd2WsGkQfNWU95x2F2WxKXZb6k=;
        b=YJVu4Q5xKjWbwJ9tW8DWkmMSED/uWDpbt/6I3mzGa5mOytt4zfd2u1sZoX8Axfmvwn
         q3pneoh4YYMe+g91KhEWwpY/i8uxPhLJtalvr9IEJqFqBpy3NPR+vbvKy9RRgvQgRrwo
         m3iamg4MfVrXQKOuZrb4VLS2oysST+ElxKpy8yLsiqB3uXmXCcdKl5+a79D7OsfC7Wen
         QLWP8OHnfMX8cc3AZordzuSnqT9gNXPTBlq4u5zy3ZoW1QF71eGHPIwxJmbmavIlT0/h
         VSdXx1JwnBTD+n+dlxPRDH57E/jfrugS1P6ugYQ0GuCVqOodGmcbC+MvsnrTjLR88Iv1
         Sxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769542821; x=1770147621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b52qO2yFLp3y0SMOMTd2WsGkQfNWU95x2F2WxKXZb6k=;
        b=nH+sbIdLVDKHFtfZUjMejw7zvP4rtqgiqIJYT3Au4Q2Qxdey5YLqiReGYvxN+lbz3V
         1x8M0IGLrbOb+oEcMQz4QMg3wVnKqsufbJJQZ1VdRb7UaB4tS085L0V7x/2MSBbSEeS4
         CBn76SLcvKtLTVeDt8LE+sRpTFC2It0MEAwlfThrpR+GOvg7EtHg/AfKr+YTV23i3tn+
         T1ljxbGu7UweOTLOzkV18c39RalkL+GXRB9io90ZA8TsSXH2Zs+f0ESEPLnpGjuM88BH
         bLNcAdusNmqdptd2rfVyGLuDngU5aReVsrAQ2MEsB2JKx4TjQZyQd/MeEeMXTVLHDR4V
         DTNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN0JYrqKwPqzIqk2dg0hwbxroZz1rOfeJn2/yiAW+KbI6lrUBtM0ITb0fzvtNFMfDdUcyR99+9brMmYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGVK/2CYFcM5mdliwreodNNf2LSr0uhXKZh2Z/lPCt3OZ6AgPX
	gHy6ysVcpFV6u2IkQad2/67jzVoYU2mNU4EYMvhVJ1dTG/AK0ZAVlpZU
X-Gm-Gg: AZuq6aJlO0iTcHQTemPFVxSbnunpoFffAH3jFfflDstmmRDEPDWSEuL03Lbv0qwVLDW
	elB7tEObII9wlj2McnM8gziH+tzj1asbgX/NXlggrcuv90O4rQO1NQd/9GKJs00GM3paLVFe9Rc
	1G7jg8kxiMOsgY73iQavF5w1dUZF6RSEs4bSBEIGnXrH+u15W/HwrPPfLpvmG+Q/U1KiXFCDlN+
	MKt/u0mPU7KorEgkrSDn3AldlHNaiZyk5oNo4RjqJDaTi+g7FTyRaGmcLWGXyCKFhYMsHQ0W1ad
	2Gw2fSf/AseBJuBVQ6mWdtSbl63kNoDuI1/iFFG3MH52FX00bWVXE27N3A/SLd50qTvJJFeeUAD
	56wLm8LTPM4UsEQQB89/tBzAt2JeRoH/IKKm/tiUah1mm8oWLHVRiDAMWrsGyLNFTn82IzQWTX7
	nEMsk54dm//juaBoMDWmIMx4Y/y03op+7qbjtjQpo=
X-Received: by 2002:a05:600c:350b:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-48069b9a017mr35915635e9.0.1769542821228;
        Tue, 27 Jan 2026 11:40:21 -0800 (PST)
Received: from osama ([41.37.41.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee562sm1088358f8f.18.2026.01.27.11.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 11:40:20 -0800 (PST)
Date: Tue, 27 Jan 2026 20:40:15 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
	"Daniel Thompson (RISCstar)" <danielt@kernel.org>,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Yongzhen Zhang <zhangyongzhen@kylinos.cn>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	syzbot+55e03490a0175b8dd81d@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] fbdev: avoid out-of-bounds read in
 fb_pad_unaligned_buffer()
Message-ID: <aXkUnxhRTB4Kw6ph@osama>
References: <20260124164633.20444-1-osama.abdelkader@gmail.com>
 <889fd11b-80ea-4c23-b47f-4e6b17536b0f@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889fd11b-80ea-4c23-b47f-4e6b17536b0f@gmx.de>

On Tue, Jan 27, 2026 at 06:57:32PM +0100, Helge Deller wrote:
> On 1/24/26 17:46, Osama Abdelkader wrote:
> > fb_pad_unaligned_buffer() unconditionally reads and advances the source
> > pointer for the final byte of each row, even when no bits from that byte
> > are actually consumed.
> > 
> > When shift_high >= mod, the remaining bits do not cross a byte boundary,
> > but the code still accesses the next source byte. This can lead to
> > out-of-bounds reads under malformed geometry, as reported by syzbot.
> > 
> > Fix this by only accessing and consuming the final source byte when it
> > contributes bits (shift_high < mod).
> > 
> > This fixes the KASAN slab-out-of-bounds read reported by syzkaller:
> > https://syzkaller.appspot.com/bug?extid=55e03490a0175b8dd81d
> > 
> > Reported-by: syzbot+55e03490a0175b8dd81d@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=55e03490a0175b8dd81d
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> > v2: address the real issue (shift_high >= mod) condition.
> > ---
> >   drivers/video/fbdev/core/fbmem.c | 15 +++++++++------
> >   1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> > index eff757ebbed1..d125c3db37a1 100644
> > --- a/drivers/video/fbdev/core/fbmem.c
> > +++ b/drivers/video/fbdev/core/fbmem.c
> > @@ -100,7 +100,7 @@ EXPORT_SYMBOL(fb_pad_aligned_buffer);
> >   void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 idx, u32 height,
> >   				u32 shift_high, u32 shift_low, u32 mod)
> >   {
> > -	u8 mask = (u8) (0xfff << shift_high), tmp;
> > +	u8 mask = (u8) (0xff << shift_high), tmp;
> 
> This part is correct, but shouldn't be part of this patch.

I just sent a seperate patch for that, and going to remove it in next version of this one.

> 
> 
> >   	int i, j;
> >   	for (i = height; i--; ) {
> > @@ -113,15 +113,18 @@ void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 idx, u32 height,
> >   			dst[j+1] = tmp;
> >   			src++;
> >   		}
> > -		tmp = dst[idx];
> > -		tmp &= mask;
> > -		tmp |= *src >> shift_low;
> > -		dst[idx] = tmp;
> > +
> > +		/* Only consume another source byte if it contributes bits */
> >   		if (shift_high < mod) {
> > +			tmp = dst[idx];
> > +			tmp &= mask;
> > +			tmp |= *src >> shift_low;
> > +			dst[idx] = tmp;
> >   			tmp = *src << shift_high;
> >   			dst[idx+1] = tmp;
> > +			src++;
> >   		}
> > -		src++;
> 
> Above you moved the src pointer inside the if(), so every line
> processed may miss a ptr increment. This means the source would need to
> be different too, but it hasn't changed, as it's still used from
> bit_putcs_unaligned() which prints a char from the character fonts.
> 
> So, I believe this part at least is wrong.
> Did you test it?
> 

I couldn't find syzbot's ReproC, so I did minimal one, I will re-test it and write you.
 
> Helge

BR,
Osama
