Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD36C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 10 Dec 2021 07:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbhLJHXK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:23:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237181AbhLJHXK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 10 Dec 2021 02:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639120774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xIuU9cNPwfmUgDmeC7P+PpkBhwlP92g1vruFU5WPOts=;
        b=JjW6DMY+pQ0QCacOWlARFVaFXE5sjnErRgWi0FQJF0xsEuo8zpGkkiT6ByQHIHf+dIINH3
        tEFD2KnXAfk9LC4gY/hstZVEvVTYbaN3eAoXqf24eTUaaMJKztgJKgqL/GWOrMyNlpAomd
        wEEO5rSG22OgFNAjgYhnNN7mD9TmwHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-174-7GsQF46PO4KbUQg82WERKA-1; Fri, 10 Dec 2021 02:19:31 -0500
X-MC-Unique: 7GsQF46PO4KbUQg82WERKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CADF5100C660;
        Fri, 10 Dec 2021 07:19:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23AB519C59;
        Fri, 10 Dec 2021 07:19:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8FC981800397; Fri, 10 Dec 2021 08:19:14 +0100 (CET)
Date:   Fri, 10 Dec 2021 08:19:14 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        kexec@lists.infradead.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        kernel@gpiccoli.net, Baoquan He <bhe@redhat.com>,
        Samuel Iglesias =?utf-8?Q?Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, xinhui pan <Xinhui.Pan@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, pjones@redhat.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Young <dyoung@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
Message-ID: <20211210071914.n4l2mdknbv3yeqtq@sirius.home.kraxel.org>
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
 <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
 <CADnq5_N9ptK4c86LO77YcrF5_M==hket+L7eYjsGCaKbORO=ug@mail.gmail.com>
 <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaea0143-a961-b83c-3c6c-4d612cd003bc@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

  Hi,

> > The drivers are asic and platform specific.  E.g., the driver for
> > vangogh is different from renoir is different from skylake, etc.  The
> > display programming interfaces are asic specific.
> 
> Cool, that makes sense! But if you (or anybody here) know some of these
> GOP drivers, e.g. for the qemu/qxl device,

OvmfPkg/QemuVideoDxe in tianocore source tree.

> I'm just curious to see/understand how complex is the FW driver to
> just put the device/screen in a usable state.

Note that qemu has a paravirtual interface for vesa vga mode programming
where you basically program a handful of registers with xres, yres,
depth etc. (after resetting the device to put it into vga compatibility
mode) and you are done.

Initializing physical hardware is an order of magnitude harder than
that.

With qxl you could also go figure the current state of the hardware and
fill screen_info with that to get a working boot framebuffer in the
kexec'ed kernel.

Problem with this approach is this works only in case the framebuffer
happens to be in a format usable by vesafb/efifb.  So no modifiers
(tiling etc.) and continuous in physical address space.  That is true
for qxl.  With virtio-gpu it wouldn't work though (framebuffer can be
scattered), and I expect with most modern physical hardware it wouldn't
work either.

take care,
  Gerd

