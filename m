From: Nicolas Souchu <nsouch@free.fr>
Subject: Re: [Linux-fbdev-devel] Redesign of kernel graphics interface
Date: Thu, 6 May 2004 23:19:53 +0000
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <20040506231953.B23760@armor.freesurf.fr>
References: <20040506181639.61975.qmail@web14929.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040506181639.61975.qmail@web14929.mail.yahoo.com>; from jonsmirl@yahoo.com on Thu, May 06, 2004 at 11:16:39AM -0700
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Thu, May 06, 2004 at 11:16:39AM -0700, Jon Smirl wrote:
> At the X Developers Conference there was a discussion of the issues around
> framebuffer and DRI. Theodore Ts'o suggested that I write it up and post it for
> discussion. I'm going to try and list all of the issues I've heard from all
> sides so some of the proposed solutions are in conflict. The goal of this list
> is to provide direction for a topic discussion at the Ottawa Kernel Summit.

[...]
> A major topic that I missed in the original list was how to handle BSD. DRM is
> under the BSD license and FB is GPL. If these two code bases are merged, what
> are we going to do about BSD? I don't know the appropriate BSD lists to post
> this to so please forward as necessary.

What is exactly your question concerning licenses?

> Another topic that I missed was, why did kgi fail and what can we do to avoid
> repeating the same path this time around.

KGI failed to be accepted by linus/linux. You surely don't want repeating this ;)
Otherwise, its design is still valid, I believe.

-- 
Nicholas Souchu - nsouch@free.fr - nsouch@FreeBSD.org


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
