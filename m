From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: [PATCH 1/2] fb: add support for foreign
	endianness
Date: Wed, 20 Feb 2008 16:43:42 +0100
Message-ID: <47BC4AAE.8020908@anagramm.de>
References: <20080205154432.GA8749@localhost.localdomain>	<20080214224942.a0cb6218.akpm@linux-foundation.org>	<20080215164542.GB16810@localhost.localdomain>	<Pine.LNX.4.64.0802171030330.6848@anakin>	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>	<19805.1203355811@turing-police.cc.vt.edu>	<47BA162C.5000807@anagramm.de>
	<1203381353.6740.59.camel@pasglop>	<47BABD3A.7010102@anagramm.de>	<20080219040530.7b1d115d.akpm@linux-foundation.org>
	<18363.31427.989835.105966@cargo.ozlabs.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JRr7V-0000RP-1a for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Feb 2008 07:44:39 -0800
Received: from moutng.kundenserver.de ([212.227.126.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JRr7S-0004IQ-Vl
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Feb 2008 07:44:29 -0800
In-Reply-To: <18363.31427.989835.105966@cargo.ozlabs.ibm.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@gmail.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Anton Vorontsov <avorontsov@ru.mvista.com>

Paul Mackerras schrieb:
> Andrew Morton writes:
> 
>> Bizarrely, the original author of the patch (Anton) has fallen off the cc. 
>> Could whoever did that please thwap himself?
>>
>> Anyway, my head is now officially spinning.  Did anyone actually have a
>> reason why we shouldn't proceed with Anton's patch?
> 
> I was wondering if it would be sufficient to provide alternative
> versions of fb_readl, fb_writel etc. that do byte-swapping.  That
> would mean that all framebuffers would have to have the same
> endianness, but that would suffice for embedded systems such as
> Anton's and would end up a lot simpler IMHO.

Yes. At least the affected PowerPC platforms can do byte-swapping on
the fly, so this should be sufficient and without performance
penalty, AFAICS.

Regards,

Clemens

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
