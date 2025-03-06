Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1545F26FDBF
	for <linux-fbdev@vger.kernel.org>; Thu,  6 Mar 2025 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741291732; cv=none; b=dVaPteSC2o8KvCGFYQrt63Q6sgcXCp8jABDWVRuHn6zjLpSH1yasn4NNkuF0fRGDg4Vli3NiH3ABe1d4xZqCplyzvPPrnGbXVneOrfnYyxSVo6VAzsjyYduHoSj2rs0oq6TmZVlvZW1pVjfphGK2UR/UN1syvTb6GPNOfFymAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741291732; c=relaxed/simple;
	bh=4ANQ6jxnMVqPUbO8KxS0IbrnE06KdtXQZKCpH/+k1M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcFdp0PbhNATy+BcMjdIQ3hdfUT3QuuQ5jIwXljWjEoSNW5eLt2P3qkJvJphyhCpVLzwVyFwGu5AcjRohz6zyn8wB8qtBSutnyL79PMRuT6FJTJPOgclEOhx6hgGbZfHhBDoOdtc7SthrCZ8tSSGMQVm4o8EnP1TLT8c0wVob4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=euhcaooe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euhcaooe"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f406e9f80so828742f8f.2
        for <linux-fbdev@vger.kernel.org>; Thu, 06 Mar 2025 12:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741291728; x=1741896528; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vu6Nb3Ka+Nd4QHA4BCCuDDi+MFoZySYQiXMqKDLBjpo=;
        b=euhcaooeRrLJfc8iV0QsMELCxV+j8/zxsrPUDsIiqjTESr2tj0ZUvH0+eeqpaNaw6Q
         ZZXgll9XMjEJMnLyXF6lbuI3lYlw/gnlFF495tAkjkg8JRlisrCislRwfH6NckD184D4
         V+eeCOyGvS2b7eheTyeAwYnuQo5aye0lbrNmUfE/F3fKv/87dVfEZVl2kMmdz+T81Twn
         SVZERV1QP9p3vz9dGub3yYNvp3C610M0zpsMSAd91Por1od3avTdvSHmrbOHcvKL70M+
         ODNqCcbax0e64QDnk9RSRujP0iJujQMnuSN9SMUlcpTAf9Bj6nzAEG3iOuy+qYsoATVu
         l/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741291728; x=1741896528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vu6Nb3Ka+Nd4QHA4BCCuDDi+MFoZySYQiXMqKDLBjpo=;
        b=nLaaRPNCwbTI7pf5rVgw0zI6Tn7cj7NaO9Jh/GOfNgxegnaWULy0FKh+OyHzBJE9Zz
         x5debEKQ7iVUvtfjJHyS6NbDQDmWREV/mfz8R98WWzdvwu9O2aDYPyuZvhrwTG6Mqzwc
         8OP7qHWkiIlL5nNcx/UXcA2lj7FyrQVvk/4fOxwfpjinZovODrElcB1jfTfISerw7oVV
         QT7hluIFvS5daZZIfiYnUm/hr3PfygMBzcuH7Sz7OA61WMzN7rTfGaw3UAHNSNeQu+Rl
         r4qPFfHKQjG5l/7ABWi+WHaeNSMSMX+V2Ab6ZTGc2vzml3dL0tcq3iJAdU5I7qZ04bzH
         g2Cg==
X-Gm-Message-State: AOJu0YwxPedJH/97RZUTHkLxb5ZiJnwvd18tn0j5a5D3WTtfNFlVupFX
	Y7F0+zzinR4emMom9ug+Ar1e8nXUbx6ZhaPaf0QTrDqhQ8/hq/ErzRU76tN72pY=
X-Gm-Gg: ASbGncvkgcj9SltOplvpMCJRlzaTxweYGcUd4x3eB8qp95Su3SjjZLDWAzJxFod/Ahr
	BQ4evuKzP/prZPA5EH6UC8JQqZICz0SD9WhPB0jYwEDrIC4AI8Rq41nuFgv5W0LmIUizoLOjz2n
	oVuVaJnwWRBHaQM9LpHki7IKa7QmE4ny7aM1K+6WZZtGgAF3Rzp3uUtGdPgGvsDtW5mCULmNSja
	fQVlx6Jx1/Bx4b7clx7xSiM8HZp3RuKmJb6AuiPzf2ZcDRHXlgdpr3hP5/fPbPDhYGaswQwGQzp
	CkuL7JTzjukABBcpsNHoTmyoCdxTgEVkSUNy2GtvCjW9mPiyhg==
