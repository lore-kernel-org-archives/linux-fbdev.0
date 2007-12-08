From: "Luca Tettamanti" <kronos.it@gmail.com>
Subject: Re: radeonfb: Please enable support for X850XT
Date: Sat, 8 Dec 2007 14:18:19 +0100
Message-ID: <68676e00712080518g6185e5d8oe74cca828d5f559d@mail.gmail.com>
References: <20071206212809.GA8249@aragorn.home.lxtec.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J0zZU-0002ME-Vz for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 08 Dec 2007 05:18:21 -0800
Received: from wa-out-1112.google.com ([209.85.146.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J0zZT-00054W-Iu
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 08 Dec 2007 05:18:20 -0800
Received: by wa-out-1112.google.com with SMTP id k22so2264074waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 08 Dec 2007 05:18:19 -0800 (PST)
In-Reply-To: <20071206212809.GA8249@aragorn.home.lxtec.de>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Luca Tettamanti <kronos.it@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Dec 6, 2007 10:28 PM, Elimar Riesebieter <riesebie@lxtec.de> wrote:
> Hi gents,
>
> I've built in a new graphic adapter. DRI and r300 works well.
>
> Xorg.0.log:
> (--) RADEON(0): Chipset: "ATI Radeon X850 XT (R480) (AGP)" (ChipID = 0x4b49)
[...]
> There was a patch which looked like enabling this card:
>
> http://marc.info/?l=linux-fbdev-devel&m=116768377303703&w=2
>
> but didn't went into mainline. The patch doesn't apply to recent kernels. So
> could you please tell me how support for the X850XT (AGP) can be applied?

Currently I rebase the patch against git-current for my own use, but I
really lack the time to properly cleanup, split and submit for
inclusion in mainline.

Btw, Jerome Glisse recently published code for in-kernel mode setting
[1]; I see the fb layer going away...

Luca
[1] http://jglisse.livejournal.com/852.html

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
