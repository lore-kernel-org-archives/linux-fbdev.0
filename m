From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [ANNOUNCE]: VM86 Daemon
Date: 01 Apr 2003 23:32:20 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049210839.1009.27.camel@localhost.localdomain>
References: <1049104351.1037.53.camel@localhost.localdomain>
	<3E886C5F.28140.1013B3CA@localhost>
	<1049160350.1059.39.camel@localhost.localdomain>
	<1049185774.593.46.camel@zion.wanadoo.fr>
	<1049189944.1009.61.camel@localhost.localdomain>
	<1049196891.596.57.camel@zion.wanadoo.fr>
	<1049203284.1050.14.camel@localhost.localdomain> 
	<1049205224.589.71.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190NoW-0001aA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 07:36:40 -0800
In-Reply-To: <1049205224.589.71.camel@zion.wanadoo.fr>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kendall Bennett <KendallB@scitechsoft.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-04-01 at 21:53, Benjamin Herrenschmidt wrote:
> > > 
> > > What do you think about adding some ioctl's for that ?
> > > 
> > 
> > It's okay by me.
> 
> Ok, I'll define something & implement it in radeonfb as soon as
> I find some time (probably after your fbmon changes get in) for
> both the EDID/userland and userland access to the dynamically
> created modedb database
> 
> BTW. Do you know if it's possible to get some infos/specs on
> the EDID format, GF formula, etc... or it's all paying stuffs ?
> 

I think you have to pay VESA for these. 

I used a combination of XFree86, read-edid, and fbmon.c for the EDID
parser. I think Kendall Bennett is planning to release their own code.

As for the GTF, I used the MS Excel spreadsheet available in VESA's ftp
site.  

As for VBE, the VBE 3.0 Core specs is free.  I also referred to Ralph
Brown's comprehensive interrupt list for x86 real mode.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
