From: krzysztof.h1@poczta.fm
Subject: Re: [PATCH] atyfb_base.c: fix warning
Date: 31 Jul 2008 10:29:45 +0200
Message-ID: <20080731082945.6AEA31E3074@f03.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOTXl-0006VY-RX for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 01:29:54 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOTXk-000577-EI
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 01:29:53 -0700
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
To: "M. Asselstine" <asselsm@mcmaster.ca>, Alexander Beregalov <a.beregalov@gmail.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "syrjala@sci.fi" <syrjala@sci.fi>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "adaplas@gmail.com" <adaplas@gmail.com>

> On Wed, Jul 30, 2008 at 5:03 PM, Alexander Beregalov
> <a.beregalov@gmail.com> wrote:
> > From: Alexander Beregalov <a.beregalov@gmail.com>
> >
> > atyfb_base.c: fix warning
> >
> > drivers/video/aty/atyfb_base.c:2663: warning: 'aty_resume_chip' defined
> > but not used
> >
> > Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
> > Cc: Ville Syrjala <syrjala@sci.fi>
> > Cc: Antonino A. Daplas <adaplas@pol.net>
> 
> Looks good, should you maybe move the aty_resume_chip() up into the
> existing #if defined(CONFIG_PM) &&... that atyfb_pci_resume() is in?
> Not sure, just a thought.
> 

The same thought has crossed my mind. Kill the forward declaration and move this short function before atyfb_pci_resume().

Regards,
Krzysztof 


----------------------------------------------------------------------
W kosciele tez zdarzaja sie wpadki!
Smieszny filmik >>> http://link.interia.pl/f1e61


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
