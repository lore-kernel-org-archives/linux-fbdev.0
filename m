From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: Twister savagefb doesn't sync
Date: Tue, 6 Jun 2006 01:11:16 -0400
Message-ID: <a728f9f90606052211v43de97c7l91a22a9faa93f76c@mail.gmail.com>
References: <44698356.80806@iit.demokritos.gr> <447381E9.4060705@gmail.com>
	<447803FC.8050009@iit.demokritos.gr> <44781B3A.5030406@gmail.com>
	<44781BFB.5020708@gmail.com> <447994A8.30600@iit.demokritos.gr>
	<447A3CC0.9060403@gmail.com> <447AF58E.3050803@iit.demokritos.gr>
	<447B60D7.8020204@gmail.com> <44845DEC.1000608@iit.demokritos.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fo5db-00059e-Ax for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 14:32:27 -0700
Received: from ug-out-1314.google.com ([66.249.92.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fo5dZ-0007be-Vz
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 14:32:27 -0700
Received: by ug-out-1314.google.com with SMTP id o2so497509uge
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 07 Jun 2006 14:32:23 -0700 (PDT)
In-Reply-To: <44845DEC.1000608@iit.demokritos.gr>
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
To: vasvir@iit.demokritos.gr, linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

On 6/5/06, Vassilis Virvilis <vasvir@iit.demokritos.gr> wrote:
> Antonino A. Daplas wrote:
> >
> > Much simpler if you just load X first with UseBIOS False then dump the regs.
> > Do the same with UseBIOS True.  You mentioned that X does not work if the
> > option UseBIOS is false.
> >
> > Tony
> >
>
> Any ideas about the data I posted?
> http://marc.theaimsgroup.com/?l=linux-fbdev-devel&m=114908868820818&w=2
>
> I can undestand that is problem difficult to tackle remotely.
>

The reason the savage xorg drver uses the bios is because almost every
panel they connect to the chip seems to require fairly custom timings.
 the twisters and prosavages are even worse than the discrete chips.
Also, only the bios seems to know the magic incantation necessary for
dualhead.  I tried for a while to add non-bios mode setting to crtc2
without much luck.

For a short term fix, just program the registers with the new values
from the bios.  You may be able to just get away with adjusting the
crtc1 dclk (SR12, SR13, SR29). A real fix may require special
calculations or tables for different chip/panel combos.

Alex


> Thanks anyway.
>
>     .bill
>
