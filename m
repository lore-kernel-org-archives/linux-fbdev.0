Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340FBC77B7C
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 May 2023 12:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbjEKMvj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 11 May 2023 08:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbjEKMvi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 11 May 2023 08:51:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF115B97
        for <linux-fbdev@vger.kernel.org>; Thu, 11 May 2023 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1683809487; i=deller@gmx.de;
        bh=eFYLN6F5bFhm67uKdYzCmoVU74IITBITOytmfNfUOwo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=elykZzdMBPnv2xSMxaXM8ITy8ZlWFPkhzhxqceLr4zhw5dF1blzutXPpMqx4yspqk
         WJBTHCKAXb/kKO46b0kDXf/cqC6TtrU0VM38WZtqLWqHzBC+/fe0B8ofjTkF7cmVW2
         IZtel2c4s8Y1A71w320FOcwYkqrxYSKVAGKrgGCO/RwaUdqQtNL71pTEB11EKIit+o
         s5Pap/yoMu4JGUuHof1Hnbtjt88NBv/CMJxqo9wb19+v6j35WIl2JOcYCHWFvAMPcR
         cN3xPZSIS0etA9AQNvl02gDSvQnYvKR3yco1k2zA42F5r6NfKdO3r7YApZZLO6NvFM
         a56E8as57Mg6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.77.61] ([109.43.178.145]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3DW-1pzHdP2cJM-00FXG2; Thu, 11
 May 2023 14:51:27 +0200
Message-ID: <752f0e2b-e069-6221-1ee0-99306f2c718a@gmx.de>
Date:   Thu, 11 May 2023 14:51:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/15] fbdev: Remove trailing whitespaces
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230331092314.2209-1-tzimmermann@suse.de>
 <e2f54d17-debc-62f4-3644-8baea4a88b10@suse.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <e2f54d17-debc-62f4-3644-8baea4a88b10@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Y7HeAbZUQde2AYeXmfB+eJF2RE4ajjMj+FWzqwzqAt1KBFtH2M
 sIyZzwyg35nuFq06yVAv3NLD8MbOVrIfdb9FQ+HL3nfYkIxTkqO67YbzhXQ1IvUxNDDLnva
 TSzEbiFtm+DGJjLkrOgO9BUtkgNhGgIjGVXk78oBYqdO/27FujNpSwYOG1gCrr9IP/9ynt8
 M+Zox5/vWZnTPeOYzMvXg==
UI-OutboundReport: notjunk:1;M01:P0:bykEU37XipQ=;zMCr8gLPGBs3INqEGBO3Lfulqg0
 yJIlyF6Ow8H67rbpeVNTv199Xrj00Wd6hULU/d5YI0+kfKkja2PZJgBHNj06Oay2tXHqcEKX7
 ZfnNmKz/2QbI6m8DRvMCHy49G5ZIZPba3ExQcHVFEWYCO0p2RGJV/m0/xCucm+5D+NGgMOfek
 vgpdxCyRGiB8CYBz1rwUxk5qdQdLLZOhRdwfzuT0OD/jHv5hfuhX13IZ28jMsro5sZ9TrFjrw
 F2x13W762XqmKvAbMR6ROkvRU2BW9v5KiGq9IuzPKI84kOGoe4nwe4qAh2+jz4nxqMuLEwrMR
 fHi2++3SK2/ru9duaDRfVdl01YiUgd45IfDhaPPia3Bnrz0HAsZVss/d4s7qvVZSOtATF11M9
 Rilq52bJ3JSyyQ8tf8p4Z0NZ5RR93Ctd8Ze5oE2r91otTlRwRG8wrrmSOCKNLp05kodsDyYQP
 oEBLTSFLFnEWFiXs4P+dUhBRluH/up0ej5syN77DIVb4MNHfo22ji9bZl6yFrMndgDah701ok
 ablU0Ab0JUHN9HR2gKhPegKPfi3txjjbBNzBZbIOKIIzqjPlCk+2KELkAukBZ6AWAZNksJrsP
 qQJJOeDSUhIfWGfr/xtFqHXWpZB6U+P5BK0SD9fcFhv9BIiv2LViouXQlrTiHYysvaR7hNFXy
 Tln+UdCpufvdrPsLJwGaELBi+XkG57gUp1yBGPSLeG9aUij8oJwN8DUeKgViRuUvca4SEbXos
 zckMJjze0CYPEy4NnthS1WOver2Km+T3m3+VZCTN0B5JrJrgB9Cl7OmCMEi4+cSxBJldtJsEl
 T88/wuxJUn2i92dOn3vMjOiJN4IemsPUEBSd3ZLaRn8VbF195YQsdIv9dZYb8rri0biGrAZn7
 KYx5LaLmaiNPU1Fn9/xMKNGH/XT9NySAgRCIJKn7XLOAygS9/au6GmJEcK0DrRaEa8RNItA0k
 NgCn8w==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On 5/11/23 14:08, Thomas Zimmermann wrote:
