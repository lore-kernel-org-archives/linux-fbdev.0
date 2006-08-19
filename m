From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: ##3 Frame Buffer Questions?
Date: Sat, 19 Aug 2006 17:44:39 +0800
Message-ID: <1155980680.10015.3.camel@daplas.org>
References: <015101c6c339$41a607b0$6400a8c0@fleballnchain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GENOE-0004DN-BL for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 19 Aug 2006 02:45:14 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GENOC-0005VO-LI
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 19 Aug 2006 02:45:14 -0700
Received: by py-out-1112.google.com with SMTP id x31so1435000pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 19 Aug 2006 02:45:09 -0700 (PDT)
In-Reply-To: <015101c6c339$41a607b0$6400a8c0@fleballnchain>
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
To: steve@flconsult.com, linux-fbdev-devel@lists.sourceforge.net

On Fri, 2006-08-18 at 22:43 -0400, Steve Spano wrote:
> Hi Antonino,
> 
> We got the buffer working and showing now in the proc folder
> 
> So we can now do a cat random > fb0 - and that works.
> 
> Do you (or someone) know the correct pattern of magic #defines that will
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
