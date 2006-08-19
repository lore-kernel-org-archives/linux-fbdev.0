From: "Steve Spano" <steve@flconsult.com>
Subject: Re: ##3 Frame Buffer Questions?
Date: Sat, 19 Aug 2006 15:46:51 -0400
Message-ID: <016c01c6c3c8$422dc850$6400a8c0@fleballnchain>
References: <1155980680.10015.3.camel@daplas.org>
Reply-To: steve@flconsult.com,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GEWo6-0007RU-HD for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 19 Aug 2006 12:48:34 -0700
Received: from mail.danica.com ([205.232.74.72] helo=danicacomputing.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GEWo4-0006m5-Oh
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 19 Aug 2006 12:48:34 -0700
Received: from fleballnchain (cpe-24-59-110-67.twcny.res.rr.com [24.59.110.67])
	by danicacomputing.com (mail2.danicacomputing.com)
	(MDaemon PRO v9.0.4) with ESMTP id md50001163215.msg
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 19 Aug 2006 15:47:24 -0400
In-Reply-To: <1155980680.10015.3.camel@daplas.org>
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
To: "'Antonino A. Daplas'" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

Hi There

Thanks again for the help - very much appreciated.

Still not seeing the terminal on the display.

We have linux running in a FPGA. The FPGA has a vga-ish hardware core
inside of it. The core transfers 16/32bit pixels from the frame buffer
to the display.

It looked like there were options for a display that had a built in
character generator and there were options for the "VGA console"

Do you (or someone) have an autoconf.h that you could share for a linux
build that properly displays the bash/logins/startup on a VGA display?

Thanks so much!

Steve Spano, President
Finger Lakes Engineering
119 South Cayuga #200
Ithaca, Ny 14850
(V) 607-277-1614 x223
(C) 607-342-1150
www.FL-ENG.com - FLE's Main Website 
www.FLEDEVFORUM.com - FLE's Developer Forum

-----Original Message-----
From: Antonino A. Daplas [mailto:adaplas@gmail.com] 
Sent: Saturday, August 19, 2006 5:45 AM
To: steve@flconsult.com; linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] ##3 Frame Buffer Questions?

On Fri, 2006-08-18 at 22:43 -0400, Steve Spano wrote:
> Hi Antonino,
> 
> We got the buffer working and showing now in the proc folder
> 
> So we can now do a cat random > fb0 - and that works.
> 
> Do you (or someone) know the correct pattern of magic #defines that
will
> put the console up on the VGA? I would like to see the startup
> messages/login prompt on the VGA display.

CONFIG_VT=y;
CONFIG_FRAMEBUFFER=m or y (of course)
CONFIG_FRAMEBUFFER_CONSOLE=y (or CONFIG_FRAMEBUFFER_CONSOLE=m followed
by modprobe fbcon)
CONFIG_FONT_8x16 (or any built-in fonts available).

In your boot parameters, include console=tty0, just to be sure.

Tony







-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
