From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: mono, gray and index configs
Date: Mon, 22 Aug 2005 16:06:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508221602040.24432@numbat.sonytel.be>
References: <9e47339105081020216574ac7e@mail.gmail.com> <42FAE3F8.8080902@gmail.com>
 <Pine.LNX.4.62.0508111020520.1037@numbat.sonytel.be>
 <b00ca3bd05081104086fa9e639@mail.gmail.com> <Pine.LNX.4.62.0508111344070.1037@numbat.sonytel.be>
 <42FB8C29.4070503@gmail.com><43069BE0.80604@gmail.com>
 <9e473391050819200950020d7@mail.gmail.com> <Pine.LNX.4.62.0508221203410.24432@numbat.sonytel.be>
 <8a0c3678050822063073c3f4f6@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E7CxA-0004tP-BZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Aug 2005 07:07:08 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E7Cx4-0005O8-27
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Aug 2005 07:07:08 -0700
In-Reply-To: <8a0c3678050822063073c3f4f6@mail.gmail.com>
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
Cc: Jon Smirl <jonsmirl@gmail.com>, "Antonino A. Daplas" <adaplas@gmail.com>

On Mon, 22 Aug 2005, Richard Smith wrote:
> > > This adds an optional function to each driver that advertises what
> > > configs it offers.
> > 
> > Do we really need this?
> > 
> > You can easily write a `probe loop' to find out about all supported configs for
> > a driver like this:
> > 
> >     for_all_possible_configs(config) {
> >         struct fb_var_screeninfo var;
> 
> This will actually try to set the mode right?

No, you cut the following line:

| var.activate |= FB_ACTIVATE_TEST;

which will cause the driver to check whether the mode is valid (or can be made
valid by rounding up).

> SDL does it this way and its caused me some pain dealing with
> framebuffers on hardware that has issues with certain modes.  Its also
> a good bit slower for the app to startup while the code crunches out
> the pll settings.
> 
> >From a users perspective I think advertising valid modes is a good thing.

Except that on most hardware the list of valid modes is _very_ large...
How many combinations of resolution, color depth, and timings do you think you
can have? I guess the complete list can easily fill up all your RAM...

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
