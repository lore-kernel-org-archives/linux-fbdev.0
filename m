From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: Text console scrolling
Date: Thu, 19 Jul 2007 20:20:45 +0200
Message-ID: <20070719202045.89106250.krzysztof.h1@wp.pl>
References: <Pine.LNX.4.62.0707181708020.15632@pademelon.sonytel.be>
	<1184774936.4523.64.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBaZo-0006YT-JZ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Jul 2007 11:18:12 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IBaZl-00066e-4X
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Jul 2007 11:18:12 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	19 Jul 2007 20:18:04 +0200
In-Reply-To: <1184774936.4523.64.camel@daplas>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Geert.Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>, "Antonino A. Daplas" <adaplas@gmail.com>

On Thu, 19 Jul 2007 00:08:56 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> On Wed, 2007-07-18 at 17:10 +0200, Geert Uytterhoeven wrote:
> > 	Hi all,
> > 
> > Yesterday, FBINFO_READS_FAST was faster in some cases, but much slower in
> > others, so I didn't really know whether I should enable it or not.
> > 
> > Today, FBINFO_READS_FAST is faster in all test cases, so the choice is clear.
> > 
> 
> The improvement of scroll_move is courtesy of Ondrej's smart blitter
> patch.
[...]
>  
> > Note that there are still a few cases where today's fastest option is a bit
> > slower than yesterday's fastest option.
> > 
> 
> All things equal, the speed of the smart blitter will depend on:
> 
> The less different the contents, the more the smart blitter will speed
> up (because less characters are actually moved). If the contents are
> totally different, then the blitter spends as much time as the old
> (dumb) blitter plus the time spent on the compare. 
> 

My guess is that comparing is relatively fast comparing to preparation of the blit operation.  
One of the very first versions of the patch had a variant to merge small blits into bigger ones.
It was done by regarding the first character after difference (string of different character) as different too.
An advantage was fewer blitter operations but the operations got bigger at least by one character.

You may look here (see MERGE_BLITS define):

http://marc.info/?l=linux-fbdev-devel&m=117869435713671&w=2

Some tests result on cards with real blitter:

http://marc.info/?l=linux-fbdev-devel&m=117881573823606&w=2

As you see, merging blits gave speed up on some cards (comparing to current method) despite it had more to compare.
But it was usually lost at higher bpp as amount of data to move grown faster.

I am interested in results of scrolling speeds with merged blits on your hardware.

Regards,
Krzysztof

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
