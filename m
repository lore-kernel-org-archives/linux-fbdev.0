Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D369DC54EBC
	for <linux-fbdev@archiver.kernel.org>; Tue,  3 Jan 2023 16:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjACQUO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 3 Jan 2023 11:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbjACQUK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 3 Jan 2023 11:20:10 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9445C1A0
        for <linux-fbdev@vger.kernel.org>; Tue,  3 Jan 2023 08:20:08 -0800 (PST)
Received: from [141.14.14.97] (v097.vpnx.molgen.mpg.de [141.14.14.97])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0557960293A85;
        Tue,  3 Jan 2023 17:20:07 +0100 (CET)
Message-ID: <c11a7128-ec34-c497-e012-577a4928dc94@molgen.mpg.de>
Date:   Tue, 3 Jan 2023 17:20:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Why is mgag200 not used over matroxfb?
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     "Z. Liu" <liuzx@knownsec.com>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, it+linux-fbdev@molgen.mpg.de
References: <5da53ec5-3a9c-ec87-da20-69f140aaaa6b@molgen.mpg.de>
 <972999d3-b75d-5680-fcef-6e6905c52ac5@suse.de>
 <7b85b832-e6fd-fe42-c6a1-93ebb591383c@molgen.mpg.de>
In-Reply-To: <7b85b832-e6fd-fe42-c6a1-93ebb591383c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Dear Thomas,


I have to correct myself.


Am 16.12.22 um 14:16 schrieb Paul Menzel:

> Am 16.12.22 um 13:27 schrieb Thomas Zimmermann:
> 
>> Am 15.12.22 um 17:39 schrieb Paul Menzel:
> 
> […]
> 
>>> Between Linux 5.10.103 and 5.10.110/5.15.77, matrixfb fails to load.
>>
>> Off-topic, but related. matroxfb is obsolete and there's a maintained 
>> DRM replacement (mgag200) for this hardware.
> 
> I also remembered something like this in the back of my head. Though I 
> thought about using simpledrm (`DRM_SIMPLEDRM`), we do not build though.
> 
>> Is there anything missing from mgag200 that prevents you from switching?
> No, it looks like the matroxfb modules take precedence over the mgag200 
> module:
> 
>      $ grep -e FB_MATROX -e MGAG /boot/config-5.15.77.mx64.440
>      CONFIG_DRM_MGAG200=m
>      CONFIG_FB_MATROX=m
>      CONFIG_FB_MATROX_MILLENIUM=y
>      CONFIG_FB_MATROX_MYSTIQUE=y
>      CONFIG_FB_MATROX_G=y
>      CONFIG_FB_MATROX_I2C=m
>      # CONFIG_FB_MATROX_MAVEN is not set
> 
>      $ lsmod | grep matrox
>      matroxfb_base          28672  0
>      matroxfb_g450          16384  1 matroxfb_base
>      matroxfb_Ti3026        16384  1 matroxfb_base
>      matroxfb_accel         16384  1 matroxfb_base
>      matroxfb_DAC1064       20480  1 matroxfb_base
>      g450_pll               16384  2 matroxfb_g450,matroxfb_DAC1064
>      matroxfb_misc          20480  5 g450_pll,matroxfb_Ti3026,matroxfb_base,matroxfb_g450,matroxfb_DAC1064

The search string was incorrect. The module mgag200, is loaded:

     $ lsmod | grep mgag200
     mgag200                36864  0
     drm_kms_helper        241664  3 mgag200
     drm                   524288  3 drm_kms_helper,mgag200
     i2c_algo_bit           16384  1 mgag200

and it is used according to `lspci`:

     $ lspci -nn -k -s 09:03.
     09:03.0 VGA compatible controller [0300]: Matrox Electronics 
Systems Ltd. MGA G200eW WPCM450 [102b:0532] (rev 0a)
         DeviceName: Embedded Video
         Subsystem: Dell MGA G200eW WPCM450 [1028:02d3]
         Kernel driver in use: mgag200
         Kernel modules: matroxfb_base, mgag200

So, it was only a cosmetic issue.


Kind regards,

Paul
