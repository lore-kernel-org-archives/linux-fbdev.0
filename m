From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 24 Mar 2015 10:40:35 +0000
Subject: Re: [PATCH 1/2] staging: sm7xxfb: start using module parameters
Message-Id: <20150324102835.GA7986@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1427172609-4318-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150324094826.GB6378@kroah.com>
In-Reply-To: <20150324094826.GB6378@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 24, 2015 at 10:48:26AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 24, 2015 at 10:20:08AM +0530, Sudip Mukherjee wrote:
> > +		 "\t\t0x31B = 1280x1024-24\n"
> > +		 "\t\tUsual example:\n"
> > +		 "\t\tinsmod ./sm7xxfb.ko mode_option=\"0x301\"\n");
> > +
> 
> That's funny :)
> 
> And how do you handle multiple devices in the system?
frankly speaking, never got the idea about multiple devices.

> 
> :(
> 
> Seriously, never use module parameters for device parameters, they are
> two different things.  The framebuffer core has options for handling
> modes, why not use them?
> 
> And yes, lots of framebuffer drivers do have crazy module parameters,
> but that doesn't mean you have to perpetuate the insanity, please do
> things properly here.
i am learning from other framebuffer drivers. i guess i should only
see at skeletonfb.c and not the others.
please drop this 1/2 patch, do i need to resend the 2/2 which adds
the MODULE_DEVICE_TABLE ? 

regards
sudip

> 
> thanks,
> 
> greg k-h
