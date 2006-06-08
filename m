From: Dennis Munsie <dmunsie@cecropia.com>
Subject: Re: intelfb updates
Date: Thu, 8 Jun 2006 15:22:06 -0400
Message-ID: <F5D6A59D-BDC3-4C01-BDF3-CB16AFDC9AED@cecropia.com>
References: <21d7e9970605270158l1ee8551cw7cc8910378cc43de@mail.gmail.com>
	<509BC7A5-C965-47C5-BB5F-416EC23D508A@cecropia.com>
	<2E36B04D-0D7E-4D25-B2C7-D3EF201FFB1E@cecropia.com>
	<21d7e9970606070155u5523432ew52ce4e705178711d@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FoQ3F-0001cQ-Fd for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Jun 2006 12:20:17 -0700
Received: from mail4.sea5.speakeasy.net ([69.17.117.6])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FoQ3B-0005RX-2z
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Jun 2006 12:20:14 -0700
In-Reply-To: <21d7e9970606070155u5523432ew52ce4e705178711d@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, "Antonino A. Daplas" <adaplas@gmail.com>

Here is what I found -- I put the 3 different versions of calc_vclock 
() into a test harness.  I used the PLL values that I'm assuming that  
the BIOS set.  Here is the chunk of the test harness that actually  
calls the 3 versions:

     printf("   old clock = %d\n", old_calc_vclock(PLLS_I9xx, 20, 6,  
3, 0, 0, 0));
     printf("before clock = %d\n", CALC_VCLOCK(20, 6, 3, 0, 0));
     printf(" after clock = %d\n", calc_vclock(PLLS_I9xx, 20, 6, 3,  
0, 0, 0));

here is the output of the program:

[gentoo-test:~ (3.715 Mb)]$ ./a.out
    old clock = 0
before clock = 283200
Floating point exception

I tried disabling the call to intelfbhw_print_hw_state() where I  
determined that my crash was occurring, but the kernel continued hang  
(it deadlocked on a spinlock actually, in the fbcon layer).  At this  
point, I broke it down into the separate patches, determined which  
one was causing the problem, and disabled it in my build :)

I also have all of the debugging options turned on -- DEBUG, VERBOSE,  
and REGDUMP.

dennis

On Jun 7, 2006, at 4:55 AM, Dave Airlie wrote:

> Wow, can you give me some numbers from the old/new calc_vclock?
>
> what does it return when it works and when it doesn't work?
>
> I'm unsure what could be different on i945, but I'm sure something  
> could be :-)
