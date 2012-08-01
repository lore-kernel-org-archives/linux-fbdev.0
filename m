From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 01 Aug 2012 09:52:24 +0000
Subject: Re: [PATCH] Fix newport con crashes
Message-Id: <5018FC58.10605@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120730105416.DBB961D1CF@solo.franken.de> <20120730133447.GA29993@linux-mips.org>
In-Reply-To: <20120730133447.GA29993@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org

On 07/30/2012 01:34 PM, Ralf Baechle wrote:
> On Mon, Jul 30, 2012 at 12:54:16PM +0200, Thomas Bogendoerfer wrote:
> 
>> Because of commit e84de0c61905030a0fe66b7210b6f1bb7c3e1eab
>> [MIPS: GIO bus support for SGI IP22/28] newport con is now taking over
>> console from dummy con, therefore it's necessary to resize the VC to
>> the correct size to avoid crashes and garbage on console
>>
>> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> I've applied your patch to master and the affected -stable branches of the
> lmo git tree.
> 
> Florian, since this is a driver specific to certain MIPS platforms I'd like
> to merge it through the MIPS tree with your ack, if that's ok?

Yes, sounds good to me. The patch looks good.


Best regards,

Florian Tobias Schandinat
