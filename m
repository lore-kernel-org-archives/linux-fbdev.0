Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD22C433DB
	for <linux-fbdev@archiver.kernel.org>; Thu, 18 Mar 2021 02:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F6A264E90
	for <linux-fbdev@archiver.kernel.org>; Thu, 18 Mar 2021 02:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhCRC5z (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 17 Mar 2021 22:57:55 -0400
Received: from m12-17.163.com ([220.181.12.17]:45223 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230484AbhCRC5k (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 17 Mar 2021 22:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=KPGwb
        9gxS2L3jpUPP+5kZ/sCntP88A2Tgi+JuYEUnic=; b=GqvExvHe/c4+8N95B/p6m
        WKNcWqOizA0Q0PdWIzneiG5bO+5zDGbA5eEeP8rU2f1T/HBFXzXxHBwMLzMfJpRF
        JyJ9BVIh3+z8UuCbIS2UpSX1c6BPwQhr1bLlHGKedxzSk1V31kp4taMQV50mPkBq
        yDCv+qWS65/G0vGZfYOJi8=
Received: from localhost (unknown [218.94.48.178])
        by smtp13 (Coremail) with SMTP id EcCowACHh4lswVJgH_hdqg--.59669S2;
        Thu, 18 Mar 2021 10:56:45 +0800 (CST)
Date:   Thu, 18 Mar 2021 10:56:44 +0800
From:   Chunyou Tang <tangchunyou@163.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     gustavoars@kernel.org, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangchunyou@yulong.com
Subject: Re: [PATCH] drivers/video/fbdev:modify 0 to NULL
Message-ID: <20210318105644.00002eac@163.com>
In-Reply-To: <5202c72d-4246-1a4e-37fa-7caf2d9c1ce3@embeddedor.com>
References: <20210318023329.488-1-tangchunyou@163.com>
        <20f1664e-df4c-d085-cb25-1d05e8a793a3@embeddedor.com>
        <20210318104718.00005767@163.com>
        <5202c72d-4246-1a4e-37fa-7caf2d9c1ce3@embeddedor.com>
Organization: yulong
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EcCowACHh4lswVJgH_hdqg--.59669S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUYtC7DUUUU
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbiHg1ZUVSItUQLFgAAsr
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,Gustavo

On Wed, 17 Mar 2021 20:54:41 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> On 3/17/21 21:47, Chunyou Tang wrote:
> 
> > I think "if (info == NULL)" is more intuitive,and there have many
> > compare likes "if (info == NULL)" in this file.  
> 
> In that case, all those instances should be changed to if (!foo),
> instead.
> 
> --
> Gustavo

OK,I change it.

--
ChunyouTang

