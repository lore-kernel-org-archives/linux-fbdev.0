Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285BC39A7FE
	for <linux-fbdev@vger.kernel.org>; Thu, 15 Jan 2026 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768481464; cv=pass; b=YL8qRPhI7xFWemgLoRV7Sc9gSWo2WJKNPACiXUVL3yIvZERWy6SwR4DBtNTT0VBmiobGyiPv4Ycy9xkv+on9Ol6goBgZdJg1Voelc9c4e2r34LlwiC93arZtHLBSLZNyEeVJlVUrF9CH/dTV/Hq2v4ntJtZeoVX/o6cA1AY8U8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768481464; c=relaxed/simple;
	bh=Zarl2LJ7UY5ioSJLPlpaoAe/GCT8sxcR4I2/Yn6UV8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bU+jOWHChClPL4UXfuScK1spbRdLj0CLz37yZkBYfnOfPT5u7iS34dnkhHyoUAgMtQjChBLx4SqxUb4CnA3E3GEED6ZzT/9a6GcX9tLeYo7qfybZh6L9d9R5l1GCO6rzwChxoQ5YoFp5TjS1aGWH8BWo6eOzRY3cUx3b86yZClI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0l5ZCvV; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0l5ZCvV"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64472121ad5so605305d50.0
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Jan 2026 04:51:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768481462; cv=none;
        d=google.com; s=arc-20240605;
        b=YPV7bqxmTPOKKmp/EAzRPnMhyXuxS2G07CC1sLsaaSXsbpoTp19vSMUdAqjziFBgVD
         4buwuwtZQ9IoED5tc5wqgS6gP7wIkivtKdhKMJxbmEcy7n1ODY7fswf4vz1S03A694Dw
         QznsgR+eCV/5/oL8HVqqOiummPS367iwTATzzaY+OYyShMKyHRq91FUQ6fFurp+Z2sTx
         SlcsOqxEU+Evc3UIvbNP3GYvUZLX06C33F5ah205vdzMb4t0xAOYSo9siUrEaBwiUlrD
         8YiwCDHuOvAknDYgsLHjS9EgL1HznCUa0YcmDDJ9vA3qq/s0qRp7gNKuzDQsfIE4/wv+
         rwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8ihpgU/XH8/vMbQwTuQEOstZ+MAwMnZDme5L7jGlj1I=;
        fh=5h27GrKh1HBNZXDEJ/OajgmaB3AqKXjZYAKsL3GkhgU=;
        b=Lt6fRnjp7/XxtxBiSRNN4eaTAkt/TGfttif4B06rwqU7A4spF7L8lwX7xKa5paZrVq
         x5IdxE322O+C7CkchHz9p8yqO1/fjHfmdaPbvBd6MW6PF3qlxEhYBPaHdDE5mCk17q1v
         SjXYPcbZOEHcGsnxdOfWRlu2nrsb7pZ4sHnnEu9zQY8J/WlPb3XAPuGq43y1pckxqkyL
         UkjNtn8I4mJsDIWKGMLrESyzTxDZX9JFkQFgKScv4ZOXQNfnGyBnLaUqOQH/6Cwl9Tfa
         VR0+Wa2T8CR+RKryc0TDg/sxGOsZi3USklEfFxpzFXfIT3xv8wyOkqwbRc4Uuwhx4hk5
         /TGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768481462; x=1769086262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ihpgU/XH8/vMbQwTuQEOstZ+MAwMnZDme5L7jGlj1I=;
        b=h0l5ZCvV4pCR/9DX44oJHpaK1NKy/9JO0Zi0i8yGtq83ljWGKAfUiKtplczI+o54/P
         H7BBbYVERVCrvo2sKR9UFKUxF0ypITJdB28mbf0b4GXIC6z6YP3vokZQc561TsSKDTWb
         jNKVmMm8s7RyZ6EKlOxcU6ClMiwSlbYj975jM487rurcUKEIhHtz/Mb+OAj8T5A+Lsvc
         3jK82JJenLg1kEO3M7GcosOH5o+xk2Ix0akxhPU7EJ7ljz/HnRV0mh+OYrTHWfWiQNyu
         Hx0sJB4CJJO4mw2ux70+tK75OIynk2mPdy6BRvSuGPteiOW5GpxSd6Hd6QhQuBhDhWgN
         85rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768481462; x=1769086262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ihpgU/XH8/vMbQwTuQEOstZ+MAwMnZDme5L7jGlj1I=;
        b=D8bO9cCmEN/NB6BYhWZA3wHi1Z1KYhd3jZoh0E6++eVovXMgQ9PX1cvk8zxfDOwFES
         8/zgZasv6d7OqUekS8jkkzgQsFHB1D7KkH6YFWJsLnwv0j6u/2oG6I1WRNh0k0Ufllnx
         +n6xsAeA5hEpSyHgKBYNldYXn2dEC9M8iuhrx79YK4otZc2Aek93Ht+d+zqg/e6yxip6
         fN0hqpO8bplJrbRGxNa9EKn/IIVww0KU5lw6LEP5bPYbCk+uCI7M+FyAI5e3PxlYfyDr
         Dt8+hRvKeyTbTdBz/g+3+zhzjfF11hMEAcanq0L8Tvlds0BBZX2MWJ+/RQRfve5CGhXA
         zHkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgGaR7DDDjVASOOWcNY8Fd3pe8mqeK8hLchuL1luMsESwH6FkyoylgT/3oyWT8TSocUiz5OHFAdEzqQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVlU5zzSewZTba6UjuFBLgppwo74Wng25meHDQVzPeXhjVCQIv
	HylF8+dEwxjHSXM8FPnDqRM+ez1WTNE7r+QDOCoUzKDSF8B9Oc/o1FbvfpRb9hivT/dqkbViaK7
	8WjYAjj7u2jUCBS4GfOsWcy0THHwUP6y52CB+
