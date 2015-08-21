From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 21 Aug 2015 09:53:52 +0000
Subject: Re: [patch] fbdev: fix snprintf() limit in show_bl_curve()
Message-Id: <20150821095352.GQ5610@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150821085302.GE25369@mwanda>
In-Reply-To: <20150821085302.GE25369@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Aug 21, 2015 at 12:22:03PM +0300, Andy Shevchenko wrote:
> On Fri, 2015-08-21 at 11:53 +0300, Dan Carpenter wrote:
> > The limit should be "PAGE_SIZE - len" instead of PAGE_SIZE.
> > 
> 
> Besides that was in the original code, the problem still might happen
> when FB_BACKLIGHT_LEVELS is set to 171+ since snprintf() returns
> desired length. I suppose you would change this to check len on each
> iteration or change to scnprintf() if I get it correct.
> 

Yeah, you're right.

If you pass a negative size to snprintf() it won't overflow, but it will
print an error.  I will send a v2 and change it to scnprintf().  I don't
think we will have 171 levels so it's not worth adding the check?

regards,
dan carpenter

