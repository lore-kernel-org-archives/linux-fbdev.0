From: Nicholas Mc Guire <der.herr@hofr.at>
Date: Fri, 20 Feb 2015 14:20:06 +0000
Subject: Re: [PATCH] video: fbdev: use msecs_to_jiffies for time conversion
Message-Id: <20150220142006.GA11757@opentech.at>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423214041-15818-1-git-send-email-hofrat@osadl.org> <54E72774.1070809@ti.com> <20150220140110.GA25767@opentech.at> <54E73F78.3050009@ti.com>
In-Reply-To: <54E73F78.3050009@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Fabian Frederick <fabf@skynet.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 20 Feb 2015, Tomi Valkeinen wrote:

> On 20/02/15 16:01, Nicholas Mc Guire wrote:
> 
> >>>  	pr_debug("%s(): task ending\n", __func__);
> >>> @@ -1460,7 +1460,7 @@ static void pxafb_disable_controller(struct pxafb_info *fbi)
> >>>  #ifdef CONFIG_FB_PXA_SMARTPANEL
> >>>  	if (fbi->lccr0 & LCCR0_LCDT) {
> >>>  		wait_for_completion_timeout(&fbi->refresh_done,
> >>> -				200 * HZ / 1000);
> >>> +				msecs_to_jiffies(200);
> >>
> >> That will not compile.
> 
> >  No compile warning or errors
> > 
> >  could you send me the compile error message and the toolchain you
> >  are using - this change should not really have any noticable impact.
> 
> I didn't compile it. It's missing a closing parenthesis.
> 
> This is one reason I'm not very fond of cleanups to drivers that the
> patch sender cannot test... They may cause more problems than they help.
>
That was the intent of compile testing the patch but it seems
that it was not covered by the config in use - sorry for that, it was 
missing the    [*]   PXA Smartpanel LCD support so
root@debian:~/linux-next# grep CONFIG_FB_PXA_SMARTPANEL .config
# CONFIG_FB_PXA_SMARTPANEL is not set

The motivation for the cleanup simply was code reasdability - will fix this up
and compile check with a proper config.

thx!
hofrat 
