From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: newbie: fb specs and indirect VRAM access
Date: Thu, 21 Aug 2008 14:54:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808211453330.31396@anakin>
References: <47858.200.178.190.130.1219177894.squirrel@mail2.icmc.usp.br>
	<34825.200.178.190.130.1219322627.squirrel@mail2.icmc.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KW9gJ-0008I7-O3 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Aug 2008 05:54:27 -0700
Received: from monty.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KW9gH-0002Jy-3x
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Aug 2008 05:54:27 -0700
In-Reply-To: <34825.200.178.190.130.1219322627.squirrel@mail2.icmc.usp.br>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jorge Marques Pelizzoni <jpeliz@icmc.usp.br>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 21 Aug 2008, Jorge Marques Pelizzoni wrote:
> A few days ago I sent the message below asking about framebuffer device
> documentation and explaining my specific situation. Nobody aswered and I
> wonder why. If those are not questions for this list, can someone please
> redirect me to the right forum?

I had hoped somebody else would find time to respond ;-)

> Jorge Marques Pelizzoni escreveu:
> > I am considering implementing a frame buffer device for a mobile platform
> > (LPC2400 on uCLinux) that, as far as I can tell, seems to lack one. Well,
> > I am a newbie to all things frame buffer-related (though familiar with
> > kernel/device module implementation) and would most appreciate it if you
> > could answer the following questions:
> >
> > 1 - are there documents specifying frame buffer devices and how
> > applications are expected to handle them (in short, their API)?

linux/Documentation/fb/framebuffer.txt
linux/include/linux/fb.h

> > 2 - my CPU cannot address "real" VRAM directly, all control being carried
> > out by means of a parallel interface. I gathered that an fb user is
> > expected to write to (virtual) VRAM directly via a pointer provided by the
> > driver and never notifies the driver of changes. Have you seen such a
> > set-up before and do you think these requirements can be reconciled? The
> > only way round this I can currently see is making the driver periodically
> > check the virtual VRAM for changes and transmit only changed parts. All in
> > all, a costly operation, as everything must be carried out by the same
> > CPU. Could whatever is used to implement mmap be called into play (without
> > whatever is used to implement msync)?

linux/Documentation/fb/deferred_io.txt

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
