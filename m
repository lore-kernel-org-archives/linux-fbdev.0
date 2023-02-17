Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2947C05027
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Feb 2023 09:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBQJFI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Feb 2023 04:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBQJFH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Feb 2023 04:05:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29325604FD
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 01:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676624660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r/Vg/oi7sg0lEBjm9qSqwVJEQFFplyI3DAHqU5zgGyM=;
        b=Ic29crjQhXdj+/58Dde0zupPGkQ5yEsSpu1IaQFE/Qk8ypYWggSSgVgFHO6IqjAEzIEXny
        7TmVwQQoWg07Tr+GXbGy10CWTSMYVKJnx1vA12De0Zq5J/Y+VC8fQl8MEnJLDHpDmTLhFL
        bVhc7aGsnPmSWXyvSWlzU7EyzAbttsw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-96-m_ywnrscMY6p7UmOcqA3CQ-1; Fri, 17 Feb 2023 04:04:19 -0500
X-MC-Unique: m_ywnrscMY6p7UmOcqA3CQ-1
Received: by mail-wm1-f72.google.com with SMTP id p30-20020a05600c1d9e00b003dffc7343c3so332949wms.0
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 01:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/Vg/oi7sg0lEBjm9qSqwVJEQFFplyI3DAHqU5zgGyM=;
        b=OCFeHlO7JezOdw8uvqdhNZpwBSqF6HnGsOTDuTQddJHRbLv56UeaMCCrMcV6HU29i/
         LQOcYnXnH5xHGe4r5O1wf1ZcL6UIKzy0RyWik55KCZ4y0z6EWj0ZubQuvrASWFr7QRgt
         nnrcLqeLLuYNycVkrw/OFE6rxLMKvGqJB1Wl2CdQ4zJy+qteVxTjfhL3cAAVupscmAcW
         5WGV5Ft9/h/sdGZrDBVzyLHZTBbsTkh5YBBLG9qiQ97KoCmZHUY+Mg1r6+aFNXiueQa3
         AIPD49tKPPBj7yysMawOwhriURKFSyeknio3XqLTZjxeocpRhmj9vRmLNT0p+Kse27Q5
         RBbA==
X-Gm-Message-State: AO0yUKWoTxTVy+fCDzZbgNNgMxVpVsM4cGlNH/+JikzZoDcGjLMLTvHy
        DQK+iTu/ETLdjDD0mSyNOh03DxgpR2AZl/lcE8FawRxmogSVA+Sqtu+T/HY48qce/MJ1mR9FYrQ
        R8le1opxVGwgwKGstakeOfxU=
X-Received: by 2002:a5d:5274:0:b0:2c5:6c26:1f73 with SMTP id l20-20020a5d5274000000b002c56c261f73mr7413163wrc.20.1676624658127;
        Fri, 17 Feb 2023 01:04:18 -0800 (PST)
X-Google-Smtp-Source: AK7set98GWM304I+yPyS58qtsFdfDQC0E6UdjQSZ+kNzg9KXWfZpJwMOLAHu6SxeCJt3DfODLkCIXA==
X-Received: by 2002:a5d:5274:0:b0:2c5:6c26:1f73 with SMTP id l20-20020a5d5274000000b002c56c261f73mr7413138wrc.20.1676624657852;
        Fri, 17 Feb 2023 01:04:17 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d6806000000b002c6d0462163sm965896wru.100.2023.02.17.01.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 01:04:17 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        geoff@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 11/11] drm: Fix comment on mode parsing
In-Reply-To: <20230209135509.7786-12-tzimmermann@suse.de>
References: <20230209135509.7786-1-tzimmermann@suse.de>
 <20230209135509.7786-12-tzimmermann@suse.de>
Date:   Fri, 17 Feb 2023 10:04:16 +0100
Message-ID: <87h6vkwtm7.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Do not claim that there's a default mode in the video= option parser.
> if no option string has been given, the parser does nothing.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier

