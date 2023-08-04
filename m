Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15349C001DB
	for <linux-fbdev@archiver.kernel.org>; Fri,  4 Aug 2023 13:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjHDNTy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 4 Aug 2023 09:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjHDNTd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 4 Aug 2023 09:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35B94C12
        for <linux-fbdev@vger.kernel.org>; Fri,  4 Aug 2023 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yghE1gT7JEHr9Ft4Ug/jdVqABt7mGQZ6VHMNTdkCnVs=;
        b=EtXFSAf/R4Us0GdwQVVnqtZMOylXMwaCl0w8BecP7mtvHiIIoCiuWIcZoMNdJ9R5bOf4m3
        1sWsgw/MdSQ1PDoNT702pNqV8mnd5fcOMfyWr2/5/vEg8gk8NQr0QZXACZIkWENE0fb1IL
        l2j2+8Bnsuj88I0ueqOn4oOdbQyKouM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297--laECBO-Mn-Ru6LY1a5Irg-1; Fri, 04 Aug 2023 09:15:47 -0400
X-MC-Unique: -laECBO-Mn-Ru6LY1a5Irg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a5a7e981ddso3410123b6e.2
        for <linux-fbdev@vger.kernel.org>; Fri, 04 Aug 2023 06:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691154946; x=1691759746;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yghE1gT7JEHr9Ft4Ug/jdVqABt7mGQZ6VHMNTdkCnVs=;
        b=Uj+dsgALblpeMEYsN/uJzGL+Foymm1fS+WWshXemb88b23ZU6RHx27MfVsexCJtIVf
         h63CojLSYwQuOfB4pvar179x/dPNe7zs6h6Dv3VSYVgcq781q2zzqlftDObultHHJ4hq
         3QO8wxPPPcjdIrIGK6nO2ICGv/jz8LKEDpZdrJIeKf6r2zHF4a9py1nAOSW3/fMR24Tr
         ypw2fGmOoZC3m7N6waWMb+zKUfa45DGcZu7cOgtk9kSlnocLGua4SpSt8DpgVHRJNkQv
         idtSxDVbhh5rxiAqKPpMuSviLVR6YMhZh6pG9AbHXOOG6IvOPgNNLKK1Lc3bpkAzklNr
         pFZg==
X-Gm-Message-State: AOJu0YzHw+ZVupNTCJ+XtxuFzrttFFfU3FyoULZNmlkeT2+bFhmw5uzo
        cat93NSoKcZofscqTfU1QqGfPioD73Vxo8ewn+u3ADyHRHleV9dLKruywLVnl0b7Pc10RA0xa+i
        TuRSEcIQ/5jLGoQCElVr4t4w=
X-Received: by 2002:a05:6808:1307:b0:3a0:5596:efe8 with SMTP id y7-20020a056808130700b003a05596efe8mr2348288oiv.54.1691154946638;
        Fri, 04 Aug 2023 06:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENWP+4GK74C7AuYHmh+2X37PsqlfaNPjW5MQ5IAf9v1dlH0ambZpvXNVp8pt59GOqaQo2gFA==
X-Received: by 2002:a05:6808:1307:b0:3a0:5596:efe8 with SMTP id y7-20020a056808130700b003a05596efe8mr2348264oiv.54.1691154946400;
        Fri, 04 Aug 2023 06:15:46 -0700 (PDT)
Received: from localhost ([181.120.144.238])
        by smtp.gmail.com with ESMTPSA id x16-20020a05680801d000b003a463ded3a3sm939158oic.53.2023.08.04.06.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:15:46 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: linux-next: Tree for Jul 31 (font problems on UML)
In-Reply-To: <dd29e5f5-d9f7-0103-e602-b98f26c88fb1@infradead.org>
References: <20230731140924.5d45b2b4@canb.auug.org.au>
 <dd29e5f5-d9f7-0103-e602-b98f26c88fb1@infradead.org>
Date:   Fri, 04 Aug 2023 15:15:43 +0200
Message-ID: <87y1ireyo0.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

Hello Randy,

Thanks for the report.

> On 7/30/23 21:09, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Changes since 20230728:
>> 
>
> I don't know if this is related to FONT changes or fbdev build changes.
>
>
> on ARCH=um, SUBARCH=i386:
>
> WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
>   Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
>   Selected by [y]:
>   - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]
>

https://lists.freedesktop.org/archives/dri-devel/2023-August/417565.html
should fix this.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

