From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/3] More XilinxFB changes
Date: Wed, 10 Oct 2007 12:31:40 -0600
Message-ID: <20071010182920.12852.41903.stgit@trillian.cg.shawcable.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IfgLq-0003bb-9N for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Oct 2007 11:32:10 -0700
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]
	helo=pd3mo2so.prod.shaw.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IfgLk-0004zs-1S
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Oct 2007 11:32:06 -0700
Received: from pd4mr2so.prod.shaw.ca
	(pd4mr2so-qfe3.prod.shaw.ca [10.0.141.213]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPP00JK6KSPFM90@l-daemon> for
	linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Oct 2007 12:31:37 -0600 (MDT)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd4mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPP000GUKSPRIA0@pd4mr2so.prod.shaw.ca> for
	linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Oct 2007 12:31:37 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004)) with ESMTP id <0JPP00L6VKSOU2X0@l-daemon> for
	linux-fbdev-devel@lists.sourceforge.net;
	Wed, 10 Oct 2007 12:31:36 -0600 (MDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, akonovalov@ru.mvista.com, linuxppc-dev@ozlabs.org, adaplas@gmail.com, jwboyer@linux.vnet.ibm.com

Here are some more changes on the xilinxfb driver.  These changes add the
ability to specify a custom resolution or framebuffer physical address.
Useful for FPGA designs which use a modified xilinxfb device.

Please review and comment.

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
