Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244E5FB84
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529832; cv=none; b=IDJUUJPqDgai5DweXkLmteD7uN+4y9s2JC8uP6VA2VfYyCdfJQD9fkmGDd+ABfRMbbcvxtZtWTFcsmxRQwMramOt6XqG4H10mY24jS62wD12VmjqiM1REYjxfe4NyxbN56CDj7+cLmao66IFlKH28Q78etZP6s7vNByn5Wk837c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529832; c=relaxed/simple;
	bh=JFGA7cUBOxuTjeYN7hldYYBL3yfCZN1NJPOflZBxm+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VIVqGJNi2JV7q3HDkopksICM83EXkXo5sDdIsz5JdUKfK5lntuHTA0tpcL+NSQKdB9OvRi5LZ7/S7hkoPSCqF+h+sP+9PvTdBj7GYaky7zjILM8K1wwJhRAyY0zWBZvxu+eV9yD90ObTgWX0hit9N050ynBPxHkk7zuKJ4AcjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ih0eEp8+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ih0eEp8+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706529829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPGFMKgvwDs0VIMi/vYwseO/McEuakTER7jhLMz5YMo=;
	b=Ih0eEp8+DzdR38N2pCknpzwiEDc7CU+cDVnyRMtNz/ww7A/x8mQCgAniyTpBGOnqPKdoGD
	jgO8Y6wrjJjYSqPA3ntKmPdQ6UpsC5mwPKwznUx34hpWeNAgnJgyNLA2uqxpEFmNcLWQ99
	VHTmNbsXWCOuQILrQZO+v4XA2R10+dY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-bMvfOGqvNIaGTgLagTB0bA-1; Mon, 29 Jan 2024 07:03:48 -0500
X-MC-Unique: bMvfOGqvNIaGTgLagTB0bA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40eeb1739edso16126225e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 04:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706529827; x=1707134627;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPGFMKgvwDs0VIMi/vYwseO/McEuakTER7jhLMz5YMo=;
        b=s2p6EOt6vgApXH+sVQmWAhdqnpy1BPwbpwA4vn9wwpOAK+vBj/9ZEGhIKjbtgSBY7n
         MFjdsVcmJUDqNWLE2CE3adBPKk/d39rwfO5I6HzNOHGvsoQi7fCwb/5OXj7qYkudinay
         rCSrbSFQ/ulOr09ff7SHfIAb2J6cEBXJKbbXkGEqu3hl4ijNWLZcawKG0ZlTjsGF6+NI
         W4AjDQWXX1F5KIKKTxePbwKfW5FgHqqyTwxUthKkfFaIJK9vTzw2qqESNIz+ITTfytPy
         WXsVpRNVKZQ6dNJBwC+eIaDkSlim5phn68Sk6ZnMM5diVmcPbMxogXKzD86Jl9B2ei5v
         7LWg==
X-Gm-Message-State: AOJu0Ywde7o6I05QzbLu672tWbVWNk22I2ZeRXt1LTRgx5Ctn0YsQE2p
	D/T8TP/RwpFYN/vnctNZ4p8h3Ws7etiTVwgqvsZ/d7lspQKWQJbTBbeZBrMHLl95xvdC4BFJ81p
	Q6ligLbaSNvzAroF5LpelvnC4reMZM3yV3Dhrd5UUau2tBlm7QptMtITD6OKCJdKwvO1Z
X-Received: by 2002:a05:600c:3b28:b0:40c:4904:bb72 with SMTP id m40-20020a05600c3b2800b0040c4904bb72mr4293878wms.18.1706529827149;
        Mon, 29 Jan 2024 04:03:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGVZlCHfW1w5Cy1UVaPYsDyCgS09754O46MznaJdDB8+pq2pjRnOyx/vIqTreeAZgsZqappg==
X-Received: by 2002:a05:600c:3b28:b0:40c:4904:bb72 with SMTP id m40-20020a05600c3b2800b0040c4904bb72mr4293874wms.18.1706529826930;
        Mon, 29 Jan 2024 04:03:46 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w7-20020a05600c474700b0040ef622799fsm3619172wmo.37.2024.01.29.04.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:03:46 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, pjones@redhat.com,
 deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 8/8] fbdev/efifb: Remove framebuffer relocation tracking
In-Reply-To: <20240117125527.23324-9-tzimmermann@suse.de>
References: <20240117125527.23324-1-tzimmermann@suse.de>
 <20240117125527.23324-9-tzimmermann@suse.de>
Date: Mon, 29 Jan 2024 13:03:46 +0100
Message-ID: <8734ug73dp.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> If the firmware framebuffer has been reloacted, the sysfb code
> fixes the screen_info state before it creates the framebuffer's
> platform device. Efifb will automatically receive a screen_info
> with updated values. Hence remove the tracking from efifb.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

