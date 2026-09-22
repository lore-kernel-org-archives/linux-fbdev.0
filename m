Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849B54EECE
	for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087163; cv=pass; b=YqbDttIUzpd49u/9EGn8Je86JdBXZaoOdurBmSiNT4ykSfdfz9Hv3FqSyjBlwpA5/0TpydUgFHpRjLCGo6Tu0thUtG+IgQH+NgrKGc+j1sYSN9ASoOwsZXyivb9XqmZiwntwOQwl5yN9DVYvXli9PEyrb9ANoXS8huWn3TYGY2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087163; c=relaxed/simple;
	bh=R2qBxqr53zWYaC1RJCIbgPO5t5bIKtz6ByZLfGYSt1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HB2QalW/7KlRe4mVwXGt/oHpdcuP2vBZPhqc1PKX8g4qVjY8MLwmv0EPEIfeTgiqDCnZKdwMFie+gl1cn5IppQW6OJHOZAuiw0V1q35+UJ8U/qXfuImWxxr3xmpFrAjFqzrVNXEQu7Zl33eZgzbBwpVdU/HGiC0dTBAlAJJI65M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqKiLLnZ; arc=pass smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqKiLLnZ"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c67e4d8d8aso2779879e0c.1
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 07:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790087161; cv=none;
        d=google.com; s=arc-20260327;
        b=FXS7ZcxFk6w9LkAywhNkFWdQwM6faLuy0+bz2zpG8Ca6HIO2CgZ9ozh0K89K1quko4
         4L47+xuWqST74uqLijRsNJAvlAuBy9sLTTAvG3Z/1vK0F/jBe+6T+isrPcsvzP5IvOxV
         o6wNTFqO/EnnzYCkn5EmNPe8FfE6Z4PmZLhQj07i/wiGL5tfagstDTeiJs9QLsJ+C77Q
         y0iZooomQZ1dEx8lHlyRo0Sf3GHnZBnUcKZMAibnbKQAramgK1ZQsSpr+5/GOOg/jSqE
         FizkPz9M1qEtnD3RsGqvbpNmheUDeG67ffhtgbFWnq6z3R+yY2a69VFxYbTMW3ZuzIHj
         9o1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6WDR0oNQbCaq9G/Y+cUlOUH1iVOQA7T9qH2RJoZlMM4=;
        fh=BRcuK6NdQywNJRzhb3SxEZQaqG59eCEPLpZgW6OEhHQ=;
        b=QdqoMKLcpM6L/hciwm6qi2fm22xgRZH8UXibpOS8j5Z8ZzVJghtTaVkfm22a8TWtbi
         6qpJiFb/DYSGOwvgjq4cbBDMWWzJ/a0axUPp8xlTisprKMXrH+NH+v/XYTZ9QEcrvkmW
         UFXsSPSZK+wN5wR2IH/vtsKAARAdW9ZZkH02htVIzU0fmyymz7eBkdhrTqVdtRRIul8t
         7PmBCHcMjZL2aoI7CV6rGZ6UlurtPOPcN2YwZgpkNgMMiggp9uNgTQKvmyjM4tY+dI9I
         nnfC069+BCwbkWMju9rFIpEhCqoXO3zF78z1aJ3S/IyN+WSPmE+jJaA+ITyj8HCrswEi
         PSRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790087161; x=1790691961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6WDR0oNQbCaq9G/Y+cUlOUH1iVOQA7T9qH2RJoZlMM4=;
        b=DqKiLLnZyYBsfVvfpnbFouygUXEIaScIX5urIZzGuKd/RGqpnaG0xuJq9dUDN6FDqp
         dfZKnnfbaGml17F0WXllXP5dOXwIYQzyhCgQwklDJhM6XNwGq9KFC4I/Dl3q5BKghSjP
         fmmivsNh520kHMhHoaXeTBPNH8k+pdq337pzQtcC/5j/t9t1oSFrm1HrQJQygB9lc184
         aMNZZmemJl8yzKmF4PWlMMnhRKCg/z9j+5B8DfejiGV5NHqEWdZDkBqk+Rey+H+PO0VP
         hxx1bWdFMbXbk4H1nxF+QudUVv1E83pxu2SEUx4PI2XNXKf6rcxcx3uOJa2lWyUKpQWp
         H3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087161; x=1790691961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6WDR0oNQbCaq9G/Y+cUlOUH1iVOQA7T9qH2RJoZlMM4=;
        b=DhqOl/2E2Bl+rz5tkoLk2M3EaHkqt0f2vXVpmvTsiMPXyFbql29R4Rt+qamf2UapcT
         t08b+zlbd8b5Yqgn3zUkZxeNG2Um7vS6JgPoQD8WB+/iCe4X7ovTi+jAIHCXzuinq1be
         VvulEwiHWgPPaPu9S2IRJ2oSpmZtrrwddwW5am21pDzBZHesVs4N1tJukFtYxO2NBrIV
         5jh4qSf3e8tdj+BPwsQT/TXjPuWRtJTxahUnNiOPknZ1TB5w9cnbVTzWcYO47HMcvFDX
         3WKHmddq2nYO7uqkfuDxqwkRFQ+Jje/BLhxEaeSUBaJQFiptAHPqz7rhJBO1IKYPBMXX
         3ltA==
