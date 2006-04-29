From: Dennis Munsie <dmunsie@cecropia.com>
Subject: Re: [PATCH 2.6.16] Add 1366x768 (WXGA) mode to modedb
Date: Fri, 28 Apr 2006 21:31:07 -0400
Message-ID: <D34BD406-8A9A-41B4-BF3F-C1FD4095B91C@cecropia.com>
References: <B3DB462A-3D86-4803-AC99-52C8F94541F3@cecropia.com> <4452ADD2.6040002@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZeIm-000807-5V
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 18:31:16 -0700
Received: from mail3.sea5.speakeasy.net ([69.17.117.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FZeIm-0005aR-0z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Apr 2006 18:31:16 -0700
Received: from pool-71-126-246-21.bstnma.fios.verizon.net (HELO [192.168.0.100]) (dmunsie@cecropia.com@[71.126.246.21])
          (envelope-sender <dmunsie@cecropia.com>)
          by mail3.sea5.speakeasy.net (qmail-ldap-1.03) with RC4-SHA encrypted SMTP
          for <linux-fbdev-devel@lists.sourceforge.net>; 29 Apr 2006 01:31:10 -0000
In-Reply-To: <4452ADD2.6040002@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; delsp="yes"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

I'm away from the actual machine, but I did just try it blindly and  
checked out the output from the driver with dmesg:

fbcvt: Aspect ratio not CVT standard
fbcvt: 1360x768@60: CVT Name - Not a CVT standard - 1.044 Mega Pixel  
Image

intelfb: intelfb_check_var: accel_flags is 0
intelfb: intelfb_var_to_depth: bpp: 32, green.length is 0
intelfb: Initial video mode is 1366x768-32@59.

It looks as if something valid is coming back and the driver is  
setting up the mode, but at this point I don't know if there is  
really something on the display or not.  One thing that is  
disconcerting is that I asked for 60Hz and it returned back 59Hz.   
Another thing, which may be nothing, is that second line where it  
says the mode is 1360x768.  I am specifically requesting  
1366x768M-32@60 in for my modeline.

I will be able to test it more thoroughly on Monday when I am back in  
the office.

thanks!
dennis

On Apr 28, 2006, at 8:05 PM, Antonino A. Daplas wrote:

> Can you try first if any of these options will work for you:
>
> video=xxxfb:1366x768M@60
>
> or
>
> video=xxxfb:1366x768MR@60


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
