From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [PATCH] skeletonfb
Date: Mon, 31 Jan 2005 19:28:01 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0501311927330.18064@pentafluge.infradead.org>
References: <200501301911.17552.lucasvr@gobolinux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CvhDU-00084B-4W
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Jan 2005 11:28:08 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CvhDS-0008FB-MT
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Jan 2005 11:28:08 -0800
In-Reply-To: <200501301911.17552.lucasvr@gobolinux.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>


Thanks. I merged it with my tree. I also will be writing newer 
documentation for people.

On Sun, 30 Jan 2005, Lucas Correia Villa Real wrote:

> Hi,
> 
> This patch just fixes some typos and adds retval documentation for some 
> functions that were missing it.
> 
> I've also a question here: skeletonfb says that  xxxfb_setcolreg() should 
> return a negative errno on error. However, if the register number being 
> accessed is out of bounds, 1 is returned. Shouldn't it be better to return 
> -EINVAL instead?  By looking at fbcmap.c, the retval isn't being checked 
> against positive/negative values, so it doesn't make sense to return 1. 
> 
> Thanks,
> 
> -- 
> Lucas
> powered by /dev/dsp
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
