From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Framebuffer and non-PCI devices
Date: Sat, 19 Feb 2005 19:40:05 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0502191937500.3355@numbat.sonytel.be>
References: <9e47339105021910257461d4cc@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2ZWZ-0007wL-1E
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 10:40:15 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D2ZWX-0004US-Cq
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 10:40:14 -0800
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j1JIeAGU014877
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Feb 2005 19:40:10 +0100 (MET)
In-Reply-To: <9e47339105021910257461d4cc@mail.gmail.com>
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 19 Feb 2005, Jon Smirl wrote:
> Are any of the framebuffers non-PCI devices?

Yes.

> Looking through the code fb_info->device appears to be filled in by
> only a subset of the drivers. Can fb_info->device be converted to a
> pci device? I would also add it as a parameter to register_fb() in

Hence, no, it cannot be a converted to a pci_dev in all cases.

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
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
