From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] Cleanup of intelfb code
Date: Thu, 4 Nov 2004 17:08:54 +0800
Message-ID: <200411041708.55104.adaplas@hotpop.com>
References: <200411041647.41604.adaplas@hotpop.com> <20041104005747.427811ee.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPdcI-0004Pz-L1
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 01:09:14 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPdcD-0006Wc-Ga
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 01:09:14 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 254019AB5E0
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  4 Nov 2004 09:08:56 +0000 (UTC)
In-Reply-To: <20041104005747.427811ee.akpm@osdl.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, sylvain.meyer@worldonline.fr

On Thursday 04 November 2004 16:57, Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
> > +	if (ACCEL(dinfo, info)) {
> >  +		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
> >  +		FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
> >  +		FBINFO_HWACCEL_IMAGEBLIT;
> >  +	} else {
> >  +		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
> >  +	}5 files changed, 113 insertions(+), 474 deletions(-)
> >
> >   	return 0;
> >   }
>
> erk, what happened there?
>

Wrong cursor position, sorry.

> I have Sylvain's priginal patch - is this in any way different?

Not much, Sylvain's original patch should be okay.  I just added
a more comprehensive changelog.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
