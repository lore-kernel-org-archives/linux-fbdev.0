From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: Initialisation sequencing.
Date: Fri, 4 Mar 2005 08:45:34 +0800
Message-ID: <200503040845.36571.adaplas@hotpop.com>
References: <200503031438.48357.adaplas@hotpop.com> <200503040407.11449.adaplas@hotpop.com> <4227A5CE.4050008@f2s.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D70wx-0000aI-Lc
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Mar 2005 16:45:51 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D70ww-0006Iw-10
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Mar 2005 16:45:51 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 65393147A469
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  4 Mar 2005 00:45:43 +0000 (UTC)
In-Reply-To: <4227A5CE.4050008@f2s.com>
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

On Friday 04 March 2005 08:03, Ian Molton wrote:
> Antonino A. Daplas wrote:
> > Are you using the backlight architecture in drivers/video/backlight?
> > Shouldn't the backlight driver pull the video driver first?  I think
> > you can do that if you make the backlight driver depend on the video
> > driver.
>
> IOW make it a child of it?
>
> I asumed that would work but I cant actually build a modular kernel for
> some reason I havent had time to look into yet.
>
> that said, does load order have *any* bearing on probe order ?
> since both devices are platform devices, both drivers can be loaded and
> dormant and brought up at any time by their devices becomming available
> from (another) module...

If you really need to ensure that video gets loaded before backlight, you can
insert:

module_get/try_module_get(<video_driver>) in your backlight on load,
module_put() on unload.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
