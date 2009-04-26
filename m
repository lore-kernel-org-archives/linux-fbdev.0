From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Framebuffer using system memory
Date: Sun, 26 Apr 2009 20:03:58 +0200
Message-ID: <10f740e80904261103t4bf54f13g47da6eea077c83c2@mail.gmail.com>
References: <49F263D0.4030108@manoweb.com>
	<10f740e80904250045u1e617c9v2d49f30fce1cf40@mail.gmail.com>
	<49F35FA6.9020904@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1Ly8i3-0002Cw-1c
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Apr 2009 18:04:11 +0000
Received: from mail-ew0-f217.google.com ([209.85.219.217])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ly8hs-0004e0-OA for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Apr 2009 18:04:11 +0000
Received: by ewy17 with SMTP id 17so1808336ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 26 Apr 2009 11:03:58 -0700 (PDT)
In-Reply-To: <49F35FA6.9020904@manoweb.com>
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

On Sat, Apr 25, 2009 at 21:08, Alessio Sangalli <alesan@manoweb.com> wrote:
> Geert Uytterhoeven wrote:
>
>> Alternatively, you could use__alloc_bootmem() in the early platform
>> code to reserve
>> the memory, cfr. arch/powerpc/platforms/ps3/setup.c
>
>
> So the usage patter seems to be:
>
> - I use __alloc_bootmem() to reserve memory
> - I export a structure that contains data about this memory (location
> and size mainly)
> - In the init of my framebuffer driver I use the data in that structure
> to configure the hardware
> - I map that area of memory to userspace when they try to mmap() this fb
> device
>
> Can you comment on this?

That's correct. Note that you don't have to do anything special for mmap()
(i.e. you do not need your own device-specific fb_mmap()), as the default one
should work fine.

If you use a platform device, you can store the memory location and size in the
platform device's platform data.

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
