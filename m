From: Anatolij Gustschin <agust@denx.de>
Subject: Re: Initialize framebuffer in bootloader?
Date: Mon, 25 Aug 2008 10:55:02 +0200
Message-ID: <48B27366.3000408@denx.de>
References: <200808242040.15869@blacky.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KXXr7-0006cc-PN for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 25 Aug 2008 01:55:21 -0700
Received: from mail-out.m-online.net ([212.18.0.9])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KXXr5-0003Ro-4p
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 25 Aug 2008 01:55:21 -0700
In-Reply-To: <200808242040.15869@blacky.localdomain>
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
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hello,

Nikita V. Youshchenko wrote:

> In an embedded system I'm involved in, there is a requirement to get some 
> graphical information displayed very fast (about a second) after poweron, 
> and then keep the picture on screen without blinking etc.
> 
> Since it is virtually impossible to boot the kernel and start the 
> application that fast, we are thinking about initializing display hardware 
> and drawing the picture in bootloader.

We do the same in U-Boot on a couple of embedded boards.

> There is no major problems in adding required code to U-Boot. What looks 
> more difficult s how to smoothly pass display hardware control to linux 
> framebuffer driver, such that "nobody will notice". Since main memory is 
> used for some hardware-accessed data structures and the frame buffer 
> itself, such a trick will likely require some altering of linux memory 
> management, etc
> 
> Before trying to implement all that, I'd like to ask if anyone has done 
> something similar, or maybe could provide some comments or pointers to any 
> related information.

What we do in Linux to inherit the state set by the boot loader is
maybe not very similar as we don't have shared frame buffer. We
prevent graphics hardware reinitialization in the frame buffer
driver if a pre_init flag of the driver's parameters structure was
set before graphics controller init:

#if defined(CONFIG_FB_PRE_INIT_FB)
	par->pre_init = 1;
#endif
	...
	if (!par->pre_init) {
		/* do all the hw init */
	}

Additionally we return in driver's set_par() without accessing any
registers if the pre_init flag was previously set and also use
following patch for VT and fbcon code:

http://git.denx.de/?p=linux-2.6-denx.git;a=commitdiff;h=ff84b47bb7ba0dfe99696ed5f7eee7a98174de9a;hp=25cb836dadabf8605cd83f9288493f9088d83c0f

Best Regards,
Anatolij

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
