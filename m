From: York Sun <yorksun@freescale.com>
Subject: Re: How to test virtual resolution
Date: Thu, 07 Aug 2008 09:57:41 -0500
Message-ID: <1218121061.30010.1.camel@linux222>
References: <FE151544B54DB0428FFA9AE99C27A12102183DD0@az33exm22.fsl.freescale.net>
	<Pine.LNX.4.64.0808062116260.17614@anakin>
	<1218052776.25178.5.camel@oslab.mtwk.freescale.net>
	<Pine.LNX.4.64.0808062205040.17614@anakin>
	<1218055896.25178.7.camel@oslab.mtwk.freescale.net>
	<Pine.LNX.4.64.0808062257420.17614@anakin>
	<1218056758.25178.10.camel@oslab.mtwk.freescale.net>
	<Pine.LNX.4.64.0808070901480.17614@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KR70w-0004a8-KT for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 08:02:54 -0700
Received: from de01egw02.freescale.net ([192.88.165.103])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KR70u-0008Nb-Sy
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 08:02:54 -0700
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m77F2iAI029477 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 7 Aug 2008 08:02:44 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m77F2hPO020158
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 7 Aug 2008 10:02:43 -0500 (CDT)
In-Reply-To: <Pine.LNX.4.64.0808070901480.17614@anakin>
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

On Thu, 2008-08-07 at 09:02 +0200, Geert Uytterhoeven wrote:
> On Wed, 6 Aug 2008, York Sun wrote:
> > On Wed, 2008-08-06 at 22:59 +0200, Geert Uytterhoeven wrote:
> > > On Wed, 6 Aug 2008, York Sun wrote:
> > > > I actually use fbset -g to set the resolutions. Does fbset have anything
> > > 
> > > So the third and fourth value for -g are the virtual resolution.
> > > 
> > > > to do with panning?
> > > 
> > > Not directly; it allows to set the virtual screen size, so the frame
> > > buffer console (or an application like fbtest) can make use of it.
> > 
> > Thanks, Geert. That's exact what I am asking -- what application can I
> > use and how?
> 
> X? Just you specify a virtual screen in xorg.conf (see `Virtual' in
> xorg.conf(5)).
> 

Yes, X works. And it does use FBIOPAN_DISPLAY ioctl. I am looking for a
simple application such as a picture viewer.

Thanks anyway.

York


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
