From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 01/15] [FB] make viafb work on x86_64
Date: Sat, 23 May 2009 08:57:25 +0200
Message-ID: <20090523085725.06ad0287.krzysztof.h1@poczta.fm>
References: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M7l4j-0001dR-13
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 06:51:21 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M7l4Z-000184-Fl for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 06:51:20 +0000
In-Reply-To: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Harald Welte <HaraldWelte@viatech.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 21 May 2009 04:28:39 +0800
Harald Welte <HaraldWelte@viatech.com> wrote:

> From: Harald Welte <laforge@gnumonks.org>
> 
> This patch makes fixes a bug in viafb on x86_64 builds (e.g. for VIA Nano CPU).
> You cannot make the assumption that sizeof(unsigned int) == sizeof(unsigned
> long), so the parsing of the default mode (640x480) fails, leading to a
> division by zero during insmod of the driver.
> 
> Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
> ---


This patch seems already merged into Linus' tree.

I have acked most of your patches. Please add the Acked-by:
entry to patches which are already ready for submission.
If a patch has the Acked-by: and a comment it means  that
a comment is not that important to stop the patch from being
merged (it is just nice to be fixed).

Please cc: your set of patches to Andrew Morton next time you post
them.

Kind regards,
Krzysztof

----------------------------------------------------------------------
Weekend w gorach za 100 PLN!
Sprawdz >>> http://link.interia.pl/f218c


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
