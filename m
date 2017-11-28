From: Jeremy Lacomis <j.lacomis@gmail.com>
Date: Tue, 28 Nov 2017 13:58:41 +0000
Subject: Re: [PATCH v2] staging: sm750b: Fix coding style issues in sm750_accel.c
Message-Id: <20171128135841.GA561@gs17931.sp.cs.cmu.edu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1511649387.20482.5.camel@perches.com>
 <20171125224812.23914-1-j.lacomis@gmail.com>
 <20171128131331.GA12924@kroah.com>
In-Reply-To: <20171128131331.GA12924@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Tue, Nov 28, 2017 at 02:13:31PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Nov 25, 2017 at 05:48:11PM -0500, Jeremy Lacomis wrote:
> > This is a patch to sm750_accel.c that fixes 80-character line length
> > warnings found by checkpatch.pl. It also fixes some grammatical errors
> > in comments and moves parameter-specific comments from inline to before
> > the function.
> > 
> > Signed-off-by: Jeremy Lacomis <j.lacomis@gmail.com>
> > ---
> > Changes in v2:
> > - Change function comments to the kernel-doc format
> > 
> >  drivers/staging/sm750fb/sm750_accel.c | 189 ++++++++++++++++++----------------
> >  1 file changed, 103 insertions(+), 86 deletions(-)
> > 
> > diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> > index 1035e91e7cd3..42cd920111bf 100644
> > --- a/drivers/staging/sm750fb/sm750_accel.c
> > +++ b/drivers/staging/sm750fb/sm750_accel.c
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > +/* SPDX-License-Identifier: GPL-2.0 */
> 
> Why did you change this line?  That is not correct.

Sorry about this Greg, I wasn't familiar with the format of the license
identifier line, and it seemed inconsistent with the rest of the comments at the
time.

> Only ever do one "logical" thing per patch.  If you have to say "also"
> in a changelog text, that's a huge hint you are doing something wrong.

I'll keep this in mind. I think my natural inclination is to be afraid that the
patches I'm sending in are _too_ trivial and breaking up these things into
several different patches would create more work for the maintainers.

Thanks,
- Jeremy
