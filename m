Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718A73B774F
	for <linux-fbdev@vger.kernel.org>; Tue, 29 Sep 2026 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790720499; cv=pass; b=nNAUxH8ytXD+FPvElBnAqCNtPzKKzv09w2HMApPJLpbzGAyGwIwLSyTJ6yMKosBTdgXwHdiL9THAm3kFmzug0iRMZl0fB5gCNcN65eLSMJPyOc1kKw9PZXi3XVAVEBsmqbWV8HhnaL/ZNOZgaUaJpVb2Uj+X1BmHpSr+NVBv/hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790720499; c=relaxed/simple;
	bh=2h/b/s1hyf+hYHDXMhDwTwcRRjLZP5znf0gW0N5R0m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paVxIbQztEoWi0tv/AKNPDYA5OgWpkCXfhUBkudGjqe/y7CzZIJXyYErfUdqLTGZJrBi8RDjGD6MowlN1Vt1JXJ+3X0nzfQVI1m7InfIF25zU/8dPZPpo+155C6SPrtoCZ923Lk3gvjTja+RwBYoNo+6aoFMk1i90iTzE0CqDrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJkhQc/O; arc=pass smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJkhQc/O"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-9178b9ca7e8so9044276d6.1
        for <linux-fbdev@vger.kernel.org>; Tue, 29 Sep 2026 15:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790720497; cv=none;
        d=google.com; s=arc-20260327;
        b=j68ADn3Ff2hWkZavaiE5zx2kBWxGhN85QYBx+sQwnM3k9P6PS6GZbqbHbDRkSTDQRF
         iVkrN7RFIX8FzyjrpQ9SAfDxFnM0r2YBrTSqxQmtEPdDvirQQwG7msFQiDnu3fensw4j
         z59GUg4Um/ltMnXY9hJPRoMQfSOty/0BfFbjzGLEKz8Sm9QCA6f5i83ov9FZYSyqTBVW
         auT+8XKIDHnahEUldhsnBwWYNgP96Chy/QQrZ7EaQy8RCRjFR+53jt8t3kbySPj9Moej
         utlU7zKd6xJisJsdhoh0YhfX/Suoxr2SmLEW+DPjQ2Ctt3JaaexaqrYh6dUZvYIdmmyb
         YU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2h/b/s1hyf+hYHDXMhDwTwcRRjLZP5znf0gW0N5R0m0=;
        fh=TpVG9aFZg+9qHC86sGiu7dwYJPNOsS8TGDyZUQ10fYg=;
        b=ojkHNhJSVUDV74ND3sELr4FXUV3d6gblKoERZOhRlpmJ1V3d/T8v7ly83JWkAi9gvu
         Ig65g7QwwyzH1cMY8tHP8HdNB4VAFprgNG8ouJfaujFXk7hlTePLeIEnAML+n8Zj9zUu
         Oq3EUzTVKPLo7VOJNvHO7Xb2V7HHnr1U9PizCrRqpK9BXG/bdanUAN/zq/y3+OJK7jSv
         zo3R6xPeMaqzZ31GqklSQePBl6s1o1pJBRHuDXOICk3zmS0AP2eLp7zFMYWq3rxv+G+m
         IYF8xolZOHpN+ks+d/l0nUVwBzOxXc8MASoJqntM+YKV7+GtcUu9b/kEa3WFe/WWNW/K
         CWfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790720497; x=1791325297; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2h/b/s1hyf+hYHDXMhDwTwcRRjLZP5znf0gW0N5R0m0=;
        b=oJkhQc/Om67h5v4ohWci4TOlquG1ejIh3wJ7FE3gZ+0xdTETeBvdxNy0EU38W02kPF
         /re8DHGex4k9HPDIb5HEPVEsVWwzS9gKu9Xm5tglYteKP0MAsHT1z5bHhYKwzVwMrAAY
         p52zZ/eMU+rNVB40iSq/fRszhqVQQtzFvhElqpgUUw+ULFBggJakO3zkCrJzYNgJv+FE
         RQWsOH27CjpJoN71w4MFBmA8BH0tASDcamNvome8uZk2mOA3bhUBIAuZZLKcc8Z1F46G
         XDSJtZcoubqmupNEPpLJnQNxO6YSBTsabfpd7NS3SntEGbOt6LCcRpPHe7UBYZ6XMgI0
         e+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790720497; x=1791325297;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2h/b/s1hyf+hYHDXMhDwTwcRRjLZP5znf0gW0N5R0m0=;
        b=utYp7Y5iDX0UfQGZH4FrlV2YKFrmWxgNIJCKNuBwD29rSsbDfOoRRJEz7QgEHRt2/I
         M+w6adLQMBjAuboYMEItqRejGHNNSZyBAFP9VoCV5Qyrj5kao6xgh9C6Gzzx3zM9n9nG
         p657PsUzlDZieepj8rxo5JQSLdjHg+fCSb7abxkmNHUHyjLhiQHyxn5UbZaK/EoYmi9Q
         l480Il+VhsLoWHHVCbbfVuUC0QL4JkH9P22ZckhR8XLr/4+Jvur2Th+cbaXhMeHJxIBJ
         GNcVTd92ZEHjIpj1z2YAhLX8ewLiaZPcltUPKVk9mAnsNfslod4agB0upXhMh8Pdlbns
         z8YA==
