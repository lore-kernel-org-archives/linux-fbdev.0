From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH][RFC] Add support for Epson S1D13806 FB
Date: Mon, 14 Mar 2005 23:06:02 +0800
Message-ID: <200503142306.02775.adaplas@hotpop.com>
References: <20050314142404.58FDF365923@mail.esiee.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAr99-0005j4-0R
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 07:06:19 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAr97-0007vW-JE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 07:06:18 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 0FC19F8CCD9
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Mar 2005 15:06:09 +0000 (UTC)
In-Reply-To: <20050314142404.58FDF365923@mail.esiee.fr>
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
To: Thibaut VARENE <varenet@esiee.fr>
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@pol.net>, Ben Dooks <ben-linux-arm@fluff.org>

On Monday 14 March 2005 22:24, Thibaut VARENE wrote:
> -------------------
>
> > On Monday 14 March 2005 21:00, Thibaut VARENE wrote:
> > > -------------------
> >
>
> 	info->fbops = &s1d13xxxfb_fbops;
> 	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
>

I must be going blind then :-)

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
