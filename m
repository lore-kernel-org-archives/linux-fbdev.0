From: Dennis Munsie <dmunsie@cecropia.com>
Subject: fixed point math
Date: Wed, 9 Aug 2006 17:31:49 -0400
Message-ID: <5FB9F032-0325-44A3-902D-234BB8589D50@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GAvaZ-0008OX-HS for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 Aug 2006 14:27:43 -0700
Received: from mail4.sea5.speakeasy.net ([69.17.117.6])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GAvaY-0000Iv-AT
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 Aug 2006 14:27:43 -0700
Received: from lex098.cecropia.com (HELO [192.168.3.132])
	(dmunsie@cecropia.com@[63.138.212.98])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail4.sea5.speakeasy.net (qmail-ldap-1.03) with RC4-SHA encrypted
	SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 9 Aug 2006 21:27:36 -0000
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
To: linux-fbdev-devel@lists.sourceforge.net

before I go off writing a bunch of code, is there any generic fixed  
point code for use in the kernel someplace?  I need to convert some  
code using float/double to fixed point, and would like to do it  
without re-inventing the wheel.

thanks!
dennis

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
