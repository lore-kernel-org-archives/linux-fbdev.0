Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfrEF3+i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA462D1
	for <linux-fbdev@vger.kernel.org>; Wed, 22 Nov 2023 01:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700646691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YRUQw0IBZCnz+KuoV47ilnnGzdOSR+bjrSCjbtytRA=;
	b=cfrEF3+iwcNVabt6jhWjkGG88qGQYWV93l9WTOtwYrEVu9SlptyKbGwnBSxIa46WuK++6s
	mGqoMnVqRWiauLUo16oUDY7GGHkWCq2Pyh5fEuLFhEXuTqSjopwX28KL46To6uSebUxKvV
	neCVAJNDDGmOCcXBE4VOnDwz+ibHErA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-sOt44Ia6PA6sx5Yicezizg-1; Wed, 22 Nov 2023 04:51:29 -0500
X-MC-Unique: sOt44Ia6PA6sx5Yicezizg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a02a5fdddcfso112717666b.2
        for <linux-fbdev@vger.kernel.org>; Wed, 22 Nov 2023 01:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646688; x=1701251488;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YRUQw0IBZCnz+KuoV47ilnnGzdOSR+bjrSCjbtytRA=;
        b=aAh2oZ2pbTqEkbiD8KaxvRmML2H5DyLOJzHzsGUeUBbtsGeCwgRz6YFjUW9HZCoYng
         Vgy7CLlYtsAaJCeIvNOSam9TxJ08VvvYb9EsMm/es1tviM+ozLVhIE3QWSZLnDZaqD+b
         GV2GESF+Gz+EzNQpYTyk5glTBkuaLvaVdia1cnDB6tI/LSxqBsJrhEH++rWWO3sPa2pU
         SGZiiBx14lEVkGaX/TiMgkeUmmdz4qrCaRSweuI6l3Cj6d0vvNijlSQgQUiFKd8jMQwj
         q6DKZAVncaxtUBi1NjzoxUndXTGNYp+qKAzBcWPcRQkc8Qm62t+pR5vUmNNjbPGQZkzA
         pAsA==
X-Gm-Message-State: AOJu0YwKK80YX6pphzOtyCVUpHCR0uX7aF2uHyoOWPhQLVqSqh1eGwtI
	90AbsWrkHS2dHrahyjrkSZoH/ugSAha6i9z7wd3ui3UNsdZb1d1nZPzdftk/lvJ3MnpzHUpXedS
	m/O0cMrf4g77ttZXvp/zAAOBIbW3gyrY=
X-Received: by 2002:a17:906:52c8:b0:a02:bc2d:e026 with SMTP id w8-20020a17090652c800b00a02bc2de026mr901978ejn.46.1700646687882;
        Wed, 22 Nov 2023 01:51:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNpJQXS0vsmxpqXnk0hQQ64thRkz+tdFplkxp4vhRTrwp6LdJ3G8irR5i0TgR9d7R+d347Cg==
X-Received: by 2002:a17:906:52c8:b0:a02:bc2d:e026 with SMTP id w8-20020a17090652c800b00a02bc2de026mr901962ejn.46.1700646687525;
        Wed, 22 Nov 2023 01:51:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g25-20020a170906349900b009fd541851f4sm4012620ejb.198.2023.11.22.01.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 01:51:27 -0800 (PST)
Message-ID: <c6f5e15d-600d-4f31-bdce-9429a3dd82b7@redhat.com>
Date: Wed, 22 Nov 2023 10:51:26 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/simplefb: Suppress error on missing power domains
Content-Language: en-US, nl
To: Richard Acayan <mailingradian@gmail.com>, Helge Deller <deller@gmx.de>,
 Thierry Reding <treding@nvidia.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20231122005457.330066-3-mailingradian@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231122005457.330066-3-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/22/23 01:54, Richard Acayan wrote:
> When the power domains are missing, the call to of_count_phandle_with_args
> fails with -ENOENT. The power domains are not required and there are
> some device trees that do not specify them. Suppress this error to fix
> devices without power domains attached to simplefb.
> 
> Fixes: 92a511a568e4 ("fbdev/simplefb: Add support for generic power-domains")
> Closes: https://lore.kernel.org/linux-fbdev/ZVwFNfkqjrvhFHM0@radian
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>

Thank you for the patch.

I've pushed this to drm-misc-next now.

Regards,

Hans



> ---
>  drivers/video/fbdev/simplefb.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index fe682af63827..6f58ee276ad1 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -466,6 +466,10 @@ static int simplefb_attach_genpds(struct simplefb_par *par,
>  	err = of_count_phandle_with_args(dev->of_node, "power-domains",
>  					 "#power-domain-cells");
>  	if (err < 0) {
> +		/* Nothing wrong if optional PDs are missing */
> +		if (err == -ENOENT)
> +			return 0;
> +
>  		dev_info(dev, "failed to parse power-domains: %d\n", err);
>  		return err;
>  	}

