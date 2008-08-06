From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: How to test virtual resolution
Date: Wed, 6 Aug 2008 22:06:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808062205040.17614@anakin>
References: <FE151544B54DB0428FFA9AE99C27A12102183DD0@az33exm22.fsl.freescale.net>
	<Pine.LNX.4.64.0808062116260.17614@anakin>
	<1218052776.25178.5.camel@oslab.mtwk.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQpGr-0006RR-64 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 13:06:09 -0700
Received: from harold.telenet-ops.be ([195.130.133.65])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KQpGp-0000vr-OS
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 13:06:09 -0700
In-Reply-To: <1218052776.25178.5.camel@oslab.mtwk.freescale.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: York Sun <yorksun@freescale.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 6 Aug 2008, York Sun wrote:
> Fbset can definitely change the resolution but it doesn't pan the
> screen. I looked around but didn't find an application takes advantage
> of the virtual resolution.

Sorry, I forgot to mention that the panning test requires that you
manually enable a large virtual resolution before running fbtest.

E.g. `fbset -vxres 2000 -vyres 2000'

> On Wed, 2008-08-06 at 21:17 +0200, Geert Uytterhoeven wrote:
> > On Wed, 6 Aug 2008, sun york wrote:
> > > I was asked to add the support for virtual resolution for fsl_diu_fb. I
> > > don't know how to test it without X. It seems that fbcon can use the
> > > virtual resolution and pan around. Can someone shed some light on this?
> > 
> > You can try fbtest (CVS module FBdev/utlilities/fbtest on
> > http://sourceforge.net/projects/linux-fbdev).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
