From: Andrew Morton <akpm@osdl.org>
Subject: fbdev maintenance
Date: Wed, 1 Nov 2006 21:49:53 -0800
Message-ID: <20061101214953.48dc7e17.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVSd-0007SN-FM for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:49:56 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVSc-0006z8-SV
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:49:55 -0800
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA25nrPo004429
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 1 Nov 2006 21:49:54 -0800
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id kA25nrSd002241
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 1 Nov 2006 21:49:53 -0800
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


I haven't heard anything from Tony for nearly three months, and I don't
think anyone else has either.  So we should make some alternative
arrangements.

I've been through the mailing list and have scooped up 25 patches, but I
don't have the knowledge to say whether they're good or bad.  I shall send
them all back to this list to refresh people's memories.  If you were one
of the people whose patches I merged, feel free to let me know whether you
think it's suitable for 2.6.19 (ie: it's a bugfix) or 2.6.20 (ie: it's a
good patch).

For the longer term, well, it would be good if someone else could step up
to take over Tony's role.  If nobody has the knowledge/time/inclination to
do that then can we please all spend more effort than we usually would in
reviewing and testing each other's work?

Thanks.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
