From: Luc Verhaegen <libv@skynet.be>
Date: Wed, 13 Aug 2014 20:01:30 +0000
Subject: Re: [PATCH 3/4] simplefb: disable dt node upon remove
Message-Id: <20140813200130.GI31326@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-4-git-send-email-libv@skynet.be>
 <CACxGe6vaPUa4QvYWBA-QY7MTmJYoeqnPt9Zh5jpky6S9UYbrvQ@mail.gmail.com>
 <CANq1E4ReOB87RX8VhnW1Ln=SK3Tw5V962ujcsfuz-2E9Uc61yQ@mail.gmail.com>
 <CACxGe6vQrhd8QOAyGnjRppmuANpT60Ao2+KmkDfF4FNeoZSZgw@mail.gmail.com>
 <20140813094524.GC31326@skynet.be> <20140813101923.GD31326@skynet.be>
 <CAKON4OwLOAq1EOzZmuefcnZ4hw0i35e3k0F6XGNRy-5jer2vyA@mail.gmail.com>
 <CACxGe6szX3LyhGHbVHrEFfaWGYUcgcxgkuhfc9ac-R0qJs-HXw@mail.gmail.com>
 <20140813192506.GH31326@skynet.be> <53EBC36C.7050800@wwwdotorg.org>
In-Reply-To: <53EBC36C.7050800@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 13, 2014 at 01:58:36PM -0600, Stephen Warren wrote:
> On 08/13/2014 01:25 PM, Luc Verhaegen wrote:
>>
>> The code that sets up simplefb for sunxi is primarily for providing a
>> console in u-boot (using the ancient cfbconsole infrastructure). From
>> what i can tell, the u-boot code for rpi is about showing a splash
>> screen (using the much newer lcd infrastructure).
>
> There's no splash screen on the Pi in the upstream U-Boot code. The LCD  
> displays the U-Boot console/stdout. If USB support for the Pi's USB host  
> is ever sent upstream, that will allow the user to use USB/LCD for  
> U-Boot control, rather than serial.

Ah ok, i hadn't immediately found a tie with the lcd code and cfbconsole 
code, so apparently i didn't dig down far enough.

Luc Verhaegen.
