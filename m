From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [2.6 patch] drivers/video/: misc cleanups
Date: Mon, 22 Nov 2004 22:33:02 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0411222232490.17195@waterleaf.sonytel.be>
References: <20041121153702.GB2829@stusta.de> <200411221055.07693.adaplas@hotpop.com>
 <Pine.GSO.4.61.0411221043040.7323@waterleaf.sonytel.be>
 <200411230446.50784.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWLoG-0000QT-Bt
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 13:33:20 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWLo5-0003A5-4P
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 13:33:20 -0800
In-Reply-To: <200411230446.50784.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Adrian Bunk <bunk@stusta.de>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Tue, 23 Nov 2004, Antonino A. Daplas wrote:
> On Monday 22 November 2004 17:43, Geert Uytterhoeven wrote:
> > On Mon, 22 Nov 2004, Antonino A. Daplas wrote:
> > > On Sunday 21 November 2004 23:58, Adrian Bunk wrote:
> > > > On Sun, Nov 21, 2004 at 04:37:02PM +0100, Adrian Bunk wrote:
> > > > > The patch below does the following cleanups under drivers/video/ :
> > > > > - make some needlessly global code static
> > > > > - the following was needlessly EXPORT_SYMBOL'ed:
> > > > >   - fbcon.c: fb_con
> > > > >   - mdacon.c: fb_blank
> > > > >   - fbmon.c: get_EDID_from_firmware (completely unused)
> > > > >...
> > > >
> > > > I forgot one thing:
> > > >
> > > > Please review my global_mode_option removal in modedb.c .
> > > >
> > > > It was always NULL and I'd say the only usage was wrong (although it
> > > > had no practical effect).
> > >
> > > Should be ok to remove it.  I only see fb_find_mode using it, and as
> > > you've concluded, usage is not very clear.
> > >
> > > BTW: The global_mode_option, previously, is filled up when no driver is
> > > specified in the boot options, such as "video=1024x768@60".  But this was
> > > removed during the fb initialization cleanup.
> >
> > What a pity... It allowed people to not have to care about the name of
> > their graphics driver(s)...
> >
> 
> The absence of the driver name array will make it a bit difficult to differentiate
> between options passed specifically to drivers vs the global mode option.
> 
> We can bring global_mode_option back. Since driver names always have a
> terminating "fb", we can search for the "fb:" substring and if not found,
> then it's a global_mode_option.
> 
> Is that okay?

Sounds fine!

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
