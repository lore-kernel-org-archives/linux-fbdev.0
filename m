Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAFBEB64D9
	for <linux-fbdev@archiver.kernel.org>; Thu,  6 Jul 2023 13:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjGFNIr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 6 Jul 2023 09:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjGFNIo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 6 Jul 2023 09:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50821BD9
        for <linux-fbdev@vger.kernel.org>; Thu,  6 Jul 2023 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688648875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LeNjy3+keWlsOvLTTvuNBq4v2wzKbZwn++nVg8XqFBY=;
        b=PXcyH9pE/pbW3vK2szPTh7cUYYx9YsjKYHGXTAkriC3wq3mR10YjLa5EmLn9pdk+CX9K0Z
        yzDKnNu/kzJarNTI21voHKfN6uBzcSpT87NnFpO7+J0iqL+vJUEheYy8mojPZyErUNLErF
        z+8vX8q1TSfa0+Ee2QlENiTSst0zxEw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-9fhW2G4ZPS22X_AlCzjEpQ-1; Thu, 06 Jul 2023 09:07:53 -0400
X-MC-Unique: 9fhW2G4ZPS22X_AlCzjEpQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbaade0c71so3970465e9.2
        for <linux-fbdev@vger.kernel.org>; Thu, 06 Jul 2023 06:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688648871; x=1691240871;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeNjy3+keWlsOvLTTvuNBq4v2wzKbZwn++nVg8XqFBY=;
        b=k148CJl7sjnLYpuzpeh5uTliRniyD5oGgcad/3OLwMYfQWt8/IgZ07rLGuef5k8J52
         U/fvX/gfZSobouWsgYax38FcqBHWpTEn2itpkEcPWHEcM3NCkGejmerh/GBhMNJCYZPq
         NX1HKwrdaakGgx7CQelmgaECidaskOxFmHPHTFxSo3e9QZjgM5Gcef++U8xi8xksPOtD
         IxV6oQMoZl7Mfj1ljXXhfgSgoNPYjU6/maCyIqukoIXHjOsy0L9ylttB11JO3me+Mi6W
         2QQvknWtqMhcsdBXl3c8lqilW27xy9nAYref2Md3WPorlNvaP7LYR/1zJlP0aYmOPWMa
         ikag==
X-Gm-Message-State: ABy/qLa2OyZfIgB08zxKWqOyrhmkkvr2VXR0pLud6sztX5Qnfk4TKQCo
        CPcravv3J3x0tw4gzYDnbPl1707SXGTmmk10L0fjGjGM1rBM6icAQudpHUDobiPg8CrQZUDmTiL
        7YsxEXNG86xZaOFBYvmWcFGhEG+xcTRQ=
X-Received: by 2002:adf:f805:0:b0:314:4c78:8b84 with SMTP id s5-20020adff805000000b003144c788b84mr1326690wrp.17.1688648871140;
        Thu, 06 Jul 2023 06:07:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEaxocSJQPDHbM+Bf8WPoQwbvLcXg68bXBbqp/OOFiEKQL+7RK5UP/6wE2wZ9Vp1LmHB/VY4Q==
X-Received: by 2002:adf:f805:0:b0:314:4c78:8b84 with SMTP id s5-20020adff805000000b003144c788b84mr1326675wrp.17.1688648870795;
        Thu, 06 Jul 2023 06:07:50 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d4807000000b003143aa0ca8asm1885374wrq.13.2023.07.06.06.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:07:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 11/11] fbdev: Harmonize some comments in <linux/fb.h>
In-Reply-To: <20230706124905.15134-12-tzimmermann@suse.de>
References: <20230706124905.15134-1-tzimmermann@suse.de>
 <20230706124905.15134-12-tzimmermann@suse.de>
Date:   Thu, 06 Jul 2023 15:07:37 +0200
Message-ID: <87sfa1xk6e.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Make the comments for I/O, system and DMA memory say the same.
> Makes the header file's structure more obvious.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Looks good to me. Thanks!

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

