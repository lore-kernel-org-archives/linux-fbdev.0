Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9738947F
	for <linux-fbdev@vger.kernel.org>; Mon,  1 Jun 2026 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312727; cv=none; b=SciIGCn2nqpLtdnth3HEpCEU2PFe8Swx/tMYBm81fLnDhdAaKSgef1fFL5im0jdGIkQNYJWYrBolK+xxEMlXkrtTtJ/jghOEGVIFV1Ojth/dbavJzUdia/toesTX9rl3BTKMIFshvDsl+LIRYWZ/3uR86+JaK9yjNC2ptEosT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312727; c=relaxed/simple;
	bh=fr8+UuFPKutgu6rLw5DlBfNvn2gZkbd1pEskj4KjYqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STWFuUMLF8ZpCNDyocokKSJwta78VYoy4dvJ4z6qJVU+Ir9XCG8gzmcpWCVQH5APnVzrofSNLs851H3ABvei5xg71lSV4n1JwZRd2uhIr+bEh8BVU0Voc0GHZ1frVu7H2khc5tiq4PF/Vsj0FJKNyjb+8NAH+xooFkbP75By/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LeCY7vSI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j2xwybB/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeCY7vSI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j2xwybB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780312725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6mo8ZBNI+D8bVnfzYhv3FnsH9wtvJpIKQXiEBDOnCQ=;
	b=LeCY7vSIg9hZfIVVFMp+Mo827u/9QDAmLOr7QTUUq2LKJUCefeoQ3f7o/pZ/G4sln9bNix
	HNi3kvjUSZ+vRBfpwnA0X6ko4jwOoUDPTj99wqOZ1RF5QnFcoZ+CffpBuqc5RT3/hv8urk
	CIA6WY8EAqLNKc7X5P3+54voAFOqR9s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-uj1ibdgLPXKVEQpzv4oRLQ-1; Mon, 01 Jun 2026 07:18:44 -0400
X-MC-Unique: uj1ibdgLPXKVEQpzv4oRLQ-1
X-Mimecast-MFC-AGG-ID: uj1ibdgLPXKVEQpzv4oRLQ_1780312723
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49041d39887so70933725e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 01 Jun 2026 04:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780312723; x=1780917523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6mo8ZBNI+D8bVnfzYhv3FnsH9wtvJpIKQXiEBDOnCQ=;
        b=j2xwybB/hySFzvUgJAjOWGxqyzcIcG2cPwO7mT1D1uzdhiBVxX2KJXr+9HAwNupzpO
         yT24w0R0ZLHqnkxWX+i/hUwqA75RZwmCF3o4kW1VrHBoxSZOFJdPLtHA5PJD+6wqqemV
         OuaRea+G2yL3lNfBz6huIeYR24g7gMc0zavYtv/pSz730y1/0Wvj3hZbr9U8Lijq5JmO
         15eLlgkN2oUlV2aExk0wRvanW9J141R4ugPTyBBW7Y+XVw3lLwelnS9vZTP4HKjR3Lfm
         anej2uAW9C8SVO8R5HeaIS0kta9U4vC+7A7S4dB0XX+VMOP837lgeGHIOwNr8hB+rV4F
         hcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780312723; x=1780917523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6mo8ZBNI+D8bVnfzYhv3FnsH9wtvJpIKQXiEBDOnCQ=;
        b=kuVAb39QIW1BVv+WiD57qYpWHPnMKTGvthoy+s4IwTbYNrM2eQo4XriQJMyNWLo2Cf
         cq2SVZhLD+CLWjMHHelY7hsinflRs6f2MizUnOho0nv558BDPZ69LfFQcYPowZv/6dID
         IbHY5atrlCaFAU/DyFPFIiRJSGbmN5sGi4dnnmRaLLYuNh2daSwbquu3dTaJt998cHKD
         gJm87C15NEPasCpIqb770F4VhwduvE1owbBb6+XfQfTVtkeR20nEGzgffzcGE9q7Y6zN
         ON1Ol5sHaGt5P03kY8P4lpnvEnwpnnl7aPYoNaTk8rV6d3YsAESoJNMcgNp8z6nA8nWU
         egJA==
X-Forwarded-Encrypted: i=1; AFNElJ/VBam70FCwMtqPLcHP9bVRD5caFQcAQbosvdYc7se+mD+PKh9qjUs3eUAPwYb7O69fJkfbToULxK9Iag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTURX1dMMr0wk2uBkGXrsb1ZmJFaWIyclD/CI2oTkESFgMXtyQ
	W+n77IbaZG292UbFVEjZ0rYvnIDPbgvd7m4juLZNeLZnBXlwhmjrtVQfAqv2Ti1tLoHXGrIRW45
	wubxfc+qsWal+Eq0pOLgp2EW3RK+jSSPsSOVVo8PvWx5YBSL99qS/QJ3fZDG1WjC/
