From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Mon, 18 Oct 2004 12:34:45 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4173B865.23362.117B098E@localhost>
References: <416E6ADC.3007.294DF20D@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJdHX-00045P-OX
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 12:34:59 -0700
Received: from mail.scitechsoft.com ([63.195.13.67])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CJdHX-0007vJ-7F
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 18 Oct 2004 12:34:59 -0700
In-reply-to: <9e47339104101610447a393abc@mail.gmail.com>
Content-description: Mail message body
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Jon Smirl <jonsmirl@gmail.com> wrote:

> > What this means is that it should be possible to build a new version of
> > the VESA framebuffer console driver for the Linux kernel that will have
> > these important features:
> > 
> > 1. Be able to switch display modes on the fly, supporting all modes
> > enumerated by the Video BIOS.
> > 
> > 2. Be able to support refresh rate control on graphics cards that support
> > the VBE 3.0 services.
> 
> How is this going to work if there are multiple graphics cards
> installed? Each card will want to install it's own VBE extension
> interrupt. 

Yep. The code I have ported to the Linux kernel right now does not 
support multiple consoles because porting that code would be a lot more 
work (I would prefer to keep it in userland if possible since it already 
works there).

Anyway the way the system works for multiple controllers is that there is 
a separate BIOS image and separate machine state maintained for each 
graphics card. So you can run the VBE driver on the primary, secondary 
and ternary drivers if you want. We do it all the time with SNAP just for 
fun and giggles ;-)

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
