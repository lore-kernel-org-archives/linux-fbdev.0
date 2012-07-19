From: Olaf Hering <olaf@aepfle.de>
Date: Thu, 19 Jul 2012 05:20:50 +0000
Subject: Re: [PATCH] radeonfb: Add quirk for the graphics adapter in some JSxx
Message-Id: <20120719052050.GA31783@aepfle.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1342630144-16350-1-git-send-email-olaf@aepfle.de>
 <001201cd656b$b2794350$176bc9f0$%han@samsung.com>
In-Reply-To: <001201cd656b$b2794350$176bc9f0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>, 'Tony Breeds' <tony@bakeyournoodle.com>
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@ozlabs.org

On Thu, Jul 19, Jingoo Han wrote:

> On Thursday, July 19, 2012 1:49 AM, olaf@aepfle.de wrote:
> > From: Tony Breeds <tony@bakeyournoodle.com>
> > 
> > These devices are set to 640x480 by firmware, switch them to 800x600@60
> > so that the graphical installer can run on remote console.
> > 
> > Reported by IBM during SLES10 SP2 beta testing:
> > 
> > https://bugzilla.novell.com/show_bug.cgi?idF1002
> > LTC50817
> > 
> > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> If the author is Tony Breeds, please add 'Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>'.

He provided the initial version of the change, but did not add his tag
back in 2009. Tony, perhaps you can do that now?

Olaf
