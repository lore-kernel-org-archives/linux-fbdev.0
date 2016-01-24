From: Greg KH <gregkh@linuxfoundation.org>
Date: Sun, 24 Jan 2016 20:50:46 +0000
Subject: Re: [PATCH] staging: sm750fb: cleanup: fix brace placement
Message-Id: <20160124205046.GA8292@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1453246935-5037-1-git-send-email-charles.rose.linux@gmail.com>
In-Reply-To: <1453246935-5037-1-git-send-email-charles.rose.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Jan 22, 2016 at 01:45:18PM -0500, Charles Rose wrote:
> On 01/19/2016 06:42 PM, Charles Rose wrote:
> >Fix brace placement warnings caught by checkpatch.pl.
> >
> >Signed-off-by: Charles Rose <charles.rose.linux@gmail.com>
> >---
> >  drivers/staging/sm750fb/sm750_cursor.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> >diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
> >index 3b7ce92..cab891c 100644
> >--- a/drivers/staging/sm750fb/sm750_cursor.c
> >+++ b/drivers/staging/sm750fb/sm750_cursor.c
> >@@ -143,8 +143,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
> >  		iowrite16(data, pbuffer);
> >
> >  		/* assume pitch is 1,2,4,8,...*/
> >-		if ((i+1) % pitch = 0)
> >-		{
> >+		if ((i+1) % pitch = 0) {
> >  			/* need a return */
> >  			pstart += offset;
> >  			pbuffer = pstart;
> >
> 
> Missed copying Greg KH on this.

I can't do anything with a forwarded patch like this :(
