From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] Do set var even if no
	fb_check_var() provided.
Date: Wed, 27 Aug 2008 23:49:15 +0200
Message-ID: <g94i4r$2hq$1@ger.gmane.org>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYStQ-0004zh-UF for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 14:49:32 -0700
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KYStO-0007me-SJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 14:49:32 -0700
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KYStJ-0006Q0-St for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 21:49:25 +0000
Received: from mnhm-590f6f04.pool.einsundeins.de ([89.15.111.4])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 27 Aug 2008 21:49:25 +0000
Received: from deller by mnhm-590f6f04.pool.einsundeins.de with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 27 Aug 2008 21:49:25 +0000
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
To: linux-fbdev-devel@lists.sourceforge.net

Geert Uytterhoeven wrote:
> On Wed, 27 Aug 2008, Takashi Yoshii wrote:
>> The behavior of FBIOSET_VSCREENINFO seems to be weired on FB which does
>> not
>>  provides fbops->fb_check_var.
>> It doesn't set anything, but gets info->var instead, and returns no
>> error. It is just same as FBIOGET_VSCREENINFO does.
>> 
>> IMHO, this should be one of the following candidates,
>>  1. set var without check.
>>  2. do nothing but return error (setting var is not supported).
>> or
>>  3. it's a bug (fb_check_var should always be provided).
>> 
>> The patch at the bottom implements "1".
>> 
>> Because I don't know API specification, nor the history of the code,
>> I would like people who knows well to discuss this.
> 
> If the driver doesn't provide a fb_check_var(), it means it cannot
> change video mode. Hence this rules out #1.
> 
> #2 is not acceptable, as it will break existing applications. It's also
> incorrect, as FBIOPUT_VSCREENINFO should succeed for supported modes.
> For unsupported modes, the mode should be rounded up to a supported mode,
> if possible. In the case of drivers that support one fixed mode only, this
> rounding up is relaxed to `rounding' to the sole supported mode.
> 
> #3 is also wrong, as fb_check_var() has been deliberately made optional to
> simplify drivers that support one fixed mode only.
> 
> Conclusion: nothing should be changed?

I'm not sure.
On parisc we just stumbled over exactly this problem where I think Takashi's
proposal "1." is probably the right solution.

Please see my Xorg bugzilla entry:
https://bugs.freedesktop.org/show_bug.cgi?id=17153 
and this problem description/thread ("X won't start with VisEG and
2.6.22.19"):
http://thread.gmane.org/gmane.linux.ports.parisc/564/focus=592

Helge


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
