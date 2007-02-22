From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: enquiry about 4 bpp frame buffer with
 nibbles swapped
Date: Thu, 22 Feb 2007 09:08:02 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0702220906410.32271@pademelon.sonytel.be>
References: <20070220121156.41538.qmail@web51601.mail.yahoo.com>
	<Pine.LNX.4.62.0702210832300.7944@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702212148500.20620@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK8zs-0008WM-Ot for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 00:08:13 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK8zr-00082A-Af
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 00:08:12 -0800
In-Reply-To: <Pine.LNX.4.64.0702212148500.20620@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Aitor Garcia <carrierphasejitter@yahoo.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 21 Feb 2007, James Simmons wrote:
> > > But I do not know where to do it. 
> > > Frame Buffer has 3 functions cfb_fillrect,
> > > cfb_copyarea and cfb_imageblit which I thought were
> > > the key to solve my problems but Qtopia Core does not
> > > make use
> > > of them.  
> > 
> > Indeed, cfb_{fillrect,copyarea,imageblit}() are used by the kernel only.
> 
> Speaking of. Are you using fbcon? If that is the case then your console 
> should look messed up.
>  
> > > imxfb_map_video_memory function or fb_mmap, seem to be
> > > good candidates but I do not know how to progress
> > > further.
> > 
> > If the order of the nibbles can be configured in hardware, you should do that.
> > Else I'm afraid you will have to modify Qtopia Core.
> 
> Can fb_bitfield handle that case ?

No, it only handles bits within a pixel. It doesn't handle the order of
pixels within a byte (or word).

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
