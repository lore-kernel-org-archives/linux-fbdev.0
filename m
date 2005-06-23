From: Raphael Assenat <raph@raphnet.net>
Subject: Re: atyfb h/vsync polarity
Date: Thu, 23 Jun 2005 14:11:16 -0400
Message-ID: <20050623181116.GG21451@midgar.vault.raphnet.net>
References: <20050622140842.GV20191@midgar.lan.raphnet.net> <200506231125.10848.alex.kern@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlWAh-000703-Qz
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 11:11:27 -0700
Received: from roc.holo.8d.com ([64.254.227.115])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.41)
	id 1DlWAg-0006mq-Bq
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 11:11:27 -0700
Content-Disposition: inline
In-Reply-To: <200506231125.10848.alex.kern@gmx.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Kern <alex.kern@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, Jun 23, 2005 at 11:25:10AM +0200, Alexander Kern wrote:
> Am Mittwoch, 22. Juni 2005 16:08 schrieb Raphael Assenat:
> > It seems strange to me that the driver ignores the sync polarity we
> > request, but I'm sure the above code exists for a good reason so I would
> > not suggest to simply remove it as a fix. Can anyone explain why this code
> > is
> > necessary?
> this behaviour is from XFree code and more VGA like.
But I dont like the idea that the driver thinking it knows better than me
what sync polarities I should use. I have a setup where I absolutely need hsync to
be high, but the driver prevents me from doing it!

> >
> > The fact that this cause problems for me is probably due to my particular
> > video setup: Ultra10 vga -> passive VGA csync on hsync pin to sync on green
> > adapter -> passive VGA to 13W3 adapter -> GDM-17E11 SGI monitor (requires
> > sync-on-green).
> >
> Anyway, SPARC has own rules, This error was always disputed on the list, 
> Here is a patch.
[patch removed]

This patch seem to be already in 2.6.12n and it does not fix my problem.
The problem on my machine is not with Csync being inactive (it is
active). I need Csync *and* high hsync polarity. H and V sync polarity  still matters, 
even if V and H sync are combined to form csync.

Regards,
Raphael Assenat



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
