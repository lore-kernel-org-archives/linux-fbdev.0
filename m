From: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 10 Mar 2017 22:05:33 +0000
Subject: Re: [PATCH 0/3] multiple checkpatch issues
Message-Id: <20170310220533.GA19329@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170310215657.7069-1-arushisinghal19971997@gmail.com>
In-Reply-To: <20170310215657.7069-1-arushisinghal19971997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com

On Sat, Mar 11, 2017 at 03:26:54AM +0530, Arushi Singhal wrote:
> Improve readability by fixing multiple checkpatch.pl
> issues in sm750fb driver. 

Note, _PLEASE_ put the subsystem/driver name in this 0/X email subject
line, like your patches have them.  It makes it easier when I sort
patches by driver/subsystem when reviewing them.  As it is, I end up
always ignoring these 0/X emails.

thanks,

greg k-h
