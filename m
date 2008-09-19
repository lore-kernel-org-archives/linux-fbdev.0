From: Alessio Sangalli <alesan@manoweb.com>
Subject: Re: Implementing new fb driver
Date: Thu, 18 Sep 2008 17:15:11 -0700
Message-ID: <48D2EF0F.1080701@manoweb.com>
References: <20080917133444.11D82CF1A0@f21.poczta.interia.pl>
	<48D13AFF.3050803@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KgTeh-0003pn-SG for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Sep 2008 17:15:27 -0700
Received: from moutng.kundenserver.de ([212.227.126.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KgTeg-0005OA-8v
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Sep 2008 17:15:27 -0700
In-Reply-To: <48D13AFF.3050803@manoweb.com>
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
To: krzysztof.h1@poczta.fm
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Alessio Sangalli wrote:

>>> the fb API unable to deal with this? I have read only 1-bit cursor
>>> images are supported.
>>>
>> No. Look at the include/linux/fb.h


I have another question: in fbmem.h line 1070 function fb_ioctl

        case FBIO_CURSOR:
                return -EINVAL;

is the ioctl 'manager' in this file? Why does it return like this? How
is the userspace supposed to deal with the cursor?

Thank you
Alessio



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
