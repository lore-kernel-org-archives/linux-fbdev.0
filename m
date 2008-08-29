From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Do set var even if no
 fb_check_var() provided.
Date: Fri, 29 Aug 2008 09:03:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808290902190.22326@anakin>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin>
	<48B759B0.4010001@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYy1O-00073p-5B for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 00:03:50 -0700
Received: from monty.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYy1M-0004OQ-GR
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 00:03:50 -0700
In-Reply-To: <48B759B0.4010001@renesas.com>
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
To: Takashi Yoshii <yoshii.takashi@renesas.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 29 Aug 2008, Takashi Yoshii wrote:
> Thank you for your explanation.
> Sorry for slow, long response.
> Summary:
> 1. I understand your strategy (no check == fix video).
> 2. pan should be fixed state after set var.
> 3. pixclock can be any, OK?
> 
> ---
> 1. 
> > > If the driver doesn't provide a fb_check_var(), it means it cannot
> > > change video mode. Hence this rules out #1.
> Well, this logic looks like "A is B because A is B".
> But, anyway this should be this because you say so.
> Accepting this as a fixed rule, things becomes simple.
> 
> I guess this is based on the idea
> var should always be corresponding to HW state.
> My patch was based on the idea
> var can be any, because HW accept all (by just ignoring all).

No, var cannot be any. Var can only be the single tuple of values the
hardware supports.

> 2. pan should be fixed state after set var.
> 
> # This is becoming another topic, though...
> One small problem of current code is that
> FBIOPUT_VSCREENINFO sometimes set PAN but sometimes does not.
> # assuming pan is not a part of "video mode".
> 
> It will be 1.unchanged, or 2.info->var, or 3.var, or 4.var+rounding?,
> but generally pan state after FBIOPUT_VSCREENINFO should be considered
> as unknown(but something valid), even if passing valid value(say, (0,0)).

Panning state is not unknown. It's in var.

> 3. pixclock can be any, OK?
> 
> The real problem(for me;) might be
> . Habit of applications that check the var by themselves.
> This is  not actually a topic on this ML. But I want to confirm that
>  pixclock can be any. Even 0 is a kind of "Valid" value.
> OK?
> 
> I'm asking because, there are drivers return timing parameters as 0.
> - HW has clock, known, but set 0 (sh_mobile_lcdfb).
> - HW must have clock, but unknown (hitfb, stifb, xilinxfb).
> - No clock (xenfb).
> There are drivers return false value.
> - No clock but return some (vfb).
> 
> If 0 is valid, problem is Xorg's issue.
> X(at least 1.4) doesn't accept clock=0. (and the reason looks be buggy)

If you don't know the pixclock, set it to 0.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