X-Forwarded-Encrypted: i=1; AKwUvBwGpaFFOwJa7yudZUUp/p5A/mQ1uwY9f+Kozjt7sEfmK85nBomwFe9/4VN+RiSLEToQ8v6GZ7mKZ5r3tQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLgwcsiQG3vBMWT9ESdp8P8MA0z5FowVo7VlxLoJMH9AAQ/BeV4
	VzXjARDsu8FZ6fXcLwS6uSinC55WlvOt19DH5ASYZvv91eFMAnfoeqX1c5XvacH1Hh5nFxh6PnN
	BHHUZe6AnWkin+I/FVIDVuj8Ht48pl8g=
X-Gm-Gg: AYBFou3vIXOz5St8PLtS3och5LRW36lgBN1QtNV054K0HxYdvZCvmbkfq2yxCEnjPJq
	KgWtTlth12wLWJEz1MNMxJsE1cA0gTthDRKnNMZHGkw0IShKjVdmEbAqq6koJweul/IoWgv5oDY
	J00Ce2jhsjc9EYyOGlPYPvG0Z4fUVHRw3X5Z1BJV3gJUDLi3V0GJp0vt/mG0ne7N0o1G82UtKkm
	aMBBUrSwho7J/yYipwuc6dsZvDfaHS4yGZFl8R40WmyVYZgdmztGUWUC7eb8DtCjjLKB96ZMVko
	y+Tq//EEMzMXoFe4fXLDEPH6H/A2fqy+3x1vnYY9t8R+zkuIioDcaWg=
X-Received: by 2002:a05:6214:3202:b0:914:4bd3:d984 with SMTP id
 6a1803df08f44-91799b4bd9fmr11450236d6.34.1790720497177; Tue, 29 Sep 2026
 15:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-13-2fcd7d011646@collabora.com> <1b722d71-93d2-93a4-acdd-bc02b9a36f95@nvidia.com>
In-Reply-To: <1b722d71-93d2-93a4-acdd-bc02b9a36f95@nvidia.com>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Tue, 29 Sep 2026 18:21:25 -0400
X-Gm-Features: AclHuK-WotblnMwdXvS53G0qNfl2c2x7OSON_0NQQ-TSXMtSHUSKVbt3lVkA9wE
Message-ID: <CAFZQkGyvxO7Dty4XXJ89FfTTeD5YfirX=16tMW2Mzds7A2_bpQ@mail.gmail.com>
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
To: Vidith Madhu <vmadhu@nvidia.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, Leo Li <sunpeng.li@amd.com>, 
	Daniel Stone <daniels@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
	Derek Foreman <derek.foreman@collabora.com>, wayland-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Sept 2026, 15:18 Vidith Madhu, <vmadhu@nvidia.com> wrote:
> My understanding is that flicker may also happen if the refresh rate
> fluctuates significantly within the sinks' range, although I don't know
> how common this is in practice. I would imagine these frame range limits
> would also be useful there to "dampen" the fluctuation.
Judging by our user complaints, it seems to be very common, and I've
been waiting for this API to do exactly that in KWin.

> In any case, if we expect userspace to use the frame range limits for the
> purpose of flicker avoidance, it may make sense to expose a read-only
> connector property for whether the display is susceptible to such
> flickering. For example, NVIDIA G-SYNC monitors are resilient to this and
> it would hinder the user experience to unnecessarily impose such a limit.
Sounds good to me. I think such flicker compensation would need to be
configurable by the end user, but having good defaults (and being able
to simplify display configuration if the driver gives good guarantees)
would be great.

- Xaver
