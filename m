From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: please disconsider bl_mutex patch
Date: Mon, 3 Jul 2006 22:53:11 -0300
Message-ID: <20060704015311.GJ27596@cathedrallabs.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fxa6W-0008Ur-Qn for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 03 Jul 2006 18:53:33 -0700
Received: from tinc.cathedrallabs.org ([72.9.252.66])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fxa6V-0000sT-Hs
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 03 Jul 2006 18:53:32 -0700
Received: from tate.cathedrallabs.org
	(201-25-166-92.ctame704.dsl.brasiltelecom.net.br [201.25.166.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tinc.cathedrallabs.org (Postfix) with ESMTP id 265A210009
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon,  3 Jul 2006 21:53:28 -0400 (EDT)
Content-Disposition: inline
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

Hi,
	just noticed that the bl_mutex removal from nvidiafb_blank() is
	wrong. while at that, noticed that recursive bl_mutex retrieval
	is also present at least on aty128fb and riva. checking how to
	fix it properly now.

-- 
Aristeu


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
