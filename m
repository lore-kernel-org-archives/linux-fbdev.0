From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 16/24] tgafb: Actually allocate
 memory for the pseudo_palette
Date: Mon, 4 Jun 2007 14:24:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0706041422440.863@blysk.ds.pg.gda.pl>
References: <466141AF.8060900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HvCYk-0001Ch-1W for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 Jun 2007 06:25:24 -0700
Received: from pollux.ds.pg.gda.pl ([153.19.208.7] ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HvCYi-0008UY-JK
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 Jun 2007 06:25:21 -0700
In-Reply-To: <466141AF.8060900@gmail.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

On Sat, 2 Jun 2007, Antonino A. Daplas wrote:

> No memory allocation was done for the pseudo_palette.  Allocate one for it.

 Indeed.  Thanks for debugging -- looks like a leftover from an earlier 
version of the changes I made which got forgotten later on.

  Maciej

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
