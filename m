From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Generic VESA framebuffer driver and Video
 card BOOT?
Date: Fri, 15 Oct 2004 21:18:56 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.61.0410152115530.17827@waterleaf.sonytel.be>
References: <416E6ADC.3007.294DF20D@localhost> <416FAF05.30267.1B66C92@localhost>
 <41701D1C.70705@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIXbS-00040Y-7U
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 12:19:02 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CIXbP-0006H9-56
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 12:19:02 -0700
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i9FJIvMp026668
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 15 Oct 2004 21:18:57 +0200 (MEST)
In-Reply-To: <41701D1C.70705@comcast.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 15 Oct 2004, Zachary Smith wrote:
> Kendall Bennett wrote:
> > Zachary Smith <plinius@comcast.net> wrote:
> > 
> > > The problem of x86-only BIOSes is one of the videocard
> > > manufacturers' own making which, in the spirit of good engineering,
> > > they should fix before requiring a downstream kludge. 
> 
> > Forgetting the fact that the BIOS image is x86, why
> > not think about the x86 BIOS image as being a set of 'generic'
> > instructions or p-code
> 
> Yes, this idea occurred to me after I posted my response.
> 
> But if you're going to add x86 emulation to the non-x86 kernels
> perhaps it would be nice if you could find a way to permit
> users to run x86 applications as well seamlessly.

Ugh... There's a big difference between a 16-bit 8086 emulator to run BIOS code
and a full-fletched 32-bit 80386 (or higher) emulator...

> Although that would introduce a tradeoff: kernel code should be
> small which is bound to be slow in the case of an emulator,
> which is OK for running BIOS code, but a user running apps
> probably prefer optimized code which may be bigger.

We already have qemu.

> On the other hand, a person running a free emulator doesn't
> really have the option of great speed :)

Really? We already have qemu.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
