From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Optimized cfbimgblt.c
Date: Wed, 26 Jan 2005 21:07:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0501262104140.15652@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0501192015560.20796@pentafluge.infradead.org>
 <200501252058.13632.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtuNa-0006Cq-GY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Jan 2005 13:07:10 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CtuNY-0001xh-Uh
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Jan 2005 13:07:10 -0800
In-Reply-To: <200501252058.13632.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, jsimmons@pentafluge.infradead.org


> Hi James,
> 
> Tested on vesafb: works
> Tested on rivafb: crashes on fb_show_logo().

Ug!! Which video card are you using,what logos are you attempting to 
draw, and if you could post the oops trace? This is really strange. I 
tested the code with Radeon, 3Dfx, NeoMagic, and the VesaFB driver. They 
all worked. Also the riva drives used cfb_imageblit for the logo. Tomorrow 
I will pull out my TNT2 card to see what happens. 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
