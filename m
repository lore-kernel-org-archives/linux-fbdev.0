From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 14 Mar 2012 10:59:36 +0000
Subject: Re: [PATCH] x86: export 'pcibios_enabled'
Message-Id: <4F607A18.8080004@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120313204114.e160849af7dbe5a4b4e5c0ad@canb.auug.org.au>	<4F5FAE63.3090908@xenotime.net>	<4F5FE9AD.7000204@zytor.com> <20120314092955.2250a782@pyramind.ukuu.org.uk>
In-Reply-To: <20120314092955.2250a782@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@xenotime.net>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Michal Januszewski <spock@gentoo.org>, linux-fbdev@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Wang YanQing <udknight@gmail.com>

[CC'ing Wang YanQing, the author of the patch requiring it]

On 03/14/2012 09:29 AM, Alan Cox wrote:
>>>  
>>>  int pcibios_enabled;
>>> +EXPORT_SYMBOL(pcibios_enabled);
>>>  
>>>  /* According to the BIOS specification at:
>>>   * http://members.datafast.net.au/dft0802/specs/bios21.pdf, we could
>>
>> I would think this should be EXPORT_SYMBOL_GPL()... this seems like a
>> symbol with a very high likelihood to be abused in strange ways.
> 
> We don't need to expose it anyway
> 
> uvesafb could look for any PCI vga class device - which I suspect is
> what it *should* be doing ?

Would this really change depending on whether the page is NX-protected
or not?
Your suggestion sounds like it is about detecting whether there is any
graphic chip present or not while the patch is about fixing an oops
caused by NX-protection of the BIOS.


Best regards,

Florian Tobias Schandinat
