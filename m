From: Ramprasad <ramprasad@ncoretech.com>
Subject: problem in displaying logo
Date: Sat, 21 Dec 2002 16:16:42 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E044692.89F5BEA6@ncoretech.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [164.164.42.6] (helo=gateway.ncoretech.com)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18PhC9-0001oT-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Dec 2002 02:49:26 -0800
Received: from mail.ncoretech.com (mail.ncoretech.com [192.168.1.3])
	by gateway.ncoretech.com (8.12.5/8.12.5) with ESMTP id gBLAmi6J006956
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Dec 2002 16:18:46 +0530
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi ,

 I am using 2.4.18-rmk7 kernel on assabet like board , with 240x320 LCD
color display panel.


My problem is i have modified the linux startup logo to 240x320 size
,This works fine on 32MB RAM and 16MB flash
 board, i.e  i can see full screen logo and i boots up fine. This does
not work on  64MB RAM and 32MB flash board . logo comes up and kernel
panic..

I just  tried to reduce the size of logo to 240x280 this works fine.

Can anybody give some pointers why this is happening..


Thanks in advance,
Ramprasad



-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