X-Gm-Gg: AY/fxX4tGVJCEkhI3D6WWWeKzyb7lW1HoGtIsA2wo5tF/So6qQKVDeE9zkl9Cu4AbBb
	p2R3TzZ9M5XxkMbGv83tgi3TRqHpIwRqNB/psSyHWKL9ET1gLWvkTVBd+EHXYJWkYpUeAff3MIc
	itNuniE9v5ZfkbuXfx54P4aasYfLMtLMVfOUepzXCWM4xemdmxLrAi7+vItrj4vcbI+2Vok+7gH
	BKHTVU8S6f86PoHn58F/duTdwwsmurJTJ6iRHJzbpvYIH9LuHFWX0EU9Q7K12SrZ9lqAwcEpg==
X-Received: by 2002:a05:690e:1699:b0:644:6b68:f126 with SMTP id
 956f58d0204a3-64901b1b0ccmr4522816d50.77.1768481461993; Thu, 15 Jan 2026
 04:51:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114171748.34767-1-karthikey3608@gmail.com> <2026011521-regally-lunchroom-5602@gregkh>
In-Reply-To: <2026011521-regally-lunchroom-5602@gregkh>
From: Karthikey Kadati <karthikey3608@gmail.com>
Date: Thu, 15 Jan 2026 18:20:50 +0530
X-Gm-Features: AZwV_QgQmeHSK0Y9SpY85bGiY58cjpqcX7XggsiI9jfwAkSE0vGXDVRNFOR3Tgs
Message-ID: <CAPsOcum71Rt7i+CcMR9-ZZOxjkfJBrL73gR7UppTrE5Wgz9wKA@mail.gmail.com>
Subject: Re: [PATCH v3] staging: sm750fb: Convert sw_i2c_read_sda to return bool
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

You are right. I overlooked that the return value is used in bitwise
shift operations used to construct the data byte.
Since `sw_i2c_read_sda()` returns a raw data bit (0 or 1) intended for
shifting, `bool` is semantically incorrect here.

I will drop this patch.

Thanks,
Karthikey


On Thu, 15 Jan 2026 at 17:02, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 14, 2026 at 10:47:48PM +0530, Karthikey Kadati wrote:
> > The sw_i2c_read_sda() function currently returns unsigned char (1 or 0).
> > Standardize it to return bool (true or false) to match kernel standards.
> >
> > Signed-off-by: Karthikey Kadati <karthikey3608@gmail.com>
> > ---
> > v3:
> >   - Add version history (Reported by kernel test robot).
> > v2:
> >   - Fix invalid "Unix Antigravity" Signed-off-by.
> >   - Submit as standalone patch (detached from unrelated series).
> >
> >  drivers/staging/sm750fb/ddk750_swi2c.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
> > index 0ef8d4ff2..9d48673d3 100644
> > --- a/drivers/staging/sm750fb/ddk750_swi2c.c
> > +++ b/drivers/staging/sm750fb/ddk750_swi2c.c
> > @@ -180,7 +180,7 @@ static void sw_i2c_sda(unsigned char value)
> >   *  Return Value:
> >   *      The SDA data bit sent by the Slave
> >   */
> > -static unsigned char sw_i2c_read_sda(void)
> > +static bool sw_i2c_read_sda(void)
>
> So how does this call:
>         data |= (sw_i2c_read_sda() << i);
> work with a boolean?
>
> confused,
>
> greg k-h
