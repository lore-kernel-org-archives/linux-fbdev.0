From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: mono, gray and index configs
Date: Mon, 22 Aug 2005 19:19:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508221918080.24432@numbat.sonytel.be>
References: <9e47339105081020216574ac7e@mail.gmail.com> 
 <Pine.LNX.4.62.0508111020520.1037@numbat.sonytel.be> 
 <b00ca3bd05081104086fa9e639@mail.gmail.com>  <Pine.LNX.4.62.0508111344070.1037@numbat.sonytel.be>
  <42FB8C29.4070503@gmail.com> <43069BE0.80604@gmail.com> 
 <9e473391050819200950020d7@mail.gmail.com>  <Pine.LNX.4.62.0508221203410.24432@numbat.sonytel.be>
  <8a0c3678050822063073c3f4f6@mail.gmail.com>  <Pine.LNX.4.62.0508221602040.24432@numbat.sonytel.be>
 <8a0c36780508220736662c8d18@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E7Fy6-0005uj-TM
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Aug 2005 10:20:18 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E7Fy4-0005Uy-AB
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Aug 2005 10:20:18 -0700
In-Reply-To: <8a0c36780508220736662c8d18@mail.gmail.com>
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
> > No, you cut the following line:
> > 
> > | var.activate |= FB_ACTIVATE_TEST;
> 
> Sorry. I was shorting and I went too far.
> 
> > which will cause the driver to check whether the mode is valid (or can be made
> > valid by rounding up).
> 
> Ah well that sounds more like was thinking of.  Is FB_ACTIVATE_TEST
> new from 2.4 -> 2.6?

It's been there from the beginning (i.e. from 1994). In fact very little was
changed in the public (userspace) fbdev interface since then :-)

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
