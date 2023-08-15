Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C61CC0015E
	for <linux-fbdev@archiver.kernel.org>; Tue, 15 Aug 2023 21:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbjHOVJN (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 15 Aug 2023 17:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240178AbjHOVIs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 15 Aug 2023 17:08:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3150F2
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Aug 2023 14:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692133700; x=1692738500; i=deller@gmx.de;
 bh=AKb3aYCWzBhsjnJcRFCgQf3uU5feEmUxdpHtfyaTV/U=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=lCWorK0KIrraXGg7Vft8UNk4sgR3FL0Riy1y7DZKckr9mU+75jJLXJE+ED+Wc8/LNJNz3uK
 MIv4sfsyT6nDmOQxTDGkVoQHhifWCNMF4Elz7hukpKCvWzXpydNqQ28xmpCvD7nDlqQPeKhQf
 OvtA6Wm7j4KQ1cZA18aw/5+NOaRGkN/4xe8P6Ahl8GP8ZPZdpK6UQSN8TWw73SVsRn+oA4a7c
 HnDKVcZsiZ51WBEa5rulK6WuEsTDOpK+FWCEFKIJG80Bl7ysPV2L+Se5ygNdaHz3lzXQ3OjZ5
 zY5re5uUIO9IvFVVD+VoLETd5OE1kR7eFSXyDi/Qt3rkoZRaIKMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.222]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1q6w9P2J0V-00P3ah; Tue, 15
 Aug 2023 23:08:20 +0200
Message-ID: <f4b9b52e-2b1d-6991-f27b-fbda4a4e27c6@gmx.de>
Date:   Tue, 15 Aug 2023 23:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] fbdev: atmel_lcdfb: Remove redundant of_match_ptr()
Content-Language: en-US
To:     Ruan Jinjie <ruanjinjie@huawei.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20230811072811.2350474-1-ruanjinjie@huawei.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230811072811.2350474-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XDDxd6WEmUBhvXIFwXRWgl9qDu2jWDVjRX7/gDpHzXfjkp35LM2
 pf/hwN9m2ewqsfRFifABo10y8vVjpg7YX3biu2kZXR1uqOWzi2IE/Q4VwZEMESLGfWBRyXh
 zNZNYPEY458fWteG0PW9tFJ9d9Hhv6ZdedEj2S89HFgqOo7mRymHmBdbaK073ix3KvPYkmv
 dlhEJqHv7kWc6XopZVG0Q==
UI-OutboundReport: notjunk:1;M01:P0:ZilbdJAkuyQ=;7Ngh845/WiB/IlKNwRplirqOpGQ
 Hs61mZdgf7XAjICKdFQ/yrqYKOjJsj+e2pf/lVnAZa2K0Zn/ioF271ykyJRYv+8l3WbsfdU8u
 MNgVBE0RzYlWnT6kXNzqf2zQXQ1EbwuOMUiDQAhn2QFvyxdKG5iEiLAzQXyJgdU6BjMSFIA8v
 7UPHIKpC2UyDplD7aJ61oHgPl3/I917B0BeRhsNRBi/mORcep4gx/Ee0NQ+KiDgcP2Wes5iC3
 xPgU4QYZ1/x8xXyebZdNjSEuz1GlZc5dbUZLQod3e3Mb0sWIsaqfMnKVD1EhC/Kk9OW05uk7J
 4DZyzOfJQ2KyigZo9/PLdwo2NI/THWjJO/8hGWt1HELf5Bbce32tGsROMbQlg5ECQS/eGs7Ci
 lQkeb51CGQKT2QEgkFLi4MEzcRsdksHTjsoSd0cvNZJSqoqO8WZI1voOW3Sf6FZBSlSeWLXtG
 5Cs/DrJ3gk+SgMUbKmz/pRIWuRYKtIEP7oFY/sw2KuHsscRK4mJa4+QDxzJEQISDhh1twyAGS
 /xd8vJcdlXnehBW2SBB51+a7x1lQQN3VEqZrphTWkcNWs5mmIY3Sg/wyDDWfkelQefXejKhtG
 GrVa1p3RgJEytc7+lAfQJ4mMGmcHdHSKd5Hfdo7xaG2ePnevBrYUJRCT63St2EBFVQzr2pEQ3
 6RIMwNqzzAwTJVPxrBSa6Jg6sHP21F09EtRGantUZ9i5nPfTr5k6OjzdyT4B9O/cJIJxKZFOk
 pTem2M/p++Kv4O/ZkyaSpr4LjNVCL1z8pKq0ogR50lByKb1mv1W1WV2ebJpJMdtK8vfnpZpAd
 AI7i47sB7ySUNzXX+/iJj332u2+W86ztCttuqjfORV7yyBddr2OM5MsihGljqQvrLdZVNf/Yu
 uHAYuzOem6bfcFtXxWFAakc6NzLKXlT/s80kZTsCJZ2dnKI4BROgUt98VfF8x9td1GAgkGFI0
 JbezPqCHQAjmhJorbxLUqk4mo6Q=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 8/11/23 09:28, Ruan Jinjie wrote:
> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
>
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

applied.

Thanks!
Helge


> ---
>   drivers/video/fbdev/atmel_lcdfb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atm=
el_lcdfb.c
> index c75a62287ec4..a908db233409 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -1306,7 +1306,7 @@ static struct platform_driver atmel_lcdfb_driver =
=3D {
>   	.resume		=3D atmel_lcdfb_resume,
>   	.driver		=3D {
>   		.name	=3D "atmel_lcdfb",
> -		.of_match_table	=3D of_match_ptr(atmel_lcdfb_dt_ids),
> +		.of_match_table	=3D atmel_lcdfb_dt_ids,
>   	},
>   };
>

