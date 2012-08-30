From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 30 Aug 2012 06:23:29 +0000
Subject: Re: [PATCH 00/19] SH Mobile LCDC panel cleanup (including board code)
Message-Id: <20120830062329.GC20229@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345122054-16013-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1345122054-16013-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

(Resending due to mail server silliness, apologies for any duplicates)

On Mon, Aug 27, 2012 at 05:54:52PM +0900, Simon Horman wrote:
> On Thu, Aug 16, 2012 at 03:00:35PM +0200, Laurent Pinchart wrote:
> > Hi everybody,
> > 
> > As part of a general panel API implementation (more on that a bit later), I've
> > cleaned up panel support in the LCDC driver and in the related board code. The
> > result is 19 patches independent of the generic panel API that I would like to
> > get reviewed by the respective board maintainers.
> 
> Hi Paul,
> 
> I'm happy for you to take all of this, including the mach-shmobile
> portions through your tree if that works for you.

..

> >  arch/arm/mach-shmobile/board-ag5evm.c       |  198 ++++++++++++++-------------
> >  arch/arm/mach-shmobile/board-ap4evb.c       |    4 +-
> >  arch/arm/mach-shmobile/board-mackerel.c     |    6 -
> >  arch/sh/boards/mach-ap325rxa/setup.c        |    6 -
> >  arch/sh/boards/mach-ecovec24/setup.c        |    6 -
> >  arch/sh/boards/mach-kfr2r09/lcd_wqvga.c     |   16 +--
> >  arch/sh/boards/mach-kfr2r09/setup.c         |    7 +-
> >  arch/sh/include/mach-kfr2r09/mach/kfr2r09.h |    6 +-
> >  drivers/video/sh_mipi_dsi.c                 |   69 ++++------
> >  drivers/video/sh_mobile_lcdcfb.c            |   54 ++++----
> >  drivers/video/sh_mobile_lcdcfb.h            |    1 +
> >  include/video/sh_mipi_dsi.h                 |    4 +-
> >  include/video/sh_mobile_lcdc.h              |    1 -
> >  13 files changed, 172 insertions(+), 206 deletions(-)
> > 
Based on the diffstat, the bulk of the change is in the mach-shmobile
directory, so this probably ought to go through your tree to minimize the
potential for merge conflicts. All of the SH stuff is trivival, so
shouldn't be an issue. You're welcome to attach my Acked-by if you like.
