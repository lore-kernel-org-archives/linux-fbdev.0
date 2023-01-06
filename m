Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA8C54EBD
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 Jan 2023 19:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjAFTRa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 6 Jan 2023 14:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjAFTR3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 6 Jan 2023 14:17:29 -0500
X-Greylist: delayed 6601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Jan 2023 11:17:28 PST
Received: from 5.mo576.mail-out.ovh.net (5.mo576.mail-out.ovh.net [46.105.43.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F02173E2D
        for <linux-fbdev@vger.kernel.org>; Fri,  6 Jan 2023 11:17:28 -0800 (PST)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.146.143])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id 97BE225C80
        for <linux-fbdev@vger.kernel.org>; Fri,  6 Jan 2023 16:51:55 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-mgz66 (unknown [10.110.171.20])
        by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 4EA361FEE3;
        Fri,  6 Jan 2023 16:51:55 +0000 (UTC)
Received: from RCM-web10.webmail.mail.ovh.net ([151.80.29.18])
        by ghost-submission-6684bf9d7b-mgz66 with ESMTPSA
        id a5ObEKtRuGNCwgYAts80MA
        (envelope-from <steve@sk2.org>); Fri, 06 Jan 2023 16:51:55 +0000
MIME-Version: 1.0
Date:   Fri, 06 Jan 2023 17:51:54 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/4] video/backlight: Use backlight helpers
In-Reply-To: <20230106164856.1453819-1-steve@sk2.org>
References: <20230106164856.1453819-1-steve@sk2.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <991730cc3a5688ada96258e4834a9304@sk2.org>
X-Sender: steve@sk2.org
X-Originating-IP: 82.65.25.201
X-Webmail-UserID: steve@sk2.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5884797339128530566
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkedtgdelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigihgtgfesthekjhdttderjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepkeehgfekjeeijefgveejudevjeekgeffvddtjefhhfetheevtddvjeejvdeuieeknecukfhppeduvdejrddtrddtrddupdekvddrieehrddvhedrvddtuddpudehuddrkedtrddvledrudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshhtvghvvgesshhkvddrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqfhgsuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Not sure why git send-email didn't thread this, I can resend if 
necessary.

Le 06/01/2023 17:48, Stephen Kitt a écrit :
> This started with work on the removal of backlight_properties'
> deprecated fb_blank field, much of which can be taken care of by using
> helper functions provided by backlight.h instead of directly accessing
> fields in backlight_properties. This patch series doesn't involve
> fb_blank, but it still seems useful to use helper functions where
> appropriate.
> 
> Stephen Kitt (4):
>   backlight: aat2870: Use backlight helper
>   backlight: arcxcnn: Use backlight helper
>   backlight: ipaq_micro: Use backlight helper
>   backlight: tosa: Use backlight helper
> 
>  drivers/video/backlight/aat2870_bl.c    | 7 +------
>  drivers/video/backlight/arcxcnn_bl.c    | 5 +----
>  drivers/video/backlight/ipaq_micro_bl.c | 7 +------
>  drivers/video/backlight/tosa_bl.c       | 7 +------
>  4 files changed, 4 insertions(+), 22 deletions(-)
