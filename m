From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 2/2] metronomefb: changes
	to use platform framebuffer
Date: Mon, 4 Aug 2008 09:30:58 +0800
Message-ID: <f17812d70808031830h631fc7bave8632cac7d283663@mail.gmail.com>
References: <1217682500-31503-1-git-send-email-jayakumar.lkml@gmail.com>
	<1217682500-31503-3-git-send-email-jayakumar.lkml@gmail.com>
	<20080803214041.24bc88da.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KPoub-0005ib-VT for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Aug 2008 18:31:03 -0700
Received: from yw-out-1718.google.com ([74.125.46.152])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KPouZ-0001tC-WA
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Aug 2008 18:31:01 -0700
Received: by yw-out-1718.google.com with SMTP id 6so1288103ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 03 Aug 2008 18:30:59 -0700 (PDT)
In-Reply-To: <20080803214041.24bc88da.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-fbdev-devel@lists.sourceforge.net, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Mon, Aug 4, 2008 at 3:40 AM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> On Sat,  2 Aug 2008 09:08:20 -0400
> Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>
>> These changes are used in order to support the use of the framebuffer
>> provided by the platform device driver rather than to directly allocate one.
>> Other changes are cleanup to error handling and order of release.
>>
>> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
>> ---
>
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>

Looks OK to me either, take it as an Ack if need one more.

> ----------------------------------------------------------------------
> Tanie rozmowy!
> Sprawdz >>>  http://link.interia.pl/f1e91
>
>
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
>



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
