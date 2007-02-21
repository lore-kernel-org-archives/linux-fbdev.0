From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: enquiry about 4 bpp frame buffer with
 nibbles swapped
Date: Wed, 21 Feb 2007 08:34:44 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0702210832300.7944@pademelon.sonytel.be>
References: <20070220121156.41538.qmail@web51601.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJm0A-00004r-4s for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Feb 2007 23:34:58 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HJm09-0003zk-Oe
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Feb 2007 23:34:58 -0800
In-Reply-To: <20070220121156.41538.qmail@web51601.mail.yahoo.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Aitor Garcia <carrierphasejitter@yahoo.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 20 Feb 2007, Aitor Garcia wrote:
> I am trying to design a 4 bpp FB driver for iMX1 using
> imxfb.c code as 
> an starting point.
> The problem that I have found is that MX1 video memory
> is organised as
> follows:
> 
> b7 b6 b5 b4  --> pixel 0.
> b3 b2 b1 b0  --> pixel 1.
> 
> The software that I'm using to display things (Qtopia
> Core) assumes a 
> different scheme of memory to pixel mapping:
> 
> b7 b6 b5 b4 ---> pixel 1.
> b3 b2 b1 b0 ---> pixel 0.
> 
> The solution to overcome this problem is apparently
> easy:
> 
> #define SWAP_NIBBLES(in,out) (out=((in&0xf)<<4) |
> ((in&0xf0)>>4) |\
>                                   ((in&0xf00)<<4) |
> ((in&0xf000)>>4) |\
> 		                  ((in&0xf0000)<<4) |
> ((in&0xf00000)>>4) |\
> 		                  ((in&0xf000000)<<4) |
> ((in&0xf0000000)>>4))
> 
> But I do not know where to do it. 
> Frame Buffer has 3 functions cfb_fillrect,
> cfb_copyarea and cfb_imageblit which I thought were
> the key to solve my problems but Qtopia Core does not
> make use
> of them.  

Indeed, cfb_{fillrect,copyarea,imageblit}() are used by the kernel only.

> imxfb_map_video_memory function or fb_mmap, seem to be
> good candidates but I do not know how to progress
> further.

If the order of the nibbles can be configured in hardware, you should do that.
Else I'm afraid you will have to modify Qtopia Core.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
