From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Suggestions req for new fb driver
Date: Thu, 15 Jun 2006 10:38:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0606151037450.19321@pademelon.sonytel.be>
References: <0ab101c69042$ed73d330$f301a8c0@procsys>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqnNA-0000T5-7f for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Jun 2006 01:38:40 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FqnN0-0001OT-O2
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Jun 2006 01:38:40 -0700
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k5F8cKCQ025025
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 15 Jun 2006 10:38:20 +0200 (MEST)
In-Reply-To: <0ab101c69042$ed73d330$f301a8c0@procsys>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 15 Jun 2006, ankur maheshwari wrote:
> I am a newbie for framebuffer and trying to write framebuffer driver for lancelot vga controller, currently it is used only with Altera Nios (No MMU, softcore) kind of architecture.
> 
> Lancelot ip core provides multi display layers (five layers) functionality, i.e. layer0 we can use for background, layer1 we can use for video, layer2 we can use for text ........
> 
> I need some suggestions in design of frame buffer driver, as we have five display layer functionality in lancelot controller do I need to write five separate framebuffer driver for each layer, or I can take 5 different fb_info and work around with it.
> 
> To my understanding taking 5 fb_info will create fb0 fb1 fb2 fb3 fb4 nodes and graphic library (not decided yet, which one to use) will drive each frame buffer separately. 
> Can some one suggest that my understanding is correct with respect to driving multi display layer, Is there any other way I can handle multi display layer, is there any already existing driver example for same functionality ???

Having 5 fb_info's is indeed the simplest solution.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
