From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fbdraw 0.1 available
Date: Mon, 13 Sep 2004 13:18:49 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0409131318030.21429@waterleaf.sonytel.be>
References: <41426651.2010201@comcast.net> <200409120340.04133.adaplas@hotpop.com>
 <4144EA58.4080900@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6orF-0000OT-Ee
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Sep 2004 04:18:53 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C6orE-0003xq-KR
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Sep 2004 04:18:53 -0700
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i8DBInMp019770
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 13 Sep 2004 13:18:49 +0200 (MEST)
In-Reply-To: <4144EA58.4080900@comcast.net>
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

On Sun, 12 Sep 2004, Zack wrote:
> > 2. Do not directly access framebuffer memory, use:
> > 3. Do not use copy_{to|from}_user when the destination/source is the
> > framebuffer.
> > 4. Do not memset the framebuffer.  You can probably create an equivalent
> > function using fb_read/write.  (Once, we have fb_memset and fb_memcpy, but
> > they're gone in 2.6).
>
> Fixed.
>
> Incidentally I am wondering, with cross-platform compatibility
> in mind I have been coding assuming that fb_{read|write}[wl] must be
> short/long aligned. Is that assumption correct?

Yes, that's the safest.

> I've also added my copyarea routine. At first I tried to make use
> of cfb_copyarea but it proved very buggy in 24bpp.

What about fixing the bugs in the existing code, instead of adding a new
routine that does the same? ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
