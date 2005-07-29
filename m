From: Richard Purdie <rpurdie@rpsys.net>
Subject: [patch 0/8] Corgi (Sharp Zaurus SL-c7x0) Driver Updates
Date: Fri, 29 Jul 2005 10:46:23 +0100
Message-ID: <1122630383.7747.85.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyRRu-00059s-6Z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 02:46:38 -0700
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1DyRRs-0007Gc-Om
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 02:46:38 -0700
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
To: akpm@osdl.org
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, vojtech@suse.cz, linux-kernel@vger.kernel.org

This is a series of driver updates for the Sharp Zaurus SL-C7x0. All the
patches have been seen by the subsystem maintainers at some point. Some
of the input patches seem to be lost in the system (since March) and
given the mainline corgi keyboard code doesn't even compile at the
moment, I'd like to see some of these making mainline sooner rather than
later. The w100fb patch depends on the corgi touchscreen cleanup patch
which is why this hasn't been merged as yet. This patch series seems the
simplest way to resolve things.

Patches 1-7 only affect the Zaurus platform and are being used by Zaurus
users in preference to mainline kernels so merging makes a lot of sense
and should be minimal risk for anyone else. They're also all patches
against code I effectively maintain.

Patch 8 is the final key to resolving an input key vs. switch issue and
I'm happy to wait for the input maintainer to merge that if appropriate.
I've included it for completeness as previous versions that are around
are suffering bitrot.

Hopefully these are all good candidates for -mm and then mainline.

Richard
(Corgi Maintainer)




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