X-Forwarded-Encrypted: i=1; AKwUvByr3RmafO+7LLRaDjAPIb/X7NkCBh/ASDR0MvrJyCw++ikzFuFvlwsOPlv/qxmxZbXJeJm56QMCfq+sLQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l/cETu/HyQOVwcR/SwybH5MXHVsmoJkoqy8FHbfkr6jqCLsYZu
	JkP5SPGXglMG91UGK4LXJgGslE9htSMq0T0QgcU1DMe4AKV3CizWeZLalH9SZp7eTEpTEpTqw5m
	qN8y61XZ1s9VMwQlyqeNIksLHHGo/Si4=
X-Gm-Gg: AYBFou2zRqma3Oz5L3jzFDaA35j8ba6u5gDXTOkSgnQ4PWwlS5UiBndus7gYRWmFHfp
	4hshBe0iwKGHAabDly5kWWk24RVewn21QD/UFXp40vVaNqe5Fk97bm1T2dmDInD6QQXe+vdF18b
	SVJCX31hdYVZ+qFuYajPEI8gzbZGfLFJvjdgbPZo0MnYGpVlHi8M54vYvc2/aqprLcaSrILyd8i
	+CZLPP8DqQ3LmyWfK6EHtdDIwg+iKUeJQ2w++qzdiolduDz3VeAXawNHRU5i0zN1pENNRg/Bkkq
	fq/vB/hbej1E7igwvfDpabbfluzvHPBiOuuefPEjACnspiREfvJAVPYV+xT8DcTjKdZH8YataP4
	PZiGK4hRaXjZISPGL3UM64Zy2OS8adyDvquoVRGixZhy7PndK6ea/PJ9koMEaPjFYufz7t3eRM+
	knypsizWOu0jB3e5qXjnI+d+2LfengM1+wyQ17Nk70f+Ox1oq1956NKmg=
X-Received: by 2002:a05:6122:8c8a:b0:5c9:a60c:2739 with SMTP id
 71dfb90a1353d-5c9b59c143cmr8717109e0c.17.1790087160739; Tue, 22 Sep 2026
 07:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922035302.167378-1-2000.costalucas@gmail.com> <2026092214-corset-unaligned-2cb2@gregkh>
In-Reply-To: <2026092214-corset-unaligned-2cb2@gregkh>
From: Lucas Costa <2000.costalucas@gmail.com>
Date: Tue, 22 Sep 2026 11:25:48 -0300
X-Gm-Features: AcwNN1VIqNxrPM8IkvNRf8clUfXVQ1DCxuz8v2KE3ex5wE-SuoBeR4i0w3V-_nw
Message-ID: <CAFxsxbpZ7weuZVgdY2mRQJJ+DCAkDHdjwsh3eQg1NBB+9h_qmw@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: free cmap on framebuffer release
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Greg! Found it by code inspection only, compile-tested it. I don't
have the hardware available.


El mar, 22 sept 2026 a las 2:41, Greg Kroah-Hartman
(<gregkh@linuxfoundation.org>) escribi=C3=B3:
>
> On Tue, Sep 22, 2026 at 12:53:02AM -0300, Lucas Costa wrote:
> > The driver never calls fb_dealloc_cmap() after it has been allocated,
> > so when the buffer is torn down we leak.
> >
> > This happens on every unbind, and when an error is detected in
> > sm750fb_framebuffer_alloc().
> >
> > fb_dealloc_cmap() gets called before framebuffer_release() in both plac=
es.
> >
> > Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> >
> > Signed-off-by: Lucas Costa <2000.costalucas@gmail.com>
> > ---
> >  drivers/staging/sm750fb/sm750.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/=
sm750.c
> > index 8b93bfeb217b..92412534239c 100644
> > --- a/drivers/staging/sm750fb/sm750.c
> > +++ b/drivers/staging/sm750fb/sm750.c
> > @@ -910,6 +910,7 @@ static void sm750fb_framebuffer_release(struct sm75=
0_dev *sm750_dev)
> >       while (sm750_dev->fb_count) {
> >               fb_info =3D sm750_dev->fbinfo[sm750_dev->fb_count - 1];
> >               unregister_framebuffer(fb_info);
> > +             fb_dealloc_cmap(&fb_info->cmap);
> >               framebuffer_release(fb_info);
> >               sm750_dev->fb_count--;
> >       }
> > @@ -943,6 +944,7 @@ static int sm750fb_framebuffer_alloc(struct sm750_d=
ev *sm750_dev, int fbidx)
> >       return 0;
> >
> >  release_fb:
> > +     fb_dealloc_cmap(&fb_info->cmap);
> >       framebuffer_release(fb_info);
> >       return err;
> >  }
> > --
> > 2.43.0
> >
> >
>
> Nice, how was this found and tested?
>
> thanks,
>
> greg k-h
