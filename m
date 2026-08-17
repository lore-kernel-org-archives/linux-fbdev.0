Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671403EEAE9
	for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959636; cv=none; b=ZLxLL6KQN0C9UGvPVThr0NfSUJ+v/rCp15JbaqLgYW/4w05c/50zu0cx+ucZX6Z09Tc4tAykm6+yYTEYXuy4zxlYC4USZCajnKfNvccBzQ3VWev3E2xCnSEc9BsXF2JORdO5VC1YWFjAaVQrN/2elMmglO2C8yTW4g8JLGMGk/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959636; c=relaxed/simple;
	bh=7VGMnmkejSh3sVd1hpCqrgINcXXfow/Hx/voysWE7aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6BVda+Ku3KTLrYhnj1SKlXXMOwvV0KrPjr+9S7WcryrJZiwp0bR94l8ZcCtZEmfHTVrpLWMBebL8y0ZReRBdEltFrTd21YX8BdvuKVNYnkSTYoBd+KpJr3D012MbF0VcSHQxkZfqqQZzDRD8keB/bLvTY6IajAYfD4SQr+u/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=OxK4Afoo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="OxK4Afoo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-495590dde14so39553415e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 02:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786959628; x=1787564428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7VGMnmkejSh3sVd1hpCqrgINcXXfow/Hx/voysWE7aM=;
        b=OxK4Afooh8iWOamFVvhtRaf1jWHdGPK1FjMkEV3a3QqNw0LDcpKZqMu0Zq8zQhTLQ0
         sUPvznOvTY7RAk/NMVcfFcO6I5gO6PSj3K7efy4kNAUa4ttskweRQ8W2j0ywHsz6edML
         PZYKscBMMxK7Jfg0i+jzxH7xyXhqAOyvHgyp0cihRIoAtABDOqD3PG5WbGkTc2qcoSiD
         xKTWuHRyU7hCuKAjS4vVRCXU4AKKX09/4gtp0gpZ6k3UlEAVIgQ5OE8Zh3mHlt+Q4GXL
         dHWln/0RGeATlUNIdK2CiJkndhAiu58SJCDz4lMOnWk3OaxT9x+kfO2zJoySZr16r1gl
         hIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786959628; x=1787564428;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7VGMnmkejSh3sVd1hpCqrgINcXXfow/Hx/voysWE7aM=;
        b=b5CBAIyv+gUPZg83bwsquBEz1T+N0IjSZKO9ucwl17KNtGNgv0B2Uc1iBgx4ENHGgu
         C9Dru1yXy7Iu1YCQFpOjQC0GVMRx5Qft78e/5sdBO1VZl2qvAsPXL3e0svhP8u00srem
         1aGGnnuR5MXbQOfYTQY84jWYxlzjpgMnenE92li91zSg9Jem6bH1uzshPZ8q5IoCQBDZ
         ITJGEBqOMrWerGiMOTWU7IVpq6ECh4Ti/wA/Tpwb51t8f6e1OuA4d9SEXq3EjSPSeUv1
         1VdL99g3w8VKAjYpZMZxGY/dEZXNRoekY0tmsViO1ZiRSTrZGIBRyN2XYaC7aM7rCTOB
         dbQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSsf+w+ikFBHcO69q/xPPvPpAEUUQ+0jTghvmPWqv6T+DTyBdQB4Tgi7jfsWZeNA/CigbuY62UFJco/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo5Hz07fYLuNhk9O7EW1UM4dQFQkQKkk92mShiwNH92frdPbxP
	AY0CDH7/iwu3U8/LTCSfrRsruUTIUvWNPrQrkv7DYkcSxQOnieiwM3NKT6C9Jek9TfY=
X-Gm-Gg: AR+sD126WpKW/aL5A2nhv9btuQKZ14H9zs1BxHzTEiQEAT7y8NGptNvM5Jk2KSWDQTj
	xw+EzrXYRxP1lFVc2K3omFAM4M3q5wQbgEBg46kF2Ul5qFUTawaLW7p59+LYtpK8XVQYFjH/ONL
	n8XU9grUkqeVB1+f2IpFjqOQ30yZOX+YusGjdd2588/5fnmNQMTubNKfbNwBoDXFDLUC0jXgsus
	XQ5Jo4lng21z2Tl/i/APct6XriocTlVKVGNqHCRX2uXeMh5zZh6M0g8zNLo/aMamnU8hn8ew/On
	w1HSZHtWUR7l4WSJl5TU5Ffnh1IGPRqj5GXKu/qJbcA0sYLkTWANgsW6i4FidSJga5WulRcHr2o
	ohwR+VzNfMsSBCm4V9a96u/Ry5H7JYByLBVVG6uU4j8RqhWCpzTKZ/uAWo5BxPMKGli2BfNbBW+
	dBCyONvQLirhFZMys97IEsWj82iM32BKtYrFroasjvgnbmvgw79aHuJispkDeyqD/zvO+Xn3nvC
	sHoz3ahx7p3MoAtt2iyIw8HVyoXMyNIEou300TfOksKRn4gBU5NGH5Ck+FdGPWOiNyt48wji67T
	XI00ii+4dwi6EMrtedDyW/dXy8FjdIi34BCpa9uzrSvqSA==
X-Received: by 2002:a7b:cb1a:0:b0:498:519:e660 with SMTP id 5b1f17b1804b1-49987935847mr230720425e9.4.1786959628339;
        Mon, 17 Aug 2026 02:40:28 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d0fb867sm36476785e9.10.2026.08.17.02.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:40:27 -0700 (PDT)
Date: Mon, 17 Aug 2026 10:40:25 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Wim de With <wf@dewith.io>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
Message-ID: <aoLXCY-q_o9IPDN3@aspen.lan>
References: <20260816-ocp8178-backlight-v3-0-caf95c453c50@dewith.io>
 <20260816-ocp8178-backlight-v3-1-caf95c453c50@dewith.io>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816-ocp8178-backlight-v3-1-caf95c453c50@dewith.io>

On Sun, Aug 16, 2026 at 12:57:03PM +0200, Wim de With wrote:
> Add device tree bindings for the Orient Chip OCP8178 LED backlight
> driver.
>
> Signed-off-by: Wim de With <wf@dewith.io>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
