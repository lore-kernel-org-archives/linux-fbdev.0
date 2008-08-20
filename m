From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] i.MX Framebuffer: Cleanup
	Coding	style
Date: Wed, 20 Aug 2008 18:15:21 +0200
Message-ID: <20080820161521.GS4713@pengutronix.de>
References: <1219158403-5180-1-git-send-email-s.hauer@pengutronix.de>
	<1219158403-5180-4-git-send-email-s.hauer@pengutronix.de>
	<20080820173501.e82dbc93.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVqEU-0004Xf-9x for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Aug 2008 09:08:26 -0700
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVqES-0004Zl-Oq
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Aug 2008 09:08:26 -0700
Content-Disposition: inline
In-Reply-To: <20080820173501.e82dbc93.krzysztof.h1@poczta.fm>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, Aug 20, 2008 at 05:35:01PM +0200, Krzysztof Helt wrote:
> On Tue, 19 Aug 2008 17:06:42 +0200
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/video/imxfb.c |   78 +++++++++++++++++++++++++------------------------
> >  1 files changed, 40 insertions(+), 38 deletions(-)
> > 
> 
> I don't like some of the changes like wrapping lines
> which are not longer than 80 characters or removing
> alignment vs previous line because it contains spaces.
> There are also positive CS changes so not everything is bad.

Hm, this patch only wraps lines longer than 80 characters (in one case
it even merges two lines to one because it's still shorter than 80
chars). It also does not remove alignment vs the previous line, instead
it aligns some lines against the previous line. Maybe reading whitespace
changes in patches is a bit confusing because the +/- at line starts
mess it up.

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
