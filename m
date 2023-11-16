Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWQ0zyqX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5492D85
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700134459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ispollcE/MJsw5tJHAndBweyVe132DivkP0ve6luwmA=;
	b=hWQ0zyqX7FwmqGz85gdhxnOqd0fU4sfWXfszEVwb9maZPwxLAT6wm9Sko8Iq8mkF6YD9iX
	0IQrdpsfMXDsH1aplctjxewnT0Y+TSQkdf8kmpd1sFOrfEHETPs8NlHlrkfi4TUqHMuSxe
	643kJbPHcEE/0B2MYmVkTC87Jp1Thjo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-pB035x0eOK-Aqv6dmPbC4w-1; Thu, 16 Nov 2023 06:34:17 -0500
X-MC-Unique: pB035x0eOK-Aqv6dmPbC4w-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507b0270b7fso654803e87.3
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:34:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700134456; x=1700739256;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ispollcE/MJsw5tJHAndBweyVe132DivkP0ve6luwmA=;
        b=KjcNcyNzhM16e0/FcsOO3mnFaBUU+WfCpnYcKDFIHlLIK7hM3XAAO2ueNdWH2mcnpz
         ZpTr6W6ntOIdOJugsJ3gTeBQHVc3WnCmstnydwh301QDDoVqaXeNVdncr4W+2R3zRw6z
         pDh9xczcnUyVU6UgRpYHEivCNptRAlYjCTsVRtCGmTOR5vHnx0L1jzd3kgcUJPxY3CI4
         TXwiZ29/rJtxz96dcNNl8tACk2YgaYR6m4BTNF5ls0pYKvIj1vr3VE0aVU9EGukO6ECb
         Xrp3Tzk5NgGRZ4P+a4V9704gO4WwhOPWy+b7+DiVvC9ERganAPIsrWyvOi5hXJ90A4mj
         SPMg==
X-Gm-Message-State: AOJu0YztSFNftIlaxiFNTiUtcdXd85bovqhTHGK7Ai7FQm76y466AvVl
	hK6Do+eCTCyMX+EWi2Flccqy3//3yGmfJnjVClmSzg745DR3Mu79wi+OoBzzfHEaRzb9dXQNEWV
	YtXqWR94KDvC/bfKJiXVQkrY=
X-Received: by 2002:a05:6512:1593:b0:50a:778b:590 with SMTP id bp19-20020a056512159300b0050a778b0590mr13338744lfb.68.1700134455922;
        Thu, 16 Nov 2023 03:34:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqkyytrftxGwNVsa7xU0GleeO6U1UIFEPfVMbUDzyf0WNqSUaiE4R7Iimixis8gkRzNHWQUw==
X-Received: by 2002:a05:6512:1593:b0:50a:778b:590 with SMTP id bp19-20020a056512159300b0050a778b0590mr13338724lfb.68.1700134455591;
        Thu, 16 Nov 2023 03:34:15 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r18-20020a056000015200b003258934a4bcsm13308726wrx.42.2023.11.16.03.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 03:34:15 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 23/32] fbdev/wm8505fb: Initialize fb_ops to fbdev
 I/O-memory helpers
In-Reply-To: <20231115102954.7102-24-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-24-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 12:34:14 +0100
Message-ID: <87pm0a2aq1.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Initialize the instance of struct fb_ops with fbdev initializer
> macros for framebuffers in DMA-able address space. This explictily
> sets the read/write, draw and mmap callbacks to the correct default
> implementation. Also select the necessary helpers in Kconfig.
>
> Fbdev drivers sometimes rely on the callbacks being NULL for a
> default implementation to be invoked; hence requireing the I/O
> helpers to be built in any case. Setting all callbacks in all
> drivers explicitly will allow to make the I/O helpers optional.
> This benefits systems that do not use these functions.
>
> Set the callbacks via macros. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

