From: Antonino Daplas <adaplas@pol.net>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
	2.5.5[45]
Date: 13 Feb 2003 07:37:46 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045092828.3527.128.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0302122013320.31435-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18j6RS-0003lj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Feb 2003 15:37:26 -0800
In-Reply-To: <Pine.LNX.4.44.0302122013320.31435-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Jak <rfjak@eircom.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-02-13 at 04:15, James Simmons wrote:
> 
> > > from rivafb_probe to riavfb_open. Can you give tht a try and tell me if it 
> > > works.
> > > 
> > 
> > I haven't tried this yet, but I think it will work.  The only (very
> > minor) problem with this is the rivafb's printk output will be incorrect
> > (no info on video memory size).  
> 
> True. All to keep in sync with X :-( Maybe we should break nv_driver.c 
> syncing since it already has been altered. Hell with it. Could you update 
> a patch with seperate functions for memsize clock finding.
> 

Will do once you provide an updated patch I can diff against.  

Tony




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
