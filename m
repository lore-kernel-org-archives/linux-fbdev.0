From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: [PATCH] cyber2000fb.c: Fix 16bpp mode
Date: Sat, 10 Nov 2007 17:52:12 +0100
Message-ID: <20071110165212.GA7202@derision.cyrius.com>
References: <000501c81e5e$c1334160$4399c420$@nl>
	<20071108082159.GB23626@deprecation.cyrius.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IqtZT-0006dI-SL for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Nov 2007 08:52:37 -0800
Received: from sorrow.cyrius.com ([65.19.161.204])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IqtZR-000447-D7
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Nov 2007 08:52:35 -0800
Content-Disposition: inline
In-Reply-To: <20071108082159.GB23626@deprecation.cyrius.com>
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
Cc: Jan Rinze <janrinze@home.nl>, Woody Suwalski <woody@suwalski.net>

* Martin Michlmayr <tbm@cyrius.com> [2007-11-08 09:22]:
> Jan Rinze noticed that 16bpp screen mode is not working on Netwinder:
> "After some deduction it appeared that it was running in 24bpp instead
> of 16bpp. Found the bug: a missing 'break' statement at the end of a
> switch case.  After adding the break statement 16bpp works fine."

You can ignore this patch.  It went in via Russell King already, see
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c2ec21c5c8f15c079c209f403d582f3134785060
-- 
Martin Michlmayr
http://www.cyrius.com/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
