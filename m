From: Shivappa Kushtagi <kushtagi@gmail.com>
Subject: Virtual framebuffer driver - mmap problem
Date: Wed, 8 Sep 2004 17:04:15 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <77e82a3f0409080434722d7650@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C50iV-0001e8-98
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 04:34:23 -0700
Received: from rproxy.gmail.com ([64.233.170.195] helo=mproxy.gmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C50iU-0000nK-Lj
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 08 Sep 2004 04:34:23 -0700
Received: by mproxy.gmail.com with SMTP id 74so329185rnl
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Sep 2004 04:34:15 -0700 (PDT)
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

Hi,

I would like to use virtual framebuffer on a linux system which is
installed with R.H.9 to simulate my target display ( an embedded
device with 320*480 resolution).

I have booted the system with VFB enabled. I verified it by checking
the file /proc/fb

# more /proc/fb
0 Virtual FB
1 VESA VGA

Problem :

I have written a application which will mmap /dev/fb0 and fill it with
some RGB values. I run framebuffer based VNC server to see whatever I
have written. I always get a white image. Looks like mmap is mapped to
some other address and fbvnc server is reading from somewhere else.

Does the existing drivers/video/vfb.c code works ? or Do I need to
tweak it ?


Regards
Shivappa


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