> I thought these patches would go through the fbdev tree, but I could
> not find them v6.4-rc1. Please review the remaining ones, so that I
> can merge them via drm-misc.

Sorry, I thought you had planned to take them through drm-misc anyway,
so I didn't applied them.

I just reviewed them again, and you may add my
Acked-by: Helge Deller <deller@gmx.de>

Alternatively I can apply them now to fbdev and send them for -rc2.
Just let me know your preference.

Helge


>
> Best regards
> Thomas
>
> Am 31.03.23 um 11:22 schrieb Thomas Zimmermann:
>> The trailing whitespaces are annoying. So remove them. No
>> functional changes. Some of the patches has already been
>> acked by Helge.
>>
>> Thomas Zimmermann (15):
>> =C2=A0=C2=A0 fbdev/68328fb: Remove trailing whitespaces
>> =C2=A0=C2=A0 fbdev/atmel_lcdfb: Remove trailing whitespaces
>> =C2=A0=C2=A0 fbdev/cg14: Remove trailing whitespaces
>> =C2=A0=C2=A0 fbdev/controlfb: Remove trailing whitespaces
>> =C2=A0=C2=A0 fbdev/g364fb: Remove trailing whitespaces
>> =C2=A0=C2=A0 fbdev/hgafb: Remove trailing whitespaces
>> =C2=A0=C2=A0 fbdev/hpfb: Remove trailing whitespaces
>> =C2=A0=C2=A0 fbdev/macfb: Remove trailing whitespaces
>> =C2=A0=C2=A0 fbdev/maxinefb: Remove trailing whitespaces
>> =C2=A0=C2=A0 fbdev/p9100: Remove trailing whitespaces
>> =C2=A0=C2=A0 fbdev/platinumfb: Remove trailing whitespaces
>> =C2=A0=C2=A0 fbdev/sa1100fb: Remove trailing whitespaces
>> =C2=A0=C2=A0 fbdev/stifb: Remove trailing whitespaces
>> =C2=A0=C2=A0 fbdev/valkyriefb: Remove trailing whitespaces
>> =C2=A0=C2=A0 fbdev/vfb: Remove trailing whitespaces
>>
>> =C2=A0 drivers/video/fbdev/68328fb.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12=
 +--
>> =C2=A0 drivers/video/fbdev/atmel_lcdfb.c |=C2=A0=C2=A0 2 +-
>> =C2=A0 drivers/video/fbdev/cg14.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 drivers/video/fbdev/controlfb.c=C2=A0=C2=A0 |=C2=A0 34 +++----
>> =C2=A0 drivers/video/fbdev/g364fb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 6 +-
>> =C2=A0 drivers/video/fbdev/hgafb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 36 +++----
>> =C2=A0 drivers/video/fbdev/hpfb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 8 +-
>> =C2=A0 drivers/video/fbdev/macfb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 10 +-
>> =C2=A0 drivers/video/fbdev/maxinefb.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2=
 +-
>> =C2=A0 drivers/video/fbdev/p9100.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0=C2=A0 4 +-
>> =C2=A0 drivers/video/fbdev/platinumfb.c=C2=A0 |=C2=A0 30 +++---
>> =C2=A0 drivers/video/fbdev/sa1100fb.c=C2=A0=C2=A0=C2=A0 |=C2=A0 32 +++-=
--
>> =C2=A0 drivers/video/fbdev/stifb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 156 +++++++++++++++---------------
>> =C2=A0 drivers/video/fbdev/valkyriefb.c=C2=A0 |=C2=A0 14 +--
>> =C2=A0 drivers/video/fbdev/vfb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 10 +-
>> =C2=A0 15 files changed, 179 insertions(+), 179 deletions(-)
>>
>

