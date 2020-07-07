From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 07 Jul 2020 19:47:14 +0000
Subject: Re: [PATCH 1/1] fbmem: add margin check to fb_check_caps()
Message-Id: <20200707194714.GA2571@kadam>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1594149963-13801-1-git-send-email-george.kennedy@oracle.com>
In-Reply-To: <1594149963-13801-1-git-send-email-george.kennedy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jul 07, 2020 at 03:26:03PM -0400, George Kennedy wrote:
> A fb_ioctl() FBIOPUT_VSCREENINFO call with invalid xres setting
> or yres setting in struct fb_var_screeninfo will result in a
> KASAN: vmalloc-out-of-bounds failure in bitfill_aligned() as
> the margins are being cleared. The margins are cleared in
> chunks and if the xres setting or yres setting is a value of
> zero upto the chunk size, the failure will occur.
> 
> Add a margin check to validate xres and yres settings.
> 
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>

Suggested-by is perhaps a bit strong.  Let's change that to:

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter
