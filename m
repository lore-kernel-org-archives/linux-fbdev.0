From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 25 Sep 2013 09:34:50 +0000
Subject: Re: [patch 2/2] backlight: lm3630: potential NULL deref in probe()
Message-Id: <20130925093450.GP6192@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130925085549.GB6661@elgon.mountain>
In-Reply-To: <20130925085549.GB6661@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Sep 25, 2013 at 06:13:28PM +0900, Jingoo Han wrote:
> On Wednesday, September 25, 2013 5:55 PM, Dan Carpenter wrote:
> > 
> > "rval" needs to be signed for the error handling to work.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> CC'ed Andrew Morton, Daniel Jeong,
> 

Ah.  I didn't realize this driver was going through Andrew.  I will
resend the patches.

regards,
dan carpenter

