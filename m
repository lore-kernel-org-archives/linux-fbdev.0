From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Enumerating available display modes?
Date: Wed, 19 Mar 2003 11:42:38 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E7857AE.25705.9081CD5@localhost>
References: <3E7759E5.8300.528C610@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70] helo=mail.scitechsoft.com)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18vjSi-0005aI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 19 Mar 2003 11:42:56 -0800
In-reply-to: <20030319020755.45526.qmail@web14904.mail.yahoo.com>
Content-description: Mail message body
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jon Smirl <jonsmirl@yahoo.com>

Jon Smirl <jonsmirl@yahoo.com> wrote:

> I just scanned a couple of the fbdrivers and there seems to be no
> way to enumerate the modes that the hardware can support. This
> feature is probably lacking since there was no real use for it
> without the DDC monitor info. 

Well without the DDC monitor info you cannot ensure that modes the 
hardware can support will work on the attached monitor, but it is better 
than now knowing what modes are available anyway. As it stands right now, 
apps can simply call into the driver and 'try' to set any more that might 
be supported, but good luck knowing if it will or if the monitor can 
handle it.

Also IMHO it is not a good idea to expect apps to pass down the CRTC and 
pixel clock timings for the graphics card. It is nice to have this 
programmable interface, but user land apps really just want to set a mode 
and not have to deal with that stuff. Rarely they even care about the 
refresh rate (just use a good one for the attached monitor).

> The fb modes are controlled via /etc/fb.modes 

How do you mean they are controlled by /etc/fb.modes?

> On the other hand, the X windows drivers know how to enumerate the
> hardware supported modes. Just look at your XFree log and you can
> see a list of card supported modes vs monitor supported modes, and
> finally the pairs that match. 

Yes, I am aware that XFree86 drivers can do this.

> The solution is to go lift the appropriate code out of the X
> windows drivers and add it to the fb ones. 

Actually IMHO a better solution is the vesafbd project, since it would 
allow framebuffer console drivers to be developed in user land, and could 
then use the existing XFree86 driver modules without having to 'port' 
them to the Linux kernel. Also with the vesafbd project it will be 
possible to add support for reading the complete EDID from the monitor 
using the VESA BIOS functions, so that the vesa framebuffer console 
driver *could* know about the attached monitor and filter the available 
modes that the VESA BIOS supports for the user applications.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