X-Gm-Gg: Acq92OGJJCP2wV3mH4zaI85pMH8Rtb2/sjeueE5Dg16JV2I0sSBBYe62KNRoVcNAYMc
	xuxEOri7WayloBWgfWqQ9G9IyrapWKNgZw5VoHKncJbDYvf++WGB1zh7090ayOQX4JX9a3LhNkL
	xjr7sTVtNsKYgvNlT5KExEqQYK3uR4y/eqSS51PaMDss21UHPt/oyFWSVR/DJ+BVrRtExe1iQL9
	R4fnVrRCUXQdY7rmPuvVMzgrbfsGv5R3bQNtYQI+evQEgv6+c3GV4NxqyMBBNAaZbXRMpJpLRgJ
	Z7vDvDjIJ6Sh+KYKfzlyR/LXvZEzJ7Q56mC2rqtSUhSO8QOeSF9P7B3OUjaSmLPO5Azu1mDwy8h
	3VkNskIAbDBE5koLUxxcYQx5WPD4CrOdo55U8++Updv04tKlyxNyyQUA39aRYeXYq6rXUCpn5
X-Received: by 2002:a05:600c:2242:b0:490:5321:2466 with SMTP id 5b1f17b1804b1-490a2941ea3mr123965135e9.20.1780312723036;
        Mon, 01 Jun 2026 04:18:43 -0700 (PDT)
X-Received: by 2002:a05:600c:2242:b0:490:5321:2466 with SMTP id 5b1f17b1804b1-490a2941ea3mr123964885e9.20.1780312722684;
        Mon, 01 Jun 2026 04:18:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ec71:10ae:399e:d3c8? ([2a01:e0a:c:37e0:ec71:10ae:399e:d3c8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a04e2sm22332510f8f.1.2026.06.01.04.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 04:18:42 -0700 (PDT)
Message-ID: <db9abca9-0174-46fc-8952-aaa23a4e4574@redhat.com>
Date: Mon, 1 Jun 2026 13:18:40 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] lib/fonts: Look up glyph data with
 font_data_glyph_buf()
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 deller@gmx.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20260529140759.529929-1-tzimmermann@suse.de>
 <20260529140759.529929-2-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260529140759.529929-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/05/2026 16:01, Thomas Zimmermann wrote:
> Add font_data_glyph_buf() to retrieve a character's glyph data or NULL
> otherwise. Console fonts can currently contain 256 or 512 glyphs. The
> kernel-internal characters are of type char, unsigned short or unsigned
> int. Catch all of them by accepting unsigned int. Callers possibly have
> to cast from signed to unsigned types to reach all glyphs in a font.

Thanks, yes I missed to check font_data_num_glyphs(), and using signed 
index is also problematic.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   include/linux/font.h |  3 +++
>   lib/fonts/fonts.c    | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/include/linux/font.h b/include/linux/font.h
> index 6845f02d739a..ea23b727388b 100644
> --- a/include/linux/font.h
> +++ b/include/linux/font.h
> @@ -101,6 +101,9 @@ font_data_t *font_data_import(const struct console_font *font, unsigned int vpit
>   void font_data_get(font_data_t *fd);
>   bool font_data_put(font_data_t *fd);
>   unsigned int font_data_size(font_data_t *fd);
> +const unsigned char *font_data_glyph_buf(font_data_t *fd,
> +					 unsigned int width, unsigned int vpitch,
> +					 unsigned int c);
>   bool font_data_is_equal(font_data_t *lhs, font_data_t *rhs);
>   int font_data_export(font_data_t *fd, struct console_font *font, unsigned int vpitch);
>   
> diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
> index f5d5333450a0..4fc66722d00d 100644
> --- a/lib/fonts/fonts.c
> +++ b/lib/fonts/fonts.c
> @@ -178,6 +178,37 @@ unsigned int font_data_size(font_data_t *fd)
>   }
>   EXPORT_SYMBOL_GPL(font_data_size);
>   
> +static unsigned int font_data_num_glyphs(font_data_t *fd, unsigned int width, unsigned int height)
> +{
> +	return font_data_size(fd) / font_glyph_size(width, height);
> +}
> +
> +/**
> + * font_data_glyph_buf() - Returns the glyph for a specific character as raw bytes
> + * @fd: The font data
> + * @width: The glyph width in bits per scanline
> + * @vpitch: The number of scanlines per glyph
> + * @c: The character
> + *
> + * Glyphs start at fixed intervals within the font data. font_data_glyph_buf()
> + * returns the glyph shape of the specified character. If no such glyph
> + * exists in the font, it returns NULL.
> + *
> + * Returns:
> + * The character's raw glyph shape, or NULL if no glyph exists for the character. The
> + * provided buffer is read-only.
> + */
> +const unsigned char *font_data_glyph_buf(font_data_t *fd,
> +					 unsigned int width, unsigned int vpitch,
> +					 unsigned int c)
> +{
> +	if (c >= font_data_num_glyphs(fd, width, vpitch))
> +		return NULL;
> +
> +	return font_data_buf(fd) + font_glyph_size(width, vpitch) * c;
> +}
> +EXPORT_SYMBOL_GPL(font_data_glyph_buf);
> +
>   /**
>    * font_data_is_equal - Compares font data for equality
>    * @lhs: Left-hand side font data

