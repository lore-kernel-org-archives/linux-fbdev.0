From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: Implementing new fb driver
Date: Sat, 20 Sep 2008 19:30:30 +0200
Message-ID: <20080920193030.37d3caf7.krzysztof.h1@poczta.fm>
References: <20080917133444.11D82CF1A0@f21.poczta.interia.pl>
	<48D13AFF.3050803@manoweb.com> <48D2EF0F.1080701@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1Kh6jH-0005YN-4t
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 20 Sep 2008 17:58:47 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kh6jB-0004M0-6q for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 20 Sep 2008 17:58:47 +0000
In-Reply-To: <48D2EF0F.1080701@manoweb.com>
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
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 18 Sep 2008 17:15:11 -0700
Alessio Sangalli <alesan@manoweb.com> wrote:

> Alessio Sangalli wrote:
> 
> >>> the fb API unable to deal with this? I have read only 1-bit cursor
> >>> images are supported.
> >>>
> >> No. Look at the include/linux/fb.h
> 
> 
> I have another question: in fbmem.h line 1070 function fb_ioctl
> 
>         case FBIO_CURSOR:
>                 return -EINVAL;
> 
> is the ioctl 'manager' in this file? Why does it return like this? How
> is the userspace supposed to deal with the cursor?
> 

I see. It seems that this ioctl is not implemented. The cursor control works through the console layer but I am not sure if you can set shape through this.

I have no time implement this at the moment.

Regards,
Krzysztof

----------------------------------------------------------------------
Doladuj telefon szybko i bezpiecznie.
Sprawdz >>  http://link.interia.pl/f1f02


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
