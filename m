From: Antonino Daplas <adaplas@pol.net>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
	2.5.5[45]
Date: 31 Jan 2003 07:01:04 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043967543.1041.25.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301242009210.31541-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18eNtG-0006Nq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Jan 2003 15:14:38 -0800
In-Reply-To: <Pine.LNX.4.44.0301242009210.31541-100000@phoenix.infradead.org>
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

On Sat, 2003-01-25 at 04:14, James Simmons wrote:
> 
> I applied part of the patch. I like to avoid changing nv_driver to much 
> because it is based on the X windows driver. Easier to keep them sync. 
> What we could do is move the following 
> 
> riva_common_setup(par);
> ..
> 
> par->dclk_max = par->riva.MaxVClock..
> 
> from rivafb_probe to riavfb_open. Can you give tht a try and tell me if it 
> works.
> 

I haven't tried this yet, but I think it will work.  The only (very
minor) problem with this is the rivafb's printk output will be incorrect
(no info on video memory size).  

Tony



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
