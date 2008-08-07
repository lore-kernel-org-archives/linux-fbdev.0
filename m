From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: How to test virtual resolution
Date: Thu, 7 Aug 2008 09:02:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808070901480.17614@anakin>
References: <FE151544B54DB0428FFA9AE99C27A12102183DD0@az33exm22.fsl.freescale.net>
	<Pine.LNX.4.64.0808062116260.17614@anakin>
	<1218052776.25178.5.camel@oslab.mtwk.freescale.net>
	<Pine.LNX.4.64.0808062205040.17614@anakin>
	<1218055896.25178.7.camel@oslab.mtwk.freescale.net>
	<Pine.LNX.4.64.0808062257420.17614@anakin>
	<1218056758.25178.10.camel@oslab.mtwk.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQzWI-0003Ed-TG for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 00:02:46 -0700
Received: from nelson.telenet-ops.be ([195.130.133.66])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KQzWH-0001Iq-FG
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 00:02:46 -0700
In-Reply-To: <1218056758.25178.10.camel@oslab.mtwk.freescale.net>
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
> On Wed, 2008-08-06 at 22:59 +0200, Geert Uytterhoeven wrote:
> > On Wed, 6 Aug 2008, York Sun wrote:
> > > I actually use fbset -g to set the resolutions. Does fbset have anything
> > 
> > So the third and fourth value for -g are the virtual resolution.
> > 
> > > to do with panning?
> > 
> > Not directly; it allows to set the virtual screen size, so the frame
> > buffer console (or an application like fbtest) can make use of it.
> 
> Thanks, Geert. That's exact what I am asking -- what application can I
> use and how?

X? Just you specify a virtual screen in xorg.conf (see `Virtual' in
xorg.conf(5)).

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
