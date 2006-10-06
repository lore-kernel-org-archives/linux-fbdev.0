From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: SM501 framebuffer driver
Date: Fri, 6 Oct 2006 19:14:17 +0100
Message-ID: <a728f9f90610061114g56283168se68e030381b779e8@mail.gmail.com>
References: <45268042.8050207@billgatliff.com> <452691A2.2020209@anagramm.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVuDG-0006ws-5I for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Oct 2006 11:14:22 -0700
Received: from ug-out-1314.google.com ([66.249.92.170])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GVuDD-0005UK-Jx
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Oct 2006 11:14:22 -0700
Received: by ug-out-1314.google.com with SMTP id p27so363509ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 06 Oct 2006 11:14:18 -0700 (PDT)
In-Reply-To: <452691A2.2020209@anagramm.de>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Robert Whaley <rwhaley@applieddata.net>

On 10/6/06, Clemens Koller <clemens.koller@anagramm.de> wrote:
> Hello, Bill,
>
> > Sorry about starting a new thread, but I was referred to this
> > list/thread by a colleague just a few minutes ago.  (OT: it isn't in the
> > archives in SF, either!).
>
> Okay, fine! I'll be glad to join the party because we are using the SM501
> on PCI of an MPC8540 embedded PowerPC.
>
> Searching the list archives, about ten people have had (at least) some
> hands on the SM501 during the last year. I also got several questions about
> the driver status off list.
>
> > I hate to play "me too!", but I also have an SM501 framebuffer driver in
> > a partial state of development.  I'd love to collaborate with others to
> > get a good version pushed upstream.
>
> Great! Where shall we collect the code?
> I have some
>
> - a working fb driver kernel module
>        (I did lots of code cleanup, but still needs a lot)
>
> - older Xfree86 driver (partially accelerated!?, never tried but code looks good)
>

As I mentioned earlier, with the exception of dualhead, I've got a
working xorg smi501 driver.  I'll be adding it to xorg git once I get
dualhead working and a few other odds and ends worked out.

Alex

> - some collected MMCC (Multi Media Companion Chip) drivers/snippets
>        for the other periperals besides the graphics part.
>
> - kernel code for an functional complete(?) SM501 implementation for
>        an RTS7751R2D Renesas SH-4 Board running Linux.
>
> I am working on the latest 2.6.18 Kernels on PowerPC.
> But I can also test the SM501 on PCI in an x86 since we have
> this PCI Demo Board with an SM501G8 AA.
> On our PPC we use the SM501GF8 AB Chip Revision (F means: RoHS Version).
>
> I also mirrored the Silicon Motion's FTP server with lots of
> Datasheets and reference designs.
>
> > One of the challenges I've encountered with this chip is dealing with
> > all the "other stuff" it has onboard.  In my driver, I addressed that by
> > creating a whole new bus similar to what Nico did for the UCB1400.  I
> > was in the process of getting AC97 working when I figured out that that
> > part of the chip is so braindead, it isn't worth using--- at least on
> > ARM platforms that don't have DMA (which was my case).
>
> Oh, I will need to get the AC97 working, too :-/
> (my hardware is more or less ready to test some software)
>
> > In an upcoming project I need to use the USBH, so I'll be revisiting
> > this issue again soon.  I have also cc'd others who have worked with me
> > on this chip.
> >
> > I'd be happy to post code if that makes sense.  Or to host a CVS repo or
> > something.
>
> Can you host a CVS repo at your place? I don't like SF much.
>
> Best greets,
>
> Clemens Koller
> _______________________________
> R&D Imaging Devices
> Anagramm GmbH
> Rupert-Mayer-Str. 45/1
> 81379 Muenchen
> Germany
>
> http://www.anagramm.de
> Phone: +49-89-741518-50
> Fax: +49-89-741518-19
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
