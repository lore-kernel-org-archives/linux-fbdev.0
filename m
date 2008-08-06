From: York Sun <yorksun@freescale.com>
Subject: Re: How to test virtual resolution
Date: Wed, 06 Aug 2008 16:05:58 -0500
Message-ID: <1218056758.25178.10.camel@oslab.mtwk.freescale.net>
References: <FE151544B54DB0428FFA9AE99C27A12102183DD0@az33exm22.fsl.freescale.net>
	<Pine.LNX.4.64.0808062116260.17614@anakin>
	<1218052776.25178.5.camel@oslab.mtwk.freescale.net>
	<Pine.LNX.4.64.0808062205040.17614@anakin>
	<1218055896.25178.7.camel@oslab.mtwk.freescale.net>
	<Pine.LNX.4.64.0808062257420.17614@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQqEk-0004Sv-10 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 14:08:02 -0700
Received: from az33egw01.freescale.net ([192.88.158.102])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQqEi-0006ZC-O8
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 14:08:01 -0700
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m76L7vCQ018619 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 6 Aug 2008 14:07:58 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m76L7RgG002540
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 6 Aug 2008 16:07:57 -0500 (CDT)
In-Reply-To: <Pine.LNX.4.64.0808062257420.17614@anakin>
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

On Wed, 2008-08-06 at 22:59 +0200, Geert Uytterhoeven wrote:
> On Wed, 6 Aug 2008, York Sun wrote:
> > I actually use fbset -g to set the resolutions. Does fbset have anything
> 
> So the third and fourth value for -g are the virtual resolution.
> 
> > to do with panning?
> 
> Not directly; it allows to set the virtual screen size, so the frame
> buffer console (or an application like fbtest) can make use of it.

Thanks, Geert. That's exact what I am asking -- what application can I
use and how?

York




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
