From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: vesafb BIOS interface
Date: Sat, 24 Oct 2009 15:37:13 +0200
Message-ID: <20091024153713.8e4d6e36.krzysztof.h1@poczta.fm>
References: <1dcc0f750910221949r6933b0d0v580f8279af73e0f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1N1gWq-0005Jm-4t
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Oct 2009 13:19:32 +0000
Received: from smtp240.poczta.interia.pl ([217.74.64.240])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N1gWl-0004ZZ-Uu for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Oct 2009 13:19:32 +0000
In-Reply-To: <1dcc0f750910221949r6933b0d0v580f8279af73e0f9@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Woon Liang Soh <woonliang.soh@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 23 Oct 2009 10:49:51 +0800
Woon Liang Soh <woonliang.soh@gmail.com> wrote:

> Is there any way in either user-space or kernel-space to make calls to the
> VBIOS to get it to call the INT routines?
> 

No. The closest thing is uvesa fb driver as it just does calls to the VESA bios through 
user-space daemon (if I understand how it works).

Regards,
Krzysztof


----------------------------------------------------------------------
Afera Hazardowa- O co tu chodzi?
Sprawdz >>> http://link.interia.pl/f238e


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
