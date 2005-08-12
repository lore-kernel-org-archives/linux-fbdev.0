From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: mono, gray and index configs
Date: Fri, 12 Aug 2005 09:24:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508120923170.18366@numbat.sonytel.be>
References: <9e47339105081020216574ac7e@mail.gmail.com> <42FAE3F8.8080902@gmail.com>
 <Pine.LNX.4.62.0508111020520.1037@numbat.sonytel.be>
 <b00ca3bd05081104086fa9e639@mail.gmail.com> <Pine.LNX.4.62.0508111344070.1037@numbat.sonytel.be>
 <42FB8C29.4070503@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3TuE-0005gX-B1
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Aug 2005 00:24:42 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E3TuC-0007t4-G3
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Aug 2005 00:24:42 -0700
In-Reply-To: <42FB8C29.4070503@gmail.com>
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
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@gmail.com>

On Fri, 12 Aug 2005, Antonino A. Daplas wrote:
> Geert Uytterhoeven wrote:
> > On Thu, 11 Aug 2005, Antonino Daplas wrote:
> > > (Depending on how correct I am with the interpretation, there might be
> > > some bugs in fbdev on how it determines the color depth. No one is
> > > complaining yet though, so greater than 1-bit monochrome is probably
> > > rare if not nonexistent.)
> > 
> > There definitely are bugs w.r.t. this, especially in the 2.4 logo code ;-)
> > 
> 
> Yes, I would agree.  Do you know of any outstanding bugs on color handling
> in 2.6 code, especially for hardware with bitdepths < 8? I would like to
> fix them.

Unfortunately not. Due to personel reasons, I temporarily don't have much
time left to do real coding.

You can always try vgafb's 16 color mode and check for yourself.

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
