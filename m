From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] i.MX Framebuffer: Cleanup Coding
	style
Date: Thu, 4 Sep 2008 09:59:33 +0200
Message-ID: <20080904075933.GI4941@pengutronix.de>
References: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
	<1220354697-13648-9-git-send-email-s.hauer@pengutronix.de>
	<20080903211917.0c03e23a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kb9kn-0003bF-VX for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 00:59:46 -0700
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Kb9km-0000OZ-Gg
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 00:59:45 -0700
Content-Disposition: inline
In-Reply-To: <20080903211917.0c03e23a.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Dyer <amdyer@gmail.com>

On Wed, Sep 03, 2008 at 09:19:17PM +0200, Krzysztof Helt wrote:
> On Tue,  2 Sep 2008 13:24:51 +0200
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/video/imxfb.c |   70 +++++++++++++++++++++++-------------------------
> >  1 files changed, 34 insertions(+), 36 deletions(-)
> > 
> 
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> One offtopic comment: do you really want the FBINFO_READS_FAST set?
> 
> It means that the driver prefer copyarea to imgblit function. It is
> usually slower on most drivers (opposite on chips with attached
> very fast memory: 3Dfx, GeForce, probably new ATI chips as well).
> 
> Please test your driver with and without this option if possible.

I'll keep that in mind and test it. I'm sure this flag never went in on
purpose, it went in with copy-paste.

Regards,
 Sascha

-- 
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
