From: Michal Januszewski <michalj@gmail.com>
Subject: Re: vesafb BIOS interface
Date: Wed, 28 Oct 2009 18:22:06 +0100
Message-ID: <5d9b736f0910281022m355e4ceeiee82f895cae418f@mail.gmail.com>
References: <1dcc0f750910221949r6933b0d0v580f8279af73e0f9@mail.gmail.com>
	<20091024153713.8e4d6e36.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michalj@gmail.com>) id 1N3CDx-0001MF-2b
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Oct 2009 17:22:17 +0000
Received: from qw-out-1920.google.com ([74.125.92.146])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N3CDs-0003nQ-84 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Oct 2009 17:22:17 +0000
Received: by qw-out-1920.google.com with SMTP id 5so263827qwc.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 Oct 2009 10:22:06 -0700 (PDT)
In-Reply-To: <20091024153713.8e4d6e36.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net, Woon Liang Soh <woonliang.soh@gmail.com>

On Sat, Oct 24, 2009 at 14:37, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

>> Is there any way in either user-space or kernel-space to make calls to the
>> VBIOS to get it to call the INT routines?
>
> No. The closest thing is uvesa fb driver as it just does calls to the VESA bios through
> user-space daemon (if I understand how it works).

That's correct.  You will probably be interested in the v86d code
(i.e. the userspace daemon mentioned above), which does all the heavy
lifting re VBIOS calls.  Have a look at testvbe.c from the v86d
tarball which demonstrates how to use the v86d code to call the VBIOS
to get some info about the graphics adapter and supported video modes.

-- 
Michal Januszewski, Gentoo Linux Developer
http://people.gentoo.org/spock

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
