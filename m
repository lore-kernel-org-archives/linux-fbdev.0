Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA0051597B
	for <linux-fbdev@vger.kernel.org>; Thu,  1 Oct 2026 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865537; cv=none; b=a2h2TaON1+OGVwN4QKSUlQAHY9E3Mal6D/PQipEtpEmMUZOHymbBJLC/lITludLfbnleRELdrzRdLLlxqLAcLVftc/Hox0fgJoHlK+tIcLM14Ts9gf/RG6imcZA8JZXVBCCygKJYYhbuISVzWpjA+EollJ56AHb0Z0kOiBfG3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865537; c=relaxed/simple;
	bh=TP4jI+wG6PBqBKAosooF+4rrhoc5hNQtPHbUvJ/nxic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sRUVpueNP56iNB2CCxB6azvvHThmwXyjtZF9tFbEdV6fEnKui+a3/e/BLsvfWbgXbPilCA7DTS6ZUIDBbZ9jJU8Z3eeCcuLWauk784OD17DuLwkMuRdzUxxdSIzSBseF+Eaizq5zSgMOzOEEar2162sEAGi6MWtlQe7kyVE8gGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5TPUfqt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VjIBUJ8J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5TPUfqt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjIBUJ8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790865529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i4xhRQFt/bWT6UALcOITRzeSEDfb1ACELZHI8/ear74=;
	b=J5TPUfqtrtqpeS8SlQLjzv3vhrZQdFt09DaMBP94eK/YbQB2f0TRRn7Uw/OTIzX1pxI5r3
	ZLumVB0WwfmL9B+zV394FspL1wqlVAwXGDUJ75ujzTrNlSTUh3cY+APEITL89jeovZUJKY
	piixZs0h17ThkR5Mm/lqlJhsvUjvd6k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-2gzl8yeFODOKFmYRAVvG_w-1; Thu, 01 Oct 2026 10:38:47 -0400
X-MC-Unique: 2gzl8yeFODOKFmYRAVvG_w-1
X-Mimecast-MFC-AGG-ID: 2gzl8yeFODOKFmYRAVvG_w_1790865526
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso31010595e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 01 Oct 2026 07:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790865526; x=1791470326; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i4xhRQFt/bWT6UALcOITRzeSEDfb1ACELZHI8/ear74=;
        b=VjIBUJ8J2/ysa0wVuaeMXcYQmXgkrijhtQC3hjYnFW1AYHsbqDtu8gxrYLSne0ydJU
         3kcFo83XDha4TQkYIeEXOo34MyYzWLRwJfo4qnXzvM4SxfNpqFhbw0LlaC6LcRpzeG+Z
         Pkv57cIxRfZmCpIyzCUZ3K7a0wzR++nDoxrTkTUJVrh300B+haIS+CYT1l1+r4e67raV
         kXTNy9otKtGR6tmARhV/kCv/JZecFrx1gW6QJtQFf9tjY01GGL7iIQEqInYI5u+DKatA
         Fik4lDASNG8V/0R7pdFL/mQzYIJ+GJZ0638PHcIectETw18Q4KS6UtJgwXCaDNKwgj1Q
         bheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865526; x=1791470326;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i4xhRQFt/bWT6UALcOITRzeSEDfb1ACELZHI8/ear74=;
        b=VxvgKzx4NDkVgDWgn1BTNCGQofpPGReC8Mj9uHMAvvCVfuY+ykyGtO8n4QQjA8HYP1
         711eO75APExsEMi0xjIKueZECtI9cvoAogcqWr4ZGAIzWFF7E6AMHKzsFsP9AtJIKfBD
         Nu78oFDe7R1TXknVqwBwb4JCN03MVt4G+1zrFpEhwiM/mpANwD17RxdtM34maAlpCYNK
         SQgwzsZoB0jLSwuVtOHfoN+rVJsl5pvy/bvBflrqpsXrU+io1N4JQza5Zd9+U1s5KB0z
         Mhc2cDb6kjTIFB3WC3D6PA4IrUuWDOCkDDHDrLmJnRuxrNB2WKvUkftpA/Fwq/HMjMPc
         nA8A==
X-Forwarded-Encrypted: i=1; AKwUvBywiou9qhmCQ1G4Hm2ZC4XabqLCrgptFlrAmwsvJzL8UsQ737UuRx6z7BhS0pZqLDI83ZkXrGzwpppSaA==@vger.kernel.org
X-Gm-Message-State: AFuF++nNF2VirmrsFrnLGYnEnS40UOSGhp0g01LD7kxcREQYViICIo/W
	BkMEFYn+8nhIExPTk6h0ooRVAHmHyH0VdCyDVy8IxNJ5Zj1XZBujv+TnnNniyHOQBHzUatL2Pu9
	sUGA0sZ/XxdZtC1QLDbgxnjHjDZEnc/LmV73SgTsRSUBFYV+mMfQ9fAycXKn2uYkawjtoPaK7
X-Gm-Gg: AYBFou0shUKtLQLqSbwqbEnSTrlSxlJhLyLsS56cL74bsifmMcKVtuZ9OnABD7slESX
	Hz6a3h0Qk7QZBGxQ8FwtxqVG64i+3lq3nz4cQ9LxEi2XBxPTbj80l8A6hfcgdOfMxHfCXUm1dU4
	DC4jp3/GM4qRqFZ0QSoz89TakUBRxl1f2ojoHx0zPKjtzxCTNwsAkoaIH+ZK3ZUz4lIRNbHPDDP
	n9doxFdHT2EiGmjIYkIQSrUhkCrYJL8vbTXjgrHPfVrpfiEi7BjreLhULP2q1dxOT61Bp7Nk+0S
	Zgj92BGW3qG1b4GzOtBnszff1XrOktAd2NrkNPaGWPa0wyw+S+/GiBquGnyJcYPXpPOVtqMKTe5
	S1HohKvdf1zMdPYpkgdEazg2yPDvSiCb+4z2eO9gntHm0YZxLSfyIOGcC5SHrzitSuA==
X-Received: by 2002:a05:600c:1f86:b0:4a0:13ea:2ec3 with SMTP id 5b1f17b1804b1-4a01b135eccmr80506955e9.35.1790865526399;
        Thu, 01 Oct 2026 07:38:46 -0700 (PDT)
X-Received: by 2002:a05:600c:1f86:b0:4a0:13ea:2ec3 with SMTP id 5b1f17b1804b1-4a01b135eccmr80506425e9.35.1790865525833;
        Thu, 01 Oct 2026 07:38:45 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a023ebe694sm51117505e9.10.2026.10.01.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:38:45 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, longli@microsoft.com,
 ssengar@linux.microsoft.com, andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/2] drm/kms-helper: Remove struct
 drm_simple_display_pipe and helpers
In-Reply-To: <20261001133736.802604-3-tzimmermann@suse.de>
References: <20261001133736.802604-1-tzimmermann@suse.de>
 <20261001133736.802604-3-tzimmermann@suse.de>
Date: Thu, 01 Oct 2026 16:38:44 +0200
Message-ID: <xlv1mrsxfpu3.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> There are no drivers using struct drm_simple_display_pipe. Remove
> the data type and all related helpers.
>
> The idea behind struct drm_simple_display_pipe was to provide an
> easier way for writing DRM drivers besides regular atomic helpers.
> It turned out to be more complicated. With all drivers being updated
> to use atomic helpers, it's time to remove simple-pipe. Also clean
> up the related TODO items.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

