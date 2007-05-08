From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 06/20] vt8623fb: New framebuffer
	driver for VIA VT8623
Date: Mon, 7 May 2007 23:28:37 -0700
Message-ID: <20070507232837.d3dfcfb4.akpm@linux-foundation.org>
References: <463C996A.9050005@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlJBs-0007B8-Jh for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 23:28:52 -0700
Received: from smtp1.linux-foundation.org ([65.172.181.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HlJBr-00050o-8w
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 May 2007 23:28:52 -0700
In-Reply-To: <463C996A.9050005@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 05 May 2007 22:49:14 +0800 "Antonino A. Daplas" <adaplas@gmail.com> wrote:

> This patch adds fbdev driver for graphics core in VIA VT8623

Is bust with CONFIG_MTRR=n

drivers/video/vt8623fb.c: In function `vt8623_pci_remove':
drivers/video/vt8623fb.c:797: error: `par' undeclared (first use in this function)
drivers/video/vt8623fb.c:797: error: (Each undeclared identifier is reported only once
drivers/video/vt8623fb.c:797: error: for each function it appears in.)

(that's ia64)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
