From: David Eger <eger@havoc.gtf.org>
Subject: fb modules and taking over console after boot
Date: Tue, 15 Jun 2004 14:43:22 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040615184322.GA9338@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaIuC-0001I4-0b
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 11:43:32 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaIuB-0006eA-Ju
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 11:43:31 -0700
Received: from havoc.gtf.org (havoc.gtf.org [127.0.0.1])
	by havoc.gtf.org (Postfix) with ESMTP id D7C1D759D
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Jun 2004 14:43:22 -0400 (EDT)
Received: (from eger@localhost)
	by havoc.gtf.org (8.12.10/8.12.10/Submit) id i5FIhMTd012294
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 14:43:22 -0400
Content-Disposition: inline
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

In Linux 2.6 -- It seems as though, for fbcon to take over the console,
the relevant fb driver has to be built in to the kernel and the card
detected during the boot sequence..  does anyone ever insert an fb driver
as a module?  If so, which fb driver, and what do you do with it?  Just
curious...

-dte


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
