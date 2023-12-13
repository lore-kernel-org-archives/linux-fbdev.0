Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDXvrrRC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4B091
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Dec 2023 01:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702461033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1d5lTjfGL0cpfRX3W23YaewhbKiq0LrOed7Lf2Vov2M=;
	b=EDXvrrRCMzgrdfhJtO9gQUE60R9yabukJrwoxhLkHZInc8qri5EVZSeLQ1MeWuBH4R/U1M
	nnARHN4vvw+9paC4yTwTitd2cEejjOEtbvkmLho86hGhE0wm0NAi0VgREXAfs7Lpaki5Jn
	uCk5EraUlaLCjkXejJEsD3yoyIXu3Eg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-FeCiXmhbNhqmaJAjPVQLGg-1; Wed, 13 Dec 2023 04:50:31 -0500
X-MC-Unique: FeCiXmhbNhqmaJAjPVQLGg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c1e05ad32so49789105e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Dec 2023 01:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702461030; x=1703065830;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1d5lTjfGL0cpfRX3W23YaewhbKiq0LrOed7Lf2Vov2M=;
        b=peAEhK7Dpl/u8yZbzmAbzKFFc6L5J5nEvaoAMOG08GutQtQbIX602WlEnqrqVLpiv5
         C5CzWwNKTcnAPmw7qULTZTMcEO5xf8a5SVj8qp+A2QZceAT9rv094HS1QqLBP5hQC02b
         5UqCKPuRlMwL6pZjasKSruBAIFT/uhk9gOTLLB7stu+Ap1DBnTPGbbvhsEQ9jhExSRCz
         hrLXsAZmzoqgr1rdqvntebtxZlXtmJKhvL5sdWTc00s2Myq3Pu92XD3QPrIJEPfSdaI8
         HsUQAJv8+tn3shMezS/0JidX+yohpHotWciZEbIyZs7IGPyb1eDEi7xjS7/rKzpnVJdN
         33kA==
X-Gm-Message-State: AOJu0YyCXQkPM1Rjo5VG3ow6e5SiqmepYBFnOXVFnNdZLwnCZnhnAfFs
	b9+zzJ+lp0VMO1dsW/nBcHSSV66pOHztWC9ffqyU36LtbBM306Hi+lfWRvQTJJzC0OqC63Mus+J
	kZOe1eL1O6B5tMgy7//QGF+Q=
X-Received: by 2002:a7b:c395:0:b0:40c:3244:fec4 with SMTP id s21-20020a7bc395000000b0040c3244fec4mr3483369wmj.218.1702461030254;
        Wed, 13 Dec 2023 01:50:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgqSGM5YlkgEE4x2dZgTCXId+uIFj/eI1/Jsb2o77bKsWa4g8US0w4RLcc8W0HwMqp/ADJ5g==
X-Received: by 2002:a7b:c395:0:b0:40c:3244:fec4 with SMTP id s21-20020a7bc395000000b0040c3244fec4mr3483358wmj.218.1702461029873;
        Wed, 13 Dec 2023 01:50:29 -0800 (PST)
Received: from localhost ([84.78.248.162])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b003334041c3edsm12872969wrx.41.2023.12.13.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 01:50:29 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Brian Masney <bmasney@redhat.com>, hdegoede@redhat.com, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, treding@nvidia.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbdev/simplefb: change loglevel when the power domains
 cannot be parsed
In-Reply-To: <20231212195754.232303-1-bmasney@redhat.com>
References: <20231212195754.232303-1-bmasney@redhat.com>
Date: Wed, 13 Dec 2023 10:50:28 +0100
Message-ID: <875y12o2hn.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brian Masney <bmasney@redhat.com> writes:

Hello Brian,

> When the power domains cannot be parsed, the message is incorrectly
> logged as an info message. Let's change this to an error since an error
> is returned.
>
> Fixes: 92a511a568e4 ("fbdev/simplefb: Add support for generic power-domains")
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/video/fbdev/simplefb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 6f58ee276ad1..028a56525047 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -470,7 +470,7 @@ static int simplefb_attach_genpds(struct simplefb_par *par,
>  		if (err == -ENOENT)
>  			return 0;
>  
> -		dev_info(dev, "failed to parse power-domains: %d\n", err);
> +		dev_err(dev, "failed to parse power-domains: %d\n", err);
>  		return err;
>  	}
>  

Makes sense to me.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

