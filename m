Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMHqSfoj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B210D4E
	for <linux-fbdev@vger.kernel.org>; Fri, 17 Nov 2023 14:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700259529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xb+39jMBjIG9e9EUVeLvv86Ka0wZnTphGetSvGEJ6aE=;
	b=jMHqSfojxfm5OoXrsh1jpiR5lDs9UHCE+RBkCS16e5PAHi1dmqNsuOjAmHaRd4Q2Ldwpj7
	QmyAvlixQcTjMKLShLn6KW6ijnGgGWZ7HwgVYzxlAXsD7UlS6B3U2j8yYjrJqlZJTHhCF+
	LsNnc49A5VaERug9HcZYh1F6pafD9EY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-7iq47FlQOsalXhAAub_4Xw-1; Fri, 17 Nov 2023 17:18:48 -0500
X-MC-Unique: 7iq47FlQOsalXhAAub_4Xw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4092164ed09so14340845e9.2
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Nov 2023 14:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700259527; x=1700864327;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xb+39jMBjIG9e9EUVeLvv86Ka0wZnTphGetSvGEJ6aE=;
        b=O97Os6MXY30k6oewDjlWgaeYnXizJEmmz3Ygyz63S37fEo1EpXrrBUd4hH/U0JAg2Y
         qP6BNAFmdZyT3qAcQKseTZS9jAhflWFiXtONA+yv8DaO9MQ6uyP0Dtyd7U24Kc27jRO7
         HHX46pnhV0p6B+MzHrIjdmgYvx3fSclQCjfD/flXhJ/9VJL6CSIT3m/7+tH/BPRnWz+U
         i9FxNick2/4XHyNgVcGJBMJ04db/66BMefT7YbPDz7CWfDt1Q9/uG7bWdLrb0hvbiJ5G
         CT/baLndzTnc7UVigxJ7kRxm2NJuwwKcd9sjmh1yRhiK84RD5hjlIxcKa2k3MFTO6l77
         ha/Q==
X-Gm-Message-State: AOJu0YzF+f/hHptVtCgmJBy0ZDPanKTit66aQRf8Q3eEmfJ8D1tKYmYQ
	8pMdYcs0YlBXHdd1Jkmg4rfePSjozyWCYhMUEczEjOaN9kt0F/7P64zQHfSHIiPUfnDRFoe45++
	SxYKFZfpABhbIN7LI3Za4w0c=
X-Received: by 2002:a05:600c:19ca:b0:3fe:2b8c:9f0b with SMTP id u10-20020a05600c19ca00b003fe2b8c9f0bmr283580wmq.23.1700259527245;
        Fri, 17 Nov 2023 14:18:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1ki+IESh+gyMw/wvDuuRKAIdBZvjvrveHDpkuOxRGvzlqclzeFbtQ8juy0XxQQTk1lYkKRQ==
X-Received: by 2002:a05:600c:19ca:b0:3fe:2b8c:9f0b with SMTP id u10-20020a05600c19ca00b003fe2b8c9f0bmr283570wmq.23.1700259526834;
        Fri, 17 Nov 2023 14:18:46 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c21d000b004063cd8105csm8421532wmj.22.2023.11.17.14.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 14:18:46 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Sahaj Sarup <sahaj.sarup@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Helge Deller <deller@gmx.de>,
 Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/3] fbdev: ssd1307fb: Change "solomon,page-offset"
 property default value
In-Reply-To: <ZVfX5Tw71cqKFJ83@smile.fi.intel.com>
References: <20231116180743.2763021-1-javierm@redhat.com>
 <20231116180743.2763021-2-javierm@redhat.com>
 <ZVfX5Tw71cqKFJ83@smile.fi.intel.com>
Date: Fri, 17 Nov 2023 23:18:45 +0100
Message-ID: <878r6w10sa.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

Hello Andy,

> On Thu, Nov 16, 2023 at 07:07:38PM +0100, Javier Martinez Canillas wrote:
>> This is used to specify the page start address offset of the display RAM.
>> 
>> The value is used as offset when setting the page start address with the
>> SSD130X_SET_PAGE_RANGE command, and the driver currently sets its value to
>> 1 if the property is not present in the Device Tree.
>> 
>> But the datasheet mentions that the value on reset for the page start is a
>> 0, so it makes more sense to also have 0 as the default value for the page
>> offset if the property is not present.
>> 
>> In fact, using a default value of 1 leads to the display not working when
>> the fbdev is attached to the framebuffer console.
>> 
>> Reported-by: Sahaj Sarup <sahaj.sarup@linaro.org>
>
> Closes?

There's no report in a mailing list or bug tracker to reference.

> Fixes?
>

Since the default has been the same since the driver was merged,
it doesn't make that much sense for me to reference that commit.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

