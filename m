From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 09 Mar 2015 12:55:13 +0000
Subject: Re: [PATCH v2 4/4] staging: sm750fb: fix undeclared function
Message-Id: <20150309125503.GB11724@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425886506-8643-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1425886506-8643-4-git-send-email-sudipm.mukherjee@gmail.com>
 <20150309124222.GE10964@mwanda>
In-Reply-To: <20150309124222.GE10964@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 09, 2015 at 03:42:22PM +0300, Dan Carpenter wrote:
> On Mon, Mar 09, 2015 at 01:05:06PM +0530, Sudip Mukherjee wrote:
> > kbuild test robot reported that for microblaze-allyesconfig
> > chan_to_field() and lynxfb_ops_set_par() were not defined. These two
> > functions were defined under CONFIG_PM, so for any archtecture if
> > CONFIG_PM is not defined we will have this error.
> > 
> > while moving the lynxfb_suspend() function some very obvious
> > checkpatch errors, like space after comma, space after if, space
> > before opening brace, were taken care of.
> 
> I have a script to review patches moving functions around but these
> white space changes break my script so I have to review it by hand.
> Sucks.

oops . sorry ..
> 
> >  static int lynxfb_ops_set_par(struct fb_info * info)
<snip>
> >  static inline unsigned int chan_to_field(unsigned int chan,struct fb_bitfield * bf)
> >  {
> >  	chan &= 0xffff;
> 
> These white space changes are not related.
if you want i can break it into multiple patches, so that reviewing can be easy and your script will not break :) .
Actually I thought, since this is a vendor crude driver there will be many such changes, so if i can combine some changes together then atleast the number of patches can be kept low and also i thought of clubbing these changes together as Joe Perches once told me "Don't get carried away with patch type separation" (reference: https://lkml.org/lkml/2015/1/1/2).

regards
sudip

> 
> regards,
> dan carpenter
> 
