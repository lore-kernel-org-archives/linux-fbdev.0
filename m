From: "Richard Drummond" <evilrich@rcdrummond.net>
Subject: [PATCH] Multi-head fix for tdfxfb driver
Date: Thu, 30 Oct 2003 15:46:33 -0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031030154638.28D3315D57@mail03.powweb.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFF0L-0001V8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 07:46:33 -0800
Received: from mail03.powweb.com ([63.251.216.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AFF0L-0008Gt-Ch
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 07:46:33 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, James Simmons <jsimmons@infradead.org>

Hi All

This patch (against 2.6.0-test9) corrects a bug in the tdfxfb driver with
regard to multi-head set-ups. The driver was stomping all over its default
fb_fix_screeninfo struct (the global, tdfx_fix) when initializing a card -
which could potentially causes problems when the time comes to set up the
next card. This fix makes it copy tdfx_fix first and modify only that copy.

Cheers,
Rich



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
