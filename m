From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Fri, 26 Dec 2003 12:01:51 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0312261200120.2029-100000@waterleaf.sonytel.be>
References: <1072305863.15477.15.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZpjG-0003TH-CB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Dec 2003 03:02:02 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AZpjF-0006F0-Ss
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 26 Dec 2003 03:02:02 -0800
In-Reply-To: <1072305863.15477.15.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: John Zielinski <grim@undead.cc>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 25 Dec 2003, Benjamin Herrenschmidt wrote:
> On Thu, 2003-12-25 at 08:34, John Zielinski wrote:
> > I've done some digging and it's definitely because of how many palette 
> > entries are updated for the 565 mode.  What's the proper number of 
> > entries that need to be updated for 565 mode, 32 or 64?   I'll have to 
> > check what the nvidia driver expects.  I can't test 24 bpp as the driver 
> > won't do that currently.
> 
> 64 but with only green mattering above 32 iirc, look what XFree does.

Yep, I can confirm that. The number of entries is 2 <<
max({red,green,blue,transp}.length).

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
