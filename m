From: Nicolas Boichat <nicolas@boichat.ch>
Subject: Re: [PATCH] fbdev: rivafb I2C timings too fast
Date: Wed, 15 Sep 2004 00:06:54 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1095199614.7037.27.camel@tom>
References: <200409150553.20272.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7LSV-0003d4-Cs
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Sep 2004 15:07:31 -0700
Received: from b1.ovh.net ([213.186.33.51] helo=mail44.ha.ovh.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34)
	id 1C7LSS-0002XD-Hp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Sep 2004 15:07:31 -0700
In-Reply-To: <200409150553.20272.adaplas@hotpop.com>
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

On Tue, 2004-09-14 at 23:53, Antonino A. Daplas wrote:
> The timings in rivafb's i2c, although enough for EDID reading, are too fast
> for some user applications. Reported by Nicolas Boichat
> <nicolas@boichat.ch>.
> 
> This patch increases the timeouts.

Thank you.

Best regards,

Nicolas



-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
