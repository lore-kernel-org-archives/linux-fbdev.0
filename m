From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove voodoo code from i2c
Date: Sat, 06 Mar 2004 10:55:14 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1078530914.5700.127.camel@gaston>
References: <20040305215210.GA23402@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzPPX-00065U-Ap
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Mar 2004 16:11:23 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AzOqH-0006Nv-6W
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Mar 2004 15:34:57 -0800
In-Reply-To: <20040305215210.GA23402@dreamland.darkstar.lan>
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
To: Kronos <kronos@kronoz.cjb.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2004-03-06 at 08:52, Kronos wrote:
> Hi,
> radeon_probe_i2c_connector contains very strange code that just send
> empty start-stop sequencies on the I2C bus. I copied the code from
> XFree86, but speaking with I2C gurus the general feeling is that this
> code can go away without any harm. I tested it on 3 different setup (all
> x86...) and it works well. I don't have any "old" monitor around to
> fiddle with though.
> 
> Oh, if you think that this code should stay I'll send you another patch
> to make it more readable.

I'd rather keep the code as close to XFree as possible at this point..

BTW... I'm still looking for an EDID spec if that exist ;)

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
