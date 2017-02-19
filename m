From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Sun, 19 Feb 2017 08:26:18 +0000
Subject: Re: [PATCH] backlight: report error on failure
Message-Id: <20170219082618.GB30444@wychelm.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484774630-4228-1-git-send-email-sudipm.mukherjee@gmail.com>
 <588FC682.9040503@gmail.com>
 <58A876EF.1040803@gmail.com>
In-Reply-To: <58A876EF.1040803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Sat, Feb 18, 2017 at 04:31:43PM +0000, Sudip Mukherjee wrote:
> On Monday 30 January 2017 11:04 PM, Sudip Mukherjee wrote:
> > On Wednesday 18 January 2017 09:23 PM, Sudip Mukherjee wrote:
> > > It is possible to update the backlight power and the brightness using
> > > the sysfs and on writing it either returns the count or if the callback
> > > function does not exist then returns the error code 'ENXIO'.
> > > 
> > > We have a situation where the userspace client is writing to the sysfs
> > > to update the power and since the callback function exists the client
> > > receives the return value as count and considers the operation to be
> > > successful. That is correct as the write to the sysfs was successful.
> > > But there is no way to know if the actual operation was done or not.
> > > 
> > > backlight_update_status() returns the error code if it fails. Pass that
> > > to the userspace client who is trying to update the power so that the
> > > client knows that the operation failed.
> > > 
> > > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> > > ---
> > 
> > A gentle ping.
> 
> Hi Andrew,
> 
> Its more than one month now that this patch was submitted. Can you please
> take it through your tree... else it will miss the merge window.

Sorry you've been waiting so long for a review. Your "gentle ping" did
result in a few minor tweaks to the maintainers but what it didn't
(until today) provoke was  review!

To be honest, the ABI changes in the patch meant I wanted to check a 
few things first. However prompted by this mail I've just replied with 
the review I *should* have sent out a week ago [asking you rather than 
me to fill in some details about the likely effect of the ABI change ;-) ].

BTW, I did do some archeology eariler in the week and I think the kernel
has been swallowing error codes here for >10 years, so I'm curious if this
is a theoretic bug fix or are you aware of some tangible problem in 
userspace that results from it?


Daniel.
