From: "Alex Stewart" <alex@foogod.com>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this one works ;-)
Date: Wed, 28 Apr 2004 16:35:57 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <59301.171.72.5.226.1083195357.squirrel@www.foogod.com>
References: <20370.159.37.7.254.1083189089.squirrel@www.foogod.com>
        <Pine.LNX.4.44.0404282252250.3125-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIyb6-0005me-Ro
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 16:36:12 -0700
Received: from adsl-209-182-168-213.value.net ([209.182.168.213] helo=firestar.foogod.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIyb6-0005f8-L9
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 16:36:12 -0700
In-Reply-To: <Pine.LNX.4.44.0404282252250.3125-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: jsimmons@infradead.org
Cc: alex@foogod.com, benh@kernel.crashing.org, grim@undead.cc, eger-dated-1083663529.7e8c27@theboonies.us, geert@linux-m68k.org, adaplas@hotpop.com, eger-dated-1082943669.d79d33@theboonies.us, linux-fbdev-devel@lists.sourceforge.net

>> The tty layer alreasy stores the resolution. See asm/termios.h. What
>> it lacks is depth and frequency. I have to do some digging to see if
>> the VT220 dealt with that data. I bet it did.
>>
>> Well, for what it's worth, I think that's wrong too.
>
> Well it's the POSIX standard.

Yeah, I know, but that doesn't mean I have to agree with it.  :)

Anyway, my point is just that ttys should only care about characters.  In
the console system, fbcon is what does the translation from a
character-based display to a pixel-based display.  Thus, nothing above
fbcon should have any notion (or any need to have a notion) of pixels,
color depths, frequency timings, or any of that.

-alex




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
