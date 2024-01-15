Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CB27475
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Jan 2024 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYzKJjCB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705307248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pehUlh5mpGQ5TGIbBN/xVKuXzozmXoCM9xJyPY4GLE0=;
	b=GYzKJjCB6Ub9oM6AtPeKHLpid/ui1SptJbxTTFAtSQ3M1VeiwdaNT57zqRK+c1Fsu87sgJ
	ljsdxlwWWkTum+hmOyHsNyP9VunlMBEOIafr8IXaoyuTjUOBb++uUH8KxHth1xr7n3MnJy
	ABBpGtF3jEJpwzRORyFYMDWxyOdzW/A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-74Z5NRAaNEW41c5vKEkVtA-1; Mon, 15 Jan 2024 03:27:27 -0500
X-MC-Unique: 74Z5NRAaNEW41c5vKEkVtA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d6e7334cfso77122565e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Jan 2024 00:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705307246; x=1705912046;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pehUlh5mpGQ5TGIbBN/xVKuXzozmXoCM9xJyPY4GLE0=;
        b=gp1dCSIkbEhMC099BO9aatQ3LjcyjVmW5TS+QTf/QJlU6UcPYfRkkQHl/enyL+mo/5
         2OJ9QX0cA7jq52OT6/z98m15WVtoI/16HEiyXBB3xRiqWBT4QQIEZ12gJPYm2F1uvh8k
         Y8bAHRLLHjWUP+Fbwk3IYO/dqlfvAqSo78xLlo+d0Z0pLiOfq3tsnwEKpgfUOY3IzwCv
         NIx7Zv7VRY0tXg3hVcrUU3BicJPAOg2/xZjD5zxhdrmg9fsm3g+aAp5WobDZrDTX0sGy
         kbwaJUBY3/ze33cTvhR59H9Ce3/8R+LGW3q88Fz0HLG7uiFGg5XO8ECDCOqZCzmhC/o8
         G2Gg==
X-Gm-Message-State: AOJu0YwmfbYN+0QaTjXrx4TdTRsB/prsnrrV8b64h1WkGJa3CTFG3hh0
	Isw2MUeTQeiA85G/K//WLFgdZsMUXAxuxxhPR+cMLHCg2pfy1lGHmg6N+gR5/kW8r3LN+7IZPn6
	xR5GNH9gzzdyTs5PRwVFeyPbA1VCsH7w=
X-Received: by 2002:a7b:cb93:0:b0:40e:6792:ac08 with SMTP id m19-20020a7bcb93000000b0040e6792ac08mr2081308wmi.14.1705307246017;
        Mon, 15 Jan 2024 00:27:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2x/nlsctM6zk5v7GGg1IXQBdJ9MByR0vhFREzXeFeH6SHdHa07Hl7vvvScqLoCtW0k+RoYA==
X-Received: by 2002:a7b:cb93:0:b0:40e:6792:ac08 with SMTP id m19-20020a7bcb93000000b0040e6792ac08mr2081301wmi.14.1705307245688;
        Mon, 15 Jan 2024 00:27:25 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g7-20020adfa487000000b00336e69fbc32sm11277592wrb.102.2024.01.15.00.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 00:27:25 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jingoo Han <jingoohan1@gmail.com>, Daniel Thompson
 <daniel.thompson@linaro.org>, Lee Jones <lee@kernel.org>, Helge Deller
 <deller@gmx.de>
Subject: Re: [PATCH v1 4/4] backlight: hx8357: Utilise temporary variable
 for struct device
In-Reply-To: <20240114152759.1040563-5-andriy.shevchenko@linux.intel.com>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-5-andriy.shevchenko@linux.intel.com>
Date: Mon, 15 Jan 2024 09:27:24 +0100
Message-ID: <8734uzovbn.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> We have a temporary variable to keep pointer to struct device.
> Utilise it inside the ->probe() implementation.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

