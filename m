Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5vPp0Zd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3691A5
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700135086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWBdAfvMBvXM91oAEjKzolXCmdPgAd5lIYD+DF4PVIY=;
	b=D5vPp0ZdAOHaGwLoF/T2CQU+JnRXpBIxfjxV3I2SQG60Xl/lvMhAj7XY3FyZkyizPramO7
	EtohkxpnOKpmNXabHqGwh821awMBRM+ucJylRMSNMpJ02zBXtClXIhEDNSwBctX8lx7EYr
	V3o6GxEf0Rre1QzVDPxocMQKaZ7cKKI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-An4v-v9FMAyQnE4oD18e2A-1; Thu, 16 Nov 2023 06:44:44 -0500
X-MC-Unique: An4v-v9FMAyQnE4oD18e2A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-408524e2368so4023335e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 03:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700135083; x=1700739883;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWBdAfvMBvXM91oAEjKzolXCmdPgAd5lIYD+DF4PVIY=;
        b=byPhCSg51/lO093F887nDu+mZoG2vPYVpzUbp5+RSBesDKVW3f/53BHgzhayJdos8M
         fku6plAWi87UYJ262BrrgAxdJFn+HaAGLFD+NgCxBcdnkK2Awl8PlZ3Zz9CC0wua6VY/
         N/xjRrfRiAlympyGI278X/T9LkV6Jeb+o56BhvJU2+RofQgDe5TvXohZfFZjVEgzU0Po
         +xQSX6eelBtRJxGoBcD4lzp/yAG/O+3/f8POwGkqGVXzGVx2NTuoBiziQBApnIaavoB5
         bnb2mr6EJPktReeKYuMtke7xfs5VjScTPtVOa82RQ7Tk07ufWrPrTPNeNxcblR/sDo/M
         RVpA==
X-Gm-Message-State: AOJu0YzKiL4Jz2Zb8dypEX34NtTwSh8YsmX7heSXWQ8e78OgHv8+BeUv
	qusqD8hnKFJwYWoFJpwovUdwnmdC8eZQybAfj2FPXXSWIoxdYmPFQo30L42dtxrKKWBlKiG7erA
	UqgfBCexrB9mwGdx7gn97QNg=
X-Received: by 2002:a05:600c:350a:b0:405:359a:c950 with SMTP id h10-20020a05600c350a00b00405359ac950mr13330095wmq.19.1700135083500;
        Thu, 16 Nov 2023 03:44:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAB7R6TX3y7IW/ozo4VrNr9YJdex4yJeaGhFiIclSVMpfZrs4uKUq3O6rvSXhk8OPjiKhQqQ==
X-Received: by 2002:a05:600c:350a:b0:405:359a:c950 with SMTP id h10-20020a05600c350a00b00405359ac950mr13330084wmq.19.1700135083231;
        Thu, 16 Nov 2023 03:44:43 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y14-20020a05600c2b0e00b0040644e699a0sm3203052wme.45.2023.11.16.03.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 03:44:43 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Sudip Mukherjee
 <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 25/32] staging/sm750fb: Declare fb_ops as constant
In-Reply-To: <20231115102954.7102-26-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-26-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 12:44:42 +0100
Message-ID: <87jzqh3ot1.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Split up lynxfb_ops and declare each as constant. The fb_ops
> instance used to be modified while initializing the driver. It is
> now constant and the driver picks the correct instance, depending
> on the settings for acceleration and cursor support.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-staging@lists.linux.dev
> ---
>  drivers/staging/sm750fb/sm750.c | 59 +++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 10 deletions(-)
>

Same than patch patch #6, the change is less trivial and would be great if
someone with the hardware can test/review. But the patch looks good to me:

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

