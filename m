From: ramprasad <ramprasad@ncoretech.com>
Subject: frame bufffer on CRT
Date: Mon, 15 Nov 2004 13:24:22 +0530
Message-ID: <419860AE.4000606@ncoretech.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CTbYI-0000b8-UC
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 14 Nov 2004 23:45:30 -0800
Received: from premium.exocore.com ([203.197.173.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CTbYH-0005Ka-LM
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 14 Nov 2004 23:45:30 -0800
Received: from mail.ncoretech.com (dsl.ncoretech.com [61.95.205.91])
	by premium.exocore.com (8.12.8/8.12.8) with ESMTP id iAF7jOAk024837
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Nov 2004 13:15:24 +0530
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ncoretech.com (Postfix) with ESMTP id 900DA5FF4D
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Nov 2004 13:15:38 +0530 (IST)
Received: from mail.ncoretech.com ([127.0.0.1])
 by localhost (mail.ncoretech.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03861-03 for <linux-fbdev-devel@lists.sourceforge.net>;
 Mon, 15 Nov 2004 13:15:38 +0530 (IST)
Received: from ncoretech.com (ws184.ncoretech.com [192.168.1.184])
	by mail.ncoretech.com (Postfix) with ESMTP id 057035FF82
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Nov 2004 13:15:38 +0530 (IST)
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
        I am using 2.4.19-rmk7-pxa1  kernel on my PXA-255 board which is 
using epson13506 chip for  CRT display.
I am seeing the linux logo on my CRT.The problem is, i am seeing two 
linux logo on my CRT.
i have set my  display to 640x480. Can anybody explain why i am seeing this.

Thanks in advance,
Ramprasad



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
