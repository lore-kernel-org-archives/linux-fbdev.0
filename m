From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Voyager GX color mapping
Date: Tue, 14 Dec 2004 19:55:32 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0412141954050.15165@waterleaf.sonytel.be>
References: <41BF177E.7010205@anagramm.de> <Pine.GSO.4.61.0412141744200.10558@waterleaf.sonytel.be>
 <41BF1F8C.6030501@anagramm.de> <Pine.GSO.4.61.0412141818150.10558@waterleaf.sonytel.be>
 <41BF2593.7000709@anagramm.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CeHph-0003Hn-BB
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 10:55:37 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CeHpf-0002Zd-4y
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Dec 2004 10:55:37 -0800
In-Reply-To: <41BF2593.7000709@anagramm.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Clemens Koller <clemens.koller@anagramm.de>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 14 Dec 2004, Clemens Koller wrote:
> > > Well, whenever I change the (yet hardcoded) structs in the driver,
> > > fbset -fb /dev/fb2 shows me the correct (changed) values.
> > > But there is no change in X at all if I play around with the values.
> > > Is it possible that X doesn't get my fb_var_screeninfo? Maybe I need
> > > to check xorg.cfg again...
> > 
> > X may try to change the values again. If you're driver allows that (like it
> > seem to do, as per your description above), it may become confusion. Please
> > don't allow to change the bitfields in your driver, only allow the values
> > that
> > the hardware does support.
> 
> Okay... interesting... How does it (try and fail to) change it?
> Through IOCTL FBIOPUT_VSCREENINFO? Can I get more debug info out of it?

Yes, through FBIOPUT_VSCREENINFO. Your driver should refuse invalid values,
unless it can round them _up_ to make them valid.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
