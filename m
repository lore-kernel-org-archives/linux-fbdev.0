From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Tile Blitting
Date: Sun, 2 Mar 2003 13:14:59 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303021312400.9181-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0302271946340.8243-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18pSP6-0005fe-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 02 Mar 2003 04:17:17 -0800
In-Reply-To: <Pine.LNX.4.44.0302271946340.8243-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 27 Feb 2003, James Simmons wrote:
> > On Don, 2003-02-27 at 15:15, Antonino Daplas wrote: 
> > > On Thu, 2003-02-27 at 09:18, James Simmons wrote:
> > >  
> > > > > Thus, the restriction that the buffer must be completely copied by the
> > > > > driver before returning.  And because of this restriction, an extra copy
> > > > > which might be unnecessary cannot be avoided (this was noted by Petr).
> > > > > 
> > > > > Treating the buffer as a ringbuffer, we eliminate these restrictions.
> > > > 
> > > > I didn't realize that the below was a ringbuffer implementation. The name
> > > > threw me off. 
> > > 
> > > Well, it's not strictly a ringbuffer implementation.  This would require
> > > a head and tail pointer where fbcon will adjust the tail and the
> > > driver/hardware will adjust the head.  This will be very difficult to
> > > implement in a device independent manner.  So we just cheat by issuing
> > > an fb_sync() per loop to flush all pending commands.
> > 
> > That still seems suboptimal though. What the DRM often does is have the
> > chip write an age value to a scratch register when it's done processing
> > something. Maybe something like that could be used to avoid waiting for
> > the chip to go idle at all?
> 
> Don't waste your time. I'm removing all the changes that have been done 
> since 2.5.51. After that I will no longer be co-maintainter of the 
> framebuffer layer. 

Are you sure about that?!?!?

What about adding a pointer to a

    struct con_ops {
      set_font();
      putc();
      putcs();
    } 
    
to struct fb_info as an interim solution, until tile blitting has matured? That
would make Petr (matroxfb) and Davem (sbusfb) happy?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
