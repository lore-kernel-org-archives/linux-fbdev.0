From: Scott Wood <scottwood@freescale.com>
Date: Tue, 24 Nov 2015 17:00:45 +0000
Subject: Re: [PATCH] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <1448384445.27264.345.camel@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 2015-11-24 at 11:56 -0500, Timur Tabi wrote:
> On Tue, Nov 24, 2015 at 11:54 AM, Timur Tabi <timur@tabi.org> wrote:
> > Well, if you're concern is that there's no platform code, then there
> > should be a check that says, "see if there's any platform code", not
> > "let's check this obscure function and abort without explanation if
> > it's not initialized."
> > 
> > Alternatively, why can't you just do this, in update_lcdc():
> 
> [Stupid gmail sent my message before I was done typing]
> 
> if (diu_ops.set_pixel_clock)
>    diu_ops.set_pixel_clock(var->pixclock);

Because it's more obviously correct to abort the probe than to continue with
some operations nooped.  This is meant to be a quick and obvious fix to the
crashing bug.  There's another patch pending to reorganize the init of this
driver.

FWIW, I don't like the fact that this driver requires "platform code" at all. 
 Why isn't it self-contained, with knowledge of the relevant boards?

-Scott

