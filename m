Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100BEC636D4
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Feb 2023 08:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBQISl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Feb 2023 03:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBQISf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Feb 2023 03:18:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F941729
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 00:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676621867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wtFVX3dHOB8+DY5YF2q7KTLFhIxjv3h/l+UG59nF41A=;
        b=hXSxeS8YedbfODm7E3hoGnHCgxrG3tcyOfBNDRvVFI2njSoh6+aj73gp6OCI/BsZVqDRNa
        5Z73hpZfjfQ0WXFj265rDpQaRyFqKJeUgcIy87jbD2J4K1fyuRvgOucBaSWS+2hvHMei4o
        YYAGnmJVHJIWYaByGtdGTW/hz8h9oSU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-172--jRFtKXIMoeCWXLV2A_WYQ-1; Fri, 17 Feb 2023 03:17:45 -0500
X-MC-Unique: -jRFtKXIMoeCWXLV2A_WYQ-1
Received: by mail-wm1-f70.google.com with SMTP id l36-20020a05600c1d2400b003dfe4bae099so285791wms.0
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Feb 2023 00:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtFVX3dHOB8+DY5YF2q7KTLFhIxjv3h/l+UG59nF41A=;
        b=jti9swKFG1dgnxqKFd+zVlC/Xm9zxXkZc79UROQOwGc57pwOYgQ3PVP7twi7kUbF7K
         M5VFsXhtDaHrN9wOWL9HGPFURL7Jl8yy/BMZmyqGXNt1zpIOb7G+WESvKkpwA3Fnpmk3
         6xP6U4E3U4YVQDTcOCmwBm+HnzLgxiDY+NjZvdvHrHdtBMq0zjZNBGArKuFFmnysl8qy
         qaSc+a63RqaXsCrABmVvylGXP/aAAYvdcHmUqcUS9zmJAu7Dchk1ZEpdxFch98YjV9R/
         UvN0CRJmNOmXmfa5XzrJq0tIdBFsTW8IzEw0JF6R+w/N9M1Z9DgFvOlNG6NdgpyYSAQp
         mcnQ==
X-Gm-Message-State: AO0yUKV6hnybdfz06ifjTpBb23ZGHNMFi0lBQwoXtmvqSNf1VnDeGFft
        lF6+pZb9x7jxAZf0Li33CY/3nbh6F8PCOLm/GSOzYKc03huEF7uXq/6MttKKoC8mz8tghxNWXUp
        SRoP39FIbE8Y0LGijBiuzaDg=
X-Received: by 2002:a05:600c:2ad6:b0:3df:eea8:1fe5 with SMTP id t22-20020a05600c2ad600b003dfeea81fe5mr137419wme.14.1676621864505;
        Fri, 17 Feb 2023 00:17:44 -0800 (PST)
X-Google-Smtp-Source: AK7set+v0I61y27bR+2XJ6an3+9nBMwpY84s+ynDtSH/Xq+FeMfX4cwaGQQ6iI5v0gNhFUVv3oSOjA==
X-Received: by 2002:a05:600c:2ad6:b0:3df:eea8:1fe5 with SMTP id t22-20020a05600c2ad600b003dfeea81fe5mr137410wme.14.1676621864243;
        Fri, 17 Feb 2023 00:17:44 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c21c900b003e11ad0750csm4235812wmj.47.2023.02.17.00.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 00:17:43 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        geoff@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 01/11] fbdev: Fix contact info in fb_cmdline.c
In-Reply-To: <20230209135509.7786-2-tzimmermann@suse.de>
References: <20230209135509.7786-1-tzimmermann@suse.de>
 <20230209135509.7786-2-tzimmermann@suse.de>
Date:   Fri, 17 Feb 2023 09:17:42 +0100
Message-ID: <87edqoyac9.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix Daniel's email address. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier

