Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C451C84A6
	for <linux-fbdev@vger.kernel.org>; Sat, 24 Jan 2026 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769273483; cv=none; b=KU9+5xb4uOf6wChOw7PmYoOxWq3CZYdPtFKHzU692g8Ad7ZpSxeS6T8qb9u0n8G2xROmYEyEgSoSDtZGX7AEfTLv4h0OYgFDIInOTdre9JyoqRsOTH5MjktqQaPBdULt97Qfx8XqQg2tKOrMd++RZV/QwlLntx+/CHQRp3FFZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769273483; c=relaxed/simple;
	bh=rFKmxm3Wp+0q98ygaCBrCQ6u0tQr6uPQEz+F7nuZCno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALnHUJq6INpvhqErANTFGN6oBQ7WEviia+15ntR4dg7fHYpTgX/yZiAH12yR997QZkRSkBVd5JE1+jx3WfE10sfbRexiiiiS5YvXY/lGypVrbeZtNhwe8d8OV6WPfXiCl4HUJ05mKG/CsHqOCgUiOSd8+xFOhX5ASfua5gxWpgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeHNH9DI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeHNH9DI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4359019da8cso2935284f8f.1
        for <linux-fbdev@vger.kernel.org>; Sat, 24 Jan 2026 08:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769273480; x=1769878280; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hxw/rJFKy3Zi43PPBn0FyNiBOjhYEoSqVsfDen/FFE0=;
        b=HeHNH9DIDZa9zH1m7phw8pUGzWfbSuCRVHPVB0Vu9KyXI8RbOxk7oLdZNb+DNRj5xa
         S4E7E4Er8KbjXMe1axXRRdx3z2VjVn1zwWHvzx/0hCEhQ80q3QHeApTlNP2SlquccURf
         xucY79Fb7XzSOJTof1x03olO/Ol38pINMIZe7KILn+BpVZeCV/ILF15reUTsveOirB69
         A+Y99jPkQpVkr+RMfp2+7XBZ5Xyl53X/YNJBpQS1L4M2RBa+MsFJDEW186mkb7Yw9Bv2
         DljJulpeld9F1hgzNhQy2ifdMDMzQpe7cLTBskh1UL4Ck2GO08xeUyrMK5BE9DdFP8Qz
         u11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769273480; x=1769878280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxw/rJFKy3Zi43PPBn0FyNiBOjhYEoSqVsfDen/FFE0=;
        b=ekWOUfyrk7zyaNJp5+soUDycP0PoeuYJw3tKAVQ3IG484AY6OCJWyuaQlI0kcvVl1m
         AVuZqxVqJBZfW85CfWq2KklG0+f3ZacGIQ8bd042QR1dfve3yVuHwFdfgHcQPm5sSKJO
         7cA8OK8qD2edVVsZOYrqKU1P/DeClJ5i/DgnII1o/Khh1Y0f/4J0c6DqO1utBzFtVORk
         RjTzY/sKv+7fa6Ts4NkB1+bjIFJrHSn+DePJIaRKFYmNmi74mu43fzZjpY6Efbf5p+ei
         ATa4peBK/+GEMjkgpUqTIsI09oX7RZTIWbJpHmcDApCcUnjJlrH0vsQ5l78wVgpa9be2
         84yA==
X-Forwarded-Encrypted: i=1; AJvYcCW1J1uIHXSlwfH7lEVL/AzXmmuskmvahxkTwhcENpPdKUD9yEzOAuF0Kqm9DCI7lwGO/rmz5s989zkOHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6l9ic9Ki/eVL2iIVw7gfp/g79pNjyUNtV2SFIqE+1zoaXgpd8
	PwFoJ1RENb9xkb3rccSKc7PaJ2Z0954aR6cKYLurqEX9No3Bxd4IRL2P
X-Gm-Gg: AZuq6aLArSjCsFgb4BpEVAenTEgBZN90+ByzSYdihmNB0LY128w8aEazoD9hKymuIAX
	rwEaH66eBFacZXTHVvh1DPqvTEeySs+vApmD/fKNus4kmMkgdpc/+I1VZJqzj5b1rIpywEedtxZ
	xbo7fBm52iCefneGx81qPMQNO6/o1my6N5p/AjB+9kCziolSTBjz8PgrAqvGnlq4FzW/7Qo5Koy
	qc6+Ojb5nJ+ZB97nrU1VPAB4Ao35CFCdnhbgQWvcN99kSf/MZXhAnyyYYLsI7rWbcgp/T8JbKRB
	k/2GaGbKAgsBoTTx21bX8iHSfECA0lGW7dnhPzovyEwS95JJ/hFZcIiW81MKckPYaD6cC0ZnaS8
	CW7nnH4ieIW/HhIQjvo7JvooAncmbfNwNNMZrEIiRdRRuly1jCjSEsnIuQikv5AWTXKKKtUYUJ3
	DlRccFunduTfdryMOlXSAg6iTVyxSC5ZweXqQHn4IW/R4=
X-Received: by 2002:a05:6000:2886:b0:435:90a7:8db with SMTP id ffacd0b85a97d-435b159cadamr12739865f8f.15.1769273479706;
        Sat, 24 Jan 2026 08:51:19 -0800 (PST)
Received: from osama ([156.223.77.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f73855sm15431440f8f.29.2026.01.24.08.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 08:51:19 -0800 (PST)
Date: Sat, 24 Jan 2026 17:51:16 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Lee Jones <lee@kernel.org>,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Yongzhen Zhang <zhangyongzhen@kylinos.cn>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	syzbot+55e03490a0175b8dd81d@syzkaller.appspotmail.com
Subject: Re: [PATCH] fbdev: Fix slab-out-of-bounds read in
 fb_pad_unaligned_buffer
Message-ID: <aXT4hLBy05W8Spy9@osama>
References: <20260118134735.11507-1-osama.abdelkader@gmail.com>
 <7d4b95ff-8a94-4d96-8b75-6153baad9fdf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d4b95ff-8a94-4d96-8b75-6153baad9fdf@suse.de>

On Mon, Jan 19, 2026 at 08:45:08AM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 18.01.26 um 14:47 schrieb Osama Abdelkader:
> > The function fb_pad_unaligned_buffer() was reading idx+1 bytes per row
> > from the source buffer, but when mod == 0 (font width is a multiple of
> > 8 bits), the source buffer only has idx bytes per row. This caused a
> > slab-out-of-bounds read when accessing src[idx] after the inner loop.
> > 
> > Fix this by only reading the extra byte when mod != 0, ensuring we
> > never read beyond the source buffer boundaries.
> > 
> > This fixes the KASAN slab-out-of-bounds read reported by syzkaller:
> > https://syzkaller.appspot.com/bug?extid=55e03490a0175b8dd81d
> > 
> > Reported-by: syzbot+55e03490a0175b8dd81d@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=55e03490a0175b8dd81d
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >   drivers/video/fbdev/core/fbmem.c | 18 ++++++++++--------
> >   1 file changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> > index eff757ebbed1..a0c4932a6758 100644
> > --- a/drivers/video/fbdev/core/fbmem.c
> > +++ b/drivers/video/fbdev/core/fbmem.c
> > @@ -113,15 +113,17 @@ void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 idx, u32 height,
> >   			dst[j+1] = tmp;
> >   			src++;
> >   		}
> > -		tmp = dst[idx];
> > -		tmp &= mask;
> > -		tmp |= *src >> shift_low;
> > -		dst[idx] = tmp;
> > -		if (shift_high < mod) {
> > -			tmp = *src << shift_high;
> > -			dst[idx+1] = tmp;
> > +		if (mod) {
> 
> How do we end up here if mod equals 0? When I look at the callers of this
> function, cases with (mod == 0) take an entirely different branch. [1] [2]
> 
> Best regards
> Thomas
> 
> [1] https://elixir.bootlin.com/linux/v6.18.6/source/drivers/video/fbdev/core/bitblit.c#L208
> [2] https://elixir.bootlin.com/linux/v6.18.6/source/drivers/video/fbdev/core/fbcon_ud.c#L199
> 
> > +			tmp = dst[idx];
> > +			tmp &= mask;
> > +			tmp |= *src >> shift_low;
> > +			dst[idx] = tmp;
> > +			if (shift_high < mod) {
> > +				tmp = *src << shift_high;
> > +				dst[idx+1] = tmp;
> > +			}
> > +			src++;
> >   		}
> > -		src++;
> >   		dst += d_pitch;
> >   	}
> >   }
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
> 
> 

You’re right that callers should only reach this path when mod != 0.
The issue isn’t the mod == 0 case itself, but that the final source byte is read
and consumed even when shift_high >= mod, where no bits are actually used.
I resent a version that only accesses the extra byte when it contributes data.

Best regards,
osama
