Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1DBC433B4
	for <linux-fbdev@archiver.kernel.org>; Thu, 20 May 2021 07:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F65611BE
	for <linux-fbdev@archiver.kernel.org>; Thu, 20 May 2021 07:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhETHvH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 20 May 2021 03:51:07 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44171 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETHvH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 20 May 2021 03:51:07 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M9WiK-1lmugn09OW-005auD; Thu, 20 May 2021 09:49:45 +0200
Received: by mail-wm1-f46.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so4617457wmg.3;
        Thu, 20 May 2021 00:49:44 -0700 (PDT)
X-Gm-Message-State: AOAM533+kgwK5+GRhL34lL8Z1KvV48ZD3AbiT3BsaAsAgGO8vqUBur3j
        bxnukR4u8y0PSOPnG46xvTyQSQFM1o441aGI7og=
X-Google-Smtp-Source: ABdhPJzTnFiyItuVXHf2Goa+uE3iwf9aQon2dCDtZRjZ/2Qcnq1b1x03TFmZZogoXxw8ZVwpVrjaamoTcjQg4uj+qBY=
X-Received: by 2002:a7b:c849:: with SMTP id c9mr2699323wml.84.1621496984686;
 Thu, 20 May 2021 00:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210519120028.7350-1-songqiang@uniontech.com>
 <YKUBtiOTE7zJHAjI@casper.infradead.org> <1049640176.41531.1621490295842.JavaMail.xmail@localhost.localdomain>
In-Reply-To: <1049640176.41531.1621490295842.JavaMail.xmail@localhost.localdomain>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 May 2021 09:48:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Pt+e3fbfWxJru7O-Np9u2u-_cVZqd5xBejLSraFYALQ@mail.gmail.com>
Message-ID: <CAK8P3a2Pt+e3fbfWxJru7O-Np9u2u-_cVZqd5xBejLSraFYALQ@mail.gmail.com>
Subject: Re: Re: [PATCH] drivers/video/fbdev/core/fbmem.c: add pointer judgment
To:     =?UTF-8?B?5a6L5by6?= <songqiang@uniontech.com>
Cc:     Matthew Wilcox <willy@infradead.org>, sam <sam@ravnborg.org>,
        "b.zolnierkie" <b.zolnierkie@samsung.com>,
        penguin-kernel <penguin-kernel@i-love.sakura.ne.jp>,
        "george.kennedy" <george.kennedy@oracle.com>,
        tzimmermann <tzimmermann@suse.de>, jgg <jgg@ziepe.ca>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:NfkXDccIH0OFI/eaJXwafFWdvnS+fVPxMMZlw9UVXSn2di68EaK
 2Po+fXuNsoLZGy1NXaOw4ei2Cqk4Bj12oh+dwMyF87BxSup8mW/sf2B6ZQLX+vGXp19IkCH
 wJmgoR+Q10nwqNQxac9aBedRdYZn7yjkciFqz8cPPRYw7eQuo+zeQGpaGDXZszg3MxWTzUq
 S2GuwiRiSj57QupbCW9qQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mq6gJmgebVo=:Ac18aJQfiT6IGPL+mN4BZo
 zLTzZ2WGSoIhRVlrJDrPKSx2uznTEIXwlrNdS5kk1WaEfB9k4S3EpVosrP0OuqFaTJ9GLx4vp
 cSHBIw+W2DIknh5o+sQsQoGJNft1gKXAZrToTXuby+4rZ1Rcn5f09Sg8LfDvEmtRdOQeqp5CO
 TyhxnW8fVILzY+xnt4SwnjhUIVhHTtW0IBtfoyqasVgZjmWP/TxG6T2/LoyWK7QQ24uUuN8cJ
 GxZ7Y7JUaX7V6kzsytuRJJ76143yZpEBjn/Ws+c17iox/zE0hHE4EapSLZvvb/aYLxGnNX7D0
 usmwxsJDrsJKllrAnxFvaHRGb7SqUJekAbAxojLwOomc7Vtsw6GrBuW7tJjfwxf7Fm5SI/g+L
 YArJI25MLriZUj4SYjBrYMGaocpCNgnc/vvJPVv0P1pMY0h92gtqGcWq+Nzap5OGy5IfvsftH
 GpPLXOOf2sp8u4DVxUUeYXoGj7cVZOAqaoJ0YW6ZqnQgTxXqFeZ2tLPjcbTGI1KieUn4dAi6A
 CL91XzfB/QB4acgDtQ6bN7nl1ZYt4XuPGl6Vqs1PG43/B983U9tXURHmXdF0lKfzrrnmLduWO
 Ll5mJtHgrjCq9IUvxm6QmT3toNNb1Qg1pHR7lLG2sCStDvwIDtCCSS4rxyeFK/LtICdzOjplT
 SARQ=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

>  > On Wed, May 19, 2021 at 08:00:28PM +0800, songqiang wrote:
> > Signed-off-by: songqiang <songqiang@uniontech.com>
> From: "Matthew Wilcox <willy@infradead.org>"
> > You need to explain:
> >
> > - Why you think this patch is needed
> > - Did you observe a problem at runtime?
> > - Is this the output from some checking tool?
> > - Why this is the right way to address the problem
>
On Thu, May 20, 2021 at 7:58 AM 宋强 <songqiang@uniontech.com> wrote:
>
> I find null pointer bug when I debug the kernel of loongson，I think the function fb_set_suspend()
> add pointer judgment will more friendly.

When replying to emails on the list, please remember

- avoid top-posting, see https://git-send-email.io/top-posting.html
- use plain text email, html replies get dropped by many mailing lists.

The information from your reply should be part of the patch description when
you send a patch, see
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html


> [  102.011018] Call Trace:
>
> [  102.013443] [<ffffffff81068e10>] fb_set_suspend+0x50/0x80
> [  102.018819] [<ffffffffc0061aa0>] loongson_drm_suspend+0x1a0/0x340 [loongson]
> [  102.025827] [<ffffffffc0061c58>] loongson_pmops_freeze+0x18/0x40 [loongson]
> [  102.032748] [<ffffffff81008fd4>] pci_pm_freeze+0x94/0x240
> [  102.038114] [<ffffffff815377e0>] dpm_run_callback.isra.5+0x20/0x140
> [  102.044341] [<ffffffff81539608>] __device_suspend+0x2c8/0x740

It looks like the check would actually belong into the loongson_drm driver.
The driver is not upstream yet, but I assume you have the source for it, so
try to fix the bug there and send the patch to the owners of that driver.

       Arnd
