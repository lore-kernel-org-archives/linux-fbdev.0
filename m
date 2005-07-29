From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH] fbdev: colormap fixes
Date: Fri, 29 Jul 2005 09:43:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0507290942080.5163@numbat.sonytel.be>
References: <200507280031.j6S0V3L3016861@hera.kernel.org> <42E8F0CD.6070500@gmail.com>
 <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
 <9e473391050728092936794718@mail.gmail.com> <9e47339105072811183ac0f008@mail.gmail.com>
 <Pine.LNX.4.62.0507282202450.29876@numbat.sonytel.be>
 <9e4733910507281315419c3c12@mail.gmail.com> <9e47339105072813213db7cee4@mail.gmail.com>
 <9e47339105072813507c00687e@mail.gmail.com> <Pine.LNX.4.62.0507282337410.29876@numbat.sonytel.be>
 <9e47339105072814505b6fe4f8@mail.gmail.com> <42E95C05.7@pol.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyPWx-00084h-Jg
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 00:43:43 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyPWx-0003BC-72
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 00:43:43 -0700
In-Reply-To: <42E95C05.7@pol.net>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Fri, 29 Jul 2005, Antonino A. Daplas wrote:
> Jon Smirl wrote:
> > On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, 28 Jul 2005, Jon Smirl wrote:
> > > > I've verified now that all ATI R300+ chips have 10bit cmaps. These are
> > > > pretty common so I'd be in favor of making this into a binary
> > > > attribute where I can get/set the whole table at once. Given that
> > > > OpenGL is already supporting 12 and 16 bits these tables are only
> > > > going to get much larger.
> > > > 
> > > > 1024 entries * 5 fields * 2 bytes = 10KB -- too big for a text
> > > > attribute.
> > > > 
> > > > 65536 entries * 5 fields * 2 bytes = 655KB -- way too big for a text
> > > > attribute.
> > > > 
> > > > The bits_per_pixel sysfs attribute is an easy way to tell how many
> > > > entries you need. You can just set it at 4, 8, 10, etc until you get
> > > > an error. Now you know the max. 2^n and you know how many entries.
> > > No, bits_per_pixel can be (much) larger than the color map size. E.g. a
> > > simple
> > > ARGB8888 directcolor mode has bits_per_pixel = 32 and color map size =
> > > 256.
> > 
> > So I have the bits_per_pixel attribute wrong in sysfs. It needs to be
> > bits_per_color and then let the driver sort it out.  Otherwise there
> > is no way to set ARGB8888 versus ARGB2101010. With bits per color you
> > would set 8 or 10.
> 
> No, you have to add another attribute for {transp|red|green|blue}.{len,offset}
> and another attribute for the pixelformat. Then using those, one can
> easily deduce the cmap size.

Indeed. One bits_per_color cannot handle e.g. RGB565 (or RGBA{10,10,10,2} :-).

> > If that isn't good enough I can switch the attribute to take strings
> > like ARGB8888.
> > 
> 
> Please no.

Ack.

> > What do you think, should I just switch to fbconfig names and a binary
> > cmap attribute?
> 
> Does a binary attribute not have the same buffer size limitation as
> the text attribute?  I really don't know, just asking.

Yes it has, but since binary data is more compact, you can fit more data in
PAGE_SIZE.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
