From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] video: export sh_mobile_lcdc panel size
Date: Tue, 12 Aug 2008 12:20:18 +0900
Message-ID: <20080812032017.GB31588@linux-sh.org>
References: <20080811062600.19986.98178.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080811062600.19986.98178.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-sh@vger.kernel.org

On Mon, Aug 11, 2008 at 03:26:00PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Export the LCD panel size for sh_mobile_lcdc boards. This allows us
> to perform dpi and screen aspect ratio calculations in user space.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Paul, maybe this is material for the SuperH tree?
> 
Yes, applied, thanks.
