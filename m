From: "Kendall Bennett" <KendallB@scitechsoft.com>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 15 Oct 2004 15:22:51 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <416FEB4B.25470.2A1DBC0@localhost>
References: <416FAF05.30267.1B66C92@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIaTe-0005xH-C9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 15:23:10 -0700
Received: from mail.scitechsoft.com ([63.195.13.67])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CIaTd-0007GT-AT
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 15:23:10 -0700
In-reply-to: <41701D1C.70705@comcast.net>
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
To: Zachary Smith <plinius@comcast.net>, linux-fbdev-devel@lists.sourceforge.net

Zachary Smith <plinius@comcast.net> wrote:

> Kendall Bennett wrote:
> > Zachary Smith <plinius@comcast.net> wrote:
> > 
> >>The problem of x86-only BIOSes is one of the videocard
> >>manufacturers' own making which, in the spirit of good engineering,
> >>they should fix before requiring a downstream kludge. 
> 
>  > Forgetting the fact that the BIOS image is x86, why
>  > not think about the x86 BIOS image as being a set of 'generic'
>  > instructions or p-code
> 
> Yes, this idea occurred to me after I posted my response.
> 
> But if you're going to add x86 emulation to the non-x86 kernels
> perhaps it would be nice if you could find a way to permit users to
> run x86 applications as well seamlessly. 

Well there is a big difference between a simple CPU emulator and a full 
fledged machine emulation environment. Although if you only plan to run 
Linux user space programs that might be easier to handle because you just 
need to handle the system calls. But you would still need x86 shared 
libraries and such which at the end of the day doesn't make much sense 
(too much bloat). 

Also the emulator only emulates real mode code at present. It had full 
support for 32-bit instructions and could probably be tweaked to run user 
space 32-bit code, but it has never been tested.

> Although that would introduce a tradeoff: kernel code should be
> small which is bound to be slow in the case of an emulator, which
> is OK for running BIOS code, but a user running apps probably
> prefer optimized code which may be bigger. 

Probably. Although we have been very surprised at just how well the 
PowerPC compiled version of the emulator runs BIOS code. It seems the 
PowerPC compilers can optimise the code a lot better than x86 compilers.

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
