From: Denis Oliver Kropp <dok@directfb.org>
Subject: Re: [PATCH 1/2] fbdev: S3 Savage Framebuffer Driver
Date: Sat, 23 Oct 2004 01:38:45 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041022233845.GA20612@master.directfb.org>
References: <200410230436.42009.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CL913-0002uc-C7
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Oct 2004 16:40:13 -0700
Received: from port-212-202-201-108.dynamic.qsc.de ([212.202.201.108] helo=master.zion.home)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CL912-0002ei-GU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Oct 2004 16:40:13 -0700
Content-Disposition: inline
In-Reply-To: <200410230436.42009.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Denis Oliver Kropp <dok@directfb.org>, Mika Pruikkonen <mpruikko@cc.hut.fi>, Sven Neumann <neo@convergence.de>

Quoting Antonino A. Daplas:
> S3 Savage Frambuffer Driver for the following chipsets: 
> 
> Savage 3D
> Savage MX
> Savage 4
> Savage 2000
> ProSavage
> SuperSavage
> 
> This is based from the driver written by:
>  Denis Oliver Kropp <dok@directfb.org>
>  Sven Neumann <neo@directfb.org>
> 
> Initial Porting to 2.6 done by:
>  Mika Pruikkonen <mpruikko@cc.hut.fi>
> 
> Added the following:
> - Console acceleration support (imageblit, fillrect, copyarea) -
>   Configurable
> - DDC2/I2C support for (ProSavage DDR-K, Savage 4 and Prosavage PM only -
>   Configurable
> - 8, 16, 32 bits per pixel

Hi,

you've made a great progress with the driver!

Nice to see that this driver is maintained again.

-- 
Best regards,
  Denis Oliver Kropp
 
.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

                            Convergence GmbH


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
