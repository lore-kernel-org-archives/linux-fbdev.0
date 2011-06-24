From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Jun 2011 07:41:05 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_meram: Correct pointer check for YCbCr chroma plane
Message-Id: <20110624074105.GD26504@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308728785-9588-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1308728785-9588-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Jun 22, 2011 at 04:46:25PM +0900, Damian Hobson-Garcia wrote:
> The check was intended to test if we have a valid pointer to write into,
> but it mistakenly checks the pointer contents instead.
> 
> Since a valid pointer is mandatory for the chroma data if a YCbCr format
> is used, the pointer check has been removed.
> 
> Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
> ---
> Sorry, forgot to sign off the previous version.  Resend
>  drivers/video/sh_mobile_meram.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
Applied, thanks.
