Return-Path: <SRS0=+7Ut=EI=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E04C00A89
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 09:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C15822277
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 09:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604310481;
	bh=pG4roRG4kqLWQWLYKSkuQN1yH7j7jRseKzuArv2SklM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=1JTWT8OEiL/fT/4enboJ8BTvKveeijM1JAEJt0kDsVYf+PfNdz3tYotFTN01VJOCI
	 YKznGOHaUB2p6wo1yXA7DgaINxdOXJrqt6uJb+k9spJpXhQZv823JXJGgPTKVVrFfp
	 I4Pmarj+hRa/A7Y8tx+Zt4VodsMiv7XWah6RXUwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgKBJsA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 Nov 2020 04:48:00 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44269 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbgKBJsA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 Nov 2020 04:48:00 -0500
Received: by mail-ej1-f66.google.com with SMTP id j24so17958517ejc.11;
        Mon, 02 Nov 2020 01:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aBL58c34rn6nb4fMXeoXHFwH4EN0oABK7+YoRvnww4A=;
        b=FVehcp7B6jXGPG4/aN81kjLJETFIFCmrbhc5fml2g4dyLdCGhON77jh5+XiD66KtyU
         /n/kaO0rxUIJHy8SBcxyseo6/JEKhdOtk/UrbabSxUSKTWcGIC9XZkS/EZs+5R2LQ9WX
         mTtV7KbNritZLToxLA5S6qTcuYBCveNeYgwwiCdN7u00reusjUjp9rqnQzKvMIUFX9q2
         UuyhpepNsbwpjXiKA5vz+4RYe2cPmwYhJsYBYM5ElC844aPYlWh7foyQfAgXbVSTHWFs
         bUK6BHD4KOx24pC50qUuj+KsbfL3WYWCsSpvZEmgYDYPgu2XLhz0yqRP1+PPcR5qma1s
         pxeg==
X-Gm-Message-State: AOAM531jiRG5hXvYxyysZpFFyTfb0Hq6i+neqPQOlWXh9RxpSmy8IcPq
        +GxEfQCH0+VFOlg9a1TFkIKKoUC1B7c2JA==
X-Google-Smtp-Source: ABdhPJyT6Zvze4YHMIYPFL++Xloau/cxO3dOk0KGmbVTqK3nh34aV7jQ6EYhRNwau95TEnaQlTZSvQ==
X-Received: by 2002:a17:906:580e:: with SMTP id m14mr14018843ejq.237.1604310477608;
        Mon, 02 Nov 2020 01:47:57 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id e13sm8525101ejh.65.2020.11.02.01.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 01:47:56 -0800 (PST)
Subject: Re: [PATCH v2 1/2] console: Remove dummy con_font_op() callback
 implementations
To:     Peilin Ye <yepeilin.cs@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Winischhofer <thomas@winischhofer.net>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        George Kennedy <george.kennedy@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604128639.git.yepeilin.cs@gmail.com>
 <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604306433.git.yepeilin.cs@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <a8157089-bc72-c409-c7cc-2fd7eb087ebc@kernel.org>
Date:   Mon, 2 Nov 2020 10:47:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604306433.git.yepeilin.cs@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 02. 11. 20, 10:36, Peilin Ye wrote:
> `struct console_font` is a UAPI structure, thus ideally should not be
> used for kernel internal abstraction. Remove some dummy .con_font_set,
> .con_font_default and .con_font_copy `struct consw` callback
> implementations, to make it cleaner.

ESEMANTIC_ERROR.

1) What do you refer to with the last "it"?

2) What's the purpose of mentioning struct console_font at all?

3) Could you clarify whether you checked it is safe to remove the hooks?

4) All the hooks now return ENOSYS for both consoles (and not 0). Is 
this intentional?

I know answers to the first 3 questions, but you need to elaborate a bit 
in the commit log to connect those sentences. Esp. for people not 
dealing with the code on a daily basis. Ad 4) I am not sure.

> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
> Change in v2:
>    - [v2 2/2] no longer Cc: stable, so do not Cc: stable
> 
> Context: https://lore.kernel.org/lkml/CAKMK7uFY2zv0adjKJ_ORVFT7Zzwn075MaU0rEU7_FuqENLR=UA@mail.gmail.com/
> 
>   drivers/usb/misc/sisusbvga/sisusb_con.c | 21 ---------------------
>   drivers/video/console/dummycon.c        | 20 --------------------
>   2 files changed, 41 deletions(-)
> 
> diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
> index c63e545fb105..dfa0d5ce6012 100644
> --- a/drivers/usb/misc/sisusbvga/sisusb_con.c
> +++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
> @@ -1345,24 +1345,6 @@ static int sisusbdummycon_blank(struct vc_data *vc, int blank, int mode_switch)
>   	return 0;
>   }
>   
> -static int sisusbdummycon_font_set(struct vc_data *vc,
> -				   struct console_font *font,
> -				   unsigned int flags)
> -{
> -	return 0;
> -}
> -
> -static int sisusbdummycon_font_default(struct vc_data *vc,
> -				       struct console_font *font, char *name)
> -{
> -	return 0;
> -}
> -
> -static int sisusbdummycon_font_copy(struct vc_data *vc, int con)
> -{
> -	return 0;
> -}
> -
>   static const struct consw sisusb_dummy_con = {
>   	.owner =		THIS_MODULE,
>   	.con_startup =		sisusbdummycon_startup,
> @@ -1375,9 +1357,6 @@ static const struct consw sisusb_dummy_con = {
>   	.con_scroll =		sisusbdummycon_scroll,
>   	.con_switch =		sisusbdummycon_switch,
>   	.con_blank =		sisusbdummycon_blank,
> -	.con_font_set =		sisusbdummycon_font_set,
> -	.con_font_default =	sisusbdummycon_font_default,
> -	.con_font_copy =	sisusbdummycon_font_copy,
>   };
>   
>   int
> diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
> index 2a0d0bda7faa..f1711b2f9ff0 100644
> --- a/drivers/video/console/dummycon.c
> +++ b/drivers/video/console/dummycon.c
> @@ -124,23 +124,6 @@ static int dummycon_switch(struct vc_data *vc)
>   	return 0;
>   }
>   
> -static int dummycon_font_set(struct vc_data *vc, struct console_font *font,
> -			     unsigned int flags)
> -{
> -	return 0;
> -}
> -
> -static int dummycon_font_default(struct vc_data *vc,
> -				 struct console_font *font, char *name)
> -{
> -	return 0;
> -}
> -
> -static int dummycon_font_copy(struct vc_data *vc, int con)
> -{
> -	return 0;
> -}
> -
>   /*
>    *  The console `switch' structure for the dummy console
>    *
> @@ -159,8 +142,5 @@ const struct consw dummy_con = {
>   	.con_scroll =	dummycon_scroll,
>   	.con_switch =	dummycon_switch,
>   	.con_blank =	dummycon_blank,
> -	.con_font_set =	dummycon_font_set,
> -	.con_font_default =	dummycon_font_default,
> -	.con_font_copy =	dummycon_font_copy,
>   };
>   EXPORT_SYMBOL_GPL(dummy_con);
> 


-- 
js
suse labs
