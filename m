From: James Simmons <jsimmons@infradead.org>
Subject: Re: status
Date: Fri, 22 Nov 2002 19:04:50 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211221902540.5899-100000@phoenix.infradead.org>
References: <1038001500.12191.19.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <1038001500.12191.19.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Any patches in the meantime?  I have a few changes I can pass to you:

Yes of course!!!!

> 1. optimized putcs to speed up scrolling by 2-3x.  (it's a small patch
> but it already outperforms fb-2.4 especially at high color depths).
> Compared with the previous patch I submitted, this change is
> non-intrusive, so no other changes are required.
>
> 2. vga16fb imageblit that supports drawing of the penguin (vga-4-planes
> only)
> 
> 3. logo drawing for directcolor visuals.

Please send me those patches ASAP!!! I will linclude them right away.
 
> The above should complete softaccel support for most hardware except for
> the more esoteric ones (mostly authored by Geert).

Geert is busy porting the Amigia driver to the new api. That means all the 
ilbm, iplan stuff will go away :-) 

> Also cfbcursor is a bit misleading, no?  It implies support for
> packed-pixels only, but I already  use it with vga16fb.

OOps. You are right. What should we call it?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
