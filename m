From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 11 Mar 2015 08:59:45 +0000
Subject: Re: [PATCH 3/3] staging: sm7xxfb: change return of sm7xx_vga_setup
Message-Id: <20150311085931.GB4560@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425836411-15481-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1425836411-15481-3-git-send-email-sudipm.mukherjee@gmail.com>
 <20150309131343.GG10964@mwanda>
 <20150309133032.GA13002@sudip-PC>
 <20150309133805.GI10964@mwanda>
 <20150309135343.GC13002@sudip-PC>
 <20150309140414.GA11015@mwanda>
In-Reply-To: <20150309140414.GA11015@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 09, 2015 at 05:04:14PM +0300, Dan Carpenter wrote:
> On Mon, Mar 09, 2015 at 07:23:43PM +0530, Sudip Mukherjee wrote:
<snip>
> > > Hm...  That's a good question.
> > > 
> > > I suspect we should just go with fb_get_mode() and do it quickly.  This
> > > driver is so new in the kernel that there are no users to get upset.
> >
> > i am afraid that is not correct. this driver was in staging from long
> > back, and Greg removed it from staging as no one was working with it.
> > But after that removal Lemote Yeeloong laptop of Steven Rostedt
> > stopped working. (https://lkml.org/lkml/2014/11/20/698) , so i guess
> > there will be many such users.
> 
> Hm...  I suspect we should still change it so it matches the other FB
> drivers but I don't know.
> 
> Perhaps Greg has an opinion?
maybe, i should make the change and then we can request Steven Rostedt
to test it on his Lemote Yeeloong. if nothing breaks, then alright,
else revert the patch.

regards
sudip

> 
> regards,
> dan carpenter
> 
