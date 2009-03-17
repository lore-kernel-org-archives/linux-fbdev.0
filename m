From: Dave Airlie <airlied@gmail.com>
Subject: Re: fbdev intel with kernel modesetting
Date: Tue, 17 Mar 2009 20:58:11 +1000
Message-ID: <21d7e9970903170358x5482218ep695cdffa586fa806@mail.gmail.com>
References: <A71FB3B26F3F479BA375A7FA660E5E0F@avitech.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <airlied@gmail.com>) id 1LjWzz-0007zf-5k
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Mar 2009 10:58:19 +0000
Received: from rv-out-0708.google.com ([209.85.198.240])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LjWzr-0008GF-QX for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Mar 2009 10:58:14 +0000
Received: by rv-out-0708.google.com with SMTP id k29so1746282rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 17 Mar 2009 03:58:11 -0700 (PDT)
In-Reply-To: <A71FB3B26F3F479BA375A7FA660E5E0F@avitech.sk>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Peter Hanzel <hanzelpeter@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, Feb 27, 2009 at 9:13 PM, Peter Hanzel <hanzelpeter@gmail.com> wrote:
> Hello.
>
> I have a question. I am using intelfb to get framebuffer console on Acer
> Extensa 5220 notebeook. (VGA Intel 965GM)
> In kernel 2.6.28.7 i must set video mode on boot with vga= param.
> Now I have discovered that in 2.6.29 kernel, there is support for kernel
> modesetting with gpu/drm/i915.
>
> Will this be joined with driver/video/intelfb ?

Not joined, hopefully driver/video/intelfb will die.

> So mode switch will work with simple fbdev IOCTL.?
> Like some cooperation between fbdev and gpu/drm?

The problem with simple ioctl is its simple, it can't express what
graphics cards actually look like.

At the moment fbset isn't hooked up, but it should be trivial to add
the code to do it,
we haven't hooked it up as there is no right answer for dual-head
displays using fbdev on top of drm,

Granted if someone was to implement something we'd probably go with it.

Dave.

>
> Thanks.
>
>
> ------------------------------------------------------------------------------
> Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
> -OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
> -Strategies to boost innovation and cut costs with open source participation
> -Receive a $600 discount off the registration fee with the source code: SFAD
> http://p.sf.net/sfu/XcvMzF8H
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>

------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
