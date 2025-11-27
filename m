Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426421862A
	for <linux-fbdev@vger.kernel.org>; Thu, 27 Nov 2025 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206302; cv=none; b=ReBPKdOQYVYmAWvFyX2LbGh2KE4EpwNqrD7d84ju5jeacmD3xfxcHntq+/j4QviL1/KaEyuLde55IylKTNCF3gxqOCBoTmoV4OmoX2fCIYRvyIWrlcwX80irov9fQdl8UGM/FYXsmGso0El3C3u0o4OCUiJS4ENbqQkDNVQVIxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206302; c=relaxed/simple;
	bh=GQVRD0kDLnRr8PlGCc+5Hnmo5Omwya0ZZMgiPEA57KI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBXojqgzhpGTwhi7GiFeYFoKGkXk2a1gkwnpdi5dbJzftA+o0KUqgNi3yxJN2tDgj+AX66jJVxSvb/DbLSHE9GTUNM5TE4eFrsR4TNJnwHBhbGDwOKwtZu8X9fGaeUT4u6xet/8JJqHShaGano5137VuPWUiXVYIcvBL/gTDKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JMxRlQgq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JMxRlQgq"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477a1c28778so2840475e9.3
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Nov 2025 17:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764206298; x=1764811098; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKgOFooMWN6cAHuCEA8Jqj3i0BZ6TtQryqGYElbczIg=;
        b=JMxRlQgqJV81zARc+UmZ8Yx75jfyYOkeJj/362TMiAkwyKCfIpRWooE0QbExftrBnR
         n0kFaOP4QWjIP9jfTFiTg6NkGeqGWUUknZNkkbp+9CZel31jLfMgrTI93NqSCj2MbPnn
         SZ180e9rEn4C+M3cnexGEmWUES+B0xf223fHxCH6GuyS7ctvUBQuHv0RK99GQc+wBxZZ
         H1tHOkNFIDdWdcLrboTrnFHjD99uMicQlGDWnm7lB8qBTnNzWoZBRqAw8LNmHoqX5h1i
         4pxspkoaEDCqv9Y2zuoK2qDR4/5Yv2M/d4ha7GCPpYUPyHx9tf9SNnS4jRaxIgyw9SZp
         h08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764206298; x=1764811098;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HKgOFooMWN6cAHuCEA8Jqj3i0BZ6TtQryqGYElbczIg=;
        b=rOXVnSjXxyJxWNj7BAoX71zEhEhKf2iObyqDqjC+2kuOWIheO/K6eM4a+bFTZaMoUz
         TJVDwlCBWl51pzrYwAPGGhaljIOXWyIcRKeRjaswU3EEINBQxMiF2Q455lgEZK39Rc3I
         xAE+C6M+r7p4vsKOoGZznPY2ZjFwchCtSQ0MzXLKl4iHk3xJhOLd+poAK+meNcmw8L43
         O4diC/Q7B2nOvgmJ3/xLYM4uSB7y4/D6unjyiXXSzbr59N1JdigHap0YzFg6z0uVBYhi
         W4fKeZ1aDzgCED058mlAaIw53oOk0BHnUfH7nNlyJaLeENe06PAq+WXswQoTSBJqqRCj
         IX7A==
X-Forwarded-Encrypted: i=1; AJvYcCWeQ1/B96NFIj1nIH9bvxKJl6Bu1WPOpi+jGf/e+LgHKsMO1r4PBEJEBCQDlPZEfgFxhN3umhkzVwAvrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQqgEdY6y+GKjTk0zHwL60rn/WkfXqj8qzpN9Ag5q1eN1XZxuJ
	0tHXcsH/UqdFPLVE/Hv1NJ720PRiQ3svQ6IY0WozzKquJ0END5afC3u1fk7cu859mTY=
X-Gm-Gg: ASbGncuiN3m1LA7Uq3Ux5Wmc8Hi1PvgR4jzuLc/SNKPcXxtlrRXSBWX/n7LLo4Hrg4J
	K/q2IEYAx0YNATtkM/tsfan0AxIz03UsvCFBlKemIlpb1k+AvPC7we+kYta2dWD5P9onEosGIel
	G+C4N+o09J4cBJu31Oc/ygE/Ro1q0g4Ehv+pMCgmWXqbVNMNdBILXjGRmsPs8ZMUhjWvhwCuixg
	QcmnLFrQ3S4byBURic1Anw0hymZ3kkY4QVc6GRaL6DBJ3UV4hv0/XgUi/n+BVdFtDl0k1tRD8DI
	mJt9/bYV+C296N+a/c6+VvwD/s0ZVLZg2Fnz+sIil6h1AN/akAMe6g812UapcBOfPqCPK5Fqysq
	hcdgAYOdRppX+r4eUQd5OnjcsyDwBQwYVKSB7Ki3tdKO483IgUZyNZtq1imGA8sa/0GLDdkA1jG
	Lm3mOBZsbfmBPIlAj8LtYKhs8K0yG/hKQj
X-Google-Smtp-Source: AGHT+IHKRsRzIcI/YdpyjCx/e6RWPSP3syqAgwQHcfAEZoMWkqQomccWOuW4YSvp5SYEElJFnjRGrw==
X-Received: by 2002:a05:600c:19ce:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-47904b25e63mr87066215e9.30.1764206297510;
        Wed, 26 Nov 2025 17:18:17 -0800 (PST)
Received: from r1chard (1-169-246-18.dynamic-ip.hinet.net. [1.169.246.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b1075ddsm207261215ad.3.2025.11.26.17.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:18:17 -0800 (PST)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Thu, 27 Nov 2025 09:18:09 +0800
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
	javierm@redhat.com, arnd@arndb.de, helgaas@kernel.org
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 3/9] sysfb: Add struct sysfb_display_info
Message-ID: <aSem0a7jTfCNTdX-@r1chard>
References: <20251126160854.553077-1-tzimmermann@suse.de>
 <20251126160854.553077-4-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126160854.553077-4-tzimmermann@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


Reviewed-by: Richard Lyu <richard.lyu@suse.com>

On 2025/11/26 17:03, Thomas Zimmermann wrote:
> Add struct sysfb_display_info to wrap display-related state. For now
> it contains only the screen's video mode. Later EDID will be added as
> well.
> 
> This struct will be helpful for passing display state to sysfb drivers
> or from the EFI stub library.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/linux/sysfb.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
> index 8527a50a5290..8b37247528bf 100644
> --- a/include/linux/sysfb.h
> +++ b/include/linux/sysfb.h
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/err.h>
> +#include <linux/screen_info.h>
>  #include <linux/types.h>
>  
>  #include <linux/platform_data/simplefb.h>
> @@ -60,6 +61,10 @@ struct efifb_dmi_info {
>  	int flags;
>  };
>  
> +struct sysfb_display_info {
> +	struct screen_info screen;
> +};
> +
>  #ifdef CONFIG_SYSFB
>  
>  void sysfb_disable(struct device *dev);
> -- 
> 2.51.1
> 
