From: Juergen Beisert <juergen127@kreuzholzen.de>
Subject: Re: [PATCH] i.MX Framebuffer: Cleanup Coding
	style
Date: Thu, 4 Sep 2008 13:20:33 +0200
Message-ID: <200809041320.35388.juergen127@kreuzholzen.de>
References: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
	<1220354697-13648-9-git-send-email-s.hauer@pengutronix.de>
	<20080903211917.0c03e23a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KbCtO-0000Q4-VC for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 04:20:51 -0700
Received: from bender.weihenstephan.org ([62.245.246.226])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KbCtN-0002Fy-Kj
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 04:20:51 -0700
Received: from MailerDaemon by bender.weihenstephan.org with local-bsmtp (Exim
	4.63) (envelope-from <juergen127@kreuzholzen.de>) id 1KbCtD-000640-AN
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 13:20:39 +0200
In-Reply-To: <20080903211917.0c03e23a.krzysztof.h1@poczta.fm>
Content-Disposition: inline
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
To: linux-fbdev-users@lists.sourceforge.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Dyer <amdyer@gmail.com>

On Mittwoch, 3. September 2008, Krzysztof Helt wrote:
> On Tue,  2 Sep 2008 13:24:51 +0200
>
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/video/imxfb.c |   70
> > +++++++++++++++++++++++------------------------- 1 files changed, 34
> > insertions(+), 36 deletions(-)
>
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>
> One offtopic comment: do you really want the FBINFO_READS_FAST set?
>
> It means that the driver prefer copyarea to imgblit function. It is

Did you ever get the framework to use the copyarea function the driver 
provides? I tried it several times and this function was never called. 
Independent from any flags I set or clear.

jbe

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
