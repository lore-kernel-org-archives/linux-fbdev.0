From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Tue, 19 Oct 2004 10:54:50 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4174F27A.8234.1645ECBF@localhost>
References: <41740384.5783.12A07B14@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJyCO-0005RW-Li
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 10:55:04 -0700
Received: from mail.scitechsoft.com ([63.195.13.67])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CJyCN-0005Wl-NB
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 10:55:04 -0700
In-reply-to: <4174704B.9050601@bitworks.com>
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
To: Richard Smith <rsmith@bitworks.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Richard Smith <rsmith@bitworks.com> wrote:

> Kendall Bennett wrote:
> 
> > Actually there is nothing wrong with the x86 BIOS from the perspective of 
> > functionality and useability (or bloat for that matter). It contains all 
> > the functionality we need and armed with something like the x86 emulator 
> > we can use it for what we need on any platform.
> 
> > IMHO that is the best solution to the problem because it will be using 
> > code that has been heavily tested by the vendor. The one thing x86 Video 
> > BIOS'es can do reliably is POST the graphics card ;-)
> 
> I'm just going to take your word on this since you have messed
> with far more video bioses than I.  I've just got a few too many
> scars over the years from trying to make the whole BIOS sub-system
> robust enough for embedded standards. 

Most BIOS'es are relatively good, but there are some terrible ones. We 
have one a lot of work over the years making our VESA VBE drivers work 
well with all the BIOS'es out there, working around the issues in the 
broken ones. I plan to use that same module for the kernel VESA driver 
when I get around to re-writing it.

> > lot of code bloat. But if you do that, then you would need this code in 
> > the kernel since now it would be the boot loader as well ;-)
> 
> Exactly. Which is why I like your project and I think its a good
> thing. The only reason I have to carry around the legacy BIOS
> baggage is for video. 

Yep.

> How big is your in-kernel implementation?

Right now the compiled x86 code is about 100K in size. PowerPC code 
appears to be about twice that size and x86-64 is about 130K I think. I 
have no idea how big an Open Firmware interpreter would be for comparison 
purposes because I have never seen an Open Source implementation of one.

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
