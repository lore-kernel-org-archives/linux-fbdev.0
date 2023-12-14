Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4xp4/2I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50EB115
	for <linux-fbdev@vger.kernel.org>; Thu, 14 Dec 2023 01:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702547330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aac/fS+HABTTdTt9Tjp0/ej5UaiGQ4YUyORo11HpcO0=;
	b=F4xp4/2I9DPL5e0cnrcWGagZNB3xkuv8HqlAFnoECAO2Wk/Ma2nklUVXuigh6C0+uv17kq
	vMbEFzszGtF5Ai721kT+AeQPEP+Om63JS+X8OuhadQB165Voghs/lptiGAYd8UAn1v4rjo
	IaWytgFVNSiIvw3vqFm7TKZeE3DYfKI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Pf3V6IdQNTCtxPFJASs2JQ-1; Thu, 14 Dec 2023 04:48:48 -0500
X-MC-Unique: Pf3V6IdQNTCtxPFJASs2JQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5526368023cso397941a12.3
        for <linux-fbdev@vger.kernel.org>; Thu, 14 Dec 2023 01:48:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702547328; x=1703152128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aac/fS+HABTTdTt9Tjp0/ej5UaiGQ4YUyORo11HpcO0=;
        b=Yd0sRDXqZXb7tg7wJboK1PzaOCrTD1zVIgYPTa2N56sOBavSX0VjVj/7SpzqYPAoSV
         tSx8SmExufO868seTmZd7K6uRpGsBpYTuA/bUdH39KM2vOnLyu+EBt1Bkb2eY2ZE3vvv
         +GSiaTzHZCJiKmut3ocZTcah+ynP3xABoVBRoA6Eu9kPO+bgVlt1ealnHCYYJkGGz7ov
         PEBTGmlGwH+8XVVmrMdCnyq8r+MydUDGI/PUG54d9LyZjIPq+xGSnuzoe8Brp1s/lYQI
         S5OD4d+8rr4Ki6iBSxWyy5kA5GVX44PkLszfj1yiwC1+lV1YS6KmYAAJAkIz0cV/BH/h
         z5dg==
X-Gm-Message-State: AOJu0YzBpweCVGyeeYNXDEOswlAPAsBRHuuzicG0BRUmAQpOPljmMrdm
	dMR/SREVzB6j9dybUHi4BFrpLEV8S99dX51wOtX18dwtllKPZG2fdIKHk9u7q9GGXzaxDk+d4jY
	xvDbHsvlGe0jGH9N2h6DI8D4=
X-Received: by 2002:a50:d692:0:b0:551:e5ea:cd32 with SMTP id r18-20020a50d692000000b00551e5eacd32mr1623889edi.23.1702547327875;
        Thu, 14 Dec 2023 01:48:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfAPTl0ZBTHUgp9clExLMwVaQJM4BXpD6DoX/3U7sXNMttZ5MP+uupqGj8TWjV6I+QQzg05Q==
X-Received: by 2002:a50:d692:0:b0:551:e5ea:cd32 with SMTP id r18-20020a50d692000000b00551e5eacd32mr1623879edi.23.1702547327612;
        Thu, 14 Dec 2023 01:48:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k13-20020a50cb8d000000b0054cc7a4dc4csm6427998edi.13.2023.12.14.01.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 01:48:46 -0800 (PST)
Message-ID: <a65ca848-20cc-4794-9731-c84eaa295fbc@redhat.com>
Date: Thu, 14 Dec 2023 10:48:46 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/simplefb: change loglevel when the power domains
 cannot be parsed
Content-Language: en-US, nl
To: Brian Masney <bmasney@redhat.com>, deller@gmx.de
Cc: treding@nvidia.com, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231212195754.232303-1-bmasney@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231212195754.232303-1-bmasney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/12/23 20:57, Brian Masney wrote:
> When the power domains cannot be parsed, the message is incorrectly
> logged as an info message. Let's change this to an error since an error
> is returned.
> 
> Fixes: 92a511a568e4 ("fbdev/simplefb: Add support for generic power-domains")
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Thank you for your patch. I have pushed this to drm-misc-next now.

Regards,

Hans



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

