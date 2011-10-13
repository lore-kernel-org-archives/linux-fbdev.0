From: Greg KH <greg@kroah.com>
Date: Thu, 13 Oct 2011 15:10:14 +0000
Subject: Re: linux-next: manual merge of the staging tree with the fbdev tree
Message-Id: <20111013151014.GA28061@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111013170225.254bc2d590deee544913ab6c@canb.auug.org.au>
In-Reply-To: <20111013170225.254bc2d590deee544913ab6c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>

On Thu, Oct 13, 2011 at 05:02:25PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the staging tree got a conflict in
> drivers/staging/xgifb/XGI_main_26.c between commit 0d5c6ca30bb0
> ("staging: xgifb: use display information in info not in var for
> panning") from the fbdev tree and commit fd26d42019cb ("staging: xgifb:
> avoid direct references xgi_video_info") from the staging tree.
> 
> I fixed it up (I think - see below) and can carry the fix as necessary.

The fix looks correct to me, thanks.

greg k-h
