From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/1 try#2] [VIDEO/FRAMEBUFFER]: add
 BF52x EZkit Display driver
Date: Thu, 6 Mar 2008 19:07:34 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803061906210.20407@anakin>
References: <1201686800-31739-1-git-send-email-bryan.wu@analog.com>
	<20080130083820.c1bcbc14.randy.dunlap@oracle.com>
	<1201711783.6463.11.camel@roc-laptop>
	<20080305230223.920765e9.akpm@linux-foundation.org>
	<386072610803060850i2e0b6e35q7e05448d5fd39bca@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JXKVY-0008P2-8p for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Mar 2008 10:07:56 -0800
Received: from monty.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JXKVV-0007cv-3J
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Mar 2008 10:07:54 -0800
In-Reply-To: <386072610803060850i2e0b6e35q7e05448d5fd39bca@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: bryan.wu@analog.com, Randy Dunlap <randy.dunlap@oracle.com>, adaplas@gmail.com, Michael Hennerich <michael.hennerich@analog.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Thu, 6 Mar 2008, Bryan Wu wrote:
> On Wed, Mar 5, 2008 at 11:02 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Thu, 31 Jan 2008 00:49:43 +0800 Bryan Wu <bryan.wu@analog.com> wrote:
> >  > +     fbinfo =
> >  > +         framebuffer_alloc(sizeof(struct bfin_t350mcqbfb_info), &pdev->dev);
> >  > +     if (!fbinfo) {
> >  > +             ret = -ENOMEM;
> >  > +             goto out2;
> >  > +     }

    [...]

> >  > +     fbinfo->pseudo_palette = kmalloc(sizeof(u32) * 16, GFP_KERNEL);
> >  > +     if (!fbinfo->pseudo_palette) {
> >  > +             printk(KERN_ERR DRIVER_NAME
> >  > +                    "Fail to allocate pseudo_palette\n");
> >  > +
> >  > +             ret = -ENOMEM;
> >  > +             goto out4;
> >  > +     }
> >  > +
> >  > +     memset(fbinfo->pseudo_palette, 0, sizeof(u32) * 16);
> >
> >  You just invented kzalloc!
> >
> 
> Right

Alternatively, you could embed the pseudo palette inside struct
bfin_t350mcqbfb_info, so it's allocated by the framebuffer_alloc() call
above.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
