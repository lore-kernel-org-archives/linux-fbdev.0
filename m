From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: mode setting and console locking
Date: Mon, 17 May 2004 13:51:21 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1084765880.6447.21.camel@gaston>
References: <20040517035129.28227.qmail@web14928.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPZEf-00012e-IQ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 20:56:17 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BPZEf-0002vu-6f
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 20:56:17 -0700
In-Reply-To: <20040517035129.28227.qmail@web14928.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>


> 
> The only difference I can see is that the X term is in KD_GRAPHICS. When the VT
> is swapped from a console in KD_TEXT to one in KD_GRAPHICS a signal must be sent
> to radeonfb. This signal is being handled wrong and the wrong data is loaded
> into the registers. But what is really wrong is that this signal shouldn't be
> sent to radeonfb at all since my radeonfb is not the primary console device and
> it shouldn't be touched on a VT swap.
> 
> I haven't figured out what happens in an fbdev driver on a KD_TEXT/KD_GRAPHICS
> transition yet.

The kernel VT subsystem issue a special blank call to the console driver
(I recently fixed issues there to catch those properly). fbcon will for
a set mode when getting one of those going from gfx->text

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
