Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008413E04D
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267885; cv=none; b=QzSmxSJs0cjfIOewsUVsd3LxeggiR1MaBwLl4TKZbJqbP2KL1qbsFFpSF0KgJIjqxtlWnJup3s381AAVBogyPVn1VHEkU6zkVue8TFDHoisedVyBPGqOG2uyIbBNjppXNe7WauR1l6+miOE30li7vh7dVG2ig31sCK2u1cqqFLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267885; c=relaxed/simple;
	bh=gvBB4VRGIbrrUzQv9lGEtqrCa23mZiVTh4i9rOyOKiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qj6lpF7HepvbW4BydwfyKHcA5JCmhRUV9b2UaqlYp09n05OGHSn2Eqw3ZMPkd4/8DqXmQ/qHrCVokvSdT29PuXU62R8j7pFgqYYiRemhXGPZ2jijqFA9TsG5zdZjuLbBQUQqjjirTglGSuxq2/y0umjju7FTpb+Eo4Hq2EIwiOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQbp0lx1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQbp0lx1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718267882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YdO1WJIrqIg61hN5vELUIZIHcL7hxfeUZFi824LjBqU=;
	b=KQbp0lx1CtDliiGKjoGo13orRAdS9cxmFzAxH9GvTCMAn27n/pvNLxwBcehx5z7NZY9X7S
	vhW+g+WXgw0ivb9z1/867fOutqZ8EYsZ+EEPSv57LwVCX17J2GPXDEIhZk9+qlv1Rq+QSg
	TtoJcKh1m94yJzDMkKIIJAm8TdrU4nw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-anqcC_l5M1yt0vjjE8P6qA-1; Thu, 13 Jun 2024 04:38:00 -0400
X-MC-Unique: anqcC_l5M1yt0vjjE8P6qA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36073f6db77so268823f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 01:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718267879; x=1718872679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdO1WJIrqIg61hN5vELUIZIHcL7hxfeUZFi824LjBqU=;
        b=nrUT1iN/1agO8RmxYSQp+PME7Gi9dskr3UjG+jem/EOCKNTQd5XfrmJBV/02i0u3zu
         2Y0YLpD5NWbJdpy/Umo6bSjFmBuoodUcGv6DATruZq6RqQAXn4W3k6R5m7vrGyEHrSWX
         RILQyK9vbe5o5MBZE6eeYg0MLQt39bgbgukP1GT21eEUtuRoUYspf+4UGp2sQT3K/EVm
         bqDfr8ReoynjRaFDaj6w35R4nogtr207uQnPwrjZKiII9/5AzAESOIDZpxix3D3qiXXX
         4rquKe/TDqZWfeEvuaqjMqWwVHzVhzqlSl4XUWtEsF+eBjq+XyPpmKWx6EL1Qk6Ohvx1
         Zb7A==
X-Forwarded-Encrypted: i=1; AJvYcCVmVpb94mVxtZAEQZIzsjfykt0J08kMfe0vXgnXFw53YTUyUzvBmz3P2ukI1q7vvMlExKqdb8y0UISLknCN6B4JeI5Y2ywSLuCAHgQ=
X-Gm-Message-State: AOJu0YwfGUX03jDrD5ja6KJhQX6hjzn2RFWAa1rSiYY2JgFEJTcm1qDQ
	tacJx1lxE5BlBwclckymy6jZI2l+BXscWLQ7afnsjbpH1krS9BGUzRk1/B9etnA7P4mysyLNQx2
	R4XKsdZOOxIKD5fB/J5FNSdKOIJdym0qw+ANYy4U0FxVNTEaPhyS+sLPIUbgf
X-Received: by 2002:a05:6000:1563:b0:360:775d:f917 with SMTP id ffacd0b85a97d-360775dfd15mr630607f8f.4.1718267879573;
        Thu, 13 Jun 2024 01:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqGjyQ/umCl2P9LZ32xVZd+McgCS7SCUcfkDyw5neb2L6t38GU4AsvVfow9TXTVGdrXdS6/Q==
X-Received: by 2002:a05:6000:1563:b0:360:775d:f917 with SMTP id ffacd0b85a97d-360775dfd15mr630592f8f.4.1718267879169;
        Thu, 13 Jun 2024 01:37:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad177sm1011707f8f.56.2024.06.13.01.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 01:37:58 -0700 (PDT)
Message-ID: <386a229b-6904-465d-b772-921f99815e8c@redhat.com>
Date: Thu, 13 Jun 2024 10:37:57 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] drm/panic: Fixes and graphical logo
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1718199918.git.geert+renesas@glider.be>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <cover.1718199918.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/06/2024 15:54, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> If drm/panic is enabled, a user-friendly message is shown on screen when
> a kernel panic occurs, together with an ASCII art penguin logo.
> Of course we can do better ;-)
> Hence this patch series extends drm/panic to draw the monochrome
> graphical boot logo, when available, preceded by the customary fix.

Thanks for your patch.

I've tested it, and it works great.

You need to rebase your series on top of drm-misc-next, because it 
conflicts with a series I pushed last week:
https://patchwork.freedesktop.org/series/134286/

This rebase should simplify the draw_logo_mono() function.

> 
> This has been tested with rcar-du.
> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (3):
>    drm/panic: Fix off-by-one logo size checks
>    drm/panic: Rename logo to logo_ascii
>    drm/panic: Add support for drawing a monochrome graphical logo
> 
>   drivers/gpu/drm/drm_panic.c | 81 +++++++++++++++++++++++++++++++++----
>   drivers/video/logo/Kconfig  |  2 +
>   2 files changed, 75 insertions(+), 8 deletions(-)
> 

