Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19FDC77B7A
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 09:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbjFGJC3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239676AbjFGJB6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 05:01:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BE926AB
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 01:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686128373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jAHIJ4eh7v+dqxg6uWyXvuAZ3noGOIESAVR0yVwLrLw=;
        b=AwE/1Lz7S9+DISUHrdxHlFzrjHflccu3Vy1k2uMBfgPNiDPS12KeWvAUpTN3eOhmPmyglg
        QTSS726axtlmvIOvRBZ8ngELeHZT9/SvdBC/baNX7H88E2xV3SkauI5GFuPjULAR44WB4Q
        UobZbpwLqVsKs/BqSpnDd3N/ZkvrttI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-G_kBRcBWNtOo7DcnbJxL7A-1; Wed, 07 Jun 2023 04:59:31 -0400
X-MC-Unique: G_kBRcBWNtOo7DcnbJxL7A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f603fed174so40248835e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 01:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128370; x=1688720370;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAHIJ4eh7v+dqxg6uWyXvuAZ3noGOIESAVR0yVwLrLw=;
        b=M5oZHQcTc4bkFL/5f1v4DUKBElja+gKbwy/o1Y7Mhw+xvwdQpjbK7q3Rqsw5qx8ERX
         9YiI9UcmJ7p/m6LtSrKReFDM2M7TQvUCntw8XdQ5oTw7klclFMzqLcQEk20ik2/tZFhj
         AwlObqomB6BfP2vdWdCga7+b5fdLDPpAFujvjqfZFYGE5CI58/OVI02L3UT9J9sIGFkp
         rHPjcaIaNK1L769R2Noc15ykTeTc2MjDChAn5de9MuRX1HRvHErRasWvWb+xHXOgry5+
         ALd90ft+zim+9wS0fUuqTP/DdLOYLMMOHkeqz8Lf1M9HNkPILWRzB67YHl5tKitQpU+2
         /b2Q==
X-Gm-Message-State: AC+VfDyYbw+dVxwUHkE7QnCBfj51PyHThQtmIBOWgrFzEqlKG5RZWf5M
        D9liGsDFZgR9BL85tX5qKIj/IU0aja07GGP35kCXKAWWMR/clQeN42cDy8Md7aMQJmXwbljT4Vz
        I3b1E8vEpVx63L9rWcHHZsg4=
X-Received: by 2002:a1c:4b0d:0:b0:3f7:5e07:ea54 with SMTP id y13-20020a1c4b0d000000b003f75e07ea54mr4233927wma.13.1686128370564;
        Wed, 07 Jun 2023 01:59:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Qn3iTdYPwZ2PEqyICfVMTtkj5C/L8grzoRqC+iaiUjGk+XghGobRkAfICwnQ/2eAeuKuydg==
X-Received: by 2002:a1c:4b0d:0:b0:3f7:5e07:ea54 with SMTP id y13-20020a1c4b0d000000b003f75e07ea54mr4233912wma.13.1686128370260;
        Wed, 07 Jun 2023 01:59:30 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003f1978bbcd6sm6448319wmo.3.2023.06.07.01.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 01:59:30 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 10/30] fbdev/ep93xx-fb: Output messages with fb_info()
 and fb_err()
In-Reply-To: <20230605144812.15241-11-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-11-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 10:59:29 +0200
Message-ID: <87legvfy1a.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix cases were output helpers are called with struct fb_info.dev.
> Use fb_info() and fb_err() instead.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

