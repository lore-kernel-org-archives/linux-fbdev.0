From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Radeonfb hsync fudge factor?
Date: Wed, 24 Dec 2003 13:12:21 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0312241310520.1638@waterleaf.sonytel.be>
References: <3FE8D315.1000904@undead.cc> <20031224091824.GB11706@master.mivlgu.local>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZ7sM-0000jr-0t
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 04:12:30 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZ7sL-0004CP-Gf
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Dec 2003 04:12:29 -0800
In-Reply-To: <20031224091824.GB11706@master.mivlgu.local>
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
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 24 Dec 2003, Sergey Vlasov wrote:
> On Tue, Dec 23, 2003 at 06:43:17PM -0500, John Zielinski wrote:
> > What's the hsync fudge factor used for?
> >
> > I noticed that the left edged of my screen moved a bit when I was
> > switching between 32/16/8 bpp modes and tracked it down to this.
>
> The same thing here - both with Radeon VE QY and 8500LE (don't remember
> the exact chip version).  Adding the opposite value to the fbset
> parameters puts the image back into the place - so it looks like the hsync
> fudge is unneeded at least with these chipsets.
>
> Probably this fudge factor was needed for some early chips?

Yep, Mach64 needs one (but atyfb doesn't take care of it yet). So if you switch
between depths, the display may shift horizontally. I guess this is due to
different lengths of the dataflow paths for different color depths.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
