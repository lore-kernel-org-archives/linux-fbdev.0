From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 26 Feb 2015 04:33:41 +0000
Subject: Re: Build warning for unused function in the file,sm7xxfb.c
Message-Id: <20150226043341.GA8294@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Thu, Feb 26, 2015 at 09:57:31AM +0530, Sudip Mukherjee wrote:
> On Wed, Feb 25, 2015 at 11:04:22PM -0500, nick wrote:
> > Greetings Sudip and others,
> > After doing a clean kernel build today I get this warning:
> > drivers/staging/sm7xxfb/sm7xxfb.c:117:19: warning: ‘sm7xx_vga_setup’ defined but not used [-Wunused-function]
> > static int __init sm7xx_vga_setup(char *options).
> > After looking into it further I found it's not being called anywhere, I was going to remove it until I 
> > found out it was used for command processing by this driver for setup of cards supported. I was wondering
> > if this function is still needed due to legacy support or to allow this command line processing feature to
> > be used still.
> Hi Nick,
> I was under the impression that you have been blacklisted from lkml.

He is, you got the email directly, it never made it to vger.

I suggest updating your personal blacklist as well, it makes things
easier.

greg k-h
