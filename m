From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Sane behavior of fbset
Date: Fri, 18 Jun 2004 10:24:48 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406181024180.11779@waterleaf.sonytel.be>
References: <200406180945.12444.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbEg6-0005nl-Tx
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 01:24:50 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BbEg6-0002yP-8Z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 01:24:50 -0700
In-Reply-To: <200406180945.12444.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 18 Jun 2004, Antonino A. Daplas wrote:
> Currently, using fbset either corrupts the display, or at worst, hangs the GPU.  I consider
> this a critical bug.  I don't want to discuss the pros/cons of using fbset vs stty to
> change the console size, but we need to make sure that using fbset (or any utility
> that utilizes the fb_set_var ioctl) does not produce undefined behavior.  There are
> at least 3 possibilities:
>
> 1.  Revert to 2.4 behavior.  This is easy to add since fbdev already has a notifier
> support. (I already have working code for this). Of course, stty will still work.
>
> 2.  Make the set_var ioctl return immediately if the vc_mode of the current display is
> KD_TEXT. Basically, fbset becomes an informational utility only. I don't know the
> repercussions of this with userland fb applications though.
>
> 3.  Modify fbset (and other similar utilities, if there are any) so it also issues an
> 'stty-like' call after a 'set_var' call.
>
> Note: As mentioned by many people before, it's almost impossible to completely
> preserve per-console mode info because of the lack of a per-display var.  So even
> if we agree to implement #1,  it cannot completely match 2.4 behavior. Also, the lack
> of per-display var means that drivers must be able to handle mode changes without
> any help.  James' fb_find_mode support in fbcon_resize does partly alleviate this
> limitation.
>
> Comments?

I vote for 1, and re-adding per-display vars.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
