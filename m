From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 23 Jun 2015 08:55:48 +0000
Subject: Re: [PATCH 6/8] Staging: sm750fb: ddk750_sii164.c: Place braces on previous lines
Message-Id: <20150623085548.GM28762@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434743301-14774-1-git-send-email-isaac.a.travers@gmail.com>
 <1434743301-14774-7-git-send-email-isaac.a.travers@gmail.com>
 <20150620072402.GA15195@sudip-PC>
In-Reply-To: <20150620072402.GA15195@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Isaac Assegai <isaac.a.travers@gmail.com>, devel@driverdev.osuosl.org, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, teddy.wang@siliconmotion.com

On Sat, Jun 20, 2015 at 12:54:02PM +0530, Sudip Mukherjee wrote:
> On Fri, Jun 19, 2015 at 12:48:19PM -0700, Isaac Assegai wrote:
> > Place braces on previous lines in ddk750_sii164.c to
> > rectify the following checkpatch errors:
> > ERROR: that open brace { should be on the previous line
> > 
> > Signed-off-by: Isaac Assegai <isaac.a.travers@gmail.com>
> > ---
> >  drivers/staging/sm750fb/ddk750_sii164.c | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
> > index 7f58fbe..64d4291 100644
> > --- a/drivers/staging/sm750fb/ddk750_sii164.c
> > +++ b/drivers/staging/sm750fb/ddk750_sii164.c
> > @@ -136,8 +136,7 @@ long sii164InitChip(
> >  #endif
> >  
> >  	/* Check if SII164 Chip exists */
> > -	if ((sii164GetVendorID() = SII164_VENDOR_ID) && (sii164GetDeviceID() = SII164_DEVICE_ID))
> > -	{
> > +	if ((sii164GetVendorID() = SII164_VENDOR_ID) && (sii164GetDeviceID() = SII164_DEVICE_ID) {
> 												^^^^
> you have not build tested it :(
> In function ‘sii164InitChip’:
> error: expected ‘)’ before ‘{’ token
> 

I never get Isaac's emails.  I think gmail is still sending them to the
Spam folder?  I searched my spam folder and don't see them though...

regards,
dan carpenter

