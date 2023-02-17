Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA562C636D4
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Feb 2023 08:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBQIuL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Feb 2023 03:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBQIuH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Feb 2023 03:50:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D475661850
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 00:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676623731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2eU8yeckiOADs0SAPKaxGJh7w9R7c65Q/H5mdcfdOj4=;
        b=K7eZbkgeAu+2g/01x937ak6rezu/DcjNSqEV4MDGj/kHkgM+S9devOtuNBGaDMhC1+QOQk
        zGwkD4dMSfGS3dO0w4LrXk7lipDFgcqW1j1ur6ewNABcjvbPVo4EoIiYiRmhcR5jIko0mU
        fI1nNnFZTgIiSY+ezjkU2b4O/qtYa/k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-99--dbIuRssNvyLLl0Lybx2rQ-1; Fri, 17 Feb 2023 03:48:49 -0500
X-MC-Unique: -dbIuRssNvyLLl0Lybx2rQ-1
Received: by mail-wm1-f72.google.com with SMTP id l32-20020a05600c1d2000b003e0107732f4so414024wms.1
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 00:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eU8yeckiOADs0SAPKaxGJh7w9R7c65Q/H5mdcfdOj4=;
        b=EtyTmeQJFr1dO+hz2mDEnNkwJNSTW/0XbKFBchscw65zqruKEtCZ8MzwDxKl9gsDOc
         umbCgKYfEi3luLXXSC6EWL0P0wbzGwp0B4Watv+rUX4iCSRsPi8V9ChncrVkMCVVmEMK
         fwyAf/nCB88DlXZw7BCuoS2VnNd/J3wpHRdNoSPYJ4eCykIjdbetwRob8D+U6hjuL6+C
         X7pPwpLNeaoBjci8x8Y5CQdA2/0tnLSuRbAwhk3VEF3r6ilgcbar2rHxVa1Rf1HFV0/Y
         kk9Gfh03G0uVN1g8x+2GI/6jGRWd4nFKLWtRWYfnBZqcdmp/vDbRH3pPMl0/XOPc2Ofb
         rh4w==
X-Gm-Message-State: AO0yUKXZu3mB6O8sKI/9UmGM4zWSded2NvBmVwbwn/xmUxVsNtM8fyPk
        W65KxlPaDZfigdru0ie+xZeFn8eahCrO0s31rEIyjfbLy/E5rmhDgmgI99SFUqn0Cw14ogHP0W1
        np3aWhzF/4hv/XWxvZ0gGVyE=
X-Received: by 2002:a05:600c:3096:b0:3dc:5c86:12f3 with SMTP id g22-20020a05600c309600b003dc5c8612f3mr7917280wmn.1.1676623728600;
        Fri, 17 Feb 2023 00:48:48 -0800 (PST)
X-Google-Smtp-Source: AK7set+a6F9dptY7bjjBAON9AHGK9gU+ghqAshRPH5VyjXN8kErI5tYZZJ197OpUlukUZMZdtlZ16Q==
X-Received: by 2002:a05:600c:3096:b0:3dc:5c86:12f3 with SMTP id g22-20020a05600c309600b003dc5c8612f3mr7917267wmn.1.1676623728342;
        Fri, 17 Feb 2023 00:48:48 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id hn30-20020a05600ca39e00b003db03725e86sm4300956wmb.8.2023.02.17.00.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 00:48:48 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        geoff@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 06/11] fbdev: Unexport fb_mode_option
In-Reply-To: <20230209135509.7786-7-tzimmermann@suse.de>
References: <20230209135509.7786-1-tzimmermann@suse.de>
 <20230209135509.7786-7-tzimmermann@suse.de>
Date:   Fri, 17 Feb 2023 09:48:47 +0100
Message-ID: <87v8k0wuc0.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> There are no external users of fb_mode_option. Unexport the variable
> and declare it static.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier

