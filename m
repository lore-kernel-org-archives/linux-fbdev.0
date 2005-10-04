From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: VESA, EDID & flat panels
Date: Tue, 04 Oct 2005 14:27:28 +0800
Message-ID: <434220D0.3020101@gmail.com>
References: <1128380013.8267.125.camel@gaston>	 <8a0c36780510031618m48c55f45u648d867bcf0130d2@mail.gmail.com> <1128397436.31063.0.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMgHI-0002q8-Do
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 03 Oct 2005 23:27:52 -0700
Received: from xproxy.gmail.com ([66.249.82.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EMgHF-0000bj-Vm
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 03 Oct 2005 23:27:52 -0700
Received: by xproxy.gmail.com with SMTP id s7so301689wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 03 Oct 2005 23:27:44 -0700 (PDT)
In-Reply-To: <1128397436.31063.0.camel@gaston>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Benjamin Herrenschmidt wrote:
> On Mon, 2005-10-03 at 18:18 -0500, Richard Smith wrote:
>>> Somebody around here has access to the VESA specs ? I'm trying to figure
>>> out if the EDID block, at least on recent flat panels, tells us wether
>>> the panel digital input is 6:6:6 or 8:8:8 ... If it's 6:6:6, we should
>>> enable dithering in drivers like radeon and "nv", while if 8:8:8, we
>>> should not. If not enabling it on a 6 bits panel, we end up with crappy
>>> looking gradients, if enabling it on a 8 bits panel, we basically end up
>>> sending a 6 bits signal to a 8 bits panel, thus reducing the quality.
>> We have  a copy from a few years ago.  Its not too descriptive if
>> IIRC.  I'll try to look at it tomorrow.
> 
> I found a lot of stuff on VESA Public site in fact. Looks like we really
> need to write some infrastructure to get to the EDID extensions :) They
> contain all sort of useful infos, though unfortunately, all of the
> panels I've come accross so far didn't seem to implement them =P
> 

It think it's because the (basic) EDID is retrieved with (basic) DDC
(address 0x50).  If I'm not mistaken, E-EDID is retrieved with E-DDC
(address 0xa0). I don't exactly know the protocol (E-DDDC specs are not
freely available), but try probing your i2c busses with:

i2cdump 0,1,2,etc 0xa0 

and see if you get anything.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
