Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69789C7EE23
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 07:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjFGH4H (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 03:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjFGH4H (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 03:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B26198C
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 00:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686124519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zrMzVIVwuoeUQwH5hpliW2Jq51XgxuMBmmo9TGjEBeo=;
        b=isajzC8t9nkJVUHcOICL+AMNcDOBwnWRP3brBoKjnsxtDK2ZIyDe/CuZhomp4MB+yMF5Vq
        A1ZmjCLjR2bvnvHva59BWjm1v+gA7F0+sClN91k6GOa58jG4Xj5VJfEuf/mwtOQ1Ebt66U
        IC79ou6thATC9N2V7G1HTAu75j0cbXs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-RVKGzEkbO1S6xi359WrBCQ-1; Wed, 07 Jun 2023 03:55:15 -0400
X-MC-Unique: RVKGzEkbO1S6xi359WrBCQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4edb90ccaadso4456762e87.3
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 00:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686124513; x=1688716513;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrMzVIVwuoeUQwH5hpliW2Jq51XgxuMBmmo9TGjEBeo=;
        b=hJygv+gDv+NRBRkNQzc/2/nhi0pzhqkjnM8nvhnnfLm9Zy/CwtgNxngAHsOc1EmmZv
         2J44RRMUl/yLdi7mREdZ2C2D+D6JyHr7H5s23LcxLvNiFakt9tcwl5v2FRjfIVFU8KDR
         5uQ9Ehntu/33RMeqAGEL1aEL4bRAWEAtbo3p2gOXXkWZrLEcx7e2DJU+6CuFnENVOS03
         Tk8QyaT2iO05FuJqUT6F/g3Q6oUuzkbv3IQd0C65yV6rXj/XMO74sk28LNoLw+rvvqpM
         V0oigjYLDO2Ggasp7ngRvGwYlb3ywkttc5iBfSfS3nRk5jNRrsKz9yTKXKVv2vGNLzPR
         mbkQ==
X-Gm-Message-State: AC+VfDw6BfKPYolOL8e6Y6Y8heK4RzkqfX0MaODqdB+D86FYbtGpVzto
        smYsuUuhfNNg2u9xmV3pdUPsldLcEjViPP+toQgAwz/xVt5vtCSNy6reYRHUrug5TktHqomIHew
        Im65Fl96SfT950ckLdgcwvetj6KVXBpw=
X-Received: by 2002:ac2:5a19:0:b0:4f3:bb14:bd40 with SMTP id q25-20020ac25a19000000b004f3bb14bd40mr1643612lfn.36.1686124513740;
        Wed, 07 Jun 2023 00:55:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5iJQ/YOY5BYJYpCuij2Dk8TuMWnzRrrUQf5oe61hk5gDfo5VjRa0aD7EjgG4gko6svJeBZBA==
X-Received: by 2002:ac2:5a19:0:b0:4f3:bb14:bd40 with SMTP id q25-20020ac25a19000000b004f3bb14bd40mr1643602lfn.36.1686124513442;
        Wed, 07 Jun 2023 00:55:13 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4d09000000b0030e5c8d55f2sm480065wrt.6.2023.06.07.00.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:55:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 07/30] fbdev/aty128fb: Use hardware device as backlight
 parent
In-Reply-To: <20230605144812.15241-8-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-8-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 09:55:12 +0200
Message-ID: <87ttvjg10f.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use the hardware device in struct fb_info.device as parent of the
> backlight device. Aligns the driver with the rest of the codebase
> and prepares fbdev for making struct fb_info.dev optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

