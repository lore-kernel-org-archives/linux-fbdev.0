From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 Mar 2011 07:09:43 +0000
Subject: Re: [patch v2] fbdev: sh_mobile_lcdc: checking NULL instead of IS_ERR()
Message-Id: <20110322070943.GE25925@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110321150313.GQ2008@bicker>
In-Reply-To: <20110321150313.GQ2008@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Mar 21, 2011 at 06:03:13PM +0300, Dan Carpenter wrote:
> backlight_device_register() returns an ERR_PTR.  It doesn't return NULL.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> V2:  print the error code as well.
> This patch is againts linux-next, in case you missed that earlier.
> 
Applied, thanks.
