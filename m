Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60222575D
	for <linux-fbdev@vger.kernel.org>; Thu, 18 Jan 2024 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705587433; cv=none; b=WqjgLaGEuRizVxEhQA7yFx9js9foRcJ5RB9xbo00dXV/KD1yOHvlgM+vJEBareAJLi6DhPZtoqPe61j0fPkTvyzNKROi3/DsjDhIEiPdcu6iW6lmet8edtZU3VpbqmWKlvUTbr5Fndjq1HPU10zvFa1hn1SoWqMRtIC6eO7fdAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705587433; c=relaxed/simple;
	bh=kBrP5/4z0gKWuaC7MCN2c/7hFq7Uz9QvDCUF8WuPVjY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Operating-System; b=ilJ9t4ze5TZxNBDTcVRAg73IFgvpnBlYOMrMSauCupuO4ZpKXH8xFhTniBqsqwjRZT+8Nnl5vPRs+a52Xy3m4LLwjSNzebr/LdTj6UXsukDtSragziSJxyDYOBPefSXyMBjpKSVTd0DlPLMX8EuZzUvkipoWT4UlEA93C2P6R1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=OgSkPFRY; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OgSkPFRY"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5573c79aac5so3137599a12.1
        for <linux-fbdev@vger.kernel.org>; Thu, 18 Jan 2024 06:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1705587430; x=1706192230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wF4iSgPnjSMZjszaSvukPCbLZVGeSigi+LPrvVrYLe4=;
        b=OgSkPFRY+ea4ojIcr1Sw1dSZkIuD8LHCdEVqAZ+JVeMZxjodDAP8h3qRnmp6saz34S
         xK724PdaXVxrod1xjK8thKbGrpLoCgezxd50RglYtmuIAzooY4HGaug5lda6neyJMLhz
         5BUihN56PkCNGZzhBxGEIPBkQtyCRNbMA1oYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705587430; x=1706192230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wF4iSgPnjSMZjszaSvukPCbLZVGeSigi+LPrvVrYLe4=;
        b=eJSOfJk+QK8sk9qYAvUUXZlHjZze7jpG1A5H8srsiFXo0tQS7qNZ8BVonlPhZSs9EG
         2IvUgT2Z/50Zf7uIMCI62qSycXQ3qMuJu1EYHlYFk0xqjdnqhk3xa4eiaSnzFHt6myW+
         Ke3Grv1L4qMJ2oSLsiF/bf6fSkOHt95UK5VWNNib4tZHxmvAiXfxUC8KiAxxMPN5CWCL
         ILlqmwLhZ1IoAZC7z1GnjdrQ/aYQEfZC8vAEe3/Cn8dyde74vzC8g33oqChOgeGgYGtw
         Rs8CgI9XwjaLyrv7HBKRJTTE882sjS5RcDtHz7y3IDkPV6k5oX0vfjQFTRyvgbpfqfct
         zpHA==
X-Gm-Message-State: AOJu0YzSc5AwZnk7MUaXtfJXOYULdklE4PI0tFs4Ir6YG0h6H6TbO/a6
	EHcxxsRu1QAOvV1z30xnafVJW4uujTrknLaxNrpBocKvVX5WtWcBDDHJgUpYaH4=
X-Google-Smtp-Source: AGHT+IGzoQ3SU0z6FJj+jiGUFdUlxq7hERImFqcv6wTD//GXqXOzJX5VAz8UujMWdI2SdWHXBbYftQ==
X-Received: by 2002:a17:906:48d2:b0:a2c:d6f7:341f with SMTP id d18-20020a17090648d200b00a2cd6f7341fmr1137561ejt.3.1705587430002;
        Thu, 18 Jan 2024 06:17:10 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id lz3-20020a170906fb0300b00a26a061eef8sm9175423ejb.69.2024.01.18.06.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 06:17:09 -0800 (PST)
Date: Thu, 18 Jan 2024 15:17:07 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 0/3] video: Simplify Kconfig options
Message-ID: <Zaky46R04of5mPRX@phenom.ffwll.local>
References: <20240118090721.7995-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118090721.7995-1-tzimmermann@suse.de>
X-Operating-System: Linux phenom 6.5.0-4-amd64 

On Thu, Jan 18, 2024 at 10:05:25AM +0100, Thomas Zimmermann wrote:
> Replace CONFIG_VIDEO_CMDLINE and CONFIG_VIDEO_NOMODESET by the single
> option CONFIG_VIDEO. Select the latter for DRM or fbdev. Both original
> options used to be selected in most cases, so this change simplifies
> the Kconfig rules.
> 
> Since commit ca6c080eef42 ("arch/parisc: Detect primary video device
> from device instance") architecture helpers for fbdev do not longer
> require fbdev in their implementation and could be used for non-fbdev
> code as well. Eventually guarding them with CONFIG_VIDEO will make
> them available to any subsystem.
> 
> v2:
> 	* support CONFIG_FB_CORE=m via IS_ENABLED() (kernel test robot)
> 
> Thomas Zimmermann (3):
>   video/cmdline: Introduce CONFIG_VIDEO for video= parameter
>   video/cmdline: Hide __video_get_options() behind CONFIG_FB_CORE
>   video/nomodeset: Select nomodeset= parameter with CONFIG_VIDEO

On the series:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
>  drivers/gpu/drm/Kconfig           |  3 +--
>  drivers/staging/sm750fb/Kconfig   |  1 -
>  drivers/video/Kconfig             |  5 +----
>  drivers/video/Makefile            |  3 +--
>  drivers/video/cmdline.c           |  2 ++
>  drivers/video/fbdev/Kconfig       | 37 -------------------------------
>  drivers/video/fbdev/core/Kconfig  |  2 +-
>  drivers/video/fbdev/core/fbmem.c  |  2 --
>  drivers/video/fbdev/geode/Kconfig |  3 ---
>  include/linux/fb.h                |  7 ------
>  include/video/cmdline.h           |  8 ++-----
>  11 files changed, 8 insertions(+), 65 deletions(-)
> 
> 
> base-commit: 05b317e8457c8e2bd1a797c9440ec07b7f341584
> -- 
> 2.43.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
