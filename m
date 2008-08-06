From: York Sun <yorksun@freescale.com>
Subject: Re: How to test virtual resolution
Date: Wed, 06 Aug 2008 15:51:36 -0500
Message-ID: <1218055896.25178.7.camel@oslab.mtwk.freescale.net>
References: <FE151544B54DB0428FFA9AE99C27A12102183DD0@az33exm22.fsl.freescale.net>
	<Pine.LNX.4.64.0808062116260.17614@anakin>
	<1218052776.25178.5.camel@oslab.mtwk.freescale.net>
	<Pine.LNX.4.64.0808062205040.17614@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQq0M-0002y7-6r for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 13:53:10 -0700
Received: from az33egw02.freescale.net ([192.88.158.103])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQq0L-0001LO-RL
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 13:53:10 -0700
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m76Kr5Hx015742 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 6 Aug 2008 13:53:05 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m76Kr4AP026664
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 6 Aug 2008 15:53:05 -0500 (CDT)
In-Reply-To: <Pine.LNX.4.64.0808062205040.17614@anakin>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

I actually use fbset -g to set the resolutions. Does fbset have anything
to do with panning?

York

On Wed, 2008-08-06 at 22:06 +0200, Geert Uytterhoeven wrote:
> On Wed, 6 Aug 2008, York Sun wrote:
> > Fbset can definitely change the resolution but it doesn't pan the
> > screen. I looked around but didn't find an application takes advantage
> > of the virtual resolution.
> 
> Sorry, I forgot to mention that the panning test requires that you
> manually enable a large virtual resolution before running fbtest.
> 
> E.g. `fbset -vxres 2000 -vyres 2000'
> 
> > On Wed, 2008-08-06 at 21:17 +0200, Geert Uytterhoeven wrote:
> > > On Wed, 6 Aug 2008, sun york wrote:
> > > > I was asked to add the support for virtual resolution for fsl_diu_fb. I
> > > > don't know how to test it without X. It seems that fbcon can use the
> > > > virtual resolution and pan around. Can someone shed some light on this?
> > > 
> > > You can try fbtest (CVS module FBdev/utlilities/fbtest on
> > > http://sourceforge.net/projects/linux-fbdev).
> 
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


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
