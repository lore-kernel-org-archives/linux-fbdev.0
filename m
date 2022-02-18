Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D369EC433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Feb 2022 09:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiBRJJk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Feb 2022 04:09:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiBRJJk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Feb 2022 04:09:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB46F2B2FC0
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Feb 2022 01:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645175362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sfUvFXiSU5P3OmBH8sxlrxxdpF+uShF0CD9hT9uvq4w=;
        b=AbWtnnxUJGyO8N9xvV5yDH5r35UuxQfOGKELSyKU+3hqWIp1X/44ePRqUlxpMUlGZO3JBZ
        RFQmAbQrxo5tsovIqk2J8h2JlxLHSG6qfF8zxZuXy1p2u67GeYiaqMYMOLJqnFSPre+2Im
        la2aaSthz7nKMbGNxBansr20gSp9z7Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-nnNthTP_NHiQZjk2I1RfPg-1; Fri, 18 Feb 2022 04:09:21 -0500
X-MC-Unique: nnNthTP_NHiQZjk2I1RfPg-1
Received: by mail-wr1-f69.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so3288088wrg.19
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Feb 2022 01:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sfUvFXiSU5P3OmBH8sxlrxxdpF+uShF0CD9hT9uvq4w=;
        b=6DgE1olk61uJJFJwkeBlwKSk5w86Yx+ThngDjKogOmtrvlii/eGz44GSDJvXaNdudg
         DPJXjcSgYPO3DU0WP1mn5rTdXKFRsaePgzwaeF/RX7nFrALuLFRQS4UfJ3rH/8ihv8p3
         5qPjNvB8H+Ak/lk0PiEdQ5nzGubZ6fek2Va+ChcMX7RcoMrFMworvWCnPwmZUOhzL6KD
         LfOHQwA7s8BCQseae161jI/i8EmC11I0eAdnQIs8UA2spLdyHqoImodMsR+Rn6sS3OCi
         OjFz3N39RJrg/HYUTE2Emtskz8i6vQ8rTLbue5kVIhrZJFwJB/sOvj5R9sN2TtU27djm
         GERw==
X-Gm-Message-State: AOAM533yUWX5lG/Bm8jqLSe92PmflI4TtpE+T6gkYGJeUT/CMts4ORn1
        8fPeNJSjFwyi4ypDpcQgDzG5LDiHN1Nln6Cr9ukN4AyVhPZxRkJfes506bobbtTQpOEVg09lgrY
        M0bUXh6u6KfYmToHu+bd6Jv4=
X-Received: by 2002:adf:82cb:0:b0:1e3:f20:fd0d with SMTP id 69-20020adf82cb000000b001e30f20fd0dmr5123088wrc.458.1645175360417;
        Fri, 18 Feb 2022 01:09:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDhTUNdcKxIs3VZA8gHsdneOJBFqccL9dojSFci0NSVvT7WcRQOnowaL0DRCJpfceq4VKGwA==
X-Received: by 2002:adf:82cb:0:b0:1e3:f20:fd0d with SMTP id 69-20020adf82cb000000b001e30f20fd0dmr5123066wrc.458.1645175360161;
        Fri, 18 Feb 2022 01:09:20 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a12sm25231149wru.99.2022.02.18.01.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 01:09:19 -0800 (PST)
Message-ID: <ceca85df-7a28-66a6-7c38-b2aa481d67df@redhat.com>
Date:   Fri, 18 Feb 2022 10:09:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] fbdev: Improve performance of sys_fillrect()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        deller@gmx.de, geert@linux-m68k.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220217103405.26492-1-tzimmermann@suse.de>
 <20220217103405.26492-2-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220217103405.26492-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 2/17/22 11:34, Thomas Zimmermann wrote:
> Improve the performance of sys_fillrect() by using word-aligned
> 32/64-bit mov instructions. While the code tried to implement this,
> the compiler failed to create fast instructions. The resulting
> binary instructions were even slower than cfb_fillrect(), which
> uses the same algorithm, but operates on I/O memory.
> 
> A microbenchmark measures the average number of CPU cycles
> for sys_fillrect() after a stabilizing period of a few minutes
> (i7-4790, FullHD, simpledrm, kernel with debugging). The value
> for CFB is given as a reference.
> 
>   sys_fillrect(), new:  26586 cycles
>   sys_fillrect(), old: 166603 cycles
>   cfb_fillrect():       41012 cycles
> 
> In the optimized case, sys_fillrect() is now ~6x faster than before
> and ~1.5x faster than the CFB implementation.
>

Wow, that's a big speedup!

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/fbdev/core/sysfillrect.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/sysfillrect.c b/drivers/video/fbdev/core/sysfillrect.c
> index 33ee3d34f9d2..bcdcaeae6538 100644
> --- a/drivers/video/fbdev/core/sysfillrect.c
> +++ b/drivers/video/fbdev/core/sysfillrect.c
> @@ -50,19 +50,9 @@ bitfill_aligned(struct fb_info *p, unsigned long *dst, int dst_idx,
>  
>  		/* Main chunk */
>  		n /= bits;
> -		while (n >= 8) {
> -			*dst++ = pat;
> -			*dst++ = pat;
> -			*dst++ = pat;
> -			*dst++ = pat;
> -			*dst++ = pat;
> -			*dst++ = pat;
> -			*dst++ = pat;
> -			*dst++ = pat;
> -			n -= 8;
> -		}
> -		while (n--)
> -			*dst++ = pat;
> +		memset_l(dst, pat, n);
> +		dst += n;
> +

Also the code is much more simpler / easy to read now. Amazing patch.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

