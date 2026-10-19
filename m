Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80464F393D
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412667; cv=none; b=YWE+QnD+5HR2DlBqVIQNyMDdzLvUl15VZB0pSkNZCNcX/LidPybnOjK+V8zwrNmRJlKBYWxsm8Q9hwzNSTpaTb90tleRa0aicPbj98kPeDLVDPAUJPFEeExL46JRvhiFP3tnDYXrFf4jx/sug2NRi2cnQMo8nfGNNOBFavJ+5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412667; c=relaxed/simple;
	bh=wd28aU++NdtOMWUJjRpk6EgNkx6fD22f8iP3kR6CsIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPxTZe5BxQcG2E51gQBoHHaWgOGPGO5hSAxCDDtN0D0AJ0AJMvGzO7s9QrU6wT0lfdDBEFBcQsb7J0USvypzb73/rC79VY2Ba3+AFteRG3WYQTGQLZcwDgtt3xC1uE0b1RYqtfkdMDiiV6cD1k7w6jnvaS3RyPJFk/gYBrginBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=JUXP5CJy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="JUXP5CJy"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so6281205e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 05:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792412662; x=1793017462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nCKEluHSWIFV51AHkRVTAd1QNSpPxxkrgvIjhQ5PXZk=;
        b=JUXP5CJyrMMjFmxa6xvURwQ3HJqNbCgVeoE9kApk/C3I8HLhyl6yflZvAtMPXTbAbq
         PZmVdIkjgqkqPo4RBL3iXj4+Gv2vfkhp8mEoTc33nuYx/hC6QXCdrRdFdxYQiAp6RAU7
         litVm9pJum2csacPR5Zeg6plHlt+ugelXA5+PbJRS63T3gFZ6csA36ec4bpqXebWJwBd
         /g8y/2cG9NKDw2mWEwo+Ctcx7a2skfoul49FHdgE2SthiXa/M1Rozb9lLYr8z9tqOtHB
         77rDdIM6UWUgYOc2WCdMXwRd4LIffiEiFux2eOgCF167Foas27W9/Py+bOht9IgfvYL7
         +EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792412662; x=1793017462;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nCKEluHSWIFV51AHkRVTAd1QNSpPxxkrgvIjhQ5PXZk=;
        b=aGG62LKDRlyWA4VGm/TNIuC/VCFVcv5wu4/hkP5Yho7y2fd8vIeuDrUHvvDfV/U7ej
         NSxji5NTXffBJ+GhysCpE5FJYkbWsjxghtzIV9nuh5Dniaov8YCdNtkUcAtrR/QbrQCl
         r9+3wpdyHN0V29SIKcysYW8oP2dB2J8IBgY3Rq1ZBNDNI9lWrStMJHnjT+MEjtXlSGJh
         dKriiQLfWo8iu8ueM20UduRguoISPBPqktCFyJcggy+AEx/UVwzx0uqJr5PqlrVFwgg3
         qYRJqCSDT9uKjmFPTU1pY+TvZX8yT1zmqFqMqbX+XRqmUS/Mdo+eRMUr3iG4k3yWYSyP
         AGPA==
X-Forwarded-Encrypted: i=1; AKwUvBx4MjrAMduuKPOPgdMleXo3ueVpTiH9HQHON33xOcQgtBYqvDLhsz2DyKH5cPp4xaOEXFzJv7OXb4TfoQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLy+klGuv7vi+m8hawj/51Xt6hYOpNUcXP1EjW3zbz171COcQR1
	lN+Pq24dgmLN3rI2gCFybeIOLe4JR48NzSTxNf09k5iOy6GO8NCrOZStADdHQo4DdjY=
