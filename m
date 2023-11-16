Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFB2cZpW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892141B8
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700129822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uAtAjL19nZ/0ZV6KMPfpP7ukF57+qpyYq0AblvSNwYM=;
	b=AFB2cZpWTGrIOtoltvqfAl7wEWA8WuoSLn0jbrXdSToKhagKkdvmFA1o5jrksrjArqFagP
	OmfreBIRYw8LDkpncokArmyjsCDf7k1tdtiRZpGhc/U486lEfA6Fqo/fEmBvXYb9iFRusl
	/ygjts9tMKUEmLEi4jG1h6voio/zaPs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-x13OGPBDOVu5CnWeq7148w-1; Thu, 16 Nov 2023 05:16:59 -0500
X-MC-Unique: x13OGPBDOVu5CnWeq7148w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-408f9e9e9b0so3265185e9.2
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 02:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700129818; x=1700734618;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAtAjL19nZ/0ZV6KMPfpP7ukF57+qpyYq0AblvSNwYM=;
        b=mREqdcIZBagmAkobui4Dt3Fpt7dNdDfokhWXwPYdA17IuUG/q2rbrttA0Qtn+8rQ7I
         jZYZ832m5CMKLikpBI95PHfpWMfZHAVPhZ9DfTwEwpb6+n2BZZwN6B0X8E/kf2ddEWyE
         WPdLAl1ElXgpvbf2gMhAb1NBSw/KFnoRx+YknBy8G3S/s+Ecpx/mZ7amp0Hqif1s6yLS
         OKEtKFII00Sr0QNSPxzRrm+0GXsfl8OvMzQ/ANVrg/1A8+0uDsnC2WVJ4EkJzvs49gPp
         sgly/bSr9G4TvtJyTbd3ccCWU44v7ilH65EtEI594KGWI+G7IcyZkA3r6ldK+4tZuK3f
         Um8w==
X-Gm-Message-State: AOJu0YyvS9BCqku86JX2WDC3QEBeiCHSg/yZINWsd2GU8nVbhpIL2EkX
	BcPE3IOfYQmzRkROWefCQ1VJ0oGvuXqbYzQ+T7wNBSY9NyjZPuajMq47HS3v2EJn5XedUnD7ZCf
	6S++waEWnyaqVqNT6AlHZUCg=
X-Received: by 2002:a1c:7218:0:b0:40a:463c:1de0 with SMTP id n24-20020a1c7218000000b0040a463c1de0mr12700967wmc.34.1700129818001;
        Thu, 16 Nov 2023 02:16:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwo4cRZ4kMa/b0dHBNMP9yNxr5MEmvXd6XyahEiigcjOkqMWJ95Q4H6fJ41SYwKyCbs0VP4w==
X-Received: by 2002:a1c:7218:0:b0:40a:463c:1de0 with SMTP id n24-20020a1c7218000000b0040a463c1de0mr12700946wmc.34.1700129817625;
        Thu, 16 Nov 2023 02:16:57 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600000cc00b0032db4e660d9sm13094966wrx.56.2023.11.16.02.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:16:57 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 07/32] auxdisplay/cfag12864bfb: Set FBINFO_VIRTFB flag
In-Reply-To: <20231115102954.7102-8-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-8-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 11:16:56 +0100
Message-ID: <87zfze3svb.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The cfag12864bfb driver operates on system memory. Mark the framebuffer
> accordingly. Helpers operating on the framebuffer memory will test for
> the presence of this flag.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> ---
>  drivers/auxdisplay/cfag12864bfb.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

