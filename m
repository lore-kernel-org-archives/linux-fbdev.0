From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 00/24] fbdev: Fix palette handling in
	various drivers
Date: Sat, 02 Jun 2007 18:19:05 +0800
Message-ID: <46614419.7090207@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuQlO-0000at-7z for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:23:14 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQlK-0001yO-UD
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:23:14 -0700
Received: by py-out-1112.google.com with SMTP id u77so1509666pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:23:10 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The bug described here:

http://lkml.org/lkml/2007/5/27/104

resulting from improper palette handling in neofb prompted me to audit the
palette handling in various drivers. Most of the problems are over-allocating 
memory for the palette (not really a problem, just wastes memory) but a few
have bugs similar to the one described above.

Andrew, 

(Since I can only compile test some of them, you can keep them in
-mm for a while).

Tony





-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
