From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 27 Feb 2015 15:26:34 +0000
Subject: Re: Build warning for unused function in the file,sm7xxfb.c
Message-Id: <20150227151434.GA2485@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54EE9B46.3090103@gmail.com>
 <20150226042731.GA3609@sudip-PC>
 <20150226043341.GA8294@kroah.com>
 <20150226051400.GA4178@sudip-PC>
 <20150226164800.GB4609@kroah.com>
In-Reply-To: <20150226164800.GB4609@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>, Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Nick Krause <xerofoify@gmail.com>
Cc: linux-fbdev@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Feb 26, 2015 at 08:48:00AM -0800, Greg KH wrote:
> On Thu, Feb 26, 2015 at 10:44:00AM +0530, Sudip Mukherjee wrote:
> > On Wed, Feb 25, 2015 at 08:33:41PM -0800, Greg KH wrote:
> > > On Thu, Feb 26, 2015 at 09:57:31AM +0530, Sudip Mukherjee wrote:
> > > 
> > > I suggest updating your personal blacklist as well, it makes things
> > > easier.
> > yes, better. and i was just seeing some of his patches, mostly all are removing of FIXME comments.
> > 
> > but i got confused with bab5bb398273bb37547a185f7b344b37c700d0b9
> > he has removed a call to function kvm_make_request() and introduced a new function kvm_set_pending_timer() which is just calling kvm_make_request(). and the commit message just says "Adds a function kvm_vcpu_set_pending_timer instead of calling kvm_make_request in lapic.c." , i am just unable to understand why this change?
> 
> I don't understand the change either, I suggest asking the kvmm
> developer who accepted it.
Hi Paolo,
We have a small confusion about commit bab5bb398273bb37547a185f7b344b37c700d0b9. It looks like the patch removed a call to function kvm_make_request() and introduced a new function kvm_set_pending_timer() which is just calling kvm_make_request() again. and the commit message just says "Adds a function kvm_vcpu_set_pending_timer instead of calling kvm_make_request in lapic.c.".

regards
sudip
> 
> thanks,
> 
> greg k-h
