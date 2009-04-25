From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Framebuffer using system memory
Date: Sat, 25 Apr 2009 09:45:32 +0200
Message-ID: <10f740e80904250045u1e617c9v2d49f30fce1cf40@mail.gmail.com>
References: <49F263D0.4030108@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1LxcZr-0004S7-LJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 25 Apr 2009 07:45:35 +0000
Received: from ey-out-1920.google.com ([74.125.78.148])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LxcZq-0007Kq-Ef for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 25 Apr 2009 07:45:35 +0000
Received: by ey-out-1920.google.com with SMTP id 13so271100eye.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 25 Apr 2009 00:45:32 -0700 (PDT)
In-Reply-To: <49F263D0.4030108@manoweb.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Alessio Sangalli <alesan@manoweb.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

On Sat, Apr 25, 2009 at 03:13, Alessio Sangalli <alesan@manoweb.com> wrote:
> Hi I am working on a framebuffer that uses the system memory.
>
> What I mean here is that I need to pass mem=120M to a system that has
> 128MB to "reserve" 8MB of memory for the framebuffer; then I program the
> hardware to use that region of memory.
>
> The reason I do this is that it seems impossible to kmalloc more that
> 4MB of contiguos physical memory with the Linux Kernel.
>
> Bottom line, I do not know how to map those 8MB back to userspace. If
> userspace opens mmaps /dev/mem and writes to the appropriate location it
> can access the fb perfectly.
>
> Any hints? All of this is on ARM9.

Alternatively, you could use__alloc_bootmem() in the early platform
code to reserve
the memory, cfr. arch/powerpc/platforms/ps3/setup.c

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

------------------------------------------------------------------------------
Crystal Reports &#45; New Free Runtime and 30 Day Trial
Check out the new simplified licensign option that enables unlimited
royalty&#45;free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
