From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH 1/4] gxfb: Replace FBSIZE config
	option with a kernel argument
Date: Sun, 9 Mar 2008 23:00:25 +0100
Message-ID: <20080309220025.GD9971@localhost.localdomain>
References: <20080223011045.48e6cb8e@ephemeral>
	<20080227163105.e1b96023.akpm@linux-foundation.org>
	<20080227195839.1e86074e@ephemeral>
	<20080308201950.28f6eae8@ephemeral>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JYTZT-0005dk-OK for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 09 Mar 2008 15:00:43 -0700
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.10])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JYTZS-0001Pr-6H
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 09 Mar 2008 15:00:43 -0700
Content-Disposition: inline
In-Reply-To: <20080308201950.28f6eae8@ephemeral>
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
To: Andres Salomon <dilinger@queued.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Sat, Mar 08, 2008 at 08:19:50PM -0500, Andres Salomon wrote:
> > assuming this is historical at this point, and manual options parsing can
> > be removed from all fb drivers at this point, or is there another reason
> > why manual parsing would be necessary?
> > 
> 
> Could I get an answer from the fbdevel folks about this?  It looks like
> the fb_get_options stuff is there for backwards compatibility.

I think so. I used fb_get_options() in arkfb and vt8623fb for mode option
only. Universal notation module.option=value is much nicer than manual
options parsing.  

-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
