From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev: don't allow to set a video
 mode via vga= if FB doesn't support it
Date: Mon, 22 Sep 2008 13:54:38 -0700
Message-ID: <20080922135438.c8a10da7.akpm@linux-foundation.org>
References: <20080921210219.GC21215@spock.one.pl>
	<20080922214747.c8bc57eb.krzysztof.h1@poczta.fm>
	<20080922220054.4e74c099@neptune.home>
	<5d9b736f0809221332q21dea0a1lb8159b64391ee978@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753367AbYIVUzi@vger.kernel.org>
In-Reply-To: <5d9b736f0809221332q21dea0a1lb8159b64391ee978@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Michal Januszewski <michalj@gmail.com>
Cc: bonbons@linux-vserver.org, krzysztof.h1@poczta.fm, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Mon, 22 Sep 2008 22:32:40 +0200
"Michal Januszewski" <michalj@gmail.com> wrote:

> On Mon, Sep 22, 2008 at 22:00, Bruno Pr__mont <bonbons@linux-vserver.org> wrote:
> 
> > This looks pretty much the same as what I requested some time ago:
> >
> > http://bugzilla.kernel.org/show_bug.cgi?id=8062
> >
> > Would need to check -mm archives for the actual patch.
> >
> > Don't remember why it did not make it to mainline...
> 
> Well, the bug and the mm fix [1] are about a similar, yet slightly different
> issue than the one I'm trying to fix with my patch (note that the issue
> reported in the bug is currently fixed in the kernel, but the actual fix
> is differrent than the one in -mm due to x86 boot code refactoring
> that took place since then).
> 
> My patch fixes the case where the framebuffer is enabled, but none of
> the drivers support boot-time video mode setting, whereas the old
> patch fixed the case where it was possible to set a video mode even
> though the kernel didn't contain the framebuffer layer.
> 
> [1] http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.21-rc2/2.6.21-rc2-mm1/broken-out/fbdev-ignore-vesa-modes-if-framebuffer-is-disabled.patch
> 

OK.  It was merged into mainline but was later reverted by Linus:


commit 01e73be3c8f254ef19d787f9b6757468175267eb
Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date:   Tue May 8 20:12:30 2007 -0700

    Revert "fbdev: ignore VESA modes if framebuffer is disabled"
    
    This reverts commit 464bdd33e9baad9806c7adbd8dfc37081a55f27e.
    
    Peter Anvin correctly points out that VESA modes have nothing to do with
    frame buffers per se - they are often just regular extended text modes.
    Disabling them just because we don't have frame buffer support is very
    wrong.
    
    Cc: H. Peter Anvin <hpa@zytor.com>
    Cc: Antonino A. Daplas <adaplas@gmail.com>,
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
