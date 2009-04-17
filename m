From: Dave Airlie <airlied@gmail.com>
Subject: Re: intelfb-support-i854.patch
Date: Fri, 17 Apr 2009 13:57:17 +1000
Message-ID: <21d7e9970904162057qd1a9ef8t31d75d17e1e31056@mail.gmail.com>
References: <20090410073651.365197DC943@f47.poczta.interia.pl>
	<20090410010528.09e0e153.akpm@linux-foundation.org>
	<alpine.DEB.2.00.0904100941380.27029@skynet.skynet.ie>
	<20090410014858.e6dfec3f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <airlied@gmail.com>) id 1LufCl-0004W9-U1
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Apr 2009 03:57:31 +0000
Received: from qw-out-1920.google.com ([74.125.92.147])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LufCY-0005FS-ID for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 17 Apr 2009 03:57:31 +0000
Received: by qw-out-1920.google.com with SMTP id 5so567950qwf.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 16 Apr 2009 20:57:17 -0700 (PDT)
In-Reply-To: <20090410014858.e6dfec3f.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Airlie <airlied@linux.ie>, Husemann <shusemann@googlemail.com>, Keith Packard <keithp@keithp.com>, linux-fbdev-devel@lists.sourceforge.net

On Fri, Apr 10, 2009 at 6:48 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 10 Apr 2009 09:42:23 +0100 (IST) Dave Airlie <airlied@linux.ie> wrote:
>
>> > Oh well, I guess I'll just merge it and see what happens.
>>
>> Well I think I jsut had my usual objections to adding anything to intelfb,
>
> What are those?

intelfb is not maintained anymore, I was only the defacto maintainer
due to the last person to touch it rule,
I added support to it for some new hardware before seeing the light of
day and realising my own craziness.

no new hardware support is added or being developed, It can't support
any outputs except VGA.

We now have kernel modesetting for all Intel hw which does almost the
exact same thing except it supports all the outputs
and lots more.

If features for the fb driver are missing from kms, I'd much rather
people work on improving the intel kms fb driver
than trying to make intelfb into something it was never meant to be.

> Will that conflict with this patch?

It was all in the patch so it should be fine.

Dave.
>
>
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by:
> High Quality Requirements in a Collaborative Environment.
> Download a free trial of Rational Requirements Composer Now!
> http://p.sf.net/sfu/www-ibm-com
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>

------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
