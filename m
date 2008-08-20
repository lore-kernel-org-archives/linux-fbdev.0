From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i.MX Framebuffer: Use
 iowrite/ioread instead of direct pointer deref
Date: Wed, 20 Aug 2008 22:23:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808202221590.16983@anakin>
References: <1219158403-5180-1-git-send-email-s.hauer@pengutronix.de>
	<1219158403-5180-3-git-send-email-s.hauer@pengutronix.de>
	<20080820173159.4bc56e34.krzysztof.h1@poczta.fm>
	<20080820163109.GU4713@pengutronix.de>
	<20080820194246.0dc9a589.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVuDc-0005Ew-8p for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Aug 2008 13:23:48 -0700
Received: from winston.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KVuDa-000416-L8
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Aug 2008 13:23:48 -0700
In-Reply-To: <20080820194246.0dc9a589.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Juergen Beisert <j.beisert@pengutronix.de>, linux-fbdev-devel@lists.sourceforge.net

On Wed, 20 Aug 2008, Krzysztof Helt wrote:
> On Wed, 20 Aug 2008 18:31:09 +0200
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Wed, Aug 20, 2008 at 05:31:59PM +0200, Krzysztof Helt wrote:
> > > On Tue, 19 Aug 2008 17:06:41 +0200
> > > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > > +#define DRIVER_NAME "imx-fb"
> > > > +
> > > 
> > > All constants below should really be put into the imxfb.h. There is already such a file.
> > 
> > AFAIK the-new-beautiful-way is not to have these header files next to
> > the .c files at all and put this stuff into the .c file. So maybe it's
> > better to move the rest of imxfb.h here aswell.
> 
> I was not aware about "the-new-beautiful-way". I am just curious about this.
> Normally, the headers for frame buffers are located at include/video. 
> 
> It can stay this way (no header) if you insist.

If the header file is included by a single source file only, it doesn't
make much sense to have the separate header file.

include/video/ is for header files that are included by multiple source
files, some outside drivers/video/.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
