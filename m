From: James Simmons <jsimmons@infradead.org>
Subject: cursor maddnes and a solution
Date: Tue, 9 Aug 2005 01:17:50 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508090115420.2749@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2hav-0006bQ-FL
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 20:49:33 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E2gbr-0001w5-H6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 19:46:28 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by externalmx-1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1E2HvK-0006K0-2S
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Aug 2005 17:24:55 -0700
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.52 #1 (Red Hat Linux))
	id 1E2HoV-0000j1-1L
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 01:17:51 +0100
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


I still refuse to touch all drivers at a time. Instead I will merge in 
soft_cursor into the internals of the fbcon cursor code. This will make 
soft cursor be longer used. Then we can remove the soft cursor from the
drivers. There will be no soft_cursor wrap around to imageb lit anymore.
I think people can live with that.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
