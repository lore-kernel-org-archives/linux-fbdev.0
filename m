Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsroFrRN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA4210FA
	for <linux-fbdev@vger.kernel.org>; Fri,  1 Dec 2023 01:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701424569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMatjIHd9Tk5Na8CUQZIbQMvS/gfCHln8w3M8+88Qnk=;
	b=UsroFrRNGYaisJSJinzOXX0z0Y4XaHwBfyH5karyW6wsWLS65oeNoPNDXYN1WJOHlmbCwc
	7GLPAQ/O3kMNZLY/Q7URecIadyZ/YviBL5HZ62jQ9DTj+/gEQaJN2vUcp3pIF0ex74YzXN
	wgwqrv6QpgRrfzsNtyiaGxfHlbDtKxI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-ChQ4yMPnMwGU0Oo2-815tQ-1; Fri, 01 Dec 2023 04:56:08 -0500
X-MC-Unique: ChQ4yMPnMwGU0Oo2-815tQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3330881541eso1549528f8f.1
        for <linux-fbdev@vger.kernel.org>; Fri, 01 Dec 2023 01:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424566; x=1702029366;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMatjIHd9Tk5Na8CUQZIbQMvS/gfCHln8w3M8+88Qnk=;
        b=axeLd4p52QNOgCXB7gLzLgMOTpWhA0OfoZMzyymdu9yjRDazFlDYej4i6xZ6LlOKhY
         n6CW042RLiOhNjhGLuUOCRbaeOEaQGsawR1yPckP5j2v8VycXEB+xhv84ruUwrJkLCfm
         8GprDqsnO+z9gFeLCnEf0csJbbr7+iJAXhayrdMf96okNWofa/paXmMqL60OtCTqB9Z0
         SiZyK+jCFsXPB4B00I44ctZzlD0n254vUad4Jy0Ncjk8/him9dTiLlTr7JZyw/nfvvsz
         L2TRKrbXR9ys7XMztgLwgbk13cwh1xDBERAWsHtti0qHwWucm9FwOauYYZwXxkMbWDHk
         4I0A==
X-Gm-Message-State: AOJu0YyWUhsmWuLihlLAW+BRrAyAIBoZFtJj5fwbc/ihnyhwwu4BWc4M
	CCS0DF+JOXsP9WsnTKU2LRu8BuJ6UAsT3LsoKl/NcqzD9r9UpCuMdrZZ6H0acVaKOCr14B/BWXp
	AON3Nn0kuprR6qiesz09sjiqaUbUD0NM=
X-Received: by 2002:adf:e70e:0:b0:332:c094:fc58 with SMTP id c14-20020adfe70e000000b00332c094fc58mr644383wrm.40.1701424566512;
        Fri, 01 Dec 2023 01:56:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOONX2od7XFZM01C8VjH7MXuBsNPzwhtbrogLN8ZS6GbUumONwXuzXa+GOeKq9RswpItpBaQ==
X-Received: by 2002:adf:e70e:0:b0:332:c094:fc58 with SMTP id c14-20020adfe70e000000b00332c094fc58mr644378wrm.40.1701424566231;
        Fri, 01 Dec 2023 01:56:06 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q13-20020adffecd000000b0033334410d01sm254018wrs.36.2023.12.01.01.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:56:05 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de, pjones@redhat.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/4] fbdev/efifb: Use screen_info pointer from device
In-Reply-To: <cf8d6ea2-e725-4794-a40c-206e53785a29@suse.de>
References: <20231129155218.3475-1-tzimmermann@suse.de>
 <20231129155218.3475-3-tzimmermann@suse.de>
 <87v89il2vj.fsf@minerva.mail-host-address-is-not-set>
 <cf8d6ea2-e725-4794-a40c-206e53785a29@suse.de>
Date: Fri, 01 Dec 2023 10:56:05 +0100
Message-ID: <87il5ixn4a.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi Javier
>
> Am 01.12.23 um 09:54 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> 
>>> Use the screen_info instance from the device instead of dereferencing
>>> the global screen_info state. Decouples the driver from per-architecture
>>> code. Duplicated the screen_info data, so that efifb can modify it at
>>> will.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> ---
>> 
>> [...]
>> 
>>> +	si = dev_get_platdata(&dev->dev);
>>> +	if (!si)
>> 
>> I would add a comment that this platform data is set when the device is
>> registered by sysfb.
>> 
>>> +		return -ENODEV;
>>> +	si = devm_kmemdup(&dev->dev, si, sizeof(*si), GFP_KERNEL);
>>> +	if (!si)
>>> +		return -ENOMEM;
>>> +
>> 
>> Why a copy? In any case maybe the global screen_info should be duplicated
>> when is set as the device platform data in sysfb_init() ?
>
> We get our own copy of the global screen_info as platform-device data.

Ah, I didn't notice that platform_device_add_data() already did a kmemdup().

> Efifb modifies some of the values in our copy in efifb_setup(). If 
> probing afterwards fails, the kernel might try a different driver, which 
> would then operate on the values modified by efifb. Hence, there's this 
> internal copy. The situation with vesafb is similar.
>

I see what you mean. I was thinking that the same device coulnd't be match
to a different driver anyways but it's true that a fail to would make that
possible.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

