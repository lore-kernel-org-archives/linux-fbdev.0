From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb: add support for newer
	cards
Date: Tue, 02 Jan 2007 11:13:35 +1100
Message-ID: <1167696815.23340.154.camel@localhost.localdomain>
References: <20070101212551.GA19598@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1XHm-00067F-3Y for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 16:13:46 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX19Ha1U11+5KD9A2VFYL2vJb/oZzx0A3QZA=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H1XHk-0004bz-KK
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 16:13:46 -0800
In-Reply-To: <20070101212551.GA19598@dreamland.darkstar.lan>
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
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Solomon Peachy <pizza@shaftnet.org>, linux-kernel@vger.kernel.org

On Mon, 2007-01-01 at 22:25 +0100, Luca Tettamanti wrote:
> Hi Ben, Andrew,
> I've rebased 'ATOM BIOS patch' from Solomon Peachy to apply to 2.6.20.
> The patch adds support for newer Radeon cards and is mainly based on
> X.Org code.
> 
> I've fixed a few things:
> - Port sharing in radeon_get_conn_info_atom; old code didn't actually
>   deal with it leading to wrong monitor detection
> - Don't try to use I2C bus if BIOS says that there's no DDC channel,
>   otherwise bad things happen:
>   http://marc.theaimsgroup.com/?l=linux-fbdev-devel&m=116455601620186&w=2
> - Make it compile on PPC (hopefully...)
> - Cleanup whitespaces and coding style (only in the code alreay affected
>   by the patch, I didn't touched all the driver...)
> 
> Signed-Off-By: Luca Tettamanti <kronos.it@gmail.com>
> Signed-Off-By: Solomon Peachy <pizza@shaftnet.org> (I guess...)

I've done my own changes here. Can you send me a patch against Solomon's
version of the driver instead of a combined patch ?

Ben.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
