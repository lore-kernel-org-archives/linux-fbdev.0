From: Ramprasad <ramprasad@ncoretech.com>
Subject: Full screen linux-logo
Date: Sat, 30 Nov 2002 19:04:07 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3DE8BE4F.2707958F@ncoretech.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [164.164.42.6] (helo=gateway.ncoretech.com)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18I7mW-0002u1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 30 Nov 2002 05:35:43 -0800
Received: from mail.ncoretech.com (IDENT:root@mail.ncoretech.com [192.168.1.3])
	by gateway.ncoretech.com (8.10.0/8.10.0) with ESMTP id gAUDZD024622
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 30 Nov 2002 19:05:13 +0530
Received: from ncoretech.com (ws225.ncoretech.com [192.168.1.225])
	by mail.ncoretech.com (8.10.0/8.10.0) with ESMTP id gAUDc0629476
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 30 Nov 2002 19:08:00 +0530
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

Hi All,

I am working on  assabet board with 320x240 mono LCD panel , kernel
2.4.18 i want to display  full screen logo while boot up.  I have set
the pixel clock value = 70000 , and bpp is 4  bit.

I am not getting the logo. i get 4 small , compressed linux logo .
Then i changed the pixclock to 171521 and bpp to 8. now  iam getting the
full logo  but there is lot of wavey lines.......

I am using the patchs given  by arnor.net

Can anybody guide me ...

Thanks in advance,
Ramprasad



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
