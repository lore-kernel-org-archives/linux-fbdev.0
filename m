From: ramprasad <ramprasad@ncoretech.com>
Subject: kernel crash when using USB keyboard
Date: Thu, 02 Dec 2004 21:48:07 +0530
Message-ID: <41AF403F.2060202@ncoretech.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZthz-0007hH-4U
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Dec 2004 08:21:31 -0800
Received: from premium.exocore.com ([203.197.173.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CZthx-0005Yw-UN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Dec 2004 08:21:30 -0800
Received: from mail.ncoretech.com (dsl.ncoretech.com [61.95.205.91])
	by premium.exocore.com (8.12.8/8.12.8) with ESMTP id iB2GLMAk022749
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 2 Dec 2004 21:51:22 +0530
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ncoretech.com (Postfix) with ESMTP id 4A7165FF82
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  2 Dec 2004 21:52:32 +0530 (IST)
Received: from mail.ncoretech.com ([127.0.0.1])
 by localhost (mail.ncoretech.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17350-06 for <linux-fbdev-devel@lists.sourceforge.net>;
 Thu,  2 Dec 2004 21:52:31 +0530 (IST)
Received: from ncoretech.com (ws184.ncoretech.com [192.168.1.184])
	by mail.ncoretech.com (Postfix) with ESMTP id C1A9F5FF4D
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  2 Dec 2004 21:52:31 +0530 (IST)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi ,
    I am working on 2.4.19-rmk7-pxa1 kernel with epson 13506 chip for my 
CRT.I am getting the  logo and also login prompt. when i plug in USB key 
and try to type ,kernel crashes and i dont see any activity on the 
screen.i.e. the cursor stops blinking.  what could be worng ? how can i 
use keyboard to login. I have enabled my FB device also and my CRT 
driver get registers with framebuffer. I can echo using tty0 on CRT.

any pointers on where to get more info.

Thanks in advance,
Ramprasad



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
