From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fbdev: workaround for broken X
	servers
Date: Sat, 06 Nov 2004 14:06:26 +1100
Message-ID: <1099710386.10262.69.camel@gaston>
References: <1099448020.900.25.camel@gaston>
	 <200411052055.17316.adaplas@hotpop.com> <1099701519.3884.32.camel@gaston>
	 <200411061002.38017.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQGud-00059q-MH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 19:06:47 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CQGuc-0002fD-54
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Nov 2004 19:06:47 -0800
In-Reply-To: <200411061002.38017.adaplas@hotpop.com>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>

On Sat, 2004-11-06 at 10:02 +0800, Antonino A. Daplas wrote:

> Currently, fbcon_blank() does the first method (pass blank unchanged),
> which means radeonfb is wrong. Adopting the second method will make
> radeonfb do the right thing, but will require changes to a lot of drivers.
> 
> So, what will it be then?

I'd rather define FB_BLANK_* constants and convert all drivers... the
conversion is trivial.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
