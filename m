From: "Julien Lebot" <lesnip3r@hotmail.com>
Subject: Re: PXA270 framebuffer
Date: Sat, 09 Jun 2007 11:04:37 +0400
Message-ID: <BAY112-F211E87F7C17589542D03D183240@phx.gbl>
References: <1181224333.4502.20.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hwv0A-0001uG-H6 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Jun 2007 00:04:46 -0700
Received: from bay0-omc2-s13.bay0.hotmail.com ([65.54.246.149])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hwv09-0002aG-5F
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Jun 2007 00:04:46 -0700
In-Reply-To: <1181224333.4502.20.camel@daplas>
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
To: adaplas@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net

Hello,
sorry for the delayed answer :)
I sent an email to the mailing list before, not sure if it worked since I 
did not get the mail back. Anyways please discard the previous one :)

>You may want to look at arcfb.c.  If you look at it's copyarea, fillrect
>and imageblit functions, they use the generic drawing functions, then
>immediately followed by an arcfb_lcd_update(). That's where the contents
>of the framebuffer is transferred to the internal memory of the LCD.
>
>The same is done for arcfb_write().
>
>(You may want to do this step first.)
>
>The above method make the framebuffer console work. Writing to /dev/fb0
>will also work (cat "file" > /dev/fb0).

This driver is interesting I understand a bit more the general steps I have 
to do.

>However, for applications that
>uses mmap(), such as X, it will not work.  You have to do some VM magic
>to make mmap() function for your driver. For this functionality, look at
>hecubafb.c driver and fb_defio.c. hecubafb.c and fb_defio.c is new for
>2.6.21.
>
>(This is the second step to make your smart lcd fully functional.)

Yes and also I would like to use the hardware framebuffer capability of 
driving my smart panel (no more bit-banging). Is there any examples / 
explanations of how I can do a DMA to the framebuffer channel 6 (the one I 
have to send the commands to) and set up properly the registers ?
The LDD stated that this is the easiest part to mess up, which I would like 
to avoid :p

>Tony

Thanks for your answers,
Julien

_________________________________________________________________
MSN Messenger : discutez en direct avec vos amis ! 
http://www.msn.fr/msger/default.asp


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
