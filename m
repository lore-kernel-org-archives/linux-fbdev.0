From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: mono, gray and index configs
Date: Thu, 11 Aug 2005 10:22:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508111020520.1037@numbat.sonytel.be>
References: <9e47339105081020216574ac7e@mail.gmail.com> <42FAE3F8.8080902@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E38Ku-0001lR-1S
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Aug 2005 01:22:48 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E38Kt-0001yD-HC
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Aug 2005 01:22:48 -0700
In-Reply-To: <42FAE3F8.8080902@gmail.com>
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
Cc: Jon Smirl <jonsmirl@gmail.com>

On Thu, 11 Aug 2005, Antonino A. Daplas wrote:
> that all the lengths = 1 and offsets = 0.  Currently, we have no way to
> specifically request for mono01, mono10, or 1-bit pseudocolor. Just check
> for fix->visual afterwards.  

For mono01 or mono10, if the visual is pseudocolor, just set the colormap to
black/white or white/black.

> For directcolor (indexed) vs truecolor, there is currently no way
> to specify which visual you want.  You also have to check for fix->visual
> afterwards.
> 
> One of the reason I also want this sysfs attribute is because in at
> least 1 driver (i810fb), it's possible to choose between truecolor and
> directcolor but it uses a hack by checking for the var->nonstd flag.

So the driver should use directcolor instead of truecolor if the hardware
supports it. The application can always set a linear colormap if it needs
truecolor.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
