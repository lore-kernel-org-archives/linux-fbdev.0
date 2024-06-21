Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4DA15A49F
	for <linux-fbdev@vger.kernel.org>; Fri, 21 Jun 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960140; cv=none; b=fn5za5dHn0q76Ygz3NrewJjmx6AkHK+NfB2mEsTBz50X5CfAJO8qxIGZMfDOBLmLvpTOG28cHdr7DFG/solS5wA3wvGcuHhJfMdoYOFNve4azB9CnOBgYo/xlu+4RiUENIltbN7jPF0k8aTZgr9Q06ss6sGyIflbA+s6DjXKq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960140; c=relaxed/simple;
	bh=Wi27qEs/5e4tSTUEdKvblPt1WEkhqGpsrhlA/n693m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxAZ6MCwhIi8qhR1yFagXWQ1qJ83G9Npfq4xG8xOygyTTdQg127BcSmQir91W2HJSwJK6QciVZeDkmg0WlJrH8+fQMDPcQr1S6cVi4xhSTTkouTBNteZzfgIgKVAXGc4tbD2occJKDKxoL+6ptIt70f2pxMxCpL0EGjA5azveUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gd698DJr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gd698DJr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718960137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZxfbjVDFLZ8q4+IcR6ygghLj1wY/E9B1wkW/5ajlvI=;
	b=Gd698DJrH+WtF0lSNr5jTI2i8DVbP0WRYlySag60oIdu0Av1wwTGYlBmzqiqmP8WWCO7y+
	SO2fPxr+SnOwdMTBQGHgk/Y/r+MMT+wjn8TslL7YWOw+jIgpDYORqOxOHPUeQl453fIk5p
	hC+VWp9xlkuZ2xIpxRcYauMF/6YKrSw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-3CgIP11PPQ-UHO22Oxx90g-1; Fri, 21 Jun 2024 04:55:36 -0400
X-MC-Unique: 3CgIP11PPQ-UHO22Oxx90g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4246e5fd996so9755365e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Jun 2024 01:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718960134; x=1719564934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZxfbjVDFLZ8q4+IcR6ygghLj1wY/E9B1wkW/5ajlvI=;
        b=vtCPqszOltY9wLutMTMM2Hmjq4JkSktLug/0FSZH4uPmThAGsm6SQbxGfgk7j1AjG3
         e9DJ9yWs616we/BgFn++txpmORaniCDyhN049AASkuZf8wnBPlfcuZQYRVJNGxYtQFBQ
         1/vFjWhG2oKAvWtAOpxkynpCLTf885+lkWMuC/YLdHrWihwkOs8a1AeenQ7kKPWx5yjf
         6uurjSsGyBtYCjav16K7odaU5n1xX3Rqfkc/RaWq9aJxmUEP4aYDcJdlvsGMT7jVWwO5
         PuOkNIfK/N2IFRzrD3O8hVXZ6welN3Okf/bmsBC8dRxMgEDsQ3yo5gk0Tmy5Z47DdwC2
         44uw==
X-Forwarded-Encrypted: i=1; AJvYcCUPx4sj9OnganeUTPqaClqc781nHjDgolFuUe+R/VLZGvGoFCSzcAhTXb7AOAHKskZofE1lxXToNVofSMBOhbcQ6IXjayJpAEzrfFc=
X-Gm-Message-State: AOJu0Yxgu161/w4KEcmfG+xaDtgzcG7YavAYdCwBneAffYaXPXL1m5wb
	wiQ66ufocF+NzW3+jBh3UunwgGNomdQ/JC2+rjm68K5levGTQi/RBmZ39dunwC0ruoUQnz0Zjod
	yyWSYFgVD471CvQJ4taYMF4OJol/Z6Uy/ZAhxOoWcDwbjlUiNIyL5OxTOxF0E
X-Received: by 2002:a05:600c:3b96:b0:421:3b74:9c02 with SMTP id 5b1f17b1804b1-424752ac00fmr57877725e9.41.1718960133948;
        Fri, 21 Jun 2024 01:55:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkCronDs3rd4uDL011azLUJoQX0z7Z/tK6nKcBDkViAJOlmHlF1yWy1e0FG6LHPQxZY7mBOA==
X-Received: by 2002:a05:600c:3b96:b0:421:3b74:9c02 with SMTP id 5b1f17b1804b1-424752ac00fmr57877585e9.41.1718960133568;
        Fri, 21 Jun 2024 01:55:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b6402sm54371555e9.10.2024.06.21.01.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 01:55:33 -0700 (PDT)
Message-ID: <b4caed34-bed4-4b72-9bb0-353ef63fe867@redhat.com>
Date: Fri, 21 Jun 2024 10:55:32 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] drm/panic: Fixes and graphical logo
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1718305355.git.geert+renesas@glider.be>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <cover.1718305355.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I want to push at least the first patch that is an important fix.
But if there are no objections, I can push the whole series except patch 
5 "drm/panic: Convert to drm_fb_clip_offset()" which causes some build 
issue.

Best regards,

-- 

Jocelyn

On 13/06/2024 21:17, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> If drm/panic is enabled, a user-friendly message is shown on screen when
> a kernel panic occurs, together with an ASCII art penguin logo.
> Of course we can do better ;-)
> Hence this patch series extends drm/panic to draw the monochrome
> graphical boot logo, when available, preceded by the customary fixes.
> 
> Changes compared to v1:
>    - Rebase against today's drm-misc-next, where drm_panic is broken on
>      all current drivers due to an uninitialized pointer dereference.
>      Presumably this was only tested with an out-of-tree driver change?
>    - New fixes [1/7], [3/7], and [4/7],
>    - New cleanup [5/7],
>    - Inline trivial draw_logo_mono().
> 
> This has been tested with rcar-du.
> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (7):
>    drm/panic: Fix uninitialized drm_scanout_buffer.set_pixel() crash
>    drm/panic: Fix off-by-one logo size checks
>    lib/fonts: Fix visiblity of SUN12x22 and TER16x32 if DRM_PANIC
>    drm/panic: Spelling s/formater/formatter/
>    drm/panic: Convert to drm_fb_clip_offset()
>    drm/panic: Rename logo to logo_ascii
>    drm/panic: Add support for drawing a monochrome graphical logo
> 
>   drivers/gpu/drm/Kconfig     |  2 +-
>   drivers/gpu/drm/drm_panic.c | 74 +++++++++++++++++++++++++++++++------
>   drivers/video/logo/Kconfig  |  2 +
>   lib/fonts/Kconfig           |  6 ++-
>   4 files changed, 70 insertions(+), 14 deletions(-)
> 

