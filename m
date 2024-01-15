Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBBB5C98
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Jan 2024 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUMqzTNz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705307052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WdHL5Nw4L0E7LviK69bDEOS/TGajAce1+kECtONWdOQ=;
	b=UUMqzTNzA8YwpfeQNOTcFeDejrxF1OHzZTHWnzmfjEDWEqQrdsCpa/3xsHB3dWzD4mcle3
	SwQTtgqerLJsAPRy2iDsifopLt7UW6eV/9MpOl4LH2oC5CpvgDLIexoRG74kjNHYt7h1c0
	/eKecx7THtQHjGUqAtmSaHnxCwdlFEA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-62eB0N2DPYymiQi4TVVdyA-1; Mon, 15 Jan 2024 03:24:10 -0500
X-MC-Unique: 62eB0N2DPYymiQi4TVVdyA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e417aa684so63079715e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Jan 2024 00:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705307049; x=1705911849;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdHL5Nw4L0E7LviK69bDEOS/TGajAce1+kECtONWdOQ=;
        b=VIGJ6eyFt6Tq3klE6M9Gd9WjMz+KJk0N6MjtyNg8nsc3TRr/TzLl5oQymgvTDMc9is
         kGycggJ4v7qTkPmaDMWxZ9fLSUC+Gi4Ou0W++tTzkqOTUbvSyLz7K/utmN4gVpr1KO8V
         v9kwyijE9dKiAemiEO1iHhCrQkAFHI62kThlFcRExSSEd1acP7Q/8CTQ5CfLEOWL6D11
         QjkQvNk7w8Ctx6dLizcytgefE5bom+GJxKjAT+ka2H9TIDKdSMTIqpqI0VIG2cieyM9Q
         B5IuU4hlgcnzvftLKwpg8Sjx6hQIw/InVibGahSnldp+Mkla2VaVORaPf5GeI9xHVHCH
         ZJkA==
X-Gm-Message-State: AOJu0Yw/RHw8sRSe0pg2xeGMfElFfi/H2fLklQANZIXc2jYn3hV0CHsw
	CCnSaz7RJUHcFFijMFW8AF/oIXkH2mkLTEkiYMDVMamdtch+vaoUTm7NGzMSycqvm34ShPwEoZl
	dc3yZkkGGTxH7A6S76s+iPAcmOtN5wFc=
X-Received: by 2002:a7b:ce89:0:b0:40e:616b:50f with SMTP id q9-20020a7bce89000000b0040e616b050fmr2463779wmj.141.1705307049671;
        Mon, 15 Jan 2024 00:24:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBEbtq4O+FopQ6pQyQO1trt0NUo5+q0+USaIZPNgscLYIqA4FgDvQ2PPDGSn+Q3oE/+3Jcxg==
X-Received: by 2002:a7b:ce89:0:b0:40e:616b:50f with SMTP id q9-20020a7bce89000000b0040e616b050fmr2463771wmj.141.1705307049365;
        Mon, 15 Jan 2024 00:24:09 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g21-20020a05600c311500b0040d30af488asm18874042wmo.40.2024.01.15.00.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 00:24:09 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jingoo Han <jingoohan1@gmail.com>, Daniel Thompson
 <daniel.thompson@linaro.org>, Lee Jones <lee@kernel.org>, Helge Deller
 <deller@gmx.de>
Subject: Re: [PATCH v1 3/4] backlight: hx8357: Make use of dev_err_probe()
In-Reply-To: <20240114152759.1040563-4-andriy.shevchenko@linux.intel.com>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-4-andriy.shevchenko@linux.intel.com>
Date: Mon, 15 Jan 2024 09:24:08 +0100
Message-ID: <875xzvovh3.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> Simplify the error handling in probe function by switching from
> dev_err() to dev_err_probe().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

