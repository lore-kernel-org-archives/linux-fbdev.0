From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: cfb_fillrect and friends undefined
Date: Thu, 03 Aug 2006 14:20:21 +0800
Message-ID: <44D195A5.8050605@gmail.com>
References: <170385E48B041543AC99CCD09E325AD1AC54B4@mail.elevenonline.com.au>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G8WZL-0003XS-Mb for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Aug 2006 23:20:31 -0700
Received: from qb-out-0506.google.com ([72.14.204.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G8WZK-0002tT-5W
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Aug 2006 23:20:31 -0700
Received: by qb-out-0506.google.com with SMTP id q12so48482qbq
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 02 Aug 2006 23:20:27 -0700 (PDT)
In-Reply-To: <170385E48B041543AC99CCD09E325AD1AC54B4@mail.elevenonline.com.au>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Richard Wolf wrote:
> Hi,
> 
> I'm trying to write a frame buffer driver, basing it on the vfb virtual
> driver.  When I try to load the module I get an error message:
> 
> lh155ba: Unknown symbol platform_driver_unregister
> lh155ba: Unknown symbol cfb_copyarea
> lh155ba: Unknown symbol platform_device_register
> lh155ba: Unknown symbol platform_driver_register
> lh155ba: Unknown symbol platform_device_unregister
> lh155ba: Unknown symbol cfb_imageblit
> lh155ba: Unknown symbol cfb_fillrect
> 
> I can't work out what config options to enable to define these symbols.  I
> can get cfb_* to appear by selecting the vfb driver, but I don't want that
> driver, just the cfb_* functions.  Any help?

Add:

select FB_CFB_IMAGEBLIT
select FB_CFB_COPYAREA
select FB_CFB_FILLRECT

in drivers/video/Kconfig (under your driver, of course).

As for the platform_*, add #include <linux/platform_device.h>

Tony

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
