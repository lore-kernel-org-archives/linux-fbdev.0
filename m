From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [ANNOUNCE]: VM86 Daemon
Date: 01 Apr 2003 09:27:36 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049160350.1059.39.camel@localhost.localdomain>
References: <1049104351.1037.53.camel@localhost.localdomain> 
	<3E886C5F.28140.1013B3CA@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190Acl-0006MI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 31 Mar 2003 17:31:39 -0800
In-Reply-To: <3E886C5F.28140.1013B3CA@localhost>
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
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-04-01 at 08:27, Kendall Bennett wrote:
> Jon Smirl <jonsmirl@yahoo.com> wrote:
> 
> > I didn't read through the code yet, is this being implemented by
> > adding some new IOCTLs to the fb interface? For example an IOCTL to
> > get the legal modes or to reset the card. 
> 
> We definitely want some new IOCTL's to allow the apps to find out what 
> modes are available, if this has not been added.

Actually, the fbdev has its own ioctl, FBIOSETVAR (or something like
that).  You place the desired mode in struct fb_var_screeninfo (var),
then set var->activate = FB_ACTIVATE_TEST.  If there's no error, the var
should now contain the best mode (not necessarily the same) which was
requested. 

All this is automatically incorporated to vesafb when vm86d is loaded. 
The new vesafb driver has additional methods for:

fb_check_var()
fb_set_par()
fb_pan_display()
fb_setcolreg()
fb_blank() -- currently a dummy method

Tony



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
