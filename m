From: ramprasad <ramprasad@ncoretech.com>
Subject: Console on CRT
Date: Mon, 22 Nov 2004 18:13:35 +0530
Message-ID: <41A1DEF7.6040407@ncoretech.com>
References: <418F6D37.7050104@ncoretech.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWDb3-0005Ng-Gs
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 04:47:09 -0800
Received: from premium.exocore.com ([203.197.173.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CWDb2-0007Yg-60
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Nov 2004 04:47:09 -0800
Received: from mail.ncoretech.com (dsl.ncoretech.com [61.95.205.91])
	by premium.exocore.com (8.12.8/8.12.8) with ESMTP id iAMCl1Ak030837
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Nov 2004 18:17:01 +0530
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ncoretech.com (Postfix) with ESMTP id EFB205FF82
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Nov 2004 18:17:37 +0530 (IST)
Received: from mail.ncoretech.com ([127.0.0.1])
 by localhost (mail.ncoretech.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22466-05 for <linux-fbdev-devel@lists.sourceforge.net>;
 Mon, 22 Nov 2004 18:17:37 +0530 (IST)
Received: from ncoretech.com (ws184.ncoretech.com [192.168.1.184])
	by mail.ncoretech.com (Postfix) with ESMTP id 71DB85FF4D
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Nov 2004 18:17:37 +0530 (IST)
In-Reply-To: <418F6D37.7050104@ncoretech.com>
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

Hi All,
    I am working on 2.4.19-rmk7-pxa1 kernel. I have an epson 13506 chip 
interfaced to PXA processor.I want to direct the boot messages to my CRT 
and also i want to use CRT as my terminal.Now i have drected my messages 
to my serial port.(kernel boot parmeter console=ttyS0,115200). I am 
seeing an linux logo on my CRT.I am using the drivers from epson website.
Any pointers on how to go about.

Thanks in advance,
Ramprasad



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
