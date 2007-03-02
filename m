From: Alex Romosan <romosan@sycorax.lbl.gov>
Subject: Re: 2.6.21-rc2 radeon backlight
Date: Fri, 02 Mar 2007 13:22:27 -0800
Message-ID: <87mz2v5oj0.fsf@sycorax.lbl.gov>
References: <20070301184531.b3aeafe3.akpm@linux-foundation.org>
	<87tzx35zkc.fsf@sycorax.lbl.gov>
	<20070302122920.a2967ebf.akpm@linux-foundation.org>
	<20070302.123514.35465791.davem@davemloft.net>
	<20070302210157.GA11786@khazad-dum.debian.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965661AbXCBVWj@vger.kernel.org>
In-Reply-To: <20070302210157.GA11786@khazad-dum.debian.net> (message from
	Henrique de Moraes Holschuh on Fri, 2 Mar 2007 18:01:57 -0300)
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, rpurdie@rpsys.net

Henrique de Moraes Holschuh <hmh@hmh.eng.br> writes:

> On Fri, 02 Mar 2007, David Miller wrote:
>> Why don't we compromise for 2.6.21 by marking the Radeon backlight
>> stuff EXPERIMENTAL until the cases where IBM ACPI works and the
>> Radeon backlight stuff does not are worked out?
>
> What ibm-acpi backlight control does is *very* different from what the
> radeon backlight control does.
>
> ibm-acpi talks to the ThinkPad EC to change the brightness of the backlight,
> it has *NO* on/off support.  Radeon talks to the video chipset to turn the
> LVDS output on/off (or something to that effect), and thus to turn the
> backlight on/off.

if i don't enable the radeon backlight support the backlight works and
i can turn it on and off using radeontool. if i enable the radeon
backlight support the screen stays dark (although i can log on my
laptop remotely). if i try to use radeontool to turn the backlight on
nothing happens. so, at least on the thinkpad, the radeon backlight
support disables some other kind of backlight support that works
otherwise.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
