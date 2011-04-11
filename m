From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 11 Apr 2011 16:40:13 +0000
Subject: Re: [PATCH] video: s3c-fb: make runtime pm functions static
Message-Id: <20110411164013.GC13545@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1302506578-21676-1-git-send-email-jg1.han@samsung.com>
In-Reply-To: <1302506578-21676-1-git-send-email-jg1.han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Apr 11, 2011 at 04:22:58PM +0900, Jingoo Han wrote:
> This patch makes runtime pm functions static.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

On Mon, Apr 11, 2011 at 04:25:37PM +0900, Jingoo Han wrote:
> The spinlock is added to interrupt routine to ensure that the driver
> is protected against multiple accesses.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Both applied, thanks.
