From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] kyrofb support
Date: Thu, 15 Jan 2004 00:31:10 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401150029070.335-100000@phoenix.infradead.org>
References: <20040113174908.487893c7.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgvPo-00084o-Tt
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 16:31:16 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AgvPo-00039u-G8
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 16:31:16 -0800
In-Reply-To: <20040113174908.487893c7.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-fbdev-devel@lists.sourceforge.net


Merge it in. The new changes don't hit the drivers that much. Mainly the 
new changes are:

1) Finalized cursor api.
2) i2c support :-)
3) DMA and memory allocation in general.
4) sysfs support.

On Tue, 13 Jan 2004, Andrew Morton wrote:

> Paul Mundt <lethal@linux-sh.org> wrote:
> >
> > This patch adds support for the Kyro graphics boards (STG4000/PowerVR 3/etc.)
> >  to 2.6.1. This is a direct port and substantial cleanup / rewrite of the 2.4
> >  driver that's available in the sh64 tree at linux-sh.bkbits.net. Some of the
> >  overlay code and the STG4000 bits are still a bit ugly, so be forewarned.
> 
> OK.  Problem is that the fbdev guys seem to be cooking up an internal API
> change.  I guess we may as well merge this driver up now and modify it if
> and when that API change hits the tree.
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
