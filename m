From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/4] gxfb: Replace FBSIZE config
 option with a kernel argument
Date: Mon, 10 Mar 2008 09:16:34 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803100915300.8567@anakin>
References: <20080223011045.48e6cb8e@ephemeral>
	<20080227163105.e1b96023.akpm@linux-foundation.org>
	<20080227195839.1e86074e@ephemeral> <20080308201950.28f6eae8@ephemeral>
	<20080309220025.GD9971@localhost.localdomain>
	<20080309195754.6d972be7@ephemeral>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JYdBg-0004TP-3N for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 01:16:48 -0700
Received: from winston.telenet-ops.be ([195.130.137.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JYdBd-00056N-Ff
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 01:16:48 -0700
In-Reply-To: <20080309195754.6d972be7@ephemeral>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, adaplas@gmail.com, linux-kernel@vger.kernel.org

On Sun, 9 Mar 2008, Andres Salomon wrote:
> On Sun, 9 Mar 2008 23:00:25 +0100
> Ondrej Zajicek <santiago@crfreenet.org> wrote:
> 
> > On Sat, Mar 08, 2008 at 08:19:50PM -0500, Andres Salomon wrote:
> > > > assuming this is historical at this point, and manual options parsing can
> > > > be removed from all fb drivers at this point, or is there another reason
> > > > why manual parsing would be necessary?
> > > > 
> > > 
> > > Could I get an answer from the fbdevel folks about this?  It looks like
> > > the fb_get_options stuff is there for backwards compatibility.
> > 
> > I think so. I used fb_get_options() in arkfb and vt8623fb for mode option
> > only. Universal notation module.option=value is much nicer than manual
> > options parsing.  

This `module.option=value' is a quite recent introduction? I first saw it
mentioned earlier this year...

> If that is indeed the case, here's a patch that might be useful.  I have
> no idea what kind of timeframe would be proposed for removing
> fb_get_options (or if it's even desirable to remove it at all given that
> people are likely still using video=$foo syntax).

Probably it's way too early for that...

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
