From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: hi-res fb console with 2.6.0-testX ?
Date: Tue, 9 Sep 2003 10:54:00 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0309091005370.3617-100000@waterleaf.sonytel.be>
References: <20030908223814.GA4495@vana.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19weHV-0005PA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 01:55:25 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19weHU-0001Xf-OQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 01:55:24 -0700
In-Reply-To: <20030908223814.GA4495@vana.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, cheapisp@sensewave.com, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 9 Sep 2003, Petr Vandrovec wrote:
> On Mon, Sep 08, 2003 at 10:57:34PM +0200, Geert Uytterhoeven wrote:
> > On Mon, 8 Sep 2003, Petr Vandrovec wrote:
> > > And whole fb subsystem changed semantic, so do not build both
> > > vesafb & matroxfb into the kernel - either one or another, or
> > > you'll be definitely surprised what will happen (and I'm almost
> > > sure that blank screen is not what you want).
> > 
> > What's wrong with the resource system that prevents this from working?
> 
> vesafb ignore failures... for framebuffer it just prints warning only, and
> for 0x3C0 region it just completely ignores warning (due to vgacon
> clash). But it should not be serious, user should just get console 
> on matroxfb, and vesafb on /dev/fb1 doing nothing.

OK.

> Main thing which prevents this from working as users expects is that
> modular fbdevs cannot be used by fbcon. So people cannot create
> initrd scripts which load proper fbdev driver anymore, after detecting
> hardware and making sure that hardware & user wishes & driver are
> compatible. They now have to build fbdevs to the kernel, and hope for
> the best...

Ugh, didn't know that...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
