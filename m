From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [git tree] Intel i9xx support for
 intelfb
Date: Wed, 22 Mar 2006 22:01:21 -0800
Message-ID: <20060322220121.5c402174.akpm@osdl.org>
References: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>
	<b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMIwD-0001Iy-CC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Mar 2006 22:04:49 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1FMIwC-0003Yk-4m
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 22 Mar 2006 22:04:49 -0800
In-Reply-To: <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com>
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
To: Antonino Daplas <adaplas@gmail.com>, Dave Airlie <airlied@linux.ie>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, sylvain.meyer@worldonline.fr

"Antonino Daplas" <adaplas@gmail.com> wrote:
>
> > The code is also available in the i915fb branch or
> > git://git.kernel.org/pub/scm/linux/kernel/git/airlied/intelfb-2.6
> >
> > It may need more testing on the i945G, and I think adding i945GM
> > support might only be a few lines of code...
> >
> > Is there a framebuffer git tree this could go in?
> 
> There's no git tree for the framebuffer layer, I just send updates
> directly to akpm. Andrew?
> 

I added Dave's git tree to the -mm lineup.  Haven't tried fetching it
it yet though.

If you're OK with it all then Dave can ask Linus to pull it direct when
he's ready.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
