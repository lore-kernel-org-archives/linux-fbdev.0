Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6A6EB64DD
	for <linux-fbdev@archiver.kernel.org>; Sat, 22 Jul 2023 00:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjGVAOL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 21 Jul 2023 20:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjGVAOK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 21 Jul 2023 20:14:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B3FE42
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Jul 2023 17:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689984799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9zAUVsITJjQgJMe+wUauASsmwQ/Teft8FD3ucSilGuQ=;
        b=GrwvLIM8xfzlNmNWyGXdbk5Pug5IRngwdQLvtLOBQo2pD4egn0H600hkpYaSUZjiQxTN0v
        XcNzB3LHW5Cpwz/Fs28qv9XVDvL009f7w8hdPbvJZJIeFT28EVTw1pnEEkire2WNod3plE
        HBJs9p//othUXYPXLgFTpe+Jlloa+oQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-0nShzWB0MiezpPWZQDujuw-1; Fri, 21 Jul 2023 20:13:18 -0400
X-MC-Unique: 0nShzWB0MiezpPWZQDujuw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-315998d6e7fso1289388f8f.3
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Jul 2023 17:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689984797; x=1690589597;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zAUVsITJjQgJMe+wUauASsmwQ/Teft8FD3ucSilGuQ=;
        b=OlNOR/s7IOcXTTHptpBNHLNRwU2AbDtFjLmcU7MpXU52UgPG6Q3CmmGoniZLiM/F4j
         g/5miU6mWzhk5I7oss6ucMFWgr8bG+4QpeR9wbj3iVLPizIKJr1ce2MSYDQlWeHrQtoX
         llY26XTJNnTW0xcHWpDG8X70iXhNbCK5YnpWfVykNwHtrXdyJa7+D/gKaK+5b6AT9spQ
         vqyFygTBZ6YWx6wV9OZCcJ54vfLMystl+PItp9mZ4tWMfkEI8ppXwxjai/MIeJPpWRwI
         bU9B97IT4APjXCAJtCiIplzrZT5qd0emSEWgD8FWp9FVCStywd4XyMv5lkvTpXRvzahb
         8ykw==
X-Gm-Message-State: ABy/qLYKaWURN5bdhze6QIS9WJXKhRLZBpPIcG0S4QEezUgj+aSgXw0L
        KCcwQWw3vjBvmHp+PWCD0ffIENldbif4s3yeSXk13/Idkv4Gf8Iw9hHdvtNMH1MmxmwHCEzlQSd
        81FCkJOgZ1f+DL1+KAcdnrqw=
X-Received: by 2002:a05:600c:20d1:b0:3fd:1daf:abd8 with SMTP id y17-20020a05600c20d100b003fd1dafabd8mr2089739wmm.40.1689984797568;
        Fri, 21 Jul 2023 17:13:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEXRkyrt5UhsSX2MfCaQiSDHQSKHbh/kU/IrA6UfVzAbLX+sn0IQirVDLsddlSuFOcFPpbQDw==
X-Received: by 2002:a05:600c:20d1:b0:3fd:1daf:abd8 with SMTP id y17-20020a05600c20d100b003fd1dafabd8mr2089733wmm.40.1689984797253;
        Fri, 21 Jul 2023 17:13:17 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c210900b003fbcdba1a52sm6920280wml.3.2023.07.21.17.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 17:13:16 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 1/4] video: Add auxiliary display drivers to Graphics
 support menu
In-Reply-To: <CANiq72=A3PLGGPGnwL=gjX7LFsQL9N8W__ojxmVpj2uCAKvhQA@mail.gmail.com>
References: <20230719081544.741051-1-javierm@redhat.com>
 <20230719081544.741051-2-javierm@redhat.com>
 <87sf9gublz.fsf@minerva.mail-host-address-is-not-set>
 <CANiq72=A3PLGGPGnwL=gjX7LFsQL9N8W__ojxmVpj2uCAKvhQA@mail.gmail.com>
Date:   Sat, 22 Jul 2023 02:13:16 +0200
Message-ID: <87mszou7kz.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

Hello Miguel,

> On Sat, Jul 22, 2023 at 12:46=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> Javier Martinez Canillas <javierm@redhat.com> writes:
>>
>> [adding Miguel Ojeda who was not in the Cc list]
>>
>> Hello Miguel, could you please ack this patch so that I can take the who=
le
>> patch-set through the drm-misc tree?
>
> A note below...
>
>> > The drivers in this subsystem are for character-based LCD displays, wh=
ich
>> > can fall into the same category of the DRM/KMS and fbdev drivers that =
are
>> > located under the "Graphics support" menu. Add auxdisplay there as wel=
l.
>
> Nit: this is not exactly true, e.g. ks0108/cfag12864b (which were the
> first in the subsystem) were not character-based but a very simple
> black-or-white 128x64 grid, so we should probably reword slightly
> this.
>

Oh, interesting. I wonder why that couldn't had been a fbdev driver then
using FB_VISUAL_MONO01? I'll reword then the commit message before apply
to the following instead:

"The drivers in this subsystem are for either character-based or monochrome
LCD controllers, which can fall into the same category of the DRM/KMS and
fbdev drivers, that are located under the "Graphics support" menu.

Add the auxdisplay drivers there as well to have all display drivers under
the same menu."

> In any case, if Helge thinks these may belong in the "Graphics
> support" menu, then I am fine with it:
>
>     Acked-by: Miguel Ojeda <ojeda@kernel.org>
>

Perfect, thanks!

> Thanks!
>
> Cheers,
> Miguel
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

