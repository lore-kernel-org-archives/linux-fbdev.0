From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Rivafb colors all messed up with 2.5.20-dj2.
Date: Wed, 5 Jun 2002 10:19:53 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0206051019050.27487-100000@vervain.sonytel.be>
References: <3CFDBCE4.9050807@megapathdsl.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.sonytel.be ([193.74.243.200])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17FW1b-0001yU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Jun 2002 01:20:12 -0700
In-Reply-To: <3CFDBCE4.9050807@megapathdsl.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Miles Lane <miles@megapathdsl.net>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@transvirtual.com>

On Wed, 5 Jun 2002, Miles Lane wrote:
> For a long time, I have had messed up colors when I use rivafb.
> In the past, just the penguin logo has been obviously messed up
> (all purple).  Now, all the colors are off.  By running
> "fbset -a 1600x1200-76" I am able to get the framebuffer colors
> correctly set.  Also, running this command gives me the 
> desired refresh rate.  I suspect I am using an incorrect
> boot parameter value.  Can someone tell me what value to use
> to get 1600x1200 @ 76Hz and 16-bit color?

  [...]

> My append= line includes "video=riva:1600x1200-16"

Modedb doesn't have a 1600x1200 76 Hz mode, but it does have 75 Hz.
Please try `1600x1200@75-16' instead.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
