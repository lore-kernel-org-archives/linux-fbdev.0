From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Framebuffer drivers that break the boot on
 systemswithout the hardware
Date: Sun, 10 Aug 2008 23:49:07 +0200
Message-ID: <489F6253.3010703@keyaccess.nl>
References: <489DFACC.6030009@keyaccess.nl>
	<200808092319.43139.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KSImV-0005xx-RE for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Aug 2008 14:48:55 -0700
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KSImT-00074l-9F
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 10 Aug 2008 14:48:55 -0700
In-Reply-To: <200808092319.43139.elendil@planet.nl>
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
To: Frans Pop <elendil@planet.nl>
Cc: akpm@osdl.org, mingo@elte.hu, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On 09-08-08 23:19, Frans Pop wrote:

> Rene Herman wrote:

>> Ingo Molnar posted a list of drivers he found to break the boot during
>> testing of randconfig kernels and among them are a number of FB drivers:
>>
>> FB_VESA
> 
> This one is set to "y" in the kernel configs for the generic Debian 
> kernels for i386 and x86_64 and is used by default for the graphical 
> version of the Debian Installer, so I'd be very surprised if it broke 
> very many systems...
> AFAIK it is only actually enabled if the 'vga=' boot parameter is passed.
> 
> Ingo's mail also lists FRAMEBUFFER_CONSOLE which again is set to "y" in 
> Debian's standard kernel configs for x86 (and probably most other 
> arches).

Okay. MDA_CONSOLE was also in there impying RAM at 0xb0000 which might 
indicate a gun/foot situation here...

>> (and FB_VIRTUAL)
> 
> This one should be fixed with 2.6.27-rc1. The commit that fixes it is:
>   commit b604838ac6d233fd6bffc0e758a818133a01ff22
>   Author: Frans Pop <elendil@planet.nl>
>   Date:   Wed Jul 23 21:31:26 2008 -0700
>     vfb: only enable if explicitly requested when compiled in

Ah, thanks.

Rene.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
