From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 0/18] fbdev: Fix Coverity Checker bugs
Date: Sat, 11 Mar 2006 09:48:50 +0800
Message-ID: <44122C82.3030306@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHtlt-0004vp-Tz
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 18:23:57 -0800
Received: from pproxy.gmail.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtlr-0000fB-Qx
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 18:23:57 -0800
Received: by pproxy.gmail.com with SMTP id z59so421959pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 18:23:40 -0800 (PST)
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The patch series is composed of fixes uncovered by the Coverity Checker.
Most of the bugs are harmless, but a few are real bugs (buffer overruns).
Some are just code cleanups resulting from inspection of the Coverity
reports although no actual bug exist.

Tony 




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
