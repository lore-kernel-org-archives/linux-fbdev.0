Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52F6EE49B0
	for <linux-fbdev@archiver.kernel.org>; Thu, 31 Aug 2023 21:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbjHaVkz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHaVky (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 31 Aug 2023 17:40:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40A0B8
        for <linux-fbdev@vger.kernel.org>; Thu, 31 Aug 2023 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693518042; x=1694122842; i=deller@gmx.de;
 bh=XvGIeCHlPIAuCmK114Tr0aUl/dR9T+CT3sQavkkdznA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=QB33x3uXc/dPdVQiz/Zea7mrLwgxux95o3/HQf2alL+gZ5MsNvDrNKajHK5B9sKu//Gxse8
 3DnEaJXlrcIoZX8+7o3v/A+Pvkk06ngV/WoSJ4jeTEmZsFS71ucwBAv1DG1Y5zl0/CzQAllKo
 Y3vwt6F8sfsSUxjpFYbNF1odMZbz0JDcHO8Qd69jDDQumyF9aY5jm5FwHKIJKpmgdvGHrkzEc
 wWa55gBODknVBYJBhOdduxOkdSHTCLeJ2NNlcOpINloyOD9PIyPuZpVnlO7JRrYQwnmmR+o9f
 33lbWUQC+bDZ7AktGXhKrLZdBx3s5t7Otl1MM9RtD8kDwZjPe2Rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.146.94]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1qFuna0S3c-00M6yG; Thu, 31
 Aug 2023 23:40:42 +0200
Message-ID: <05668dd5-efee-2bc1-54dc-a38f6aed6c4a@gmx.de>
Date:   Thu, 31 Aug 2023 23:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fbdev: ssd1307fb: Use bool for ssd1307fb_deviceinfo flags
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <303bb1a5012862f0003d3246a0c8120b97ea995b.1693483416.git.geert+renesas@glider.be>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <303bb1a5012862f0003d3246a0c8120b97ea995b.1693483416.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LR0hQZODiPaTgDZOkwrKsaIOmTMUBJmYUwfHejlWM2bdumn1g2X
 sSo5NaVMR2cCPBPq7PpYymMl0+b3E/MozE5WbjfnhZLvCHQX9iyPiOKbAnw7/clAdcLlXsI
 /jAs2LBOzxLf49/YMEHU9mhHbJbp9ut43BvsMwP4AxzmcZ7xM9Q9lUtDGFPYV+3JxrfvWaN
 zsnmzT1GYo3xL8ccc0klg==
UI-OutboundReport: notjunk:1;M01:P0:qzvPanJlYYs=;H8MwDpTdrhw9YZ2FE4EU3fhFsZ6
 U03UUsDc2X1yy4hDUUJ7eMf5piXMptssRb8QYNMbRWlsg0XomC56bn2/DoQhkj4CFZ+4W0A6w
 ke9KqY9IrCpXEbGEWuOnbOyi+PIqp1nJzQpg/DOxNY5cUcPdDyvYjdskNsHpBCBCqKbduD0F8
 HalNGjeYI5fHdDzdB+CgNKb8wsLcuUKxhQowlvEG+FCNT7w0e0s31oSVi83hNNbCwNlDjhhTm
 7nUYYpxcj6qvnA29ZGmMTVnzbfXUIrMqwCFhraxq4/wkWxdK4P21ovRXVHed3NtcYr7wd/FLT
 n5EMTRY0Esgq4h3jsa0iChzc4Xrcc6AJtJjK7FiPcGlgHP53Hx7BEzmOvjLpSzDO8o5WEMOfR
 sQ1vHiMizxoBD4f4o8V/ANrQKyl2vcWoYWpgqK88BUD79dfQJBlx7U/zufnhAqC1l+7pW4fgt
 bSuOvsE7DAnTYs+L73PoDibfxhLgwMZzdG+NoBBAmjD1S7k8Pt74ruwQuboTO3QMgCvAEue8H
 f3fdaiAwn4Sxqdh+D6jkU8X+Yag58GI9op7VAJk62nROjNOIYeoj85KLM7JCAu4nF3fjtlAen
 fQHpAF4C6IoUhuYqKF1pHd0kY93WwpTrmto5iQpY7D9gRGV7cmfZQF+QaNxJv72DNkGPFovR7
 FCS5KQU5EyNhIdVQLKh/46Aw+o8LLQcIQZ2W6vf/9FqY1RPuS1fKeyqDoRNtUSkTNbjs03IaZ
 /MqeLN0fPXyoHMBvNmaEQ/FlvZs0JmLdC4pqHnh341RukBhsDrwfwlNZzw5OJFONol71bt0BN
 V0eXzSpkxDRFZBxyf9TvIdQN7ABnimAFW9bUgrvQ3G6kCDyCJdQJUPAWYWkhanEhFiL2aGtUz
 lUWBu9hZlSzaZksZYpze3GB91k0LYcKa436A4W1BoDRZ2nLwVr2hv6ii0nQUjLwEBkbfTS2km
 ZO7sWg==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 8/31/23 14:05, Geert Uytterhoeven wrote:
> The .need_pwm and .need_chargepump fields in struct ssd1307fb_deviceinfo
> are flags that can have only two possible values: 0 and 1.
> Reduce kernel size by changing their types from int to bool.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

applied to fbdev git tree.

Thanks!
Helge

> ---
>   drivers/video/fbdev/ssd1307fb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd13=
07fb.c
> index 86dd24022871a843..5ae48e36fccb4e8d 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -52,8 +52,8 @@ struct ssd1307fb_deviceinfo {
>   	u32 default_vcomh;
>   	u32 default_dclk_div;
>   	u32 default_dclk_frq;
> -	int need_pwm;
> -	int need_chargepump;
> +	bool need_pwm;
> +	bool need_chargepump;
>   };
>
>   struct ssd1307fb_par {

