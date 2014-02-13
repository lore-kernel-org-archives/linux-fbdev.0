From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Thu, 13 Feb 2014 17:19:32 +0000
Subject: Re: Fixing the kernels backlight API
Message-Id: <20140213171932.GB4420@srcf.ucam.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <52FB8F45.9060006@redhat.com>
	<CAPM=9tyYLuoTtW69-cPx-JSuar++D5WEtYRZr_-aP7uowZpVyA@mail.gmail.com>
	<52FCCBA1.3070303@redhat.com>
In-Reply-To: <52FCCBA1.3070303@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: "xorg-devel@lists.x.org" <xorg-devel@lists.x.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jingoo Han <jg1.han@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>

On Thu, Feb 13, 2014 at 02:41:53PM +0100, Hans de Goede wrote:

> I still believe we need to do better, but maybe that better needs to be done
> in userspace rather then in the kernel.

One option is to put it on the connector but provide some mechanism for 
userspace to define the relationship between platform/firmware 
interfaces and connectors. We ought to be able to tie connectors into 
the ACPI namespace and do a better job than we currently do with the 
association between backlight and connector. The bigger problem is 
figuring out how platform interfaces tie into things, and that's where 
heuristics are probably going to be involved.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
