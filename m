From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Some questions
Date: Wed, 5 Mar 2003 18:01:46 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303051800580.23176-100000@vervain.sonytel.be>
References: <1046882655.1291.234.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qcIS-0005KY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 09:03:13 -0800
In-Reply-To: <1046882655.1291.234.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 6 Mar 2003, Antonino Daplas wrote:
> On Thu, 2003-03-06 at 00:17, Thomas Winischhofer wrote:
> > Antonino Daplas wrote:
> > >> > Strange.  If you boot at 800x600, the console will compute that as
> > >> > 100x37.  On fbcon_resize, it will request 800x592 but because the
> > >> > difference is only 8, fb_set_var should be skipped, so no mode change
> > >> > should happen throughout.
> > >>
> > >>But it definitely does. I can see this on my LCD (which goes dark during 
> > >>mode changes) and, of course, the log.
> > 
> > Just check this with the newest versions from fbdev at bk. In my code 
> > (which is, as I said in the beginning, the stock 2.5.63 kernel), 
> > fbcon_resize does NO check whatsoever. It stupidly calls set_var().
> 
> Of course.  My tree is so modified that I forgot that Jame's latest
> patch was not yet applied to the main tree :-)
> > 
> > I think that might be one reason for what I see :)
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Note that this patch is dated Feb 20. In the mean time James applied at least
your accel_putcs() optimizations and my logo updates.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
