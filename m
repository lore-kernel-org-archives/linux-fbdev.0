From: Moshe Green <mgmoshes@gmail.com>
Date: Sat, 24 Sep 2016 21:09:28 +0000
Subject: Re: [PATCH] staging: sm750fb: rename getChipType to get_chip_type
Message-Id: <20160924210928.GA5246@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <9a9ab953f0c55df0ffe75a7a3c35ba6dc9e2f742.1474568117.git.mgmoshes@gmail.com>
 <20160923121352.GA3556@kroah.com>
In-Reply-To: <20160923121352.GA3556@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Fri, Sep 23, 2016 at 02:13:52PM +0200, Greg KH wrote:
> On Thu, Sep 22, 2016 at 09:15:45PM +0300, Moshe Green wrote:
> > Rename CamelCased function getChipType to get_chip_type.
> > This issue was found by checkpatch.pl
> 
> As this is a global function, can you rename it to something like
> "sm750_get_chip_type()"?  Having a driver-specific function called
> get_chip_type() is not good.
> 
> thanks,
> 
> greg k-h

Will do.
Thanks,

Moshe Green
