From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: probing the supported resolution list
Date: Sat, 3 Oct 2009 07:04:19 +0200
Message-ID: <20091003070419.29e4ff82.krzysztof.h1@poczta.fm>
References: <4AC45D35.3020600@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MtwXQ-0008JW-E2
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 03 Oct 2009 04:48:08 +0000
Received: from smtp240.poczta.interia.pl ([217.74.64.240])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MtwXI-0006zR-RS for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 03 Oct 2009 04:48:07 +0000
In-Reply-To: <4AC45D35.3020600@manoweb.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Alessio Sangalli <alesan@manoweb.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 01 Oct 2009 00:41:41 -0700
Alessio Sangalli <alesan@manoweb.com> wrote:

> Hi, is there a standard way for a userspace program to "probe" the 
> supported display sizes/refresh rates/bit depths? The display I'm 
> writing a driver for only supports a few specific resolutions, and I'm 
> wondering how a userspace program can discover those.
> 

I am not aware of such a probe function.

E.g. the xorg fbdev driver just tries to select list of defined resolutions and 
select only the available ones. If your list of resolutions and depths is limited 
to few entries you can try this approach as well.

Regards,
Krzysztof


----------------------------------------------------------------------
Afera Hazardowa- O co tu chodzi?
Sprawdz >>> http://link.interia.pl/f238e


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
