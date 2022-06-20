Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B07C43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 20 Jun 2022 12:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbiFTMvb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 20 Jun 2022 08:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242156AbiFTMv1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 20 Jun 2022 08:51:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECC613E2C
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Jun 2022 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655729478;
        bh=ane58u1rCbvv7BCjhbMnYE/gT9iyr33orKE5FMfJQ2M=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=WnhuEF1HBUn/kizTl0EiAhQKfEwnGqjI6ukud6NRqnjoPWwI5ZrFtH2K2RbNo9Zdx
         qidw4In5Zfm3KBBkdKC9mN9upK0ofEIHdW7Q31fjtpOTe4+jLIaikuasbl9s4nypfM
         B9pcr3lTzDbL3ln1V9Foqx1LXLt17A6I/Qh/fq9A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.174.149]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1nRCMt2ozN-00fEcH; Mon, 20
 Jun 2022 14:51:18 +0200
Message-ID: <a12be485-3708-a84f-0120-d6938b322e96@gmx.de>
Date:   Mon, 20 Jun 2022 14:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write
Content-Language: en-US
To:     Hyunwoo Kim <imv4bel@gmail.com>, linux-fbdev@vger.kernel.org
References: <20220611192851.GA482606@ubuntu>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220611192851.GA482606@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pJoLVwzBY6FIXNhh2wKHGB0wDu/xenFViBfOvouK4Ox6xyacK0V
 sSIjpj206VIsYZEqlmFN9GvoxKckSlGScNonBFVcQaxrV6NPGEl1WV4cBwYhQkaKQpAKrL5
 bhEs5pMj5WDkMTIe8o538Rnpw2L93lBUhHVspNnqh4e3GsfIh82KAeDKYsClpBZbLMpwWBU
 UZsfof3QsLzDthdnuuWpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ktkig/JK8kY=:iaxkWmbw3O28jVwxgIXqPd
 rDNTGJ6zchNw/xbkMe2hnUrhIUfFNPQcsB8JiLEprPyVc4WeFqX4SeAyXlNc0rofwzEPkYrYL
 xMs5oL90T+X2Je37usesXdcKvG37IAAIbBOBUVAE5OWmbKzLNdiWKmvtYPi/HBsyETfoLIih3
 k8XoYyZc9b/CLX2SrdXR390+u/C8Xd6y51qDUZbQ3dGbdIYciGZY5gbVf0yWiAPi3J7JaCZV9
 iMEFxh3B0K+9DebvaQyRrfQbv2vxTFiJhSfcI6YTBIsTtofur0UFYaYQ2VM9ZM1zqeqyXyPJa
 Pt6RT4atRTysuMjvzE+A8EmijKsO4uAlWycG4atHG6jpoDvbOMtd8pbE/Q9xLUU23OfZvTK+v
 ev4mmlsWHuzanHZ/wscOoIMRdIc/AmCKdQlFXwQMGwAlFGJBU5pnoOYCZzQGMcWwXEwK18035
 CbIk/FbCShJxkP5mnMUAIAUD/mwfjLG6kH+ehr79D2N0/FJF5BSQD1ox/Xr2aiowa9cDXeQIK
 J3Bo3UBY38qyw0lXSY5NvYfRZnTbDw6s7GHuu4CMI7TjO8bQDoU6PlR5PZBgm2K8G1IGgRWnn
 mg/l/XCsLzRknGuP0es4T3lR61SEbbc6bX+egzPuexLijys6T4GmJ8J2muHNip5LNf7PH5U7q
 kY/SwwOV2l1IcnM0CdSjedMA98xN6zltnZwavY8dHJJBhWpsJ4/d+MJGFCKO77v0qqnCAuypz
 84zS36rAgxjE68UMErGepvkU+P7Xj0oPnZ1lVMbtfbO2mT6Zef0DDE3QcnSUU8LRQT84RCw4G
 ggJ9NH8ochlqvzi9byYxt3g/v3xuAlVtbzOWCONXDzN5esGJxXgkhUTWMF/owlPTX0/o3crC8
 h/2tenOdnsBmGTmzMLrletCbWQcr9WBDOhYACUu1IdpGE/6JSo33Taqw46+GBub79VtSd+p00
 XA8Ddo+GjZs4j71kvHZuJcNUMf9Kp96ia14F0vZGk1RmsBsJEMJJYZxxl2eoYcsXJC0CF5JfO
 SLKnr/WKhTNZJ8NMSCg6WgQNq8ft+j1wD5HjiRbapeKYQ6Swyq6yCD5H+d5JSwq+UyFeZLxZn
 3s2w6L9QglWGVQ4paxnLgc+sNC3yfKW3QVJdxSA7AjJ6kOS4IPoFtfqsw==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Hyunwoo,

On 6/11/22 21:28, Hyunwoo Kim wrote:
> In pxa3xx_gcu_write, a count parameter of
> type size_t is passed to words of type int.
> Then, copy_from_user may cause a heap overflow because
> it is used as the third argument of copy_from_user.

I suggest to simply change the type of "words" a few lines above:
Instead of
        int words =3D count / 4;
use
        size_t words =3D count / 4;

count is already of type size_t and then you don't need to check against <=
 0.

Can you resend such a patch?

Helge

>
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  drivers/video/fbdev/pxa3xx-gcu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3=
xx-gcu.c
> index 043cc8f9ef1c..5ca6d37e365f 100644
> --- a/drivers/video/fbdev/pxa3xx-gcu.c
> +++ b/drivers/video/fbdev/pxa3xx-gcu.c
> @@ -389,7 +389,7 @@ pxa3xx_gcu_write(struct file *file, const char *buff=
,
>  	priv->shared->num_words +=3D words;
>
>  	/* Last word reserved for batch buffer end command */
> -	if (words >=3D PXA3XX_GCU_BATCH_WORDS)
> +	if (words >=3D PXA3XX_GCU_BATCH_WORDS || words < 0)
>  		return -E2BIG;
>
>  	/* Wait for a free buffer */

