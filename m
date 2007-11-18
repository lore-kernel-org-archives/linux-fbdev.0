From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fb_ddc: Fix DDC lines quirk
Date: Mon, 19 Nov 2007 07:40:04 +1100
Message-ID: <1195418404.6638.2.camel@pasglop>
References: <20071118142141.22a1e753@hyperion.delvare>
Reply-To: benh@kernel.crashing.org,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ItqwS-0000qL-Jp for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Nov 2007 12:40:32 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX18N1wl3bzQcFkOUhSjjtlJLrsVL67dGtBQ=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ItqwP-0000o6-3w
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Nov 2007 12:40:30 -0800
In-Reply-To: <20071118142141.22a1e753@hyperion.delvare>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@gmail.com>


On Sun, 2007-11-18 at 14:21 +0100, Jean Delvare wrote:
> 
> On top of that, as it appears that this code has been broken for one
> year now and nobody seems to have complained, I'm curious if it makes
> sense to keep this quirk in place. It makes the code more complex and
> slower just for the sake of monitors which I guess nobody uses
> anymore. Can't we just get rid of it?
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

I'll have to double check, I suspect some Apple monitors may choke on
the "proper" way of releasing the lines (shut down assuming no more host
is connected, some stupid trick they do). I'll test when I get a chance.

Regarding the quirk, well... I think the X folks are tempted to get rid
of it too.

Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
