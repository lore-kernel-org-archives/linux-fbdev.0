From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: [Linux-fbdev-devel] New FBDev patch
Date: Fri, 9 Jan 2004 18:17:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040109171733.GA13027@dreamland.darkstar.lan>
References: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Il Thu, Jan 08, 2004 at 10:03:54PM +0000, James Simmons ha scritto: 
> 
> This is the latest patch against 2.6.0-rc3. Give it a try.
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

> <kronos@kronoz.cjb.net> (03/09/17 1.1267.40.1)
>    Add new API framebuffer_alloc and framebuffer_release.
>    
>    Framebuffer info structure (ie. struct fb_info) must be obtained from
>    framebuffer_alloc. When it is no longer needed (after unregister_framebuffer
>    and clean up) it can be released using framebuffer_release.
>    
>    If the framebuffer is not registered yet (eg. on error path) then fb_info must
>    be released via kfree. 


Are we sure that we want this for 2.6? Greg KH has a much less intrusive
patch, maybe you should take that instead and keep my work 2.7.

If you decide to go with framebuffer_alloc then I have more patches for
you ;)

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
I went to God just to see
And I was looking at me
Saw heaven and hell were lies
When I'm God everyone dies
