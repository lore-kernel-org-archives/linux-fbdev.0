From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Dynamic switch from Console on ttyS0 to
 fbcon
Date: Wed, 20 Aug 2008 08:51:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808200850330.383@anakin>
References: <8c675e9b0808192118g598fc380kf3cb3aa22cf969c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVhXd-0002QK-WC for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 23:51:38 -0700
Received: from monty.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KVhXc-00083L-KR
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 23:51:38 -0700
In-Reply-To: <8c675e9b0808192118g598fc380kf3cb3aa22cf969c8@mail.gmail.com>
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
To: Amol Lad <amol.lad@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 20 Aug 2008, Amol Lad wrote:
> I'm trying to switch the console from ttyS0 to frame buffer. This is
> achieved using fbcon; you can either link it statically in kernel or
> "modprobe fbcon" (Documentation/fb/fbcon.txt)
> 
> The problem is if "console=ttyS0,115200n8" is passed on u-boot command
> line then the console switch to framebuffer does not happen after
> doing modprobe fbcon.
> 
> If "console=ttyS0,115200n8" argument is not passed on u-boot then the
> console switch happens after modprobe fbcon.
> 
> Any ideas why switch does not happen when "console=" argument is
> passed to the kernel ? (In my application, I need to switch the
> console dynamically to framebuffer from ttyS0. This decision cannot be
> done in u-boot so u-boot will pass "console=ttyS0,115200n8" argument)

Have you tried

    console=ttyS0,115200n8 console=tty0

? This will make console output go to both, and console input will come
from tty0.

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
