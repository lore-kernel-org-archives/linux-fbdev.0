From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [ PATCH-LINK ] fb accel capabilities - take 2
Date: Fri, 28 May 2004 15:42:12 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200405281542.13028.adaplas@hotpop.com>
References: <40B691DF.4060509@winischhofer.net> <1085715488.40b6b42062e3c@mail.theboonies.us>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTc0a-0002Re-Im
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 May 2004 00:42:28 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTc0Z-0002Iv-TJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 May 2004 00:42:27 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id B472B72BA4
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 May 2004 06:47:58 +0000 (UTC)
In-Reply-To: <1085715488.40b6b42062e3c@mail.theboonies.us>
Content-Disposition: inline
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
To: David Eger <eger-dated-1086320292.98e266@theboonies.us>, David Eger <eger-sender-da68b9@theboonies.us>, Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Friday 28 May 2004 11:38, David Eger wrote:
> Thomas Winischhofer eloquently put:
> > David Eger wrote:

> It's all part of fixing bugs ;-)  When my "accelerated" fb driver is still
> super-slow, i consider that a bug.  And it's a bug of the framebuffer
> subsystem, not really of the drivers.  Your lovely

There is also another cause for the slowdown.  Although 2.6 fbcon is slightly 
faster than 2.4 fbcon (not considering other variables such as panning), the 
speed can be increased further more (around 30-50%).  

This is mainly due to the use of sys_inbuf and sys_outbuf, which are used a 
lot, for transferring data from the pixmap when creating the monochrome 
bitmap (for use by xxx_imageblit).  I guess we just need to use standard 
memcopy (or similar), possibly inlined, if the pixmap is in system RAM, and 
only use sys_inbuf and sys_outbuf when the pixmap is in video/DMA/etc memory.

Tony 




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
