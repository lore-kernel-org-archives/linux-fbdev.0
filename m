From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: 2.5.70 - Blank Screen with VESA VGA Framebuffer
Date: Fri, 13 Jun 2003 10:06:38 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0306131005450.11468-100000@vervain.sonytel.be>
References: <0BCBFEACE44CF0469CF5EBF7F6B612531E5E35@chn-snr-msg.wipro.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19QjbH-0005cB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 Jun 2003 01:07:56 -0700
In-Reply-To: <0BCBFEACE44CF0469CF5EBF7F6B612531E5E35@chn-snr-msg.wipro.com>
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
To: Parag Warudkar <parag.warudkar@wipro.com>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 13 Jun 2003, Parag Warudkar wrote:
> Thanx for your reply. I have attached my config file. I have tried all
> possible configurations (desparation ;) but it hasn't worked so far. 
> (Same problem sometimes white screen (atyfb) and sometimes blank
> (vga=788)).
> If you need more info or want me to try out something, please let me
> know.

Does atyfb in 2.4.20 work for you? You may have the Mobility M1 that doesn't
work (yet) with atyfb, but we're getting closer...

> -----Original Message-----
> From:   James Simmons [mailto:jsimmons@infradead.org]
> Sent:   Fri 6/13/2003 00:27
> To:     Parag Warudkar
> Cc:     linux-fbdev-devel@lists.sourceforge.net
> Subject:        Re: [Linux-fbdev-devel] 2.5.70 - Blank Screen with VESA
> VGA Framebuffer
> 
> 
> > I have a Sony VAIO laptop with ATI Mobility M1 AGP chip. I can use
> > XFree86 on 2.4.x if I enable VESA VGA Frame buffer and enable vga=788
> on
> > kernel command line. With Kernel 2.5.70 after enabling VESA VGA
> > Framebuffer console and specifying vga= commandline, I just get a blank
> > screen just after the boot process starts and X doesn't work. (Garbled
> > screen). Without the vga= commandline, I get normal boot screen but X
> > needs the vga= option and doesn't work.
> >
> > I have tried everything but to no avail. Does anyone know what do I
> need
> > to do in order to get kernel 2.5.X working with Framebuffer console
> > (VESA VGA or atyfb) and vga=788? I tried video=atyfb but that too
> > doesn't work..
> 
> What does your config file look like. Did you enable both Framebuffer
> support and framebuffer console support?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
