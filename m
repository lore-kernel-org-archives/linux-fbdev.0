From: James Simmons <jsimmons@infradead.org>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
 2.5.5[45]
Date: Wed, 12 Feb 2003 20:15:06 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302122013320.31435-100000@phoenix.infradead.org>
References: <1043967543.1041.25.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18j3ID-0000Xl-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Feb 2003 12:15:42 -0800
In-Reply-To: <1043967543.1041.25.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Jak <rfjak@eircom.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > from rivafb_probe to riavfb_open. Can you give tht a try and tell me if it 
> > works.
> > 
> 
> I haven't tried this yet, but I think it will work.  The only (very
> minor) problem with this is the rivafb's printk output will be incorrect
> (no info on video memory size).  

True. All to keep in sync with X :-( Maybe we should break nv_driver.c 
syncing since it already has been altered. Hell with it. Could you update 
a patch with seperate functions for memsize clock finding.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
