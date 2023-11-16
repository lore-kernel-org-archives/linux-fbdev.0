Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBg3jENr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B60DB8
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700130590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s4K0NJtAI8Ut/gylc6ZVPplq/yszo6HBWl7CF/uc+l0=;
	b=IBg3jENrvC9jtFSs+E3zWHMX6uzEFH7xBnNHLIf9xA13nBZg9nPVboJlHCW+sSEEaPW1la
	VCtw+UZMOB0P0PeL5MUhjj3hps+oh9/oisZESZn0cb8UU+/wapKZbmn/9tuPbSw0Qu/wTH
	C32/wNkkPp7XSXdiMgVwZPoaSaPYd4M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-UucUAQx2PXSYionTT2ecsw-1; Thu, 16 Nov 2023 05:29:49 -0500
X-MC-Unique: UucUAQx2PXSYionTT2ecsw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4083a670d25so3445755e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700130588; x=1700735388;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4K0NJtAI8Ut/gylc6ZVPplq/yszo6HBWl7CF/uc+l0=;
        b=EUdnH3C8MLyaSurZ+52h6PC1sxDKFFD8FMD8YBxr02Rt2c2xCN0NfvismYWmcpx0qb
         85WmvhVFmitCX80+Tnfn8yhuok2nn5o/12uH/3q6lqPBTc7QACQ02vU25rQKJXjylq5P
         JFRpDOucgZ97O1enVwWU9yKHdhlltei41LEljM29ezk61QH/OkG06njhG8zN8J8nmWky
         LAKhqp8KaufHK6JkvmWqd5Ji8GC2FrYT/VWqYZWcOLaeIVJ97bT92jtCzGXZQ889VDY7
         5e0quRObtsx6qSf1JMiDTsESOfF8f1RLM9tavM7Dw1UtsXsy/QG91M9aMsr8lstk9sJ8
         ngYA==
X-Gm-Message-State: AOJu0YwrpU30ZdEWTWbiUav2AVKJOjpqIflQ2NeMRFqxDeOAdxbRE61b
	9O0CtEbqNnpIGrLQeCJUBsp0YN5wiw+SkSdJNfsfJLCSMbagT0UCFcnowDe5i/Yx0KfAFxsTcjK
	i4yZhYLigxRZRdk5DcLLrowgfYHWClnY=
X-Received: by 2002:a05:6000:1786:b0:32d:ac49:2bb1 with SMTP id e6-20020a056000178600b0032dac492bb1mr13618214wrg.63.1700130587862;
        Thu, 16 Nov 2023 02:29:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgdsoziH1ZKEaEPDcC8kszLbLsQivWBIF52pYZtiDhTohP8oeKvhhcyaQz03bxlr6BsqAL7Q==
X-Received: by 2002:a05:6000:1786:b0:32d:ac49:2bb1 with SMTP id e6-20020a056000178600b0032dac492bb1mr13618201wrg.63.1700130587589;
        Thu, 16 Nov 2023 02:29:47 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p15-20020a056000018f00b0032d96dd703bsm13215613wrx.70.2023.11.16.02.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:29:47 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 12/32] fbdev/sh_mobile_lcdcfb: Set FBINFO_VIRTFB flag
In-Reply-To: <20231115102954.7102-13-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-13-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:29:46 +0100
Message-ID: <87leay3s9x.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The sh_mobile_lcdcfb driver operates on DMA-able system memory. Mark
> the framebuffer accordingly. Helpers operating on the framebuffer memory
> will test for the presence of this flag.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

