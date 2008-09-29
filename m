From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: Allow more revisions in epson s1d13...
 driver
Date: Mon, 29 Sep 2008 17:32:02 +0200
Message-ID: <20080929173202.1edd25e0.kristoffer.ericson@gmail.com>
References: <20080929154735.a7cc4a29.kristoffer.ericson@gmail.com>
	<7d01f9f00809290803x603491e9w52891e767eade471@mail.gmail.com>
	<Pine.LNX.4.64.0809291717510.24296@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1KkKjr-0003Z9-SO
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Sep 2008 15:32:43 +0000
Received: from ey-out-1920.google.com ([74.125.78.146])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KkKjl-0004VC-Vi for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Sep 2008 15:32:43 +0000
Received: by ey-out-1920.google.com with SMTP id 4so524752eyk.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 29 Sep 2008 08:32:35 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0809291717510.24296@anakin>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: akpm@linux-foundation.org, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, Thibaut VARENE <varenet@parisc-linux.org>

On Mon, 29 Sep 2008 17:18:26 +0200 (CEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Mon, 29 Sep 2008, Thibaut VARENE wrote:
> > On Mon, Sep 29, 2008 at 3:47 PM, Kristoffer Ericson
> > <kristoffer.ericson@gmail.com> wrote:
> > > I've been trying to get someones attention to this patch. Currently the
> > > file in question is without maintainer.
> > > Ive however talked to Author Thiabaut Varene and adapted according
> > > to his suggestions (he's cc'ed in this mail).
> > 
> > This patch is a Ack from my side, save maybe for a tiny nitpick on the
> > fact that I think s1d13xxxfb_revisions should be __devinitdata, but
> > doing so seems to trigger compile issues. Haven't had time yet to dig
> > that out.
> 
> > > +static const int s1d13xxxfb_revisions[] = {
> > > +       S1D13506_CHIP_REV,/* Rev.4 on HP Jornada 7xx S1D13506 */
> > > +       S1D13806_CHIP_REV /* Rev.7 on .. */
> > > +};
> 
> Does the compile issue go away if you use __devinitconst instead of
> __devinitdata?
> 

Yes, thanks for clearing that up. Going to resend with fixed also adding the ack.


> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
