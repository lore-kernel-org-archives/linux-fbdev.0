From: Antonino Daplas <adaplas@pol.net>
Subject: Re: status
Date: 23 Nov 2002 03:12:15 +0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1038003170.12191.24.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0211221902540.5899-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0211221902540.5899-100000@phoenix.infradead.org>
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

On Sat, 2002-11-23 at 00:04, James Simmons wrote:
> 
> > Any patches in the meantime?  I have a few changes I can pass to you:
> 
> Yes of course!!!!
> 
I mean, do you have patches against vanilla linux?  I currently don't
have bk right now.  I browsed the bk repository, and it seems you made a
lot of changes.

> > 1. optimized putcs to speed up scrolling by 2-3x.  (it's a small patch
> > but it already outperforms fb-2.4 especially at high color depths).
> > Compared with the previous patch I submitted, this change is
> > non-intrusive, so no other changes are required.
> >
> > 2. vga16fb imageblit that supports drawing of the penguin (vga-4-planes
> > only)
> > 
> > 3. logo drawing for directcolor visuals.
> 
> Please send me those patches ASAP!!! I will linclude them right away.
I can, but against 2.5.48 only + your old fbdev.diff.  You might have a
hard time merging it to your repository.

>  
> > The above should complete softaccel support for most hardware except for
> > the more esoteric ones (mostly authored by Geert).
> 
> Geert is busy porting the Amigia driver to the new api. That means all the 
> ilbm, iplan stuff will go away :-) 
> 
> > Also cfbcursor is a bit misleading, no?  It implies support for
> > packed-pixels only, but I already  use it with vga16fb.
> 
> OOps. You are right. What should we call it?
> 
I don't know, gen_cursor?

Tony




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
