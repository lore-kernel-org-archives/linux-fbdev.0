From: "Jatin Kumar" <jatin.kumar@gatech.edu>
Subject: Re: asynchronous resolution change
Date: Mon, 24 Nov 2008 20:52:52 -0500
Message-ID: <333fec630811241752i616754f5wcde88e812a439b01@mail.gmail.com>
References: <333fec630811181704t19194e5et6d5299e2305f4401@mail.gmail.com>
	<Pine.LNX.4.64.0811190933200.27671@anakin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5523743415968159253=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jatinkumar@gmail.com>) id 1L4n6m-0008K0-CD
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Nov 2008 01:52:56 +0000
Received: from yw-out-1718.google.com ([74.125.46.155])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L4n6j-000559-Ng for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Nov 2008 01:52:56 +0000
Received: by yw-out-1718.google.com with SMTP id 6so915353ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 24 Nov 2008 17:52:52 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0811190933200.27671@anakin>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

--===============5523743415968159253==
Content-Type: multipart/alternative; 
	boundary="----=_Part_134786_14687732.1227577972084"

------=_Part_134786_14687732.1227577972084
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, Nov 19, 2008 at 3:35 AM, Geert Uytterhoeven <geert@linux-m68k.org>wrote:

> On Tue, 18 Nov 2008, Jatin Kumar wrote:
> > I am new to linux fb model and had some queries regarding resolution
> change
> > mechanisms.
> >
> > Consider a situation where the frambuffer kernel module (vfb/xenfb etc)
> > wants to change the resolution.
> >
> > 1. Is there a mechanism to this, considering the applications/windowing
> > system/console above the framebuffer hasnt initiated the size change?
> >
> > 2. Is there a way to do an upcall into the application/windowing
> > system/console modules to inform them about the size change
> asynchronously?
> >
> > In this particular case ; the display hardware(instead of the user) has
> > initiated the resolution change.Is it possible in the current fb
> framework
> > to support it?
>
> Yes there is! If the resolution is changed, and the number of columns and
> lines of the console changes, the tty subsystem will send the SIGWINCH
> signal
> to the application, cfr. tty_do_resize() in drivers/char/tty_io.c.
>
> Note that not all applications handle it. E.g. X doesn't, AFAIK.
>
> Gr{oetje,eeting}s,
>
>                                                Geert



Hi Geert,

Thanks much for the info.

Is the tty_io_resize( ) relatively new? .
I am looking at 2.6.18.8 src code (used for xen) and could not find the
function.

Also are there any plans for exposing a similar callback api in the linux fb
model to make the applications stay updated about the underlying
resolution/hardware mode changes?

Thanks so much,
Jatin


>
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
>                                                            -- Linus
> Torvalds
>

------=_Part_134786_14687732.1227577972084
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div class="gmail_quote">On Wed, Nov 19, 2008 at 3:35 AM, Geert Uytterhoeven <span dir="ltr">&lt;<a href="mailto:geert@linux-m68k.org">geert@linux-m68k.org</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Tue, 18 Nov 2008, Jatin Kumar wrote:<br>
&gt; I am new to linux fb model and had some queries regarding resolution change<br>
&gt; mechanisms.<br>
&gt;<br>
&gt; Consider a situation where the frambuffer kernel module (vfb/xenfb etc)<br>
&gt; wants to change the resolution.<br>
&gt;<br>
&gt; 1. Is there a mechanism to this, considering the applications/windowing<br>
&gt; system/console above the framebuffer hasnt initiated the size change?<br>
&gt;<br>
&gt; 2. Is there a way to do an upcall into the application/windowing<br>
&gt; system/console modules to inform them about the size change asynchronously?<br>
&gt;<br>
&gt; In this particular case ; the display hardware(instead of the user) has<br>
&gt; initiated the resolution change.Is it possible in the current fb framework<br>
&gt; to support it?<br>
<br>
</div>Yes there is! If the resolution is changed, and the number of columns and<br>
lines of the console changes, the tty subsystem will send the SIGWINCH signal<br>
to the application, cfr. tty_do_resize() in drivers/char/tty_io.c.<br>
<br>
Note that not all applications handle it. E.g. X doesn&#39;t, AFAIK.<br>
<br>
Gr{oetje,eeting}s,<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Geert</blockquote><div><br>&nbsp;</div><div>Hi Geert,<br>
<br>
Thanks much for the info.<br>
<br>
Is the tty_io_resize( ) relatively new? .<br>
I am looking at <a href="http://2.6.18.8">2.6.18.8</a> src code (used for xen) and could not find the function.<br>
<br>
Also are there any plans for exposing a similar callback api in the
linux fb model to make the applications stay updated about the underlying resolution/hardware
mode changes?<br>
<br>
Thanks so much,<br>
Jatin<br>&nbsp;
<br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<font color="#888888"><br>
--<br>
Geert Uytterhoeven -- There&#39;s lots of Linux beyond ia32 -- <a href="mailto:geert@linux-m68k.org">geert@linux-m68k.org</a><br>
<br>
In personal conversations with technical people, I call myself a hacker. But<br>
when I&#39;m talking to journalists I just say &quot;programmer&quot; or something like that.<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-- Linus Torvalds<br>
</font></blockquote></div><br>

------=_Part_134786_14687732.1227577972084--


--===============5523743415968159253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============5523743415968159253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============5523743415968159253==--
