From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: bugs!
Date: Fri, 14 May 2004 01:30:36 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200405140130.36852.lucasvr@gobolinux.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOUKr-00035n-0y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 21:30:13 -0700
Received: from ibague.terra.com.br ([200.154.55.225])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOUKq-0001Ud-JG
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 21:30:12 -0700
Received: from merida.terra.com.br (merida.terra.com.br [200.154.55.132])
	by ibague.terra.com.br (Postfix) with ESMTP id D4CC2EC197
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 May 2004 01:30:04 -0300 (BRT)
Received: from ummagumma.ozzmosis.net (200-203-051-117.nhoce7002.dsl.brasiltelecom.net.br [200.203.51.117])
	(authenticated user lucasvr)
	by merida.terra.com.br (Postfix) with ESMTP id A5CFB3C023
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 May 2004 01:30:04 -0300 (BRT)
Content-Disposition: inline
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Hi!

I'm almost finished with my driver for the monochromatic ST7565 LCD, but I'm 
dealing with a bug that I could't solve by the entire day.

It was designed to be run as a module, and it's living together with another 
display that already owns the console devices. So, when I load st7565's 
module, it just skips take_over_console() code in fbmem.c and starts to 
accept write()'s on it.

By the way, I got some demo applications from MicroWindows (microwindows.org) 
that starts to get more information from the driver. It looks like when they 
request st7565_set_cmap(), some invalid pointer is accessed and the driver 
just dies:

Unhandled fault: external abort on non-linefetch (0x00a) at 0x4001a004
pgd = c3d78000
*pgd = 0bcaf001, *pmd = 0bcaf001, *pte = c4a5e0b3, *ppte = c4a5eff2

I've looked at other drivers' routines, such as hgafb, and it really looks to 
be everything on the right place. I got the impression that this error could 
be happening due to the fact that my driver didn't get the console's 
ownership, so I've disabled the other driver and compiled st7565 built-in, 
but then the driver dies with the same message at take_over_console().

Does anyone know if hgafb is a working driver that I could rely on? Also I got 
confused by the need to use or not a color pallete -- probably I don't need, 
as I'm working only with black/white, but at this time I'm no more sure about 
anything at all :-)

I'm also confused about the "setcolreg()" function passed to fb_get_cmap(). 
What should it do? What's the meaning of its 1st parameter, "regno"?

If someone could take a time to give a quick look on my set_cmap() routine, 
I've uploaded the code here:

http://cscience.org/~lucasvr/etc/st7565.c

Thanks in advance, any help will be very appreciated!
Lucas


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
