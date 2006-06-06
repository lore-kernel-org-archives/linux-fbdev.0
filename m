From: Vassilis Virvilis <vasvir@iit.demokritos.gr>
Subject: Re: Twister savagefb doesn't sync
Date: Tue, 06 Jun 2006 12:57:43 +0300
Message-ID: <44855197.7040801@iit.demokritos.gr>
References: <44698356.80806@iit.demokritos.gr> <447381E9.4060705@gmail.com>	
	<447803FC.8050009@iit.demokritos.gr>
	<44781B3A.5030406@gmail.com>	 <44781BFB.5020708@gmail.com>
	<447994A8.30600@iit.demokritos.gr>	 <447A3CC0.9060403@gmail.com>
	<447AF58E.3050803@iit.demokritos.gr>	 <447B60D7.8020204@gmail.com>
	<44845DEC.1000608@iit.demokritos.gr>
	<a728f9f90606052211v43de97c7l91a22a9faa93f76c@mail.gmail.com>
Reply-To: vasvir@iit.demokritos.gr,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FnYEO-0007al-Ts for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Jun 2006 02:52:13 -0700
Received: from zeus.iit.demokritos.gr ([143.233.226.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FnYEM-0002Aq-9j
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Jun 2006 02:52:12 -0700
In-Reply-To: <a728f9f90606052211v43de97c7l91a22a9faa93f76c@mail.gmail.com>
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
To: Alex Deucher <alexdeucher@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

Alex Deucher wrote:
> On 6/5/06, Vassilis Virvilis <vasvir@iit.demokritos.gr> wrote:
> 
> The reason the savage xorg drver uses the bios is because almost every
> panel they connect to the chip seems to require fairly custom timings.
> the twisters and prosavages are even worse than the discrete chips.
> Also, only the bios seems to know the magic incantation necessary for
> dualhead.  I tried for a while to add non-bios mode setting to crtc2
> without much luck.

I don't care for dualhead right now. I can imagine it is 4 times weirder
than my current setup. What is crtc*?

> 
> For a short term fix, just program the registers with the new values
> from the bios.  You may be able to just get away with adjusting the
> crtc1 dclk (SR12, SR13, SR29).

I will try that. Thanks for the suggestion.

A real fix may require special
> calculations or tables for different chip/panel combos.
> 

I will try for both of my monitors and I will report here any
success or failure unless of course I am told that this info is
not desirable.

Do you know if changing the number of colors 256/64K/16M requires
clock adjustments (SR12, SR13, SR29)?

Thanks for answering.

      .bill
