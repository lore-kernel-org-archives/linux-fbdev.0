From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix switch from XFree
Date: Tue, 10 Feb 2004 22:31:01 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1076412661.874.21.camel@gaston>
References: <1076409397.873.6.camel@gaston> <20040210110622.GA1913@lambda>
	 <1076411840.874.18.camel@gaston>  <20040210112820.GA2273@lambda>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqW6o-0000BK-2I
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 03:31:18 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AqW6b-0004eZ-Ng
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 03:31:05 -0800
In-Reply-To: <20040210112820.GA2273@lambda>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Or to use a different pipe, if the hardware provides accelerated context
> switching :)).

Do we really care ? This is VT switch...

> Ok, but for the mode, if you use UseFBdev, then the server will not
> touch the mode, and rather use the underlying fbdev infrastructure for
> it. Why not do something similar for 2D, and tell X that this version of
> the fbdev does indeed know how to fix the accel engine, and doesn't care
> about getting it in broken state.

It already doesn't care :) It doesn't save / restore the engine state

> Ok, i understand, but again, maybe if the fbdev doesn't care, there is
> no need for X trying to save/restore it ? Or whatever it tries to do.

It only does the mode, and only without FBDev

> I think we could decide on a sane policy for both fbdev and X to follow
> (for example, each one is in charge of resetting their mode/accel engine
> state), and then submit this policy to the XFree86 people to adhere too
> if the UseFBDev option is used. If XFree86 drivers do not implement it,
> then they are broken, and its their problem, but if they do, then we
> result in having the most economical context swithc possible.
> 
> Friendly,
> 
> Sven Luther
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
