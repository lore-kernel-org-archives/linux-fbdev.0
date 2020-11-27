Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42352C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 21:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B6822210
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 21:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgK0VSf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 16:18:35 -0500
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:52062 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730049AbgK0VRE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 16:17:04 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 49B1E18225647;
        Fri, 27 Nov 2020 21:16:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: way41_430dcee2738b
X-Filterd-Recvd-Size: 3518
Received: from [10.0.0.26] (cpe-23-242-83-182.socal.res.rr.com [23.242.83.182])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Nov 2020 21:16:43 +0000 (UTC)
Message-ID: <f8b2737702e295b9f780b98f27faac759ffff7ae.camel@perches.com>
Subject: Re: [PATCH v1 02/28] video: fbcon: Use pr_debug() in fbcon
From:   Joe Perches <joe@perches.com>
To:     Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-nvidia@lists.surfsouth.com,
        Michal Januszewski <spock@gentoo.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimemrmann <tzimmermann@suse.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Date:   Fri, 27 Nov 2020 13:16:41 -0800
In-Reply-To: <20201127195825.858960-3-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
         <20201127195825.858960-3-sam@ravnborg.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 2020-11-27 at 20:57 +0100, Sam Ravnborg wrote:
> Replacing DPRINTK() statements with pr_debug fixes
> W=1 warnings.
> And moves to a more standard logging setup at the same time.
[]
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
[]
> @@ -1015,9 +1007,9 @@ static const char *fbcon_startup(void)
>  	rows /= vc->vc_font.height;
>  	vc_resize(vc, cols, rows);
>  
> 
> -	DPRINTK("mode:   %s\n", info->fix.id);
> -	DPRINTK("visual: %d\n", info->fix.visual);
> -	DPRINTK("res:    %dx%d-%d\n", info->var.xres,
> +	pr_debug("mode:   %s\n", info->fix.id);
> +	pr_debug("visual: %d\n", info->fix.visual);
> +	pr_debug("res:    %dx%d-%d\n", info->var.xres,
>  		info->var.yres,
>  		info->var.bits_per_pixel);

It'd be nicer to reindent the subsequent lines too.

> @@ -3299,7 +3291,7 @@ static void fbcon_exit(void)
>  
> 
>  		if (info->queue.func)
>  			pending = cancel_work_sync(&info->queue);
> -		DPRINTK("fbcon: %s pending work\n", (pending ? "canceled" :
> +		pr_debug("fbcon: %s pending work\n", (pending ? "canceled" :
>  			"no"));

perhaps:

		pr_debug("fbcon: %s pending work\n", pending ? "canceled" : "no");


