From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sat, 01 Jun 2019 16:19:29 +0000
Subject: Re: [PATCH AUTOSEL 4.4 44/56] video: imsttfb: fix potential NULL pointer dereferences
Message-Id: <20190601161929.GA5028@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190601132600.27427-1-sashal@kernel.org>
 <20190601132600.27427-44-sashal@kernel.org>
In-Reply-To: <20190601132600.27427-44-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sasha Levin <sashal@kernel.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Kangjie Lu <kjlu@umn.edu>, linux-kernel@vger.kernel.org, Finn Thain <fthain@telegraphics.com.au>, stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>

On Sat, Jun 01, 2019 at 09:25:48AM -0400, Sasha Levin wrote:
> From: Kangjie Lu <kjlu@umn.edu>
> 
> [ Upstream commit 1d84353d205a953e2381044953b7fa31c8c9702d ]
> 
> In case ioremap fails, the fix releases resources and returns
> -ENOMEM to avoid NULL pointer dereferences.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Finn Thain <fthain@telegraphics.com.au>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [b.zolnierkie: minor patch summary fixup]
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/video/fbdev/imsttfb.c | 5 +++++
>  1 file changed, 5 insertions(+)

Why only 4.4.y?  Shouldn't this be queued up for everything or none?

thanks,

greg k-h
