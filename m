Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB13C6FD18
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Apr 2023 16:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjDYQ5S (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjDYQ5R (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Apr 2023 12:57:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DEC14446
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 09:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682441790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QgrFF00z2wCMViqatkmG+CLp0kBJ37AT7atyuO0HEqU=;
        b=M4uOXzTO+2yf2CI3o0TufyLu+ARkDR/XvGdWYiWmXXFTg4IANV6eKgEXYt1hHv1y9RDZ5u
        ZvfdcCeVwyIiBPOiyu1dFrqv0XiGG6gQENkogFhYPhxKgkPGrJ7eaJndbG66rSEBYWzuTf
        jBOmGiVfzpIIs1Htgj85c7LUzVMKQLg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-mvaRXII_MbKXxwkCMQgSGg-1; Tue, 25 Apr 2023 12:56:29 -0400
X-MC-Unique: mvaRXII_MbKXxwkCMQgSGg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2f6632b85fcso1837378f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 09:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682441788; x=1685033788;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgrFF00z2wCMViqatkmG+CLp0kBJ37AT7atyuO0HEqU=;
        b=BNx88GPgjHGDI9ZAppwL0HzcNDym0D0TYYsSUiC+nBoClCrOkBJrEYjCpSHgAd6+gn
         21/zVxg6MNPQ0VNZi/PcVF9ADu6+eRYrSv8lpJ1MB2rfrWQGAYqTURgR/5EtzdA4Zeaf
         a46VpwR6ln5cqO99E+qTi9jNON4V1dSAmdJBY1DUEDKEvcdBSCgwck7BYLO94HTl2jMv
         y79Vus21kw1zLzx2i4CTTpzpEp4r3EWSCPfnaDRD444PZfFGL9OL2hEY0+MXAJc7nlGZ
         r4bfpmQS2sKiBUqvIc6RfObV9msRXWHgEUQ7A11W5wR334ZgnZY1stB9y720Pq0LKOWF
         aZvw==
X-Gm-Message-State: AC+VfDzsZtFRSE1HWMXIO94venLRBHb8OVNIpmL/zCVcqJ/+1JSVSu4A
        CneexMvjpU/kLl6OwFhdap2X/QM8YRX0CuO5fTfmsJmY2vpyRIZp4mgweJoHLeTE8bbDIGpPVbn
        bva1cG01NVGoYu5C5isM1iVc=
X-Received: by 2002:a5d:48ca:0:b0:304:7ff3:9b2 with SMTP id p10-20020a5d48ca000000b003047ff309b2mr3900203wrs.39.1682441787969;
        Tue, 25 Apr 2023 09:56:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7MeNC8cJ9OH2Zuh38sAFoM69kuwhsPNczCEv8GrTcsCUMsmycijC69SXBl8Qf/CgPBx366KQ==
X-Received: by 2002:a5d:48ca:0:b0:304:7ff3:9b2 with SMTP id p10-20020a5d48ca000000b003047ff309b2mr3900186wrs.39.1682441787586;
        Tue, 25 Apr 2023 09:56:27 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k5-20020adff5c5000000b002f103ca90cdsm13473182wrp.101.2023.04.25.09.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:56:27 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, deller@gmx.de, arnd@arndb.de,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] arch/x86: Include <asm/fb.h> in fbdev source file
In-Reply-To: <20230424084751.14641-1-tzimmermann@suse.de>
References: <20230424084751.14641-1-tzimmermann@suse.de>
Date:   Tue, 25 Apr 2023 18:56:26 +0200
Message-ID: <87v8hjhpdx.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Move the implementation of fb_pgprotect() to fbdev.c and include
> <asm/fb.h>. Fixes the following warning:
>
>   ../arch/x86/video/fbdev.c:14:5: warning: no previous prototype for 'fb_is_primary_device' [-Wmissing-prototypes]
>      14 | int fb_is_primary_device(struct fb_info *info)
>         |     ^~~~~~~~~~~~~~~~~~~~
>
> Just including <asm/fb.h> results in a number of built-in errors
> about undefined function. Moving fb_pgprotect() to the source file
> avoids the required include statements in the header. The function
> is only called occasionally from fb_mmap(), so having it as static
> inline had no benefit.
>
> While at it, fix the codying style in fbdev.c.
>
> Link: https://elixir.bootlin.com/linux/v6.3-rc7/source/drivers/video/fbdev/core/fbmem.c#L1404
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

[...]

> base-commit: d2639bb054c42db5ff15c56902d1113303f5b655
> prerequisite-patch-id: 0aa359f6144c4015c140c8a6750be19099c676fb
> prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
> prerequisite-patch-id: cbc453ee02fae02af22fbfdce56ab732c7a88c36
> -- 

This is a disadvantage of format.useAutoBase = true. I find that have to
do `git branch --set-upstream-to=$foo` more often than I would like...

At least it seems that patchwork ignores these so that's OK.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

