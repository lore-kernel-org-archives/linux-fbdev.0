From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] hgafb: convert to new platform
	driver API (bugzilla	#9689)
Date: Wed, 4 Jun 2008 04:03:23 +0400
Message-ID: <20080604000323.GA24548@polina.dev.rtsoft.ru>
References: <20080602193608.5173cdc0.krzysztof.h1@poczta.fm>
	<20080603161346.9685e0a9.akpm@linux-foundation.org>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3gTR-000344-4r for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 17:03:29 -0700
Received: from [85.21.88.6] (helo=buildserver.ru.mvista.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K3gTN-0002nT-KV
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 17:03:29 -0700
Content-Disposition: inline
In-Reply-To: <20080603161346.9685e0a9.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, Jun 03, 2008 at 04:13:46PM -0700, Andrew Morton wrote:
[...]
> > -	info = framebuffer_alloc(0, NULL);
> > +	info = framebuffer_alloc(0, &pdev->dev);

(1)

[...]
> >  	if (!ret) {
> > -		ret = platform_device_register(&hgafb_device);
> > -		if (ret)
> > -			driver_unregister(&hgafb_driver);
> > +		hgafb_device = platform_device_register_simple("hgafb", 0, NULL, 0);
> > +
> > +		if (IS_ERR(hgafb_device)) {

(2)

> > +			platform_driver_unregister(&hgafb_driver);
> > +			ret = PTR_ERR(hgafb_device);
> > +		}
> >  	}
> >  
> >  	return ret;
> > @@ -647,8 +649,8 @@ static int __init hgafb_init(void)
> >  
> >  static void __exit hgafb_exit(void)
> >  {
> > -	platform_device_unregister(&hgafb_device);
> > -	driver_unregister(&hgafb_driver);
> > +	platform_device_unregister(hgafb_device);
> > +	platform_driver_unregister(&hgafb_driver);
> >  }
> 
> Oh.  I just merged Anton's similar patch, below.
> 
> What should we do?

Please drop mine. Krzysztof's patch is better because of (1) and (2).

(1) is nice addition. Plus mine doesn't do (2), i.e. IS_ERR(), thus
might cause troubles in case platform_device_register_simple() return
errors.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
