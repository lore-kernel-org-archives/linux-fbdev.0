From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] kyrofb support
Date: Tue, 13 Jan 2004 18:09:26 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040113180926.5fdb0824.akpm@osdl.org>
References: <20040114013306.GB9515@linux-sh.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgaSx-0006n6-LA
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 18:09:07 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgaSx-0002c7-8s
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 18:09:07 -0800
In-Reply-To: <20040114013306.GB9515@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org

Paul Mundt <lethal@linux-sh.org> wrote:
>
> This patch adds support for the Kyro graphics boards (STG4000/PowerVR 3/etc.)
>  to 2.6.1. This is a direct port and substantial cleanup / rewrite of the 2.4
>  driver that's available in the sh64 tree at linux-sh.bkbits.net. Some of the
>  overlay code and the STG4000 bits are still a bit ugly, so be forewarned.

Why is kyro_modedb[] and the code which touches it under #ifdef MODULE?

kyrofb_pci_tbl[] cannot be marked __devinitdata - it is linked into
system-wide PCI tables and will be walked at various times in the kernel. 
If it is in a discarded section the kernel oopses.

Shouldn't the module_exit(kyrofb_exit); be inside #ifdef MODULE too?


In general, what are the fbdev drivers doing here btw?  It's very strange
that some core file (fbmem.c) has to "know" about individual card drivers. 
It should be sufficient for the driver to just register itself with the core
at the drivers's module_init() time.

Sigh.  Too late to fix that now I guess.



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
