From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] sh: sh7760fb: Fix color pallette setting
Date: Fri, 21 Nov 2008 16:46:54 +0900
Message-ID: <20081121074654.GA26414@linux-sh.org>
References: <492648A1.2090000@renesas.com> <49264861.6030205@renesas.com>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <492648A1.2090000@renesas.com> <49264861.6030205@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Linux-sh <linux-sh@vger.kernel.org>

On Fri, Nov 21, 2008 at 02:34:25PM +0900, Nobuhiro Iwamatsu wrote:
> The setting of the color palette was wrong, fixed it.
> And removed fb_setcmap, and added fb_setcolreg function.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

On Fri, Nov 21, 2008 at 02:35:29PM +0900, Nobuhiro Iwamatsu wrote:
> SH7720 and 7721 has IP of Frame Buffer same as SH7760.
> This driver can support these.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Applied, thanks.
