From: Isaac Assegai <isaac.a.travers@gmail.com>
Date: Tue, 02 Jun 2015 07:55:22 +0000
Subject: Re: [PATCH 12/12] Staging: sm750fb: Insert spaces after commas in three files.
Message-Id: <20150602075522.GA10942@ubuntu-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433134873-9869-1-git-send-email-isaac.a.travers@gmail.com>
 <1433134873-9869-13-git-send-email-isaac.a.travers@gmail.com>
 <20150602064806.GF6382@sudip-PC>
In-Reply-To: <20150602064806.GF6382@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: gregkh@linuxfoundation.org, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Tue, Jun 02, 2015 at 12:18:06PM +0530, Sudip Mukherjee wrote:
> On Sun, May 31, 2015 at 10:01:13PM -0700, Isaac Assegai wrote:
> > Insert Spaces after commas to rectify the following checkpatch
> > errors in ddk750_mode.c, sm750_accel.c and sm750_help.h:
> > ERROR: space required after that ','
> > 
> > Signed-off-by: Isaac Assegai <isaac.a.travers@gmail.com>
> > ---
> >  drivers/staging/sm750fb/ddk750_mode.c | 46 +++++++++++++++++------------------
> >  drivers/staging/sm750fb/sm750_accel.c |  2 +-
> >  drivers/staging/sm750fb/sm750_help.h  |  2 +-
> >  3 files changed, 25 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > index 4e252fb..a054747 100644
> > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > @@ -101,29 +101,29 @@ static int programModeRegisters(mode_parameter_t * pModeParam, pll_value_t * pll
> >              | FIELD_VALUE(0, CRT_VERTICAL_SYNC, START, pModeParam->vertical_sync_start - 1));
> >  
> >  
> > -		ulTmpValue = FIELD_VALUE(0, CRT_DISPLAY_CTRL,VSYNC_PHASE, pModeParam->vertical_sync_polarity)|
> > +		ulTmpValue = FIELD_VALUE(0, CRT_DISPLAY_CTRL, VSYNC_PHASE, pModeParam->vertical_sync_polarity)|
> >  					  FIELD_VALUE(0, CRT_DISPLAY_CTRL, HSYNC_PHASE, pModeParam->horizontal_sync_polarity)|
> > -					  FIELD_SET(0, CRT_DISPLAY_CTRL, TIMING,ENABLE)|
> > -					  FIELD_SET(0,CRT_DISPLAY_CTRL,PLANE,ENABLE);
> > +					  FIELD_SET(0, CRT_DISPLAY_CTRL, TIMING, ENABLE)|
> > +					  FIELD_SET(0, CRT_DISPLAY_CTRL, PLANE, ENABLE);
> I am getting confused now.
> This part you have modified in patch 10/12 and i just replied that
> you have missed two modifications.
> 
> regards
> sudip
Thanks for your feedback Sudip, I have a few questions:
1. After applying the first 11 patches I ran checkpatch again and noticed that
I missed three warnings so I ran a 12th patch fixing them. That's why you
see the 12th patch modifying a file that another patch already touched.
What should be done in this type of situation?

2. On Patch 3 you pointed out two trailing whitespace errors.
I ran checkpatch on all the patches before I sent them to
make sure I didn't introduce any new errors, however
there are *many* warnings and errors showing up from
the poor styling already present and I missed these
whitespace errors in the mess.
Can I make checkpatch suppress any errors that might have already
been present in the code and only show me those issues introduced
by the patch itself? If not, how did you identify it?

Thanks,
Isaac
