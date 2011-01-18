From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Jan 2011 04:38:51 +0000
Subject: Re: [PATCH] video: pxa3xx-gcu: Return -EFAULT when copy_from_user() fails
Message-Id: <20110118043851.GH2122@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294997951.12295.1.camel@mola>
In-Reply-To: <1294997951.12295.1.camel@mola>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Janine Kropp <nin@directfb.org>, Denis Oliver Kropp <dok@directfb.org>, Eric Miao <eric.y.miao@gmail.com>, linux-fbdev@vger.kernel.org

On Fri, Jan 14, 2011 at 05:39:11PM +0800, Axel Lin wrote:
> Return -EFAULT instead of number of bytes that could not be copied if
> copy_from_user() fails.
> 
> Also fix a typo in the comments.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.
