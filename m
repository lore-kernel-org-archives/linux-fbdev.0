Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C06C192B66
	for <linux-fbdev@vger.kernel.org>; Fri, 14 Jun 2024 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357798; cv=none; b=SCdeHos8/LfYe+l02K2n/i7Ygp/sppYFnOLKbq9r8aa8EUN7z3IO03XX3aBj5cUEjOsxGwL6pVDgwU7JbDk+3sf/Cj0oUtcKva04uchN14AXQZQgIPl1fGN4RBMvgJN/d/5XR3Xi0mNWe2bpD3JJupM8S+7N86qg347Hxwc/dDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357798; c=relaxed/simple;
	bh=3Xp4hft43r0s80HHbt2Bg6bC+vwJU8fQ6blHSl4LPdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VU9p2kysbNoEktiGDFcUo2prMHrpFibK4JO1JrU8ioIVmbl/rcrLrrY+Kuvznrb0gpKJN3ng5y2xu9qXuQmDUZ2NMImcwkxQsTPefmlb6DJiAQqQu1e9ujD+S1/ERwJXl8bwS4mCmlBgQHLW1jWrg/sQtpUIUfhuI386bpnbEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpzp4gbi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpzp4gbi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718357796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdfeWtRDAuWsZ8j9bLApAvsSD5oNrsJwjHXB/7FcSzc=;
	b=fpzp4gbi2tk7Cw6JJtlANF1AJJZpEr/uGWQqoGL4I48CwMLTHKFfLH9Nl/gl7tZxQ92eNR
	dyZg8D6tdnzRvGzU6QroSe7BaZmuwI9LdI8NlCAQAn/JxDCQnOg2XLjUItN337VSdFtMnN
	OyS3I6KfAjDEYRBmf1pvkczJ+a9fSUw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-KUMw5g3KMGuIcy72UQJjvQ-1; Fri, 14 Jun 2024 05:36:29 -0400
X-MC-Unique: KUMw5g3KMGuIcy72UQJjvQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4218447b900so10616305e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Jun 2024 02:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718357788; x=1718962588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdfeWtRDAuWsZ8j9bLApAvsSD5oNrsJwjHXB/7FcSzc=;
        b=n1NB/fdP/aftMbBz4w/WcjXzPvZSjPXUWuwYvSoOhm1UP1cH1MBNSDZ+SImLm7WFz8
         9lhjBoRKaPMGbuifgnQewDjO2MQCADtGRvCUdu7KoYnaPb8ttNOjXYW1bOW55UhtodEK
         0v8TAJQK4nJvj8GOBkwK3S5sru9RLlIoXzWjORxnJ9OKZ6adRxq4/DCfakVJHHqbAtu7
         nIq/JpSFuqvMfq6oyWCLyC/RvV8URo2KdCPLD7llUPNSrJugFMRthHdxOeP6S3gpvFki
         bYxck+di9SbtyWAcwQcG1pikytfNkJAkKMisFhhbo5uIITEAFDiFt0tnRMuxS/EG0vto
         ZpXw==
X-Forwarded-Encrypted: i=1; AJvYcCWMQAI3Wjx1/UIv+KxafPtLwmkHvpfU1GUSqKaYt4dsl8xEBi9Sn34crUXnpjyn+e9gVwpHJJ8AHJV4OUPXcRs1O5aU/SqU6T0DSLQ=
X-Gm-Message-State: AOJu0Ywbhkn4UmacLONsNPMPfg/JeiDSH9pWKH4H8ioM3WCUL4Cy7YL4
	C/YeRPkRljk4B/hYdwgsmBlHESogYTgiwP/3Z8Fkkln7XgGD2l8bhistdV9yRPgs1nlU+wDC+IB
	bngpy0v8V24XFBp438lEr/wMQIIg7cBczijqOKZYq0VziksY+JngmMoit23Tl
X-Received: by 2002:a05:600c:4a9f:b0:422:eee2:572c with SMTP id 5b1f17b1804b1-422eee257d9mr40054875e9.8.1718357788188;
        Fri, 14 Jun 2024 02:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjxUAkrfgiqF4B9IILJq7eNGszyZUh3YENf1nv29/SYoE7i85RFm0GdV/Ed29jYVD8fE7b5g==
X-Received: by 2002:a05:600c:4a9f:b0:422:eee2:572c with SMTP id 5b1f17b1804b1-422eee257d9mr40054755e9.8.1718357787860;
        Fri, 14 Jun 2024 02:36:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a65bsm53388225e9.42.2024.06.14.02.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 02:36:27 -0700 (PDT)
Message-ID: <a60c6382-2c41-49aa-8f79-ee9744f12b4b@redhat.com>
Date: Fri, 14 Jun 2024 11:36:26 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] drm/panic: Fix off-by-one logo size checks
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1718305355.git.geert+renesas@glider.be>
 <1c9d02463cef3eac22cfac3ac6d1adad369f367b.1718305355.git.geert+renesas@glider.be>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <1c9d02463cef3eac22cfac3ac6d1adad369f367b.1718305355.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2024 21:18, Geert Uytterhoeven wrote:
> Logos that are either just as wide or just as high as the display work
> fine.

Sure, that looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Fixes: bf9fb17c6672868d ("drm/panic: Add a drm panic handler")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>    - Rebased.
> ---
>   drivers/gpu/drm/drm_panic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index fc04ed4e0b399f55..814ef5c20c08ee42 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -472,7 +472,7 @@ static void draw_panic_static_user(struct drm_scanout_buffer *sb)
>   	drm_panic_fill(sb, &r_screen, bg_color);
>   
>   	if ((r_msg.x1 >= drm_rect_width(&r_logo) || r_msg.y1 >= drm_rect_height(&r_logo)) &&
> -	    drm_rect_width(&r_logo) < sb->width && drm_rect_height(&r_logo) < sb->height) {
> +	    drm_rect_width(&r_logo) <= sb->width && drm_rect_height(&r_logo) <= sb->height) {
>   		draw_txt_rectangle(sb, font, logo, logo_lines, false, &r_logo, fg_color);
>   	}
>   	draw_txt_rectangle(sb, font, panic_msg, msg_lines, true, &r_msg, fg_color);

