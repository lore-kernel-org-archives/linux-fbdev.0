From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 02 Jun 2015 08:37:56 +0000
Subject: Re: [PATCH 12/12] Staging: sm750fb: Insert spaces after commas in three files.
Message-Id: <20150602082555.GA4436@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433134873-9869-1-git-send-email-isaac.a.travers@gmail.com>
 <1433134873-9869-13-git-send-email-isaac.a.travers@gmail.com>
 <20150602064806.GF6382@sudip-PC>
 <20150602075522.GA10942@ubuntu-desktop>
In-Reply-To: <20150602075522.GA10942@ubuntu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Isaac Assegai <isaac.a.travers@gmail.com>
Cc: gregkh@linuxfoundation.org, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Tue, Jun 02, 2015 at 12:55:22AM -0700, Isaac Assegai wrote:
> On Tue, Jun 02, 2015 at 12:18:06PM +0530, Sudip Mukherjee wrote:
> > On Sun, May 31, 2015 at 10:01:13PM -0700, Isaac Assegai wrote:
<snip>
> > > +					  FIELD_SET(0, CRT_DISPLAY_CTRL, TIMING, ENABLE)|
> > > +					  FIELD_SET(0, CRT_DISPLAY_CTRL, PLANE, ENABLE);
> > I am getting confused now.
> > This part you have modified in patch 10/12 and i just replied that
> > you have missed two modifications.
> > 
> Thanks for your feedback Sudip, I have a few questions:
> 1. After applying the first 11 patches I ran checkpatch again and noticed that
> I missed three warnings so I ran a 12th patch fixing them. That's why you
> see the 12th patch modifying a file that another patch already touched.
> What should be done in this type of situation?
you have to start from the beginning again. :(
I have faced such similar situation also, but starting for the beginnig
is the only way.
> 
> 2. On Patch 3 you pointed out two trailing whitespace errors.
> I ran checkpatch on all the patches before I sent them to
> make sure I didn't introduce any new errors,
but it looks like they were introduced in your patch.
> -     int (*de_imageblit)(struct lynx_accel *,const char *,u32,u32,u32,
> -                                             u32,u32,u32,u32,u32,u32,u32,u32,u32);
> +     int (*de_imageblit)(struct lynx_accel *, const char *, u32, u32, u32, u32,
the original code was having three u32, i think when you moved one more
u32 from the following line you forgot to remove the space after that.

>however
> there are *many* warnings and errors showing up from
> the poor styling already present and I missed these
> whitespace errors in the mess.
> Can I make checkpatch suppress any errors that might have already
> been present in the code and only show me those issues introduced
> by the patch itself? If not, how did you identify it?
i dont think checkpatch can work like that way.
identification was easy. i saw checkpatch giving error and noticed you
have modified the code. So i checked the original code if trailing
whitespace was there or not.

regards
sudip
