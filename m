From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/8] fbcon: Do not touch hardware if vc_mode != KD_TEXT
Date: Wed, 03 Nov 2004 09:27:01 +1100
Message-ID: <1099434421.20294.19.camel@gaston>
References: <200411021946.06302.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CP7Ed-0004wK-Kg
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 14:34:39 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CP7Ec-0004Zo-PK
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 14:34:39 -0800
In-Reply-To: <200411021946.06302.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-11-02 at 19:46 +0800, Antonino A. Daplas wrote:
> The frambuffer console is still writing to the graphics hardware even if the
> hardware is not owned anymore by the console.  This can lead to crashes with
> some hardware.
> 
> A trace of the source indicates that it comes from almost anywhere, anytime.
> 
> The fix is to return immediately if vc_mode != KD_TEXT.  The test is placed in 
> the following functions if not already present.
> 
> fbcon_cursor()
> fbcon_putcs()
> fbcon_clear()
> fbcon_bmove() 
> fbcon_blank() 

Since the exact same thing must be done if the fbdev are "asleep", can't
we just have a kind of inline helper fbcon_useable() that does both test
and make sure every place is properly dealt with ?

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
