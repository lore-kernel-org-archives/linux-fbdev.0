From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Default timings in vga16fb driver
Date: Fri, 26 Nov 2004 10:11:33 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0411261010460.26681@waterleaf.sonytel.be>
References: <41A36DA5.8090200@fujitsu-siemens.com> <200411250016.25813.adaplas@hotpop.com>
 <41A5F24A.4040804@fujitsu-siemens.com> <200411260351.57443.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CXc8w-000508-HL
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Nov 2004 01:11:54 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CXc8v-0002zg-M1
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Nov 2004 01:11:54 -0800
In-Reply-To: <200411260351.57443.adaplas@hotpop.com>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Martin Wilck <martin.wilck@fujitsu-siemens.com>

On Fri, 26 Nov 2004, Antonino A. Daplas wrote:
> On Thursday 25 November 2004 22:55, Martin Wilck wrote:
> > Antonino A. Daplas wrote:
> > > I don't think you overlooked anything. The default modeline of vga16fb
> > > should be corrected.
> >
> > OK, so here's the patch (using the timings from /etc/fb.modes). Should I
> > send it to linux-kernel, too?
> 
> No, I'll take care of this.

BTW, can't vga16fb just use modedb, with the default mode being 640x480-4@60?

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
