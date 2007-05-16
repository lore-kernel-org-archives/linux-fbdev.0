From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 01/10] fbdev: Clean up of sparc FB
	options
Date: Wed, 16 May 2007 16:17:17 -0700 (PDT)
Message-ID: <20070516.161717.115911096.davem@davemloft.net>
References: <464B74EE.5040407@gmail.com>
	<20070516.144739.41633447.davem@davemloft.net>
	<1179357305.4743.20.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoSk6-0007Pc-BF for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 16:17:14 -0700
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoSk5-0001jK-M9
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 16:17:14 -0700
In-Reply-To: <1179357305.4743.20.camel@daplas>
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
To: adaplas@gmail.com
Cc: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net

From: "Antonino A. Daplas" <adaplas@gmail.com>
Date: Thu, 17 May 2007 07:15:05 +0800

> A flag may be the easiest. But we can also define an arch-specific
> function (ie, fb_get_primary_device()) in asm/fb.h. With the x86, this
> can be easily done by checking the IORESOURCE_ROM_SHADOW bit flag.  
> 
> I'll add this for the x86, and then perhaps others can follow suit.

What would this iterate over?  The list of all registered
fb_info's?

Anyways this sounds great, I'll add the sparc bits once you
push the x86 version.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
