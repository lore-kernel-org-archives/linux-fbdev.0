From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] sh: split coherent pages
Date: Wed, 17 Dec 2008 17:33:02 +0900
Message-ID: <20081217083302.GA6483@linux-sh.org>
References: <20081217082949.30120.83664.sendpatchset@rx1.opensource.se> <20081217081845.28528.20104.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081217082949.30120.83664.sendpatchset@rx1.opensource.se> <20081217081845.28528.20104.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, Dec 17, 2008 at 05:18:45PM +0900, Magnus Damm wrote:
> Split pages returned by dma_alloc_coherent() and make sure
> we free them one by one.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

On Wed, Dec 17, 2008 at 05:29:49PM +0900, Magnus Damm wrote:
> Since the sh_mobile_lcdc hardware has the framebuffer(s) in system RAM,
> use FB_SYS instead of FB_CFB. Also hook in read and write helpers.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Both applied, thanks.
