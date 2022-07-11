Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BB3C43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 11 Jul 2022 11:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiGKLhI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiGKLgv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 11 Jul 2022 07:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81A9A8BAAA
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 04:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657538648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PXcH7XPyiqXQf/YCraM2DsGXqmeqYbmlOyORvpQYVqY=;
        b=WlG+F+qpVD/SVbuOlPgPoJb66DgZtDwNLIj34iKQuFzpNbcaWTFhkPrwB59oanI7VMPIIc
        Ybj95IRHDpLcdwD62hgNL8d9rtJqNg2l0qYtaTNwhIzgmIMI93fgexGL5l09CPtXi4Ij/Q
        5mZWyYRfDo+lpZhxoxXlm8TsOKVoZGY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-sycHvVN6OT6LBovsMD5-iw-1; Mon, 11 Jul 2022 07:24:06 -0400
X-MC-Unique: sycHvVN6OT6LBovsMD5-iw-1
Received: by mail-wm1-f71.google.com with SMTP id 2-20020a1c0202000000b003a2cfab44eeso5085874wmc.6
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 04:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PXcH7XPyiqXQf/YCraM2DsGXqmeqYbmlOyORvpQYVqY=;
        b=6fp5iW69Wq/99JLIRPpopVpnk1+mmhHA24CCeEOiGX4ihLTEniInDLaeQg3nWPwVy8
         t5iS6CybpVIQ6A4+YVtIzhaxida6S6aOQMXeTd9IKWsU8go/f56HB8ZnSN3r3b53zaWZ
         fPt6RAKLHYZQ4jdc+dJJ2JK/mWV0cJfpRbX2uIWduHVX79XadJ6lVnaX3HIho1iJcH5D
         LSgJiRrNOvklV8VPXBX/EZoa3aCbeIZfjqFSr43H2grK35yv3Ny1cKlA9QHo3PgA6seG
         YgC2Xs/nLzplGbpGetzjMjI7UkK4/YOJHyByvwaNeKA9XKBQ9a/SNrZI1vsYZUpsCYAP
         xD3A==
X-Gm-Message-State: AJIora+mPr6l3P3Z/B8S6GiRa67CoWI6XYXE1hgW4ccpQIln+JpxYZKP
        U2wJQMpO6dc10hwxFRYT+ArYeqALqIREUasUIHWHA3UjJDg6lyAxExFrA1C+DFYwqfnXeu6xWiO
        TwR02wbl65Ni8JaiE7H0ZgDs=
X-Received: by 2002:a5d:6149:0:b0:21d:6ba7:6095 with SMTP id y9-20020a5d6149000000b0021d6ba76095mr16111653wrt.680.1657538645787;
        Mon, 11 Jul 2022 04:24:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t+UhotmR2eivMrEaSMsPtL4oXAPCvxQ5CRcLHZzaRlgXGZLXCBF4emHYXNPE71YvR1EZ7rjw==
X-Received: by 2002:a5d:6149:0:b0:21d:6ba7:6095 with SMTP id y9-20020a5d6149000000b0021d6ba76095mr16111641wrt.680.1657538645616;
        Mon, 11 Jul 2022 04:24:05 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q1-20020a056000136100b00210320d9fbfsm6783085wrz.18.2022.07.11.04.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:24:05 -0700 (PDT)
Message-ID: <b0f5479c-1880-65f5-3870-191603468828@redhat.com>
Date:   Mon, 11 Jul 2022 13:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 09/11] video/aperture: Remove conflicting VGA devices, if
 any
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-10-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220707153952.32264-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/7/22 17:39, Thomas Zimmermann wrote:
> On the primary graphics adapter, a driver might conflict with a VGA
> driver that controls the VGA framebuffer I/O range. Remove the VGA
> driver from the aperture helpers. Until now, this case has been
> hendled by fbdev, but it should work even with fbdev disabled.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

