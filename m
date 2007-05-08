From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [PATCH] atmel_lcdfb: AT91/AT32 LCD
 Controller framebuffer driver
Date: Tue, 8 May 2007 19:26:55 +0200
Message-ID: <20070508192655.08b1d649@dhcp-252-105.norway.atmel.com>
References: <463F3388.7020102@rfo.atmel.com> <1178574017.4674.30.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlTT6-0003xG-GQ for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 10:27:20 -0700
Received: from nat-132.atmel.no ([80.232.32.132] helo=relay.atmel.no)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HlTT5-0000FU-RB
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 10:27:20 -0700
In-Reply-To: <1178574017.4674.30.camel@daplas>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel list <linux-kernel@vger.kernel.org>, Patrice Vilchez <patrice.vilchez@rfo.atmel.com>

Hi Antonio,

Thanks for the feedback. I'm just going to reply to one of your
comments and leave the rest for Nicolas...

On Tue, 08 May 2007 05:40:17 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> > +static int __init atmel_lcdfb_init(void)
> > +{
> > +	return platform_driver_probe(&atmel_lcdfb_driver, atmel_lcdfb_probe);
> > +}  
> 
> Is this intentional?  Why not platform_driver_register()?

Yes, it's intentional. This way, the atmel_lcdfb_probe function can be
__init since it doesn't need to be referenced from atmel_lcdfb_driver.
Saves a bit of memory at run time.

The downside is that hot plugging won't work, but that isn't very
relevant for on-chip devices anyway.

Haavard

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