X-Gm-Gg: AYBFou3OYmzAibWZ96vdrKZR9WSbagj/nmOdINnXQo9c/5IlRIKB/DCQB5jBWHUM0bQ
	Cih3sxp5s3PPQ5uPVS6TMPjCA36+zahjvAipmAQjMGYjh/YTTdMxE/bV7BR7Y4fauTP//RS08Jm
	WJtr7TZbckpi0d3FbVrn6FLrdXcgriuEG4XF66UxBoutJh1m3k75yssFkQEl6PYfB94cwWiLRDk
	fxZZWMz5bYLosiZxmh+QZlqhBy8l2u89RPbp+WocJ6U1u9bXBoH7srPY1RETxeK25ceQEAC4Qwk
	N4SC46deZV1AK6/Ywdx68T2BhRdRt3VMXBe5kEDEI0HIfDUlqMF6zMvKytWYWLxButl6gVygRmj
	Obv1X1y3+ACjpZvTI4aKEos0soWRYqi02qYD0Fcl0EpTcqfoI4bG3LjZQFy0TMpv08qchpt4f10
	bRDPudwY+pn8Z/H8NPJn5eLSR8lrcYHZ2kYzgzbhCqDOEIQkY8T7X1J8Q5BbmqJLQNF9pwxfcgJ
	tyLQCDVUs2eTzDrWmLeTeckgxPy0xvrqeBP1uES6yb/rarWpywf/jJQAXL9rbp+MIxM3wWvIXKR
	di642EO6O83DJT9hKZjurNA/htza3NWRT7DNV7kMgTcKPz0sgQ30IQnWic0=
X-Received: by 2002:a05:600c:3484:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a1d7605e04mr161218185e9.14.1792412661854;
        Mon, 19 Oct 2026 05:24:21 -0700 (PDT)
Received: from aspen.lan (aztw-33-b2-v4wan-169864-cust3247.vm26.cable.virginm.net. [92.239.204.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1dc8ee409sm284385915e9.13.2026.10.19.05.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:24:20 -0700 (PDT)
Date: Mon, 19 Oct 2026 13:24:18 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Luka Panio <lukapanio@gmail.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com,
	pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, deller@gmx.de, krzk@kernel.org,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, junjie.cao@linux.dev,
	mitltlatltl@gmail.com
Subject: Re: [PATCH 0/2] backlight: Add Awinic AW99703 driver
Message-ID: <atYL8jLQmljt3ypQ@aspen.lan>
References: <20261016162912.64581-1-lukapanio@gmail.com>
 <CACi=Ov6Jg5eUxskBbmtWOS03jta90RK0nByhWf4EQs1PNhvuKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACi=Ov6Jg5eUxskBbmtWOS03jta90RK0nByhWf4EQs1PNhvuKQ@mail.gmail.com>

On Mon, Oct 19, 2026 at 01:26:21PM +0200, Luka Panio wrote:
> Hi Daniel, Krzysztof,
>
> Thanks for the reviews. Before reworking this for v2 I'd like to agree
> on the approach.
>
> Following Daniel's suggestion I'll add AW99703 support to the aw99706
> driver using per-chip data instead of adding a new driver. The register
> maps differ almost entirely, so most of the DT properties stay
> per-chip (dim-mode/UVLO/ramp-ctl on AW99706, OVP/OCP/inductor on
> AW99703).
>
> Following Krzysztof's review, the AW99703 binding will drop the
> ramp/transition timing and mapping properties and use the standard
> led-sources and led-max-microamp properties.
>
> That leaves the one common property, the maximum LED current,
> spelled differently in a single driver: awinic,iled-max-microamp for
> AW99706 and led-max-microamp for AW99703. To avoid that I'd like to:
>
>   - add led-max-microamp to awinic,aw99706.yaml and mark
>     awinic,iled-max-microamp as deprecated
>   - have the driver read led-max-microamp for both chips, falling back
>     to awinic,iled-max-microamp on AW99706 so existing DTs keep working
>
> Does that sound acceptable?

IIUC you plan to improve the binding for AW99706 before adding AW99703
support, and you will keep the old DT property working to that
existing DTBs continue to work?

Both sound good to me.


Daniel.
