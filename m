From: Jurriaan <thunder7@xs4all.nl>
Subject: why does radeonfb work fine in 2.6, but not in 2.4.29-pre1?
Date: Sun, 28 Nov 2004 19:46:06 +0100
Message-ID: <20041128184606.GA2537@middle.of.nowhere>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CYU40-000152-A7
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 28 Nov 2004 10:46:24 -0800
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CYU3z-0000QH-Eq
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 28 Nov 2004 10:46:24 -0800
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-vbr8.xs4all.nl (8.12.11/8.12.11) with ESMTP id iASIkJ7r098948
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 28 Nov 2004 19:46:19 +0100 (CET)
	(envelope-from jurriaan@rivierenland.xs4all.nl)
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

The same radeonfb-setup works fine in every 2.6 kernel I can remember
(last tested with 2.6.10-rc2-mm3) but give the dreaded 'cannot map FB'
in 2.4.29-pre1.

The card has 128 Mb of ram, and my system has 3 Mb of RAM.

Is there any reason the ioremap() call works on 2.6, but doesn't on 2.4?

I've tried searching google for hints, but nothing has turned up.

Is there any way to test 2.4 with my radeonfb and all of my memory?

Thanks,
Jurriaan
-- 
proof by exhaustion:
	An issue or two of a journal devoted to your proof is useful.
Debian (Unstable) GNU/Linux 2.6.10-rc2-mm3 2x6078 bogomips load 1.67


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
