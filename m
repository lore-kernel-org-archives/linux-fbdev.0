Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55DEC4332F
	for <linux-fbdev@archiver.kernel.org>; Tue, 15 Nov 2022 17:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKORFY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 15 Nov 2022 12:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiKORFY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 15 Nov 2022 12:05:24 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EA3C35
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Nov 2022 09:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668531916; bh=KVN7ppXUYLHGWX4l5qTOQy0881aAAXZhmkshIpWyY64=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=W+76Lcx7MqNoK8pZ+12sq2z7tCPBZ6YILGirwF8UNx3gM2ulAOP0y8WNTvByyBJFB
         wk47uzdTHuFF1leYKyb8wIEunktTrPUGqfPPszLTPUPwnA+n5oPFRBODqLK8L7pwIQ
         iwlRH2m2u+TSFBPuTaxD+xPwZgLEEK3ogwqOw96pikSfUWHJXbiJSDIv0SH8NPa0u9
         OYe2N6ScORQo3Xd3XYSAQf7erF+gRpY8oPvzz/6Qlh/UKlOgQ9L0VpZduLQKI3YjbQ
         +z6GYjAsklJl61k/5iImgca9cmdpgnrrdGCmxn04VYEjNdv/GItMFN7a3lgaw3UeFA
         EibmlrRA+hM4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.131.87]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsUp-1okJs320gZ-00HOgp; Tue, 15
 Nov 2022 18:05:16 +0100
Message-ID: <09b7b91c-4bae-0bba-7701-cb1f8c58c00b@gmx.de>
Date:   Tue, 15 Nov 2022 18:05:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] Add framebuffer device driver for gamecube/wii,
 incorporating Farter's work.
Content-Language: en-US
To:     Zopolis0 <creatorsmithmdt@gmail.com>, linux-fbdev@vger.kernel.org
References: <CAEYL+X9qahvtsi71thrOzzqdtq_mpdTyV1ZCqc-TvMH--7HqdQ@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAEYL+X9qahvtsi71thrOzzqdtq_mpdTyV1ZCqc-TvMH--7HqdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:To227Fi5OhzERrr1AhzdZd++HvhqleIHhXtLIMI2zoNi4mtqnoL
 zignwgvVEOgsn4NKayTJujrIPO4mVgmV54Sqhv917PpVeX4TevmKXjY5Hpsm8+JsSMSixXs
 2tsLoaj4HHJUzU3+rdn/Tc328XZ6KXuWcC+eF6S1vXCWxQPmWLigDaUjSqEvewRkqg8HKQY
 21nDkmsPPe6AIyzEAFx9Q==
UI-OutboundReport: notjunk:1;M01:P0:05p/sNtBAdQ=;vVuBWd9d2zRsAslaol0dw0dTWdK
 jpt//hUq3leYqP0CwHQmmiMAjfgsLpNQmZgGIeYSidIMf6/OMMlTwMyLOMdLkmFuK4lAzAfIR
 +jxkku1OW2cChHEdQ5MNuQjbfVsWGv+U/D0Eh78dei/MZ7bjWosLT0c04eRefRnjaWRPWHdik
 sjLkNPEVyIEi09f1uTF4timKDNmh61wo7HCdvTSoMRtFkPNJqWuHa1nKBjh/wy9S+eT8Q16tY
 0FSyQ9oUG33zJp1K0etVELi8JZJzPL9hc2sdRK+ADkyQgpGKezco2Mb1LEuKje7GpdJMkCUzR
 LRF7Q85lU5uGgd0gvE799xmjbZrMk5EpzFVc1Sc2kDCBO8864h4WrLk3Vte3MWsnjMx7RNe3Q
 cS/KlZyCkw1huWwMPZdIPQNA/ZPe2fR/OU7bstKif1BqJyKAJHeE7WUBDEeJ7/tdgh3NRUrdX
 RBpXoPBhL0/dubiAC/pWnWeHDviRIyNnv/ch9FDIromorR+m8awlX6m47ifBLElbkv1kYx3EA
 k8KvKdpOchEEmeUt8jCiePh6HUd1qolSmBe0bK4gNB6mmOx3LYxoiEsep1IaP9opBKASa91mm
 ArDJ22ZvCfdC7zG73GRtO6DBxLvmSLWBmfu3wn1Cz/Hje/zMJEhhcdDHukbOs/wGYP2fJwmC1
 qRd6f2QCUiNMhjtNvhhdwRTgE8thb0Vrr0rvMbTjKtHfKZ2CnRJzhub/ExUGE1z2E1q580CJ1
 e872eL3A2iWR+iJIbNqePFFqNS0XYorebQ+kLeYF+FK528hIzlawWgQZ5E810Tu0/HlEit4WW
 e3IAHuWA5PrnL5t4H8tQf2OimP3Y0cggnl+7RccCyn/5X2ocswMSxsEXzQ8zEza8FYwd5ld60
 g69VN1oi9gO89LsCHo44WL5DyVUPg//KRIXmUdbyO5cDqr0rxTEAOzKGDq25D3A5PLScvDYfd
 w3ioQnAkxHJOKTcJf2J8yYAKYAE=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 11/15/22 11:05, Zopolis0 wrote:
> Just upstreaming the gc/wii framebuffer driver from gc-linux, and
> incorporates Farter's patch to solve the color issue. See
> https://fartersoft.com/blog/2011/06/22/hacking-up-an-rgb-framebuffer-driver-for-wii-linux/
> and https://fartersoft.com/blog/2011/07/31/hacking-up-an-rgb-framebuffer-driver-for-wii-linux-take-two/.

Just for the record:
Is there a reason why it wasn't (or can't be) ported to DRM ?
Looking at the patch (and the hardware behind it) I do see various reasons,
but I'd like to hear it from you...

Helge
