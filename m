Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033272F7F12
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Oct 2026 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945481; cv=none; b=i/oI1+Ge9708FcWiAXaLQF0HY97kkFloByn+H4hfIBS4ViI7hTA8JdiHNxPRO7kk1INWnIsW0C75iQi82EE5AWXgaFgeyQRRYv1GrGtw1aNbkYKDPrWc/EVi3moFfqcU3rOTVdLgtos3FPeVYKFdc2MH2kqZ+bucOSNxAGtErzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945481; c=relaxed/simple;
	bh=Eea0KEkQbSlRaY4fITFghJeqNRMhlnUIBzIPKXj0Z20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IFe0iK1ZN8y3+6aXKuyD7QLN+6vynOKSrbwOGt0B4CFxo7ZU1opsGAptNKRTSIB6RlGfzHixgHO4sIyI9ce8RbVR52kM2hfX8ofAabGhIJGwTMy68tt+ZDvHOQ5USQkNT+Zwm+XGXC3usaCuvRj8Hu+aEzZNpTFPQDo7YbAWpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INaX7G/Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jy0VyC21; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INaX7G/Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jy0VyC21"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790945478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PXxRsRzuT/lLVwUTudBZrzfm5MyaTiR0eopkV7RSLVU=;
	b=INaX7G/QNvwaDhl+VJyyz/I7SdllubSGxyzu70zoQRJEKY+b6MA80n/2FkQvk8LbIKj0cQ
	no01aGdY1KG6QDkRsBPYBK+zYv7mFAsmFasyyVdFMUG6n+fW6pML77JWXATThwj3PPsjk5
	Yn7MJcatNOtZ6th9TAlyQW9RbdIpZik=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-Qcx0zmi8PDiHhbTyhfpK7A-1; Fri, 02 Oct 2026 08:51:17 -0400
X-MC-Unique: Qcx0zmi8PDiHhbTyhfpK7A-1
X-Mimecast-MFC-AGG-ID: Qcx0zmi8PDiHhbTyhfpK7A_1790945477
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a020cf06c3so11508575e9.3
        for <linux-fbdev@vger.kernel.org>; Fri, 02 Oct 2026 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790945476; x=1791550276; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXxRsRzuT/lLVwUTudBZrzfm5MyaTiR0eopkV7RSLVU=;
        b=Jy0VyC21FB7hPBPsbpYcTKSKdx6JK3KajQs57X0i4g6XhYCbeiDpVa7IxvwLtS2NyC
         wtA8f9F1mPnv0rm5qREaTczOo5XiQf6vtB2kSAjdOca6VkkIdQ3uafv+CiviS7a624Ym
         TOgROcPjkqPDajlgq1n0PUhAkIbfM+bWznntorKiVfl0Ombfw2NpK98SHko6YX7RjsDp
         d4mtsYmfVWkhgq8XOtJ9nsJ5OwCDO0SQ2KeFhbSw2AHZBqNJ1eVwpxkAHkCw8BBS8Ndq
         5phZSektZo+dy7jpaI6hbv4WvMZMOi5BCKGSmbXnGdti2PMKM40Esvq1N+LUCo+pCn6t
         1Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945476; x=1791550276;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PXxRsRzuT/lLVwUTudBZrzfm5MyaTiR0eopkV7RSLVU=;
        b=Vs/pbo3E3qaRy1YBx7Q11HgwZCOJl85s9OuN/6orn28R7VvXeGv515+myTm4bxeJUX
         PcyObHlOkhJ36ciop3H/+PINObOr094r5djiwwaZOieAed6oFp6kJTFnNvtFM6y26hXI
         po6tafP1ONmhPNnN6H9E8qv0OEtcFI45ao0cRua+y+Tp4m36T/I0Yp0LPVt1zQv0QPum
         r2gGl1PBz7hS+wW/qr6Owlv4i37++8IEVmzz1BBCKUWrK747zWr47Y/MsUBSvCw7xsdX
         y+X73OklhVR77h2Qq0e6/nF9kw21KRmNEeVrKf7ZoBHzOBiUSijTCfXO3kChg8zWVRJ8
         9Xag==
X-Forwarded-Encrypted: i=1; AKwUvBwoHzGkH/VP61XD3Zz7IXNJhyXBdLjwKXr6eZPN9KVzEg32iOV/e4q4kS8kT938jG7TGTj2xg8x5yzpvg==@vger.kernel.org
X-Gm-Message-State: AFuF++mAW1dJNAMGB+4OA0M8qSV2wkjRiqMxaUkFI26fyidE5XzxfnZo
	Tk7R3jUAVgJuXOtFm8pPI97NXR7bT6f6IGjXYALCyHNwtulr5zcCFsewKX6BN3HE9Qpk250h53r
	pJiNcMVgM03sV90KkLzJtDNbjqaevpahWf3zFkm4hxknDwDNIi9mxbQ7Uvw0qUmhIQku5InaG
X-Gm-Gg: AYBFou2OMi+6WH2lvzjaaokSghyMVqlWeP5C4aA7yuX6k06jzrL9F0wxP32+72OxSFF
	edbWxeBoRRxHemBzaI8/NVPsuPyvTf0gsIRYviMgJnjqQ30bSIwskP6/HwAuTOWmbUIiUjSvx7I
	kvxrL+4HpL136hxqIPPMqJuqg+t0sC0hZTJNVvhaYfBdBVpIlDRbyr7HHU7CkLGaTOHKyseL5wa
	B1VmI3HFBKFDZzmzPAZfwP1sriRceT+vwCmagTPdlv2AK/DF+2s7c+sf6leHDzjtLt6QG62M6J+
	wzjmOIb/nDWlShGsTaj4bowCEtFwq16VvEvPBD0bzgDWgedxC8fLKwoX5fu/W0eqGBfAB90jhFS
	7gWCmtutxe8pEZ+1bMlSzTFlZyx2spkyn5lvzUTGQ0H1s8gOSq4vwh+exSZxuKODKog==
X-Received: by 2002:a05:600c:6098:b0:4a0:1b14:e283 with SMTP id 5b1f17b1804b1-4a0274e9d3dmr46216735e9.1.1790945476473;
        Fri, 02 Oct 2026 05:51:16 -0700 (PDT)
X-Received: by 2002:a05:600c:6098:b0:4a0:1b14:e283 with SMTP id 5b1f17b1804b1-4a0274e9d3dmr46216415e9.1.1790945476056;
        Fri, 02 Oct 2026 05:51:16 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm88527965e9.6.2026.10.02.05.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:51:15 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, ssengar@linux.microsoft.com,
 andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 4/7] drm/hisilicon/hibmc: Do not include
 <drm/drm_simple_kms_helper.h>
In-Reply-To: <20261002124456.741011-5-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
 <20261002124456.741011-5-tzimmermann@suse.de>
Date: Fri, 02 Oct 2026 14:51:14 +0200
Message-ID: <xlv1ece86zb1.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The hibmc driver does not require anything from the simple-kms
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

