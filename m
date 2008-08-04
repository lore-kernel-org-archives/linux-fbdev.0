From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 1/2] am200epd: use fb
	notifiers and gpio api
Date: Mon, 4 Aug 2008 09:27:58 +0800
Message-ID: <f17812d70808031827g2cdaada4r6b5ead0e24b9ec90@mail.gmail.com>
References: <1217682500-31503-1-git-send-email-jayakumar.lkml@gmail.com>
	<1217682500-31503-2-git-send-email-jayakumar.lkml@gmail.com>
	<20080803213814.50ca9ad5.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KPorf-0005Ry-S1 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Aug 2008 18:27:59 -0700
Received: from yw-out-1718.google.com ([74.125.46.158])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KPorf-0006l5-Gk
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Aug 2008 18:27:59 -0700
Received: by yw-out-1718.google.com with SMTP id 6so1287674ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 03 Aug 2008 18:27:59 -0700 (PDT)
In-Reply-To: <20080803213814.50ca9ad5.krzysztof.h1@poczta.fm>
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

On Mon, Aug 4, 2008 at 3:38 AM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> On Sat,  2 Aug 2008 09:08:19 -0400
> Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>
>> The original am200epd driver was designed with bad assumptions. It
>> manipulated GPSR/GPLR registers directly. It relied on direct access to the
>> pxa LCDC registers which have since conflicted with commit
>> ce4fb7b892a6d6c6a0f87366b26fd834d2923dd7 . This patch moves it into mach-pxa
>> and overhauls it to use a fb obtained through fb notifiers. It now uses the
>> generic GPIO api.
>>
>> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
>> ---
>
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>

Nice work, it looks very clean, and I like this very much.

Acked-by: Eric Miao <eric.miao@marvell.com>

If you need another Acked-by :-)

> ----------------------------------------------------------------------
> Te newsy nakreca Cie na caly dzien!
> Sprawdz >>> http://link.interia.pl/f1e94
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
