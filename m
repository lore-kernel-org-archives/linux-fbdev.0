From: James Simmons <jsimmons@infradead.org>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
 2.5.5[45]
Date: Fri, 24 Jan 2003 20:14:54 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301242009210.31541-100000@phoenix.infradead.org>
References: <1042990390.1058.4.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18cAEc-0007jk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jan 2003 12:15:31 -0800
In-Reply-To: <1042990390.1058.4.camel@localhost.localdomain>
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


> >  after clearing green screen using fbset, text colours are wrong
> ...unfortunately, upon exit, the driver restores only the partly
> initialized state, thus the vga console text colors are wrong. 

We should move the riva_load_state(par->initial_state) in riavfb_remove to 
rivafb_release. 
 
> >  rmmod fbcon locks up machine, no ALT-SYSRQ effective
> This is wishful thinking :-), as fbcon cannot be unloaded (yet). 

It works if you have more than one type of VT console system. I use MDA 
console with FB console. This way I can add and remove fbcon.o at will and 
test it in detail.

> Calling riva_common_setup() calls RivaGetConfig() which modifies the
> hardware.  Since we only need fix->smem_len and the bandwidth from
> RivaGetConfig(), I isolated them into riva_get_memlen() and
> riva_get_maxdclk().  RivaGetConfig will be called from rivafb_open()
> anyway.

I applied part of the patch. I like to avoid changing nv_driver to much 
because it is based on the X windows driver. Easier to keep them sync. 
What we could do is move the following 

riva_common_setup(par);
..

par->dclk_max = par->riva.MaxVClock..

from rivafb_probe to riavfb_open. Can you give tht a try and tell me if it 
works.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
