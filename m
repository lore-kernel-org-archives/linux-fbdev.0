From: Antonino Daplas <adaplas@pol.net>
Subject: Re: status
Date: 23 Nov 2002 02:45:03 +0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1038001500.12191.19.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0211220049430.17898-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0211220049430.17898-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2002-11-22 at 22:52, James Simmons wrote:
> 
> Hi folks!!!
> 
>    Just to let you know where I am for the fbdev developement. I finished 
> off the latest api changes. The cursor api has been cleaned up and it uses 
> fb_image struct. This makes life easier. 
>    I ported over the ATI 128 driver to the latest changes. I finished the 
> 3Dfx driver yesterday and got the ATI mach 64 driver done this morning.
> I will test it tomorrow. Then I will finsih up the NVIDIA driver. After 
> that I'm going to push the code to linus. 
Any patches in the meantime?  I have a few changes I can pass to you:

1. optimized putcs to speed up scrolling by 2-3x.  (it's a small patch
but it already outperforms fb-2.4 especially at high color depths).
Compared with the previous patch I submitted, this change is
non-intrusive, so no other changes are required.

2. vga16fb imageblit that supports drawing of the penguin (vga-4-planes
only)

3. logo drawing for directcolor visuals.

The above should complete softaccel support for most hardware except for
the more esoteric ones (mostly authored by Geert).

Also cfbcursor is a bit misleading, no?  It implies support for
packed-pixels only, but I already  use it with vga16fb.

Tony 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
