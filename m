From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: Feature Freeze?
Date: Wed, 5 Mar 2003 12:05:29 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030305110529.GA2036@iliana>
References: <1046852721.1228.13.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233] helo=mel-rto3.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qWic-00084o-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 03:05:50 -0800
Content-Disposition: inline
In-Reply-To: <1046852721.1228.13.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Mar 05, 2003 at 04:26:04PM +0800, Antonino Daplas wrote:
> 
> Hi,
> 
> I believe it's time to finalize what is needed/not needed for the
> framebuffer framework:
> 
> 1. Text mode support?

Would this work also on arches which don't traditionnaly do text mode ?
Like ppc for example. 

> 2. console resizing using fbset (besides stty)?

What about dynamic multi-head support ?

> 7. Anything else?

Well, what is the exact status of mult-head and multi-seat ? It is
supposed to work, but i did not (yet) experience it myself, mainly
because non of my graphic cards are yet supported. One point i would
like to see addressed is the ability to share one framebuffer and have
both heads be separate viewports into this same framebuffer. This
means setting a framebuffer with a stride equal to the sum of both's
head resolution and having each head display a subset of it. This would
also include having one head be a mirror of the other and other such
things. This feature and resizing may cause problems though.

> 8. feature freeze deadline?

This would be for fbdev deature freeze, right, not for the drivers ?

BTW, i will no more be able to work on pm3fb, since i just recently
noticed that my nice AGP8 supporting motherboard doesn't accept my
Appian Jeronimo 2000 board. :(((

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
