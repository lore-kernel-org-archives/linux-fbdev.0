Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141F6C433EF
	for <linux-fbdev@archiver.kernel.org>; Sat, 11 Dec 2021 09:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhLKJ0w (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 11 Dec 2021 04:26:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229839AbhLKJ0v (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 11 Dec 2021 04:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639214811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FuzLqB82BcW0UP+PPCzPY/LPJgq+aPig3zfEP1M1Qiw=;
        b=F813cUURlJjmBcbdwRgiOFxz5Pas/02oYhQypyppczieTDv/hOlAnRVGOLkIX6XQiZ89za
        V5s26eE7P9XbnLOV+/mLJhtBejFbVyetSpRZOdGAmhopB8wj3VJzPfu1LaHsLcGVUPDOlA
        RoS7Twiejj+SqKm/c+3JwWVQdIJehtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-wb8vZXmRPh-pKWUdhmnIAQ-1; Sat, 11 Dec 2021 04:26:48 -0500
X-MC-Unique: wb8vZXmRPh-pKWUdhmnIAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B8E68042E0;
        Sat, 11 Dec 2021 09:26:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CBA545D66;
        Sat, 11 Dec 2021 09:26:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 38AED1800091; Sat, 11 Dec 2021 10:20:50 +0100 (CET)
Date:   Sat, 11 Dec 2021 10:20:50 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Baoquan He <bhe@redhat.com>,
        Samuel Iglesias =?utf-8?Q?Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, kernel@gpiccoli.net,
        kexec@lists.infradead.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        pjones@redhat.com, Thomas Zimmermann <tzimmermann@suse.de>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
Message-ID: <20211211092050.wbczxxrnzoywbns6@sirius.home.kraxel.org>
References: <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
 <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
 <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
 <6d3c7acf-a23f-3073-56ed-375ccb8cc815@suse.de>
 <99b38881-8c63-de04-50f8-aa4119b52b25@igalia.com>
 <CADnq5_NqPEY6vPSsBQSst5Gsw-VpJ-sp-5DHMeB+EGA2t7KoAQ@mail.gmail.com>
 <56dfb915-036b-0584-f0ef-83c786970d6e@igalia.com>
 <d1de6ca3-11ae-af9e-a2fb-7bcb6fae01d6@amd.com>
 <3988a221-2f6a-540a-3d77-18c2c67ddbe7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3988a221-2f6a-540a-3d77-18c2c67ddbe7@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Dec 10, 2021 at 07:54:34PM -0500, Felix Kuehling wrote:
 
> Do you actually need to restore the exact boot-up mode? If you have the same
> framebuffer memory layout (width, height, bpp, stride) the precise display
> timing doesn't really matter. So we "just" need to switch to a mode that's
> compatible with the efifb framebuffer parameters and point the display
> engine at the efifb as the scan-out buffer.

That'll probably doable for a normal kexec but in case of a crashdump
kexec I don't think it is a good idea to touch the gpu using the driver
of the kernel which just crashed ...

take care,
  Gerd

