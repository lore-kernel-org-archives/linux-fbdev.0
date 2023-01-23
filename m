Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975C9C54E94
	for <linux-fbdev@archiver.kernel.org>; Mon, 23 Jan 2023 15:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjAWPDt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjAWPDr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 23 Jan 2023 10:03:47 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7750CEC75;
        Mon, 23 Jan 2023 07:03:33 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pJyM0-002Qyi-Pi; Mon, 23 Jan 2023 16:03:24 +0100
Received: from dynamic-077-011-154-164.77.11.pool.telefonica.de ([77.11.154.164] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pJyM0-003cbS-Hz; Mon, 23 Jan 2023 16:03:24 +0100
Message-ID: <a9883a81-d909-09c5-708b-d598e030380e@physik.fu-berlin.de>
Date:   Mon, 23 Jan 2023 16:03:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH/RFC 0/3] Atari DRM driver
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Helge Deller <deller@gmx.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1669406380.git.geert@linux-m68k.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <cover.1669406380.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.11.154.164
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Geert!

On 11/25/22 21:31, Geert Uytterhoeven wrote:
> This RFC patch series adds a DRM driver for the good old Atari
> ST/TT/Falcon hardware.  It was developed and tested (only) on the ARAnyM
> emulator.

I just remembered this WIP driver. Has there been any progress?

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

