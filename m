Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E30C001DE
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jul 2023 12:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGaMzX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jul 2023 08:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGaMzW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jul 2023 08:55:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF65D10FF
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jul 2023 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690808113; x=1691412913; i=deller@gmx.de;
 bh=uZ24tCDPloarimLbnb8GLRgv81AnDnCwQoQQQYP5vk8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Cwb/MT6kgZbuNFKxnl71B51I3BO+gA+lXWv07AESRod7V/1xUS/vHyAofvMa4yxEc/yyNHL
 /TbZnp5NZ6cSbhgoLW6zcqEW4LK1wdLueg4fVnmR3VsPGXMH+0dM1Tg+wAI9EXlE4C7g+wPbo
 PRRoosckTYglD3Odd9tHFPRvIvBWTAbrZTCFiXy3T15hA5gZlf8U//Wb733SL58JTiwcV0VTP
 BM/VLy/kDxmKt1P2s/qk04AQn1bJMUgiu1V9R5hyph6aZ8vsfuVQbLJj8Av7sS6rhKfE6dw6G
 ITiCnWCCZHJnFxZNDfKn15cHwbMfST/t+AiUsmRp2nTm6WL0PaVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.238]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCpR-1ppBry10AZ-00bGOf; Mon, 31
 Jul 2023 14:55:13 +0200
Message-ID: <064cd2bd-9f36-d30d-586a-cee58d433b8f@gmx.de>
Date:   Mon, 31 Jul 2023 14:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fbdev: mx3fb: Remove the driver
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>
Cc:     arnd@arndb.de, linux-fbdev@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
References: <20230728211201.1108407-1-festevam@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230728211201.1108407-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q+XUa2ZRPlXWPHLp2AK/mocQGEbtq90vCiNnUnseQlylDBj3OzH
 Z+bzuBXLcgpYGKflmuU+XrgFXz1gEzGqervM22Acr8cu3IQ7YkAKoSaZ5W7c2z0aZbpTdAC
 kY1VF8gDGEOxN6/6afj+VqUwfMnuzfEad2uvWbni0/hpS5Vtkz/ryd0oxRsPMH97f/ypMAU
 hkuJeB+FSo/3WQ8zj8avA==
UI-OutboundReport: notjunk:1;M01:P0:J7OQoFAIgkM=;duP7BYVdbF5K6m4TSFzGn9IoqjJ
 F24mcOKC/G6MbeTvObJ5uhWivIGsAjLextXFNzYACShxeqDxPn0/IBQdfVX4xFgb76y5zIa6k
 Q4zHWuxPlO4Gyhh9hRnY5VsBEHHrbLh/Pzp67JEWMJ8hEptKJm1Y0mAUA3R/YJOuJ4sf0369I
 gd8jDODyT7mCO062EpoYP1X4ORtT64HGrhow31bOUEvO08NkJ5fQm8qIAhXNEyANFYQeLIJGb
 a1yf1sN+zvD+1xbel+qMf3wyHtMXBkKL8+maAAU2iFfpZBRi1iQREAwGnWwyC/o8Exx+3plmL
 FrD2VdciK7OTLAdbH5GQAN2Kse/gSLvMV3AcXlDn74dA42uDLxwB6g2k48egTMggJ8GBqpumN
 itzFxgB+MtPyR18NIboFpXO+/tP6jS5Mu9i8Xgj3+Z2vVSj0jWg88wXy+eFYrIIO4a4mURmpf
 noSPI7KCHeGSgWt6UJXOIxbk3SS4l02fkrCcRfe8UfloGjtGmVY4k1nrFI68bLG+pV6g9A0vh
 sve/DTLEKifM9LAVX4Q8irJCZ555K4W70HjKQcu2mqhpBbHqv1gynoDJ/iyTrsGEP/kxA21Df
 MMN/HfC8Ju8IRb9bJ2I7P2FEO8sGep9b3eVF50UAt2onaTW58VYC6KnR+S5gxCvDLE9ZEJbMz
 p1JlL/ZWeCjltPWoGKFxukF/Vu+SaB+P/NPqtCkhJS6SkT5PQiGQVWMXd9/faFvbnxKO6uFwu
 PWrJklzgAVSG4u93bdGuE1tbdANTOq3be2M2HIPIK/9/EWBN4Sx+2zO9nn0c8beVeFy3d/v4h
 Z3mJSe43yxcG5kqQI5RL1Nf5PxNDpIwTOPzr7JC0rRr4UthWiGHc2YGG/x07iQnD7TViCaXrT
 /cZFhrY4XftlGLLvJc1rrXjvLCcbVY90d/APfQmkJmvU7/hJl8u4nR19F8r9vVDa9N+l9+NIK
 BpEZ6dDLsTHLESVYI+L0XLIEwPY=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/28/23 23:12, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>
> The mx3fb driver does not support devicetree and i.MX has been converted
> to a DT-only platform since kernel 5.10.
>
> As there is no user for this driver anymore, just remove it.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

applied.

Thanks!
Helge

> ---
>   drivers/video/fbdev/Kconfig               |   13 -
>   drivers/video/fbdev/Makefile              |    1 -
>   drivers/video/fbdev/mx3fb.c               | 1697 ---------------------
>   include/linux/platform_data/video-mx3fb.h |   50 -
>   4 files changed, 1761 deletions(-)
>   delete mode 100644 drivers/video/fbdev/mx3fb.c
>   delete mode 100644 include/linux/platform_data/video-mx3fb.h

