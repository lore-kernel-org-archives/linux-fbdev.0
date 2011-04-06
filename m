From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Apr 2011 16:45:51 +0000
Subject: Re: [PATCH] video: s3c-fb: fix checkpatch errors and warning
Message-Id: <20110406164550.GC11820@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301642247-20926-1-git-send-email-jg1.han@samsung.com>
In-Reply-To: <1301642247-20926-1-git-send-email-jg1.han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Apr 01, 2011 at 04:17:27PM +0900, Jingoo Han wrote:
> This patch fixes the checkpatch errors listed below:
> 
> ERROR: space required before the open parenthesis '('
> ERROR: need consistent spacing around '+' (ctx:WxV)
> ERROR: space prohibited before that close parenthesis ')'
> 
> Also, following warning is fixed by adding 'platid' variable
> which can reduce number of lines exceeding 80 characters.
> 
> WARNING: line over 80 characters
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied, thanks.
