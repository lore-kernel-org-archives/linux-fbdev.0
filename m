From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 30 Aug 2011 20:41:39 +0000
Subject: Re: [PULL] SH mobile LCDC cleanups and fixes
Message-Id: <4E5D4B03.1050909@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201108191044.52130.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201108191044.52130.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,

On 08/19/2011 08:44 AM, Laurent Pinchart wrote:
> Hi Florian,
> 
> Here are the latest SH mobile LCDC and MERAM cleanups and fixes based on top
> of v3.1-rc2. All the patches have been posted to the list. I've incorporated
> acked-by and tested-by lines when available, but most of the patches received
> no comment.
> 
> The following changes since commit 93ee7a9340d64f20295aacc3fb6a22b759323280:
> 
>   Linux 3.1-rc2 (2011-08-14 15:09:08 -0700)
> 
> are available in the git repository at:
>   git://linuxtv.org/pinchartl/fbdev.git sh-mobile-lcdc

Pulled, thanks.
It looks good to me, as far as I can tell.
Just the first commits that were not your own ones should have had more verbose
commit messages and I think they should have had your Signed-off as you received
them via e-mail?

And on another note:
Would you mind adding yourself as maintainer of drivers/video/sh_mobile_* in
MAINTAINERS? I can't find any entry for it yet and having me as primary source
for review for a driver I don't know is a bad idea, at least if there are people
that know it better.


Thanks,

Florian Tobias Schandinat

> 
> Damian Hobson-Garcia (5):
>       fbdev: sh_mobile_meram: Enable runtime PM
>       fbdev: sh_mobile_meram: Enable/disable MERAM along with LCDC
>       fbdev: sh_mobile_meram: Move private data from .h to .c
>       fbdev: sh_mobile_meram: Backup/restore device registers on shutdown/resume
>       fbdev: sh_mobile_meram: Assign meram to the SH7372_A4LC power domain
> 
> Laurent Pinchart (11):
>       fbdev: sh_mobile_lcdc: Turn dot clock on before resuming from runtime PM
>       fbdev: sh_mobile_lcdc: Replace hardcoded register values with macros
>       fbdev: sh_mobile_lcdc: Don't acknowlege interrupts unintentionally
>       fbdev: sh_mobile_lcdc: Compute clock pattern using divider denominator
>       fbdev: sh_mobile_lcdc: Split LCDC start code from sh_mobile_lcdc_start
>       fbdev: sh_mobile_lcdc: Store the frame buffer base address when panning
>       fbdev: sh_mobile_lcdc: Restart LCDC in runtime PM resume handler
>       fbdev: sh_mobile_meram: Replace hardcoded register values with macros
>       fbdev: sh_mobile_meram: Validate ICB configuration outside mutex
>       fbdev: sh_mobile_meram: Fix MExxCTL register save on runtime PM suspend
>       fbdev: sh_mobile_meram: Remove unneeded sh_mobile_meram.h
> 
>  arch/arm/mach-shmobile/board-mackerel.c |    1 +
>  drivers/video/sh_mobile_lcdcfb.c        |  592 ++++++++++++++-----------------
>  drivers/video/sh_mobile_lcdcfb.h        |   12 +-
>  drivers/video/sh_mobile_meram.c         |  202 +++++++++--
>  drivers/video/sh_mobile_meram.h         |   41 ---
>  include/video/sh_mobile_lcdc.h          |  135 ++++++-
>  6 files changed, 556 insertions(+), 427 deletions(-)
>  delete mode 100644 drivers/video/sh_mobile_meram.h
> 

