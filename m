Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fznMueJ6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6561C95
	for <linux-fbdev@vger.kernel.org>; Tue, 12 Dec 2023 13:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702414893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LVAsjbMqpYyZ3IkWoFHSbEJwyLTdmo/iH1LCGeQmZh8=;
	b=fznMueJ6GIEXFsusPyDnZFR275uKWrdcFghfXTxuLDjvjXACUO8ZiZb8n1Mber5wOIpevP
	sFBfJTl59MFEQkBetEt/4r9jnRc9wP5DeJwi9d+mAfwTcWoKdpp1ydJKgDgEVwiCpQTvzg
	/u9W+rkcALdy4kFxncHLqW+TU0NI3Qw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-UsRzdciwP0a944RbUerVgA-1; Tue, 12 Dec 2023 16:01:31 -0500
X-MC-Unique: UsRzdciwP0a944RbUerVgA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67ef0871074so7462066d6.1
        for <linux-fbdev@vger.kernel.org>; Tue, 12 Dec 2023 13:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414890; x=1703019690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVAsjbMqpYyZ3IkWoFHSbEJwyLTdmo/iH1LCGeQmZh8=;
        b=AHZYtIdHmHPTRkuaHNqiiZkG/tDuusr2AgViNog+9Syxc2mp7W//shlvWlwensi4rj
         JwTKc70F4Gy6aTIyU/HrJ7t0ZNEMIc+L3r+L/aMZffNCff8lIX+mK6xKzA7cVUJp0BxA
         3/j1Z1f2rYUpmgClhoVT34mr5LSWJR9iSxxviTcMp/XT0Ymfkdp0NnjfcRqj55F2lj9/
         DiL+LQM6tiTD/vDXqLOxK6py40E4Pm8GWJuhybzz3VL1WTWvFl/ekoCO791IqaSWZk2p
         2ZO/MpkAgBk12Fz4Qpu1OGDp9vQcL95+YiW3vljzY416lVtH/xgoQUSgq7lDnsf7AX8+
         fTuQ==
X-Gm-Message-State: AOJu0YyHh988qIt1Ldw4Ywp1Rm1kYt5RlvK7W11DbU3coGk3A1wwlOyo
	SWyUjcdLFA/Njkx8fsNBNsXjzsW3ef6Pjf+6FtsvHkgalRS4ajFXaYfFU2yGiiQPS+liWL02FBu
	ww1X5nQ5ES7M3tDUvtTMp9vo=
X-Received: by 2002:a05:6214:e8d:b0:67e:aa5b:8e9f with SMTP id hf13-20020a0562140e8d00b0067eaa5b8e9fmr8845939qvb.62.1702414890652;
        Tue, 12 Dec 2023 13:01:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVewhRs7Hdh5QT+34KH2wML5O8m9XHLGWFWDGFa8wOrPNpZCusPikbcT6klf4Qm0z2wwfb/g==
X-Received: by 2002:a05:6214:e8d:b0:67e:aa5b:8e9f with SMTP id hf13-20020a0562140e8d00b0067eaa5b8e9fmr8845928qvb.62.1702414890410;
        Tue, 12 Dec 2023 13:01:30 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id n6-20020a056214008600b0067ea8085b71sm4471934qvr.5.2023.12.12.13.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:01:29 -0800 (PST)
Date: Tue, 12 Dec 2023 15:01:27 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Brian Masney <bmasney@redhat.com>
Cc: hdegoede@redhat.com, deller@gmx.de, treding@nvidia.com, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev/simplefb: change loglevel when the power domains
 cannot be parsed
Message-ID: <lv3bauwrmy2bkycijpmgmym6x2kxo57twl62ttpgsbwecmxoge@quhe7siu6zdp>
References: <20231212195754.232303-1-bmasney@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212195754.232303-1-bmasney@redhat.com>

On Tue, Dec 12, 2023 at 02:57:54PM -0500, Brian Masney wrote:
> When the power domains cannot be parsed, the message is incorrectly
> logged as an info message. Let's change this to an error since an error
> is returned.
> 
> Fixes: 92a511a568e4 ("fbdev/simplefb: Add support for generic power-domains")
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Acked-by: Andrew Halaney <ahalaney@redhat.com>

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
> -- 
> 2.43.0
> 

