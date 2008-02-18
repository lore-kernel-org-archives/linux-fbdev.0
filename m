From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] fb: add support for foreign	endianness
Date: Tue, 19 Feb 2008 00:35:08 +0100
Message-ID: <47BA162C.5000807@anagramm.de>
References: <20080205154432.GA8749@localhost.localdomain>	<20080214224942.a0cb6218.akpm@linux-foundation.org>	<20080215164542.GB16810@localhost.localdomain>	<Pine.LNX.4.64.0802171030330.6848@anakin>	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm> <19805.1203355811@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756378AbYBRXfh@vger.kernel.org>
In-Reply-To: <19805.1203355811@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>, adaplas@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, avorontsov@ru.mvista.com

Valdis.Kletnieks@vt.edu schrieb:
> On Mon, 18 Feb 2008 08:18:47 +0100, Krzysztof Helt said:
>> I know two fb drivers which use endianess information (pm2fb and s3c2410fb).
>> Both resolve endianess at driver level. Actually, both handle it by setting special
>> bits so the graphics chip itself reorder bytes to transform foreign endianess. 
>> I understand that this patch is for chips which cannot reorder bytes by themselves.
> 
> Does anybody know of such a chip that's actually available in the wild?  Or are
> we writing drivers for speculative possible chips?
> 

I had troubles with the Silicon Motion SM501/SM502 endianess on PowerPC PCI vs. LocalBus.
The chip also has a register to swap endianess, but that seems to only affect some
LocalBus modes.
The current fb and X drivers are working, but when it comes to font
aliasing and hw-acceleration, the problems start to rise again...

Regards,

Clemens
