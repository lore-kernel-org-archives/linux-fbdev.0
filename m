From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 24 Jun 2015 09:28:41 +0000
Subject: Re: [PATCH] staging: sm750fb: use tabs for indentation
Message-Id: <20150624092841.GJ30834@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434761450-15722-1-git-send-email-juston.h.li@gmail.com>
 <20150622174601.GF28762@mwanda>
 <CAFow2F_AKeKc54EZu0QE5ovPkyuZ2bem9BUC1d-vf23k3p6exQ@mail.gmail.com>
In-Reply-To: <CAFow2F_AKeKc54EZu0QE5ovPkyuZ2bem9BUC1d-vf23k3p6exQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juston Li <juston.h.li@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Mon, Jun 22, 2015 at 11:30:30AM -0700, Juston Li wrote:
> On Mon, Jun 22, 2015 at 10:46 AM, Dan Carpenter
> <dan.carpenter@oracle.com> wrote:
> > On Fri, Jun 19, 2015 at 05:50:50PM -0700, Juston Li wrote:
> >>  void sii164ClearInterrupt(void)
> >>  {
> >> -    unsigned char detectReg;
> >> +     unsigned char detectReg;
> >>
> >> -    /* Clear the MDI interrupt */
> >> -    detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
> >> -    i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
> >
> > The patch accidentally deletes this write.
> >
> >> +     /* Clear the MDI interrupt */
> >> +     detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
> >>  }
> >
> > regards,
> > dan carpenter
> 
> This was fixed and patch is now included in the patchset:
> [PATCH v2 00/19] staging: sm750fb: checkpatch.pl fixes

Have you sent this patchset to the list?  I don't see it in my inbox.

regards,
dan carpenter

