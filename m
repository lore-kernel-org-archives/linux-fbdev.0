From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: Twister savagefb doesn't sync (resolved for
	640x480@64K)
Date: Sun, 11 Jun 2006 11:03:11 -0400
Message-ID: <a728f9f90606110803v10ca364xf3e32e4a40f4bbfa@mail.gmail.com>
References: <44698356.80806@iit.demokritos.gr>
	<447994A8.30600@iit.demokritos.gr> <447A3CC0.9060403@gmail.com>
	<447AF58E.3050803@iit.demokritos.gr> <447B60D7.8020204@gmail.com>
	<44845DEC.1000608@iit.demokritos.gr>
	<a728f9f90606052211v43de97c7l91a22a9faa93f76c@mail.gmail.com>
	<44855197.7040801@iit.demokritos.gr>
	<a728f9f90606060743t7fd6dfdfia3e2a050ff954e06@mail.gmail.com>
	<448C067B.3040404@iit.demokritos.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FpqOL-0002fZ-Fw for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 10:39:57 -0700
Received: from ug-out-1314.google.com ([66.249.92.169])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FpqOL-0002Ib-1g
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 10:39:57 -0700
Received: by ug-out-1314.google.com with SMTP id o2so2468772uge
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 12 Jun 2006 10:39:49 -0700 (PDT)
In-Reply-To: <448C067B.3040404@iit.demokritos.gr>
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
To: vasvir@iit.demokritos.gr
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

On 6/11/06, Vassilis Virvilis <vasvir@iit.demokritos.gr> wrote:
> Hi Alex,
>
> I would like to thank you and Antonino for all the help so far. I have finally
> manage to make my twister to sync with both of my screens (one TFT, one CRT).
>
> I am attaching the patch. The patch itself disables all modes other than
> 640x480@64K-60Hz. Note that the patch is clearly inapropriate but it
> may sparkle some discussion about how this thing works.
>
> One more question:
>
> Alex Deucher wrote:
> >> > The reason the savage xorg drver uses the bios is because almost every
> >> > panel they connect to the chip seems to require fairly custom timings.
> >> > the twisters and prosavages are even worse than the discrete chips.
> >> > Also, only the bios seems to know the magic incantation necessary for
> >> > dualhead.  I tried for a while to add non-bios mode setting to crtc2
> >> > without much luck.
> >>
>
> When you say panel what do you mean?
> a) The rest of the framebuffer and scan logic resided in CRTC?
> b) The screen attached to CRTC?
>
> I believe a) but I would like to know for sure.

I'm not sure I understand your question.  The panel connects to the
chip via a built in flat panel interface, however it has to be driven
with timings and a clock just like a CRT.  The CRTC can drive either
the FP interface or the DAC or both.  Based on you patch it seems you
only need to tweak the clock.  Perhaps if we had a few more testers we
could figure out a pattern for common panels and put in some sort of
generic fix.

Alex

>
> Thanks again...
>
>     .bill
>
>
>
