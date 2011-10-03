From: Timur Tabi <timur@freescale.com>
Date: Mon, 03 Oct 2011 17:24:05 +0000
Subject: Re: [PATCH 1/9] drivers/video: fsl-diu-fb: fix some ioctls
Message-Id: <4E89EFB5.1020200@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1317244795-24671-1-git-send-email-timur@freescale.com>
In-Reply-To: <1317244795-24671-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Florian Tobias Schandinat wrote:
> On 09/28/2011 09:19 PM, Timur Tabi wrote:
>> Use the _IOx macros to define the ioctl commands, instead of hard-coded
>> numbers.  Unfortunately, the original definitions of MFB_SET_PIXFMT and
>> MFB_GET_PIXFMT used the wrong value for the size, so this will break
>> binary compatibility with older applications.
> 
> Don't break compatibility without the need to do so. Ask yourself whether using
> those macros is really worth it. If the answer is yes, at least give userspace a
> grace period, some kernel versions where both values work. For example you could
> rename the old numerical ones to MFB_SET_PIXFMT_OLD and then add a compatibility
> IOCTL, for example like this
> 
> case MFB_SET_PIXFMT_OLD:
> 	/* you could add a warning message here */
> case MFB_SET_PIXFMT:
> 	...

Ok, I can do that.

> Not much work and you could delete the compatibility stuff in a year or two but
> it would it make much easier for users to upgrade.
> 
> I don't know your driver, can int be only 32 bit on all plattforms where it can
> be used or is this another thing where compatibility can break?

We have 64-bit processors, but currently none of them have any multimedia
support.  That might change one day, and I'd rather the drivers be 64-bit clean
before we announce any such parts.  There are other places in the driver that
break on 64-bit, and I will fix those as well (just not today).

-- 
Timur Tabi
Linux kernel developer at Freescale

