From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 12 Jan 2011 06:00:23 +0000
Subject: Re: [PATCH 05/16] s3c2410fb: don't treat NULL clk as an error
Message-Id: <20110112060022.GB2350@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294749833-32019-1-git-send-email-jamie@jamieiles.com> <1294749833-32019-6-git-send-email-jamie@jamieiles.com>
In-Reply-To: <1294749833-32019-6-git-send-email-jamie@jamieiles.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-kernel@vger.kernel.org, Vincent Sanders <support@simtec.co.uk>, linux-fbdev@vger.kernel.org

On Tue, Jan 11, 2011 at 12:43:42PM +0000, Jamie Iles wrote:
> clk_get() returns a struct clk cookie to the driver and some platforms
> may return NULL if they only support a single clock.  clk_get() has only
> failed if it returns a ERR_PTR() encoded pointer.
> 
> Cc: Vincent Sanders <support@simtec.co.uk>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Applied, thanks.
