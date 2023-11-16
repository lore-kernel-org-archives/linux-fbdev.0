Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1LgOyOq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4EE181
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700130189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QKlQrhqsBoYf+hk0vg7TpTavnWCYL+e+GgtfpdfkoBw=;
	b=Y1LgOyOqeS0WFpnpyw6U6fvJ0VH6vERhGsXdM/K9VYiRqE9eFBYfhzR7+iOEu+K15/Lo+p
	7iv2F+Uhin1GcHCPsIuIBrQioQMH1Th6yjOsaaj5A2kVwAR053IPxp8vjJN83sMeWVMi/e
	NL31Bn0Wrl6v9qa7F2HVsbNTFJ6ExBg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-m51SgLv1O_ymeh9WJf_Hdg-1; Thu, 16 Nov 2023 05:23:07 -0500
X-MC-Unique: m51SgLv1O_ymeh9WJf_Hdg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4094158c899so3245915e9.3
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:23:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700130186; x=1700734986;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKlQrhqsBoYf+hk0vg7TpTavnWCYL+e+GgtfpdfkoBw=;
        b=lG3TLJaX4oPH0qALwtYZyhkNTjfnIsVFpsR811IfmfSpvEFwfeqfl2ONiN0cG/ad5D
         l5xWpvARBW4mIGe6ey3gbROgz9OrZqKm5aWzpAYPkHzZOz6xd3BtODgq7PjQQVVcM0cT
         yMQsM4/N3PiMKNiVSt3L4nWlNEtTkB4f6rQt2R04Jtt7ylTAqUpX2386+vzx8Vke1AhY
         cuw4Yo9j7yq2jyw4Xg9AIrZ93Iz7ONWzbV+s62+DvvfOkrfYLB1g7wkz07hhFa226UyO
         YMekp25i2EtwiKPSBXW6908GEvEIrQmHmzMhfGRgl6otHtd2VIXLNrDDoRiX5MCPkq2L
         NlvA==
X-Gm-Message-State: AOJu0YwlVR6Z6ru27Vw5rern9WqaFQjKptKR8Z+4ijjvwwU/mwnZSOvO
	gcoXtdGGWj1pSNe+uUm8S5UxNTcp7Xf6obwuLFPn97OnUAaIWwF5lFy/TSZHV0aGH/qI7bH+5aT
	M2qm6/eiEDXwW6AC3mp0VS9A=
X-Received: by 2002:a05:600c:3501:b0:409:1841:3f42 with SMTP id h1-20020a05600c350100b0040918413f42mr1450108wmq.13.1700130186779;
        Thu, 16 Nov 2023 02:23:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmsPSg5RpSpbHftJGzRUwc+ZPBT7s0miHBuCtvWrca9PPzS4s3f504W/4AegmjrLfXmUevNA==
X-Received: by 2002:a05:600c:3501:b0:409:1841:3f42 with SMTP id h1-20020a05600c350100b0040918413f42mr1450087wmq.13.1700130186451;
        Thu, 16 Nov 2023 02:23:06 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c314700b0040841e79715sm3015109wmo.27.2023.11.16.02.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:23:06 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Miguel Ojeda <ojeda@kernel.org>, Robin
 van der Gracht <robin@protonic.nl>
Subject: Re: [PATCH 09/32] auxdisplay/ht16k33: Set FBINFO_VIRTFB flag
In-Reply-To: <20231115102954.7102-10-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-10-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:23:05 +0100
Message-ID: <87ttpm3sl2.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The ht16k33 driver operates on system memory. Mark the framebuffer
> accordingly. Helpers operating on the framebuffer memory will test
> for the presence of this flag.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Robin van der Gracht <robin@protonic.nl>
> ---
>  drivers/auxdisplay/ht16k33.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

