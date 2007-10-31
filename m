From: Peter Samuelson <peter@p12n.org>
Subject: [patch] con2fbmap limit check
Date: Wed, 31 Oct 2007 09:58:19 -0500
Message-ID: <20071031145819.GB27631@p12n.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InF80-0003yM-RY for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Oct 2007 08:05:11 -0700
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1InF7z-0008Gl-6D
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Oct 2007 08:05:08 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net


Trivial patch to avoid an oops I hit when trying to figure out how to
use con2fbmap.
-- 
Peter Samuelson | org-tld!p12n!peter | http://p12n.org/


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
