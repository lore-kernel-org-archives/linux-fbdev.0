From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Dec 2010 15:59:12 +0000
Subject: Re: [PATCH] s1d13xxxfb: drop unused code
Message-Id: <20101220155912.GC26766@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101217190013.0107a93a@queued.net>
In-Reply-To: <20101217190013.0107a93a@queued.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andres Salomon <dilinger@queued.net>
Cc: akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 17, 2010 at 07:00:13PM -0800, Andres Salomon wrote:
> 
> Silence warnings such as -
> 
> drivers/video/s1d13xxxfb.c:421: warning: ???bltbit_wait_bitset??? defined but not used
> 
> Just drop the unused code.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>

Applied, thanks.
