From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [SPAM] [PATCH 4/4 2.6.24] fbdev:
 platforming hecubafb and n411
Date: Fri, 4 Apr 2008 14:44:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804041442430.24006@anakin>
References: <20080404010318.17144.4354.sendpatchset@hit-nxdomain.opendns.com>
	<20080404010414.17144.60962.sendpatchset@hit-nxdomain.opendns.com>
	<Pine.LNX.4.64.0804041236270.24006@anakin>
	<45a44e480804040438n17422cfeqde0bcfc45fd01326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhlHL-0007Jm-4K for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 05:44:23 -0700
Received: from wilson.telenet-ops.be ([195.130.132.42])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JhlHJ-0000kM-I0
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 05:44:23 -0700
In-Reply-To: <45a44e480804040438n17422cfeqde0bcfc45fd01326@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net

On Fri, 4 Apr 2008, Jaya Kumar wrote:
> On Fri, Apr 4, 2008 at 6:37 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, 3 Apr 2008, Jaya Kumar wrote:
> >  > This patch splits hecubafb into the platform independent hecubafb and
> >  > the platform dependent n411.
> >  >
> >  > Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> >  >
> >  > ---
> >  >
> >  >  drivers/video/hecubafb.c |  250 +++++++++--------------------------------------
> >  >  drivers/video/n411.c     |  202 +++++++++++++++++++++++++++++++++++++
> >  >  include/video/hecubafb.h |   51 +++++++++
> >  >  3 files changed, 304 insertions(+), 199 deletions(-)
> >
> >  Why is there no corresponding change to a Kconfig and Makefile?
> 
> I left the Kconfig/Makefile changes in patch 3. I am hoping that is

Ah, I didn't seem to have received that one...

> okay. Should I split those out?

I think it's better to keep the Kconfig/Makefile changes together. Else
you get an unbuildable tree if you apply patches 1-3, but don't apply
patch 4.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
