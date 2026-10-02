Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1B363C51
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Oct 2026 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945526; cv=none; b=WNVrhgKwG8T10PRZ+tPGuP5nQeYTYkEkXRcFm970rNx6yk3zyf4NHAfhGHZAwVedZDr6iB8bSuV1Vq+dz8jBWcv1iiKgQ+TiL/PiTNr4NZsLNV6Jk3L7dmQToo8yl3ZAe+jvqa0pe3hxbWm2fs5SUJJ5UHou/fdQRdMF2YA/lAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945526; c=relaxed/simple;
	bh=53D/5/B2wvX6dN+ASmuNpK0/77E27Hvucfz5GPvSt78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OyVut7EkoJFpF3y41mC+Njj/b2jB9plf0V72Epz8Lhg7//ZZI7h+xzEKzU1gt7JgsanGBKCQXWeLox7qUkdy4BogO9UTH4aXmIPda7okBMpXsPtxaXW8eKARPChLkCmCIatfWuvW8oF9NB7CFqfWcZ7RRY/A62Fu0Qe0GY1wOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HS/x8/Gh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FvIgfvvB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HS/x8/Gh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvIgfvvB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790945518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2xT9hRgPB5QRriD8h5Z5tNs8Qaw44VoG/fyOaMAKs4=;
	b=HS/x8/GhrcurKkxSdZnltbdvkPgib7XlkdH3vWKBy1l8hQI6PPCcuLEV9rKq0Bh7AtVaYW
	B+F01NZCKypjTQcf1FY2Db3QHbdjKpgPqieRHOmzH8L4/yI4uvKW3FCxLN8Zr2oWF1IuQv
	tn6+UCl19blZ7rBM9gTVVFKjFRezxpk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-3oxDh3MBOIq4_xg3XOGtYA-1; Fri, 02 Oct 2026 08:51:52 -0400
X-MC-Unique: 3oxDh3MBOIq4_xg3XOGtYA-1
X-Mimecast-MFC-AGG-ID: 3oxDh3MBOIq4_xg3XOGtYA_1790945509
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b02d63407so1931827f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 02 Oct 2026 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790945509; x=1791550309; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B2xT9hRgPB5QRriD8h5Z5tNs8Qaw44VoG/fyOaMAKs4=;
        b=FvIgfvvBuVEH4fr+bliuLq0Y48vr5txV1T17UVja8VSJ+cqVnB4/TV/AzrhyM5X73b
         rAtmS9/dMb1molQLQex0J+wzOHAPAaiE7sXecz2TcCyH937yfL7U0dHffXFPvF8Gh1pL
         87Z/7tnAjylOuvVsYkq89ICc4i9gzkdbKYWs5AAA95vurR8asCQxkMAZ/oHTTVQMM+sl
         NrmZ8SoL7HKmIgC2u/lyK0G5a/YujrgxzRgizynFYbOIcYgYWWbwMfO73Wj0/Q9bUssA
         z/tTaz0AMexO2V5nMZCArw+FngEEQwKzBIOtqf/6CY5zLmc0eDlWEiKD5k29BoMErxIP
         6wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945509; x=1791550309;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B2xT9hRgPB5QRriD8h5Z5tNs8Qaw44VoG/fyOaMAKs4=;
        b=oI10/zpn5UzMWpgVXUQjjW1FqWAhdk9UNMlqttf0To8soKtYd6saM2qUDP4y1Jo2kc
         77krRLsuKAldgFuLYsasIU5TXGZV6nABO24gxrB7lBShEmgbJRM2UdRDo6EM+BOi3ymr
         nbhxKkqn7Z6VHlme2bQAD30Lenf9QDCxAlpJfwJ8z1xA1E5GOPuj5VXn6zNQnKgakfU0
         DkIi7p85yhqdXe5q6/3zAF8VjZ0C5x3EXlg8dFcQrRgX/Whwr/yqaQoP4EMNwlFYQRhX
         77PxbDxRRoDaDyKpnDyAWcdB2YSShDGOUPSNrp35avZYnCuxiwDMBmxSKWP6O+75XhAQ
         l+Mg==
X-Forwarded-Encrypted: i=1; AKwUvBz8KYj2BHwSp/5k45gJ1iF21GoXPpahFtZpdL3fGLZm4J8kZKlYQCRTTbK055f/0YrkGppwiHs+vowi7A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJaWJA46uyDtXJKY5uNVNYtNF3oMGl3f15wPaZcdGCp0Wb/8kzA
	+72qksWWs+Qyv0Vjh4CJ813Di8rTUZyr/DxeNNL/Aclk5RDtaLF0L5NzawFGemQDSlUI9Kh3Z8u
	e6fyEf6HCqraDVg5+UtQIFw2MVE7kAsVkUzwvgcKGfi6iFVr01KEqt7AFuRMKWN2+
X-Gm-Gg: AYBFou05pI7782+Wi8lJIDXsR3VZQ5LFhsfgDEKw6rA310V7jmn7OSIf/Gqdz5aH1JU
	oR0t53xFHmbKQ261tG2taun7/JyphkQlbIcGawssBVzRHnz2V4p61nL7qTbDpmlak1yh5UwxRXM
	B/nUSSIJsuRKWcCt7IfOu/dYxppY0eWh1ZY58fpBkBcZW61z9jb2JlGj3f0cUqriC98dtI5stAS
	JDAkV9e8ps/+2F41lvEukovlXWysBlpyxxTvOkc0ytOTvnsiX0CrCJPv8xWWK1J4cma38xHQ4Qr
	AnnTzJoG6ba7SZg470QgSu9OWE1y3UEUrhTp9j3rjjebZG43YiGLLGLlz0IZgh9E2gvxluDkRmv
	bx08AXghE+UKzbnsRqsfAVjnH5GgnaT3zD/W8AkH044/dMMhnClYeIuR9091iZi0BZw==
X-Received: by 2002:a5d:5f53:0:b0:48b:74b:4ce8 with SMTP id ffacd0b85a97d-48b12754475mr6263163f8f.17.1790945508857;
        Fri, 02 Oct 2026 05:51:48 -0700 (PDT)
X-Received: by 2002:a5d:5f53:0:b0:48b:74b:4ce8 with SMTP id ffacd0b85a97d-48b12754475mr6263100f8f.17.1790945508338;
        Fri, 02 Oct 2026 05:51:48 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f8c4asm5711527f8f.37.2026.10.02.05.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:51:47 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, ssengar@linux.microsoft.com,
 andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 6/7] drm/verisilicon: Do not include
 <drm/drm_simple_kms_helper.h>
In-Reply-To: <20261002124456.741011-7-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
 <20261002124456.741011-7-tzimmermann@suse.de>
Date: Fri, 02 Oct 2026 14:51:45 +0200
Message-ID: <xlv18q4g6za6.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The verisilicon driver does not require anything from the simple-kms
> header. Do not include it.
>
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

