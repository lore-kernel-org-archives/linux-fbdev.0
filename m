From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbcon: replace mono_col macro with
 static inline
Date: Tue, 26 Feb 2008 22:36:23 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802262235150.22486@anakin>
References: <1203963237.5582.4.camel@brick>
	<Pine.LNX.4.64.0802260917410.5158@anakin>
	<1204059074.5582.35.camel@brick>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JU7TU-000074-FL for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 13:36:32 -0800
Received: from edna.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JU7TS-0000D4-P4
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 13:36:32 -0800
In-Reply-To: <1204059074.5582.35.camel@brick>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Antonino Daplas <adaplas@gmail.com>

On Tue, 26 Feb 2008, Harvey Harrison wrote:
> On Tue, 2008-02-26 at 09:18 +0100, Geert Uytterhoeven wrote:
> > On Mon, 25 Feb 2008, Harvey Harrison wrote:
> > > +static inline int mono_col(struct fb_info *info)
> >                               ^^^^^^^^^^^^^^^^^^^^
> > const struct fb_info *info?
> 
> I suppose, but seeing as it's an inline, does it really matter?

Sure, if one day a new routine calls mono_col() passing a const struct fb_info
pointer, it won't compile.

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
