From: Richard Drummond <lists@rcdrummond.net>
Subject: Re: Programmers documetnation on framebuffer console?
Date: Tue, 18 Mar 2003 22:39:58 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200303182237.15811.lists@rcdrummond.net>
References: <3E7725F8.25132.45DF134@localhost>
Reply-To: lists@rcdrummond.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18vUL5-00016F-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Mar 2003 19:34:03 -0800
Received: from sdn-ap-029ilchicp0029.dialsprint.net ([65.178.168.29])
	by falcon.mail.pas.earthlink.net with esmtp (Exim 3.33 #1)
	id 18vUL3-00041g-00
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Mar 2003 19:34:02 -0800
In-Reply-To: <3E7725F8.25132.45DF134@localhost>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Hi Kendal

Since nobody else has replied to you yet, I'll stop lurking and attempt a 
reply. ;-b)

On Tuesday 18 March 2003 16:58, Kendall Bennett wrote:
> Can someone point me at programmer's documentation on how to use the
> framebuffer console subsystem on Linux? I have been to linux-fbdev.org
> and a few other places, but all of the linux to what would appear to be
> useful documentation or libraries are all dead.

There seems to be precious little documentation around on actually how to use 
the fbdev API. Alas, the only real sources of information seem to be the code 
of the projects that actually use fbdev - for example, LibSDL, DirectFB (see 
http://www.directfb.org), and tools such as fbset, fbi, etc. Luckily, the API 
is very simple.

> I need something that
> talks about the ioctl()'s that an application uses to get mode
> information, set modes and use the acceleration functions from the
> framebuffer console driver.

The kernel source code is of course the definitive source of info here. Look 
in drivers/video/fbmem.c to see the ioctl()s that fbdev supports. As far as 
acceleration goes, this is useable only from the kernel space and is designed 
for accelerating text consoles (the accelerated functions are called by 
various functions in drivers/video/fbcon.c).

Cheers,
Rich




-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
