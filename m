From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: Initialisation sequencing.
Date: Fri, 4 Mar 2005 04:07:11 +0800
Message-ID: <200503040407.11449.adaplas@hotpop.com>
References: <200503031438.48357.adaplas@hotpop.com> <4226D649.4000408@f2s.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6wbq-0002Yt-M6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Mar 2005 12:07:46 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D6wbZ-0001Qd-0V
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Mar 2005 12:07:46 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id D4DBFF500F2
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  3 Mar 2005 20:07:17 +0000 (UTC)
In-Reply-To: <4226D649.4000408@f2s.com>
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
To: Ian Molton <spyro@f2s.com>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thursday 03 March 2005 17:18, Ian Molton wrote:
> Antonino A. Daplas wrote:
> > If your backlight driver depends on the video driver, then you
> > just have to initialize backlight after video.
> >
> > Why not place your backlight driver in after drivers/video in
> > drivers/Makefile?
>
> What about the modular case ?

Are you using the backlight architecture in drivers/video/backlight? Shouldn't
the backlight driver pull the video driver first?  I think you can do that if you
make the backlight driver depend on the video driver.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
