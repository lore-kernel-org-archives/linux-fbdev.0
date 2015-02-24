From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 24 Feb 2015 05:58:27 +0000
Subject: Re: [PATCH] staging/sm7xxfb: Make 'struct vgamode' static
Message-Id: <20150224054627.GA3371@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424690176-7966-1-git-send-email-peter.senna@gmail.com>
In-Reply-To: <1424690176-7966-1-git-send-email-peter.senna@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Senna Tschudin <peter.senna@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Mon, Feb 23, 2015 at 12:16:16PM +0100, Peter Senna Tschudin wrote:
> sparse was complaining that symbol 'vgamode' was not declared.
> 
> Declaring vgamode as static.
a similar patch has already been sent to Greg, which is not yet applied.

regards
sudip

> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
> ---
> -- 
> 2.1.0
> 
