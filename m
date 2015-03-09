From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 09 Mar 2015 13:53:52 +0000
Subject: Re: [PATCH 3/3] staging: sm7xxfb: change return of sm7xx_vga_setup
Message-Id: <20150309135343.GC13002@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425836411-15481-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1425836411-15481-3-git-send-email-sudipm.mukherjee@gmail.com>
 <20150309131343.GG10964@mwanda>
 <20150309133032.GA13002@sudip-PC>
 <20150309133805.GI10964@mwanda>
In-Reply-To: <20150309133805.GI10964@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 09, 2015 at 04:38:05PM +0300, Dan Carpenter wrote:
> 
> 
> On Mon, Mar 09, 2015 at 07:00:33PM +0530, Sudip Mukherjee wrote:
> > On Mon, Mar 09, 2015 at 04:13:43PM +0300, Dan Carpenter wrote:
> > > On Sun, Mar 08, 2015 at 11:10:11PM +0530, Sudip Mukherjee wrote:
> > > > change return type of sm7xx_vga_setup() to void as we are not using
> > > > the return type anywhere. if this function fails we fall back to the
> > > > default configuration.
> > > > 
> > > > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > > 
> > > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > 
> > > This patch is fine but if you wanted you could send a follow on which
> > > set it to SCREEN_X_RES, SCREEN_Y_RES, SCREEN_BPP if there were no
> > > options.  Then remove the "if (smtc_scr_info.lfb_width != 0) " condition
> > > in smtcfb_pci_probe().
> > 
> > yes, i could have. But actually I am thinking to totally remove this function and use more conventional fb_get_mode() in its places. But if i do so then the boot parameters will change. Currently it is like vga=sm712fb:0x301 but if i change it to use fb_get_mode() then the boot parameters will change to vga=sm712fb:640x480@60-8 , and that is why I am hesitating. But it will be more conventional to what all framebuffer drivers follows.
> > 
> 
> Hm...  That's a good question.
> 
> I suspect we should just go with fb_get_mode() and do it quickly.  This
> driver is so new in the kernel that there are no users to get upset.
i am afraid that is not correct. this driver was in staging from long back, and Greg removed it from staging as no one was working with it. But after that removal Lemote Yeeloong laptop of Steven Rostedt stopped working. (https://lkml.org/lkml/2014/11/20/698) , so i guess there will be many such users.

regards
sudip

> 
> regards,
> dan carpenter
> 
