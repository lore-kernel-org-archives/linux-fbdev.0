From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Feature Freeze?
Date: Wed, 5 Mar 2003 10:57:45 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303051055250.23176-100000@vervain.sonytel.be>
References: <1046852721.1228.13.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qVfJ-00063k-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 01:58:21 -0800
In-Reply-To: <1046852721.1228.13.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 5 Mar 2003, Antonino Daplas wrote:
> I believe it's time to finalize what is needed/not needed for the
> framebuffer framework:

> 1. Text mode support?

Required by at least davem and petr

> 2. console resizing using fbset (besides stty)?

Nice, if it's not too much work.

> 3. support for unloading of fbcon if modular?
> 4. driver specified placement of buffers - for putcs method?
> 5. flexible logo placement/overlayed logo?
> 6. generic console display rotation?

Low priority, IMHO.

> 7. Anything else?

0. Update all drivers

Absolutely required

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
