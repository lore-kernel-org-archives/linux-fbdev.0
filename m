From: "Amol Lad" <amol.lad@gmail.com>
Subject: Re: Dynamic switch from Console on ttyS0 to
	fbcon
Date: Fri, 22 Aug 2008 12:52:58 +0530
Message-ID: <8c675e9b0808220022r334169a1ra15ef839f0ba06a7@mail.gmail.com>
References: <8c675e9b0808192118g598fc380kf3cb3aa22cf969c8@mail.gmail.com>
	<Pine.LNX.4.64.0808200850330.383@anakin>
	<8c675e9b0808200016x6da4be9bm3f4cc697ffc5cac1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KWQz6-0007qW-HU for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Aug 2008 00:23:00 -0700
Received: from fg-out-1718.google.com ([72.14.220.153])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KWQz5-0007FQ-TB
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Aug 2008 00:23:00 -0700
Received: by fg-out-1718.google.com with SMTP id d23so178950fga.32
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 22 Aug 2008 00:22:58 -0700 (PDT)
In-Reply-To: <8c675e9b0808200016x6da4be9bm3f4cc697ffc5cac1@mail.gmail.com>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

well.... very easy solution

1. Pass console=ttyS0 command line
2. modprobe fbcon
3. a.out 1>/dev/tty0 2>/dev/tty0

So, now all outs from a.out will come on FB

thanks

On Wed, Aug 20, 2008 at 12:46 PM, Amol Lad <amol.lad@gmail.com> wrote:
> On Wed, Aug 20, 2008 at 12:21 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Wed, 20 Aug 2008, Amol Lad wrote:
>>> I'm trying to switch the console from ttyS0 to frame buffer.
>>>
>>> The problem is if "console=ttyS0,115200n8" is passed on u-boot command
>>> line then the console switch to framebuffer does not happen after
>>> doing modprobe fbcon.
>>>
>>> If "console=ttyS0,115200n8" argument is not passed on u-boot then the
>>> console switch happens after modprobe fbcon.
>>>
>
>> Have you tried
>>
>>    console=ttyS0,115200n8 console=tty0
>>
>> ? This will make console output go to both, and console input will come
>> from tty0.
>
> I tried that. This makes user space to use tty0 as /dev/console. In
> this case I did "modprobe fbcon" (from telnet session) and I get
> console on FB.
> But I want console to stay on ttyS0 if "modprobe fbcon" is not done.
> This way based on some /proc entry I can decide to switch to frame
> buffer console in startup script or stay in ttyS0 mode
>
>>
>> Gr{oetje,eeting}s,
>
> Thanks
> Amol
>
>>
>>                                                Geert
>>
>> --
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>>
>> In personal conversations with technical people, I call myself a hacker. But
>> when I'm talking to journalists I just say "programmer" or something like that.
>>                                                            -- Linus Torvalds
>>
>

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
