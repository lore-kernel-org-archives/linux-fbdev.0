Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3860AEB64D9
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 Jul 2023 07:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjGDH4U (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 Jul 2023 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjGDHzz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 Jul 2023 03:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECE4173B
        for <linux-fbdev@vger.kernel.org>; Tue,  4 Jul 2023 00:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688457283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKrB5YS08GogmNSu7Y0RQRA2Szw+Z40s1lTL+YoBbo8=;
        b=B1JCrY73CrV3nmTyA8Xv2L5RnrSmYenblr1SAhitvUDw1J7CKuWUn9t4tVoVhgM06LXeH2
        5j8wDKz9aaqxXELIxEX1hTDJVW7g3SlDU+UQJGuyKIiO9hHeZ/g/t9T0IAf6OcFnk0ckdD
        O113PHcPaRacxiRGFCTxELbIR9T9ZDQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-CVQPM-LsNgeXQDXCHSNVWA-1; Tue, 04 Jul 2023 03:54:42 -0400
X-MC-Unique: CVQPM-LsNgeXQDXCHSNVWA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fb76659d44so4897625e87.3
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Jul 2023 00:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457281; x=1691049281;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKrB5YS08GogmNSu7Y0RQRA2Szw+Z40s1lTL+YoBbo8=;
        b=LUy2+cxvopTgb7Og+syPlKJ9YbzcPaLVqlpOq3le64HISAaGG85Z3dwf+ZWMNrWyM3
         STVJVd2Kpz2Yj2P/u1iwzadA6mu4IWE5zxjHU8hAyg9106GVevNMmuqB/8BRLOS5buv5
         2+sM/6bB6cOd5tlujFCiC7o/dZcQabbg1ZrKUeej6UObszSoP909gRodwA+dMxcvPPcC
         AIDp2ekjjPooVCOJrXy+6wrIP5TQ2XkElcUgTS/NNM7UekFqUgYmLIstTyhNQuyKpEL/
         e0woItOkC8yKhDO0C2YAdpR8cvGYUNqqJ8Z/ER0EvuZf9UsOI6OiUjStUWU3drcQsTxB
         TwPA==
X-Gm-Message-State: ABy/qLacQnJULoJdLVgkE07DGksYcU95BPFlkwxFXMndZIFb2YRd1QDG
        luGjP6tCTZXUQj8VyuxoK+Kk5ZmJlk5bsyGTc4JuXU+xh7wVreHhjHlgugVLNcLMj9cR9IHqgj5
        fBfc+V73r8Fht9cp2uRIXjhM=
X-Received: by 2002:ac2:5f92:0:b0:4fa:a0c3:efa1 with SMTP id r18-20020ac25f92000000b004faa0c3efa1mr8124397lfe.7.1688457280934;
        Tue, 04 Jul 2023 00:54:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGv5H/b0zhH/dQl8i//ZbCh57DUE2bTT97eL1Mf3dlGQfF99dJp+Ktbu5zRXTh1sOMdVeb8dQ==
X-Received: by 2002:ac2:5f92:0:b0:4fa:a0c3:efa1 with SMTP id r18-20020ac25f92000000b004faa0c3efa1mr8124377lfe.7.1688457280294;
        Tue, 04 Jul 2023 00:54:40 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c230700b003fa968e9c27sm24443386wmo.9.2023.07.04.00.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:54:40 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 1/5] video: Add auxiliary display drivers to Graphics
 support menu
In-Reply-To: <CAMuHMdXRg1OUy6UHuH4H+qkK-qO+jTKdVoG_SRM3q_PkyD+Bbw@mail.gmail.com>
References: <20230703230534.997525-1-javierm@redhat.com>
 <20230703230534.997525-2-javierm@redhat.com>
 <CAMuHMdXRg1OUy6UHuH4H+qkK-qO+jTKdVoG_SRM3q_PkyD+Bbw@mail.gmail.com>
Date:   Tue, 04 Jul 2023 09:54:39 +0200
Message-ID: <87h6qkyuv4.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

> Hi Javier,
>
> On Tue, Jul 4, 2023 at 1:05=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> The drivers in this subsystem are for character-based LCD displays, which
>> can fall into the same category of the DRM/KMS and fbdev drivers that are
>> located under the "Graphics support" menu. Add auxdisplay there as well.
>>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Thanks for your patch!
>
>> --- a/drivers/video/Kconfig
>> +++ b/drivers/video/Kconfig
>> @@ -30,6 +30,8 @@ if HAS_IOMEM
>>  config HAVE_FB_ATMEL
>>         bool
>>
>> +source "drivers/auxdisplay/Kconfig"
>
> This is inside the "if HAS_IOMEM" section, while there was no
> such limitation before.
>

Gah, I missed that. Thanks a lot for pointing it out.

If I move the source outside of the if block, are you OK with this patch?

I think Thomas is correct and would make sense to put the character-based
drivers next to the DRM and fbdev drivers since all these are for display.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

