From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb and 16bit color problem
Date: Mon, 24 Jun 2002 05:24:11 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020624032412.27294@192.168.4.1>
References: <20020620212958.B20756@bokeoa.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from n147.ols.wavesec.net ([209.151.19.147] helo=zion.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Mr8U-0000e0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Jun 2002 07:17:39 -0700
In-Reply-To: <20020620212958.B20756@bokeoa.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Bryan Stillwell <bryan@bokeoa.com>, linux-fbdev-devel@lists.sourceforge.net

>Any ideas would be helpful.  I tried looking at the code myself, but I'm
>still quite new to the framebuffer code.  However, this part looked kind
>of strange to me:
>
>   /* For 565, the green component is mixed one order below */
>   if (rinfo->depth == 16) {
>      OUTREG(PALETTE_INDEX, pindex>>1);
>      OUTREG(PALETTE_DATA, (rinfo->palette[regno>>1].red << 16) |
>             (green << 8) | (rinfo->palette[regno>>1].blue));
>      green = rinfo->palette[regno<<1].green;
>   }
>
>
>BTW, I have a Radeon 8500 (QL).

I wrote that part and it works just fine on my powerbook... at least with
the radeonfb version that is in my tree, but I don't think it differs
from the official one in this regard. You can try making sure it's properly
setting 32 palette entries for green when using that mode.

Ben.




-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
