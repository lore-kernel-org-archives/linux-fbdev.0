From: "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] sbusfb: Initialize cmap.transp in FBIOPUTCMAP_SPARC
Date: Sun, 6 Jun 2004 19:58:58 -0700
Sender: sparclinux-owner@vger.kernel.org
Message-ID: <20040606195858.6fe4c75e.davem@redhat.com>
References: <20040606010629.A23517@mail.kroptech.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20040606010629.A23517@mail.kroptech.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: sparclinux@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org

On Sun, 6 Jun 2004 01:06:29 -0400
Adam Kropelin <akropel1@rochester.rr.com> wrote:

> When handling FBIOPUTCMAP_SPARC, sbusfb fails to initialize cmap.transp,
> which quickly leads to an oops when fb_set_cmap() dereferences it.
> 
> First encountered in Aurora Wombat kernels and seems to afflict mainline
> as well. Patch is against 2.6.7-rc2. xorg still fails to actually get
> anything to display on my CG6, but at least it no longer oopses the kernel.
> 
> Signed-off-by: Adam Kropelin <akropel1@rochester.rr.com>

Applied, thanks a lot Adam.
