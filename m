From: Shivappa Kushtagi <kushtagi@gmail.com>
Subject: Re: Virtual framebuffer driver - mmap problem
Date: Wed, 8 Sep 2004 19:21:03 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <77e82a3f0409080651732d891e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C52qn-0003Ey-AS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 06:51:05 -0700
Received: from rproxy.gmail.com ([64.233.170.193] helo=mproxy.gmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C52qm-0005GW-7R
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 06:51:04 -0700
Received: by mproxy.gmail.com with SMTP id 74so337040rnl
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Sep 2004 06:51:03 -0700 (PDT)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

> I would like to use virtual framebuffer on a linux system which is
> installed with R.H.9 to simulate my target display ( an embedded
> device with 320*480 resolution).

== The virtual framebuffer is intended for testing _the kernel_ only.

> I have written a application which will mmap /dev/fb0 and fill it with
> some RGB values. I run framebuffer based VNC server to see whatever I
> have written. I always get a white image. Looks like mmap is mapped to
> some other address and fbvnc server is reading from somewhere else.
>
> Does the existing drivers/video/vfb.c code works ? or Do I need to
> tweak it ?

== You cannot mmap() the video memory of vfb.

==  Why don"t you use vesafb?

As I had mentioned in my earlier post, I wanted to use virtual
framebuffer to simulate the display of my target device (say some PDA
with size 320*480 ).  With vesafb, I will not be able to change the
resolution ( fbset fails telling,  invalid argument )


Is there any other framebuffer based methods to simulate a display ?

Regards
Shivappa


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