X-Google-Smtp-Source: AGHT+IEUEM1THRDjnKYSch5Ww+/6WcBAoHn7/OHeW6aQR2tMBEMKVdYUpqjgGMl6Rqo4PDPLKLMO6g==
X-Received: by 2002:a5d:6d8a:0:b0:391:1218:d5f7 with SMTP id ffacd0b85a97d-39132dacbd3mr295375f8f.40.1741291728288;
        Thu, 06 Mar 2025 12:08:48 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfe0004sm2942613f8f.40.2025.03.06.12.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 12:08:47 -0800 (PST)
Date: Thu, 6 Mar 2025 23:08:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: sm750fb: Fix CamelCase variable naming
Message-ID: <b500aadd-e273-4434-8219-6e5c04f7c8e9@stanley.mountain>
References: <20250228162359.14029-1-lima.gabriel.luz@gmail.com>
 <ba45d980-c6b1-482a-8bfd-457a92d3e24b@stanley.mountain>
 <635f849e14854b0db1f53a0d0bf329c3070e5859.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <635f849e14854b0db1f53a0d0bf329c3070e5859.camel@gmail.com>

On Thu, Mar 06, 2025 at 04:40:05PM -0300, Gabriel Lima Luz wrote:
> Em sex, 2025-02-28 às 20:40 +0300, Dan Carpenter escreveu:
> > On Fri, Feb 28, 2025 at 01:23:54PM -0300, Gabriel Lima Luz wrote:
> > > Adhere to Linux kernel coding style.
> > > 
> > > Reported by checkpatch:
> > > 
> > > CHECK: Avoid CamelCase
> > > 
> > > Signed-off-by: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
> > > ---
> > >  drivers/staging/sm750fb/ddk750_power.h | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/staging/sm750fb/ddk750_power.h
> > > b/drivers/staging/sm750fb/ddk750_power.h
> > > index 63c9e8b6ffb3..33e852fe6949 100644
> > > --- a/drivers/staging/sm750fb/ddk750_power.h
> > > +++ b/drivers/staging/sm750fb/ddk750_power.h
> > > @@ -3,10 +3,10 @@
> > >  #define DDK750_POWER_H__
> > >  
> > >  enum dpms {
> > > -	crtDPMS_ON = 0x0,
> > > -	crtDPMS_STANDBY = 0x1,
> > > -	crtDPMS_SUSPEND = 0x2,
> > > -	crtDPMS_OFF = 0x3,
> > > +	crt_DPMS_ON = 0x0,
> > > +	crt_DPMS_STANDBY = 0x1,
> > > +	crt_DPMS_SUSPEND = 0x2,
> > > +	crt_DPMS_OFF = 0x3,
> > >  };
> > >  
> > 
> > It seems these are not used.  Just delete them.
> > 
> > regards,
> > dan carpenter
> > 
> The dpms enum is used in the definition of the 
> ddk750_set_dpms function in ddk750_power.h file and
> this function is called in ddk750_display.c on line 158.
> 
> If I were to delete it, what changes should I make to 
> the function mentioned above ? 
> 
> this is my first contribution, thanks for all the help.

Huh.  Using a enum for shifting isn't the right thing.  It should
be unsigned int.

The enum does serve as documentation.  Maybe just change it to
a comment or something next to the ddk750_set_dpms() function.

The ddk750_set_dpms() function does a weird thing:

	value = (value & ~SYSTEM_CTRL_DPMS_MASK) | state;

state is something in 0x3 but SYSTEM_CTRL_DPMS_MASK is
(0x3u << 30).  I bet it should match the on both sides of the
if statement:

	value = (value & ~SYSTEM_CTRL_DPMS_MASK) | (state << 30);

But I can't test it so who knows?

regards,
dan carpenter


