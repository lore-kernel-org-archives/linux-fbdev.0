From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Feb 2015 15:21:54 +0000
Subject: Re: Build warning for unused function in the file,sm7xxfb.c
Message-Id: <54F08B92.3030006@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54EE9B46.3090103@gmail.com> <20150226042731.GA3609@sudip-PC> <20150226043341.GA8294@kroah.com> <20150226051400.GA4178@sudip-PC> <20150226164800.GB4609@kroah.com> <20150227151434.GA2485@sudip-PC>
In-Reply-To: <20150227151434.GA2485@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Gleb Natapov <gleb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Nick Krause <xerofoify@gmail.com>
Cc: linux-fbdev@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org



On 27/02/2015 16:14, Sudip Mukherjee wrote:
>>> I don't understand the change either, I suggest asking the kvmm 
>>> developer who accepted it.
> Hi Paolo, We have a small confusion about commit
> bab5bb398273bb37547a185f7b344b37c700d0b9. It looks like the patch
> removed a call to function kvm_make_request() and introduced a new
> function kvm_set_pending_timer() which is just calling
> kvm_make_request() again. and the commit message just says "Adds a
> function kvm_vcpu_set_pending_timer instead of calling
> kvm_make_request in lapic.c.".

It's just a cosmetic change; and yes, I know who the author is.

Paolo
