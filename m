From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/7] Detaching fbcon
Date: Mon, 12 Jun 2006 14:25:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0606121424300.7668@pademelon.sonytel.be>
References: <44856223.9010606@gmail.com> <448C19D7.5010706@t-online.de>
	<448C83AD.9060200@gmail.com> <448D1C9E.7050606@t-online.de>
	<448D5B4F.5080504@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FplUM-0005N0-7I for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 05:25:50 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FplUL-0007Yk-KE
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 05:25:50 -0700
In-Reply-To: <448D5B4F.5080504@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Knut Petersen <Knut_Petersen@t-online.de>

On Mon, 12 Jun 2006, Antonino A. Daplas wrote:
> Knut Petersen wrote:
> > I suggest to add the fb_unbinding / fb_binding fbops and to only allow
> > unbinding if we know that it will not leave the video hardware in a state
> > that is unusable for proper operation.
> > 
> > If there is nothing to be done inside those two fbops, they simply return
> > 0.
> > 
> > Other framebuffer drivers set the hardware to a state that is completely
> > unusable by a textmode console and that is incompatible with X. These
> > might need to know if X is active to decide if unbinding makes any sense at
> > that specific moment.
> 
> This is very ugly. Drivers should not care whether it's safe to load or
> unload, unbind or bind, or whether a specific application is open or not.
> This is not their job, this should be the job of the higher layer or an
> arbiter.  And yes, the state of graphics is currently ugly, witness the
> very long threads on how to to make everything work together.
> 
> Right now, the only thing I can claim is that trying to do an fbdev
> operation while inside X will result in undefined, if not fatal behavior.
> Don't do it. And no matter how many ugly hacks and workarounds we add
> for the framebuffer layer, this will always be true.

The main problem is that there are too many drivers for the same hardware:
  - vgacon
  - fbdev
  - X

All of them want to control the hardware, and all of them make assumptions
about its state...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
