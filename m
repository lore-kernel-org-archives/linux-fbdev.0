From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 0/4] fbdev: uvesafb
Date: Tue, 26 Jun 2007 11:42:41 +0100
Message-ID: <20070626104241.GR8547@earth.li>
References: <20070623104920.GA12623@spock.one.pl>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756862AbXFZLOm@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070623104920.GA12623@spock.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Januszewski <spock@gentoo.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sat, Jun 23, 2007 at 12:49:20PM +0200, Michal Januszewski wrote:
> uvesafb is a generic driver for VBE2+ compliant video cards; an enhanced
> version of vesafb and a direct successor of vesafb-tng [1].
> 
> uvesafb uses a userspace helper application (v86d, [2]) to run the x86
> Video BIOS code.  This makes it possible to include in uvesafb all the
> standard features (refresh rate control, video mode changes etc) that
> are missing from vesafb without resorting to ugly hacks such as the ones
> used in [1].  The current implementation of v86d can use either LRMI or
> x86emu to run the BIOS code and supports both x86 and x86_64.

Have you considered using libx86[1] in v86d? It looks very similar to
what you have at present and there are plans to extend it to non
x86(_64) archs.

J.

[1] http://www.codon.org.uk/~mjg59/libx86/

-- 
] http://www.earth.li/~noodles/ []         noodles is criminal         [
]  PGP/GPG Key @ the.earth.li   []                                     [
] via keyserver, web or email.  []                                     [
] RSA: 4DC4E7FD / DSA: 5B430367 []                                     [
