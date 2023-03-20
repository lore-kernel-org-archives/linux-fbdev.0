Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454C0C7618A
	for <linux-fbdev@archiver.kernel.org>; Mon, 20 Mar 2023 11:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjCTLMS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 20 Mar 2023 07:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCTLL6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 20 Mar 2023 07:11:58 -0400
Received: from lithium.sammserver.com (lithium.sammserver.com [168.119.122.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01661B0
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Mar 2023 04:08:26 -0700 (PDT)
Received: from mail.sammserver.com (sammserver.wg [10.32.40.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by lithium.sammserver.com (Postfix) with ESMTPS id 80EA431181CC;
        Mon, 20 Mar 2023 12:08:13 +0100 (CET)
Received: from mail.sammserver.com (localhost.localdomain [127.0.0.1])
        by mail.sammserver.com (Postfix) with ESMTP id 293123627D;
        Mon, 20 Mar 2023 12:08:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1679310493; bh=0jP3D3BZL68xe5B5D2b80NpReBfe6GPfvVjUNfacUbQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kpt6Ql8kbkfDS+tXED4XbdBTPyvaXOo0ZYMUX/Ee9AD7jGBalMDdh3r5iH+Pu3tib
         eotxR8eXf10HWKPgYyuMabFt8Y/6BE4tdbqbc8okHdwT62Y+QNUnvlY6WVqDZsQAfw
         XGdDhJ+NmQF0lDV2lViexqKZLDd8jnxO+MsuydB4=
MIME-Version: 1.0
Date:   Mon, 20 Mar 2023 12:08:13 +0100
From:   =?UTF-8?Q?Samuel_=C4=8Cavoj?= <samuel@cavoj.net>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2 07/11] video/aperture: Disable and unregister sysfb
 devices via aperture helpers
In-Reply-To: <874jqfpw7k.fsf@minerva.mail-host-address-is-not-set>
References: <20220718072322.8927-1-tzimmermann@suse.de>
 <20220718072322.8927-8-tzimmermann@suse.de>
 <9f682c15a5484b4a94f63e20d41f67d0@cavoj.net>
 <e881f6d6-0d2b-5775-68f2-35cc4d666d63@suse.de>
 <874jqfpw7k.fsf@minerva.mail-host-address-is-not-set>
Message-ID: <87706a167c1e490a12371e2edf0f34e3@cavoj.net>
X-Sender: samuel@cavoj.net
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2023-03-20 11:13, Javier Martinez Canillas wrote:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
> 
> [...]
> 
>>>> +    /*
>>>> +     * If a driver asked to unregister a platform device registered 
>>>> by
>>>> +     * sysfb, then can be assumed that this is a driver for a 
>>>> display
>>>> +     * that is set up by the system firmware and has a generic 
>>>> driver.
>>>> +     *
>>>> +     * Drivers for devices that don't have a generic driver will 
>>>> never
>>>> +     * ask for this, so let's assume that a real driver for the 
>>>> display
>>>> +     * was already probed and prevent sysfb to register devices 
>>>> later.
>>>> +     */
>>>> +    sysfb_disable();
>>> 
>>> This call to sysfb_disable() has been causing trouble with regard to
>>> VFIO. VFIO has been calling aperture_remove_conflicting_pci_devices 
>>> to
>>> get rid of any console drivers (d173780620792c) using the device in
>>> question, but now even unrelated drivers are getting killed. Example
>>> situation:
>> 
>> Which drivers do you use?

This happens with either no drivers loaded or the proprietary nvidia
driver. Nouveau is fine as it doesn't rely on efifb but brings its own.

>> 
> 
> Also, what kernel version?

I tried with 6.2.6, can build mainline and test there as well.

Thanks for help!

> 
> [...]
> 
>>> 
>>> Machine has two GPUs and uses efifb for the console. Efifb registers
>>> with the aperture system the efi framebuffer region, which is covered
>>> by a BAR resource of GPU 1. VFIO grabs GPU 2 and calls
>>> aperture_remove_conflicting_pci_devices(GPU 2). GPU 2 has no overlap
>>> with the efifb on GPU1 but the efifb is killed regardless due to
>>> the unconditional call to sysfb_disable(). The console switches
>>> to dummy and locks up from the user perspective.
>>> This seems unnecessary, as the device is unrelated.
>>> 
> 
> That's a bug indeed but I thought that was already fixed...
