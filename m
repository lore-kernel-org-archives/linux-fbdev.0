From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 26 Feb 2015 05:26:00 +0000
Subject: Re: Build warning for unused function in the file,sm7xxfb.c
Message-Id: <20150226051400.GA4178@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150226043341.GA8294@kroah.com>
In-Reply-To: <20150226043341.GA8294@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Feb 25, 2015 at 08:33:41PM -0800, Greg KH wrote:
> On Thu, Feb 26, 2015 at 09:57:31AM +0530, Sudip Mukherjee wrote:
> 
> I suggest updating your personal blacklist as well, it makes things
> easier.
yes, better. and i was just seeing some of his patches, mostly all are removing of FIXME comments.

but i got confused with bab5bb398273bb37547a185f7b344b37c700d0b9
he has removed a call to function kvm_make_request() and introduced a new function kvm_set_pending_timer() which is just calling kvm_make_request(). and the commit message just says "Adds a function kvm_vcpu_set_pending_timer instead of calling kvm_make_request in lapic.c." , i am just unable to understand why this change?

regards
sudip
> 
> greg k-h
