From: Takashi Yoshii <yoshii.takashi@renesas.com>
Subject: Re: [PATCH] Do set var even if no
 fb_check_var() provided.
Date: Fri, 29 Aug 2008 11:06:40 +0900
Message-ID: <48B759B0.4010001@renesas.com>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYtOT-0004yP-VI for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 19:07:22 -0700
Received: from mail.renesas.com ([202.234.163.13] helo=mail06.idc.renesas.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYtOS-0004rQ-EZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 19:07:21 -0700
In-reply-to: <Pine.LNX.4.64.0808270855110.7910@anakin>
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

Thank you for your explanation.
Sorry for slow, long response.
Summary:
 1. I understand your strategy (no check == fix video).
 2. pan should be fixed state after set var.
 3. pixclock can be any, OK?

---
1. 
> > If the driver doesn't provide a fb_check_var(), it means it cannot
> > change video mode. Hence this rules out #1.
Well, this logic looks like "A is B because A is B".
But, anyway this should be this because you say so.
Accepting this as a fixed rule, things becomes simple.

I guess this is based on the idea
 var should always be corresponding to HW state.
My patch was based on the idea
 var can be any, because HW accept all (by just ignoring all).

> > #2 is not acceptable, as it will break existing applications. It's also
> > incorrect, as FBIOPUT_VSCREENINFO should succeed for supported modes.
Right. It's important not to break existing application. I found Xorg server
 does set var then check it to see if the operation was successful.
Perhaps that is the usage of this API. So, returning error seems bad.

> > #3 is also wrong, as fb_check_var() has been deliberately made optional to
> > simplify drivers that support one fixed mode only.
OK. I don't think it is bad idea.

---
2. pan should be fixed state after set var.

# This is becoming another topic, though...
One small problem of current code is that
 FBIOPUT_VSCREENINFO sometimes set PAN but sometimes does not.
# assuming pan is not a part of "video mode".

It will be 1.unchanged, or 2.info->var, or 3.var, or 4.var+rounding?,
but generally pan state after FBIOPUT_VSCREENINFO should be considered
 as unknown(but something valid), even if passing valid value(say, (0,0)).

It's ok if set or not. But, I believe it should be deterministic.

---
3. pixclock can be any, OK?

The real problem(for me;) might be
. Habit of applications that check the var by themselves.
This is  not actually a topic on this ML. But I want to confirm that
  pixclock can be any. Even 0 is a kind of "Valid" value.
OK?

I'm asking because, there are drivers return timing parameters as 0.
- HW has clock, known, but set 0 (sh_mobile_lcdfb).
- HW must have clock, but unknown (hitfb, stifb, xilinxfb).
- No clock (xenfb).
There are drivers return false value.
- No clock but return some (vfb).

If 0 is valid, problem is Xorg's issue.
X(at least 1.4) doesn't accept clock=0. (and the reason looks be buggy)

Regards,
/yoshii



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
